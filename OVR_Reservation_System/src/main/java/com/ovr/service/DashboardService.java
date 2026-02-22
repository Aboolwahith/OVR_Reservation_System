package com.ovr.service;

import com.ovr.dao.DashboardDAO;
import com.ovr.model.DashboardStats;

public class DashboardService {
    private DashboardDAO dashboardDAO = new DashboardDAO();

    public DashboardStats getDashboardData() {
        // Business logic can be added here
        return dashboardDAO.getCounts();
    }
}