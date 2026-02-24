package com.ovr.dao;

import com.ovr.model.DashboardStats;
import com.ovr.util.DBConnection;

import java.sql.*;

/**
 * OVR – Dashboard DAO
 * All SQL queries are isolated here (DAO Pattern).
 * Servlets NEVER contain raw SQL — only DAO calls.
 */
public class DashboardDAO {

    // ═══════════════════════════════════════════════════════════
    //  MASTER METHOD — Builds entire DashboardStats in one call
    // ═══════════════════════════════════════════════════════════

    /**
     * Fetches all KPIs in a single DB session for efficiency.
     * @param userId  – logged-in receptionist's user_id (for notifications)
     * @return fully populated DashboardStats bean
     */
    public DashboardStats getDashboardStats(int userId) throws SQLException {
        DashboardStats stats = new DashboardStats();

        try (Connection conn = DBConnection.getConnection()) {

            stats.setTotalRooms(getTotalRooms(conn));
            stats.setAvailableRooms(getRoomCountByStatus(conn, "AVAILABLE"));
            stats.setOccupiedRooms(getRoomCountByStatus(conn, "OCCUPIED"));
            stats.setMaintenanceRooms(getRoomCountByStatus(conn, "MAINTENANCE"));
            stats.calculateOccupancyRate();   // Business formula applied here

            stats.setTodayCheckIns(getTodayCheckIns(conn));
            stats.setTodayCheckOuts(getTodayCheckOuts(conn));
            stats.setTodayRevenue(getTodayRevenue(conn));

            stats.setTotalGuests(getTotalGuests(conn));
            stats.setActiveReservations(getActiveReservations(conn));
            stats.setUnreadNotifications(getUnreadNotifications(conn, userId));
        }

        return stats;
    }

    // ═══════════════════════════════════════════════════════════
    //  ROOM QUERIES
    // ═══════════════════════════════════════════════════════════

    /**
     * Total rooms in the hotel.
     * Formula: COUNT(*) FROM rooms
     */
    private int getTotalRooms(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) FROM rooms";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /**
     * Count rooms by their operational status.
     * Formula: COUNT(*) FROM rooms WHERE status = ?
     * @param status  AVAILABLE | OCCUPIED | MAINTENANCE
     */
    private int getRoomCountByStatus(Connection conn, String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM rooms WHERE status = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    // ═══════════════════════════════════════════════════════════
    //  RESERVATION QUERIES
    // ═══════════════════════════════════════════════════════════

    /**
     * Guests scheduled to check in TODAY.
     * Counts BOOKED reservations with check_in = CURDATE()
     */
    private int getTodayCheckIns(Connection conn) throws SQLException {
        String sql = """
                SELECT COUNT(*) FROM reservations
                WHERE check_in = CURDATE()
                  AND status IN ('BOOKED', 'CHECKED_IN')
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /**
     * Guests scheduled to check out TODAY.
     * Counts CHECKED_IN reservations with check_out = CURDATE()
     */
    private int getTodayCheckOuts(Connection conn) throws SQLException {
        String sql = """
                SELECT COUNT(*) FROM reservations
                WHERE check_out = CURDATE()
                  AND status IN ('CHECKED_IN', 'BOOKED')
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /**
     * Active reservations (BOOKED or CHECKED_IN).
     * Used for the active reservations count card.
     */
    private int getActiveReservations(Connection conn) throws SQLException {
        String sql = """
                SELECT COUNT(*) FROM reservations
                WHERE status IN ('BOOKED', 'CHECKED_IN')
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // ═══════════════════════════════════════════════════════════
    //  REVENUE QUERY
    // ═══════════════════════════════════════════════════════════

    /**
     * Revenue generated from billing records for TODAY's check-ins.
     * Formula: SUM(total_amount) WHERE reservation's check_in = CURDATE()
     *
     * JOIN path: billing → reservations → check_in date
     */
    private double getTodayRevenue(Connection conn) throws SQLException {
        String sql = """
                SELECT COALESCE(SUM(b.total_amount), 0)
                FROM billing b
                INNER JOIN reservations r ON b.reservation_id = r.reservation_id
                WHERE r.check_in = CURDATE()
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getDouble(1) : 0.0;
        }
    }

    // ═══════════════════════════════════════════════════════════
    //  GUEST & NOTIFICATION QUERIES
    // ═══════════════════════════════════════════════════════════

    /**
     * Total registered guests in the system.
     */
    private int getTotalGuests(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) FROM guests";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    /**
     * Unread notifications for the logged-in user.
     * Linked via user_id FK in notifications table.
     */
    private int getUnreadNotifications(Connection conn, int userId) throws SQLException {
        String sql = """
                SELECT COUNT(*) FROM notifications
                WHERE user_id = ?
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    // ═══════════════════════════════════════════════════════════
    //  RECENT RESERVATIONS (for Activity Feed on Dashboard)
    // ═══════════════════════════════════════════════════════════

    /**
     * Fetches the 5 most recent reservations for the activity feed table.
     * Returns ResultSet — caller must close connection.
     * NOTE: This method returns a disconnected result via a helper class.
     *       For simplicity we pass back data via the RecentReservation inner class.
     */
    public java.util.List<RecentReservation> getRecentReservations() throws SQLException {
        java.util.List<RecentReservation> list = new java.util.ArrayList<>();
        String sql = """
                SELECT r.reservation_number,
                       g.full_name,
                       rt.type_name,
                       r.check_in,
                       r.check_out,
                       r.status
                FROM reservations r
                INNER JOIN guests  g  ON r.guest_id = g.guest_id
                INNER JOIN rooms   rm ON r.room_id   = rm.room_id
                INNER JOIN room_types rt ON rm.type_id = rt.type_id
                ORDER BY r.created_at DESC
                LIMIT 5
                """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                RecentReservation rr = new RecentReservation();
                rr.reservationNumber = rs.getString("reservation_number");
                rr.guestName         = rs.getString("full_name");
                rr.roomType          = rs.getString("type_name");
                rr.checkIn           = rs.getDate("check_in").toLocalDate().toString();
                rr.checkOut          = rs.getDate("check_out").toLocalDate().toString();
                rr.status            = rs.getString("status");
                list.add(rr);
            }
        }
        return list;
    }

    // ═══════════════════════════════════════════════════════════
    //  INNER DATA TRANSFER CLASS
    // ═══════════════════════════════════════════════════════════

    /**
     * Lightweight DTO for recent reservation rows.
     * Public fields for easy JSP EL access via getters.
     */
    public static class RecentReservation {
        private String reservationNumber;
        private String guestName;
        private String roomType;
        private String checkIn;
        private String checkOut;
        private String status;

        public String getReservationNumber() { return reservationNumber; }
        public String getGuestName()         { return guestName; }
        public String getRoomType()          { return roomType; }
        public String getCheckIn()           { return checkIn; }
        public String getCheckOut()          { return checkOut; }
        public String getStatus()            { return status; }
    }
}
