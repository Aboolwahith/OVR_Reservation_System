package com.ovr.dao;

import com.ovr.model.Guest;
import com.ovr.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * OVR – Guest DAO
 * All SQL is isolated here. Servlets only call these methods.
 *
 * Operations:
 *   getAllGuests()          – Full list for the table view
 *   searchGuests(keyword)  – Live search by name, country, phone
 *   getGuestById(id)       – Single guest for edit pre-fill
 *   addGuest(guest)        – INSERT new guest
 *   updateGuest(guest)     – UPDATE existing guest
 *   deleteGuest(id)        – DELETE (only if no active reservations)
 *   hasActiveReservations  – Guard before delete
 *   getTotalGuestCount()   – For dashboard stat
 */
public class GuestDAO {

    // ═══════════════════════════════════════════════════════════
    //  READ OPERATIONS
    // ═══════════════════════════════════════════════════════════

    /**
     * Fetches all guests ordered by most recently added first.
     */
    public List<Guest> getAllGuests() throws SQLException {
        List<Guest> list = new ArrayList<>();
        String sql = """
                SELECT guest_id, full_name, address, country,
                       phone_code, phone_number,
                       DATE_FORMAT(created_at, '%d %b %Y') AS created_at
                FROM guests
                ORDER BY created_at DESC
                """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    /**
     * Live search — matches against full_name, country, phone_number.
     * Used by the search bar (GET /guests?search=keyword).
     * PreparedStatement with LIKE prevents SQL injection.
     */
    public List<Guest> searchGuests(String keyword) throws SQLException {
        List<Guest> list = new ArrayList<>();
        String sql = """
                SELECT guest_id, full_name, address, country,
                       phone_code, phone_number,
                       DATE_FORMAT(created_at, '%d %b %Y') AS created_at
                FROM guests
                WHERE full_name   LIKE ?
                   OR country     LIKE ?
                   OR phone_number LIKE ?
                ORDER BY created_at DESC
                """;
        String pattern = "%" + keyword.trim() + "%";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ps.setString(3, pattern);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    /**
     * Fetch a single guest by ID — used to pre-fill the Edit modal.
     * Returns null if not found.
     */
    public Guest getGuestById(int guestId) throws SQLException {
        String sql = """
                SELECT guest_id, full_name, address, country,
                       phone_code, phone_number,
                       DATE_FORMAT(created_at, '%d %b %Y') AS created_at
                FROM guests
                WHERE guest_id = ?
                """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guestId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? mapRow(rs) : null;
            }
        }
    }

    /**
     * Total guest count — used by the Dashboard stats card.
     */
    public int getTotalGuestCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM guests";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // ═══════════════════════════════════════════════════════════
    //  WRITE OPERATIONS
    // ═══════════════════════════════════════════════════════════

    /**
     * INSERT a new guest record.
     * Returns the generated guest_id on success, -1 on failure.
     */
    public int addGuest(Guest guest) throws SQLException {
        String sql = """
                INSERT INTO guests (full_name, address, country, phone_code, phone_number)
                VALUES (?, ?, ?, ?, ?)
                """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, sanitize(guest.getFullName()));
            ps.setString(2, sanitize(guest.getAddress()));
            ps.setString(3, sanitize(guest.getCountry()));
            ps.setString(4, sanitize(guest.getPhoneCode()));
            ps.setString(5, sanitize(guest.getPhoneNumber()));
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                return keys.next() ? keys.getInt(1) : -1;
            }
        }
    }

    /**
     * UPDATE an existing guest's details.
     * Returns true if the row was updated.
     */
    public boolean updateGuest(Guest guest) throws SQLException {
        String sql = """
                UPDATE guests
                SET full_name    = ?,
                    address      = ?,
                    country      = ?,
                    phone_code   = ?,
                    phone_number = ?
                WHERE guest_id = ?
                """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sanitize(guest.getFullName()));
            ps.setString(2, sanitize(guest.getAddress()));
            ps.setString(3, sanitize(guest.getCountry()));
            ps.setString(4, sanitize(guest.getPhoneCode()));
            ps.setString(5, sanitize(guest.getPhoneNumber()));
            ps.setInt(6, guest.getGuestId());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * DELETE a guest ONLY if they have no reservations at all.
     * The FK constraint (fk_res_guest ON DELETE CASCADE) will
     * cascade-delete reservations if we allow it — so we guard
     * here first to prevent accidental data loss.
     *
     * @return "DELETED"   – success
     *         "HAS_RESERVATIONS" – blocked, guest has booking history
     *         "NOT_FOUND" – guest_id doesn't exist
     */
    public String deleteGuest(int guestId) throws SQLException {
        if (hasReservations(guestId)) return "HAS_RESERVATIONS";

        String sql = "DELETE FROM guests WHERE guest_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guestId);
            return ps.executeUpdate() > 0 ? "DELETED" : "NOT_FOUND";
        }
    }

    // ═══════════════════════════════════════════════════════════
    //  PRIVATE HELPERS
    // ═══════════════════════════════════════════════════════════

    /**
     * Check if a guest has any reservation records (active OR historical).
     */
    private boolean hasReservations(int guestId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM reservations WHERE guest_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guestId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    /**
     * Maps a ResultSet row → Guest bean.
     * Single place to change if column names ever change.
     */
    private Guest mapRow(ResultSet rs) throws SQLException {
        Guest g = new Guest();
        g.setGuestId(rs.getInt("guest_id"));
        g.setFullName(rs.getString("full_name"));
        g.setAddress(rs.getString("address"));
        g.setCountry(rs.getString("country"));
        g.setPhoneCode(rs.getString("phone_code"));
        g.setPhoneNumber(rs.getString("phone_number"));
        g.setCreatedAt(rs.getString("created_at"));
        return g;
    }

    /**
     * Basic null guard for string inputs.
     * XSS/injection is handled by PreparedStatement — this just
     * prevents NullPointerException on empty optional fields.
     */
    private String sanitize(String value) {
        return (value != null) ? value.trim() : "";
    }
}
