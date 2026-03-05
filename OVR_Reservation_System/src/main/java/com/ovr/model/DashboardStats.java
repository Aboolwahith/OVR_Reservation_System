package com.ovr.model;

public class DashboardStats {

    private int    totalReservations;
    private int    todayCheckIns;
    private int    todayCheckOuts;
    private double todayRevenue;

    public DashboardStats() {}

    public int    getTotalReservations()              { return totalReservations; }
    public void   setTotalReservations(int n)         { this.totalReservations = n; }

    public int    getTodayCheckIns()                  { return todayCheckIns; }
    public void   setTodayCheckIns(int n)             { this.todayCheckIns = n; }

    public int    getTodayCheckOuts()                 { return todayCheckOuts; }
    public void   setTodayCheckOuts(int n)            { this.todayCheckOuts = n; }

    public double getTodayRevenue()                   { return todayRevenue; }
    public void   setTodayRevenue(double r)           { this.todayRevenue = r; }
}
