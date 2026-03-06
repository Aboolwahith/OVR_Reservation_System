package com.ovr.dao;

import com.ovr.model.Reservation;
import com.ovr.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    // ── INSERT ──────────────────────────────────────────────────────────────
    public boolean addReservation(Reservation r) {
        String sql = "INSERT INTO reservations "
                   + "(reservation_number, guest_name, address, contact_number, "
                   + " room_type_id, check_in, check_out) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, r.getReservationNumber());
            ps.setString(2, r.getGuestName());
            ps.setString(3, r.getAddress());
            ps.setString(4, r.getContactNumber());
            ps.setInt   (5, r.getRoomTypeId());
            ps.setDate  (6, r.getCheckIn());
            ps.setDate  (7, r.getCheckOut());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── FIND BY RESERVATION NUMBER ───────────────────────────────────────────
    public Reservation findByReservationNumber(String number) {
        String sql = "SELECT * FROM reservations WHERE reservation_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, number);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── GET ALL ──────────────────────────────────────────────────────────────
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ── DELETE (for JUnit cleanup) ───────────────────────────────────────────
    public boolean deleteByReservationNumber(String number) {
        String sql = "DELETE FROM reservations WHERE reservation_number = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, number);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── HELPER ───────────────────────────────────────────────────────────────
    private Reservation mapRow(ResultSet rs) throws SQLException {
        Reservation r = new Reservation();
        r.setReservationId    (rs.getInt      ("reservation_id"));
        r.setReservationNumber(rs.getString   ("reservation_number"));
        r.setGuestName        (rs.getString   ("guest_name"));
        r.setAddress          (rs.getString   ("address"));
        r.setContactNumber    (rs.getString   ("contact_number"));
        r.setRoomTypeId       (rs.getInt      ("room_type_id"));
        r.setCheckIn          (rs.getDate     ("check_in"));
        r.setCheckOut         (rs.getDate     ("check_out"));
        r.setCreatedAt        (rs.getTimestamp("created_at"));
        return r;
    }
}
