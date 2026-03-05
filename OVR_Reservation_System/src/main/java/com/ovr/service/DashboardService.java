package com.ovr.service;

import com.ovr.dao.DashboardDAO;
import com.ovr.model.DashboardStats;

public class DashboardService {

    private final DashboardDAO dashboardDAO = new DashboardDAO();

    public DashboardStats getStats() {
        DashboardStats stats = new DashboardStats();
        stats.setTotalReservations(dashboardDAO.getTotalReservations());
        stats.setTodayCheckIns    (dashboardDAO.getTodayCheckIns());
        stats.setTodayCheckOuts   (dashboardDAO.getTodayCheckOuts());
        stats.setTodayRevenue     (dashboardDAO.getTodayRevenue());
        return stats;
    }
}
