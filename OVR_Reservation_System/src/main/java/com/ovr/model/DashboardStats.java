package com.ovr.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class DashboardStats {
    private int totalRooms = 0;
    private int availableRooms = 0;
    private int occupiedRooms = 0;
    private int activeGuests = 0;
    private int todayCheckIns = 0;
    private int todayCheckOuts = 0;
    private List<Map<String, Object>> upcomingCheckOuts = new ArrayList<>();

    public DashboardStats() {}

    // Getters and Setters
    public int getTotalRooms() { return totalRooms; }
    public void setTotalRooms(int totalRooms) { this.totalRooms = totalRooms; }
    public int getAvailableRooms() { return availableRooms; }
    public void setAvailableRooms(int availableRooms) { this.availableRooms = availableRooms; }
    public int getOccupiedRooms() { return occupiedRooms; }
    public void setOccupiedRooms(int occupiedRooms) { this.occupiedRooms = occupiedRooms; }
    public int getActiveGuests() { return activeGuests; }
    public void setActiveGuests(int activeGuests) { this.activeGuests = activeGuests; }
    public int getTodayCheckIns() { return todayCheckIns; }
    public void setTodayCheckIns(int todayCheckIns) { this.todayCheckIns = todayCheckIns; }
    public int getTodayCheckOuts() { return todayCheckOuts; }
    public void setTodayCheckOuts(int todayCheckOuts) { this.todayCheckOuts = todayCheckOuts; }
    public List<Map<String, Object>> getUpcomingCheckOuts() { return upcomingCheckOuts; }
    public void setUpcomingCheckOuts(List<Map<String, Object>> upcomingCheckOuts) { 
        this.upcomingCheckOuts = (upcomingCheckOuts != null) ? upcomingCheckOuts : new ArrayList<>(); 
    }
}