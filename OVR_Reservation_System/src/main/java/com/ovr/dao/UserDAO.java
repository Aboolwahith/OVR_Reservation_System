package com.ovr.dao;

import com.ovr.model.User;
import com.ovr.util.DBConnection;

import java.sql.*;

public class UserDAO {

    public User findByUsername(String username) {

        String sql = "SELECT * FROM users WHERE username = ?";
        User user = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean registerUser(User user) {

        String sql = "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getRole());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    public boolean updatePassword(String username, String hashedPassword) {
        // SQL query to update the password for a specific user
        String sql = "UPDATE users SET password = ? WHERE username = ?";
        
        // Using try-with-resources for automatic closing of connection and statement
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, hashedPassword); // Set the new hashed password
            ps.setString(2, username);       // Set the username filter
            
            int rowsUpdated = ps.executeUpdate();
            
            // Return true if at least one row was updated
            return rowsUpdated > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating password for user: " + username);
            e.printStackTrace();
            return false;
        }
    }
}
