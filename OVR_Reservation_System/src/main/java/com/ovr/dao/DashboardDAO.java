package com.ovr.dao;

import com.ovr.model.DashboardStats;
import com.ovr.util.DBConnection;
import java.sql.*;
import java.util.*;

public class DashboardDAO {

    public DashboardStats getCounts() {
        DashboardStats stats = new DashboardStats();
        String query = "SELECT " +
                       "(SELECT COUNT(*) FROM rooms) as total, " +
                       "(SELECT COUNT(*) FROM rooms WHERE status = 'AVAILABLE') as available, " +
                       "(SELECT COUNT(*) FROM rooms WHERE status = 'OCCUPIED') as occupied, " +
                       "(SELECT COUNT(*) FROM reservations WHERE status = 'CHECKED_IN') as active_guests, " +
                       "(SELECT COUNT(*) FROM reservations WHERE DATE(check_in) = CURDATE()) as checkins_today, " +
                       "(SELECT COUNT(*) FROM reservations WHERE DATE(check_out) = CURDATE()) as checkouts_today";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stats.setTotalRooms(rs.getInt("total"));
                stats.setAvailableRooms(rs.getInt("available"));
                stats.setOccupiedRooms(rs.getInt("occupied"));
                stats.setActiveGuests(rs.getInt("active_guests"));
                stats.setTodayCheckIns(rs.getInt("checkins_today"));
                stats.setTodayCheckOuts(rs.getInt("checkouts_today"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return stats;
    }

    public Map<String, Integer> getMonthlyReservations() {
        Map<String, Integer> monthlyData = new LinkedHashMap<>();
        String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
        for (String m : months) monthlyData.put(m, 0);

        String sql = "SELECT MONTHNAME(created_at) as month, COUNT(*) as count " +
                     "FROM reservations WHERE YEAR(created_at) = YEAR(CURDATE()) " +
                     "GROUP BY MONTH(created_at)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String fullMonth = rs.getString("month");
                if(fullMonth != null) {
                    String mName = fullMonth.substring(0, 3);
                    monthlyData.put(mName, rs.getInt("count"));
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return monthlyData;
    }

    public List<Map<String, Object>> getUpcomingCheckOuts() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT g.full_name, r.room_number, res.check_out " +
                     "FROM reservations res " +
                     "JOIN guests g ON res.guest_id = g.guest_id " +
                     "JOIN rooms r ON res.room_id = r.room_id " +
                     "WHERE res.status = 'CHECKED_IN' " +
                     "ORDER BY res.check_out ASC LIMIT 5";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("guest", rs.getString("full_name"));
                row.put("room", rs.getString("room_number"));
                row.put("date", rs.getDate("check_out"));
                list.add(row);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}