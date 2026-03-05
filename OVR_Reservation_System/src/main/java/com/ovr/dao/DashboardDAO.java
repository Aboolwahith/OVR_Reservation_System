package com.ovr.dao;

import com.ovr.util.DBConnection;
import java.sql.*;

public class DashboardDAO {

    public int getTotalReservations() {
        String sql = "SELECT COUNT(*) FROM reservations";
        return querySingleInt(sql);
    }

    public int getTodayCheckIns() {
        String sql = "SELECT COUNT(*) FROM reservations WHERE check_in = CURDATE()";
        return querySingleInt(sql);
    }

    public int getTodayCheckOuts() {
        String sql = "SELECT COUNT(*) FROM reservations WHERE check_out = CURDATE()";
        return querySingleInt(sql);
    }

    public double getTodayRevenue() {
        // Revenue = nights × price_per_night for reservations checking out today
        String sql = "SELECT COALESCE(SUM(DATEDIFF(r.check_out, r.check_in) * rt.price_per_night), 0) "
                   + "FROM reservations r "
                   + "JOIN room_types rt ON r.room_type_id = rt.room_type_id "
                   + "WHERE r.check_out = CURDATE()";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // ── HELPER ────────────────────────────────────────────────────────────────
    private int querySingleInt(String sql) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
