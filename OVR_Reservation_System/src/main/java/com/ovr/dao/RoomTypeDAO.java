package com.ovr.dao;

import com.ovr.model.RoomType;
import com.ovr.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomTypeDAO {

    public List<RoomType> getAllRoomTypes() {
        List<RoomType> list = new ArrayList<>();
        String sql = "SELECT * FROM room_types ORDER BY room_type_id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RoomType rt = new RoomType();
                rt.setRoomTypeId   (rs.getInt       ("room_type_id"));
                rt.setRoomCode     (rs.getString    ("room_code"));
                rt.setTypeName     (rs.getString    ("type_name"));
                rt.setPricePerNight(rs.getBigDecimal("price_per_night"));
                list.add(rt);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public RoomType findById(int roomTypeId) {
        String sql = "SELECT * FROM room_types WHERE room_type_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomTypeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                RoomType rt = new RoomType();
                rt.setRoomTypeId   (rs.getInt       ("room_type_id"));
                rt.setRoomCode     (rs.getString    ("room_code"));
                rt.setTypeName     (rs.getString    ("type_name"));
                rt.setPricePerNight(rs.getBigDecimal("price_per_night"));
                return rt;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
