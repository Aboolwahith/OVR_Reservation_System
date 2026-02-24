package com.ovr.model;

/**
 * OVR – Dashboard Statistics Bean
 * Carries all computed KPIs from DAO → Servlet → JSP
 */
public class DashboardStats {

    // ── Room Metrics ──────────────────────────────────────────
    private int totalRooms;
    private int availableRooms;
    private int occupiedRooms;
    private int maintenanceRooms;
    private double occupancyRate;          // (occupied / total) × 100

    // ── Today's Operational Metrics ───────────────────────────
    private int todayCheckIns;
    private int todayCheckOuts;
    private double todayRevenue;           // SUM billing where check_in = today

    // ── Recent Activity (for activity feed) ───────────────────
    private int totalGuests;
    private int activeReservations;        // status = BOOKED or CHECKED_IN
    private int unreadNotifications;

    // ═══════════════════════════════════════════════════════════
    //  Constructors
    // ═══════════════════════════════════════════════════════════

    public DashboardStats() {}

    // ═══════════════════════════════════════════════════════════
    //  Business Logic Helpers
    // ═══════════════════════════════════════════════════════════

    /**
     * Calculates occupancy rate from raw room counts.
     * Formula: (OccupiedRooms / TotalRooms) × 100
     */
    public void calculateOccupancyRate() {
        if (totalRooms > 0) {
            this.occupancyRate = ((double) occupiedRooms / totalRooms) * 100.0;
        } else {
            this.occupancyRate = 0.0;
        }
    }

    /**
     * Returns a status label for occupancy level.
     * Used by JSP for colour-coding the occupancy card.
     */
    public String getOccupancyStatus() {
        if (occupancyRate >= 80) return "HIGH";
        if (occupancyRate >= 50) return "MODERATE";
        return "LOW";
    }

    /**
     * Returns formatted occupancy rate string.
     */
    public String getOccupancyRateFormatted() {
        return String.format("%.1f%%", occupancyRate);
    }

    /**
     * Returns formatted today's revenue string.
     */
    public String getTodayRevenueFormatted() {
        return String.format("$%.2f", todayRevenue);
    }

    // ═══════════════════════════════════════════════════════════
    //  Getters & Setters
    // ═══════════════════════════════════════════════════════════

    public int getTotalRooms()                      { return totalRooms; }
    public void setTotalRooms(int totalRooms)       { this.totalRooms = totalRooms; }

    public int getAvailableRooms()                  { return availableRooms; }
    public void setAvailableRooms(int v)            { this.availableRooms = v; }

    public int getOccupiedRooms()                   { return occupiedRooms; }
    public void setOccupiedRooms(int v)             { this.occupiedRooms = v; }

    public int getMaintenanceRooms()                { return maintenanceRooms; }
    public void setMaintenanceRooms(int v)          { this.maintenanceRooms = v; }

    public double getOccupancyRate()                { return occupancyRate; }
    public void setOccupancyRate(double v)          { this.occupancyRate = v; }

    public int getTodayCheckIns()                   { return todayCheckIns; }
    public void setTodayCheckIns(int v)             { this.todayCheckIns = v; }

    public int getTodayCheckOuts()                  { return todayCheckOuts; }
    public void setTodayCheckOuts(int v)            { this.todayCheckOuts = v; }

    public double getTodayRevenue()                 { return todayRevenue; }
    public void setTodayRevenue(double v)           { this.todayRevenue = v; }

    public int getTotalGuests()                     { return totalGuests; }
    public void setTotalGuests(int v)               { this.totalGuests = v; }

    public int getActiveReservations()              { return activeReservations; }
    public void setActiveReservations(int v)        { this.activeReservations = v; }

    public int getUnreadNotifications()             { return unreadNotifications; }
    public void setUnreadNotifications(int v)       { this.unreadNotifications = v; }

    @Override
    public String toString() {
        return "DashboardStats{" +
                "totalRooms=" + totalRooms +
                ", available=" + availableRooms +
                ", occupied=" + occupiedRooms +
                ", occupancyRate=" + getOccupancyRateFormatted() +
                ", todayRevenue=" + getTodayRevenueFormatted() +
                ", todayCheckIns=" + todayCheckIns +
                ", todayCheckOuts=" + todayCheckOuts +
                '}';
    }
}
