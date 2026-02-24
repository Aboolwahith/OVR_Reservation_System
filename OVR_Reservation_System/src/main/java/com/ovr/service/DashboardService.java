package com.ovr.service;

import com.ovr.dao.DashboardDAO;
import com.ovr.model.DashboardStats;
import java.sql.SQLException;

/**
 * OVR – Dashboard Service
 * Thin service layer between DashboardServlet and DashboardDAO.
 * All SQL logic lives in DashboardDAO — this class just coordinates.
 */
public class DashboardService {

    private DashboardDAO dao = new DashboardDAO();

    /**
     * Returns fully populated DashboardStats for the given receptionist.
     * @param userId – logged-in user's ID (for unread notifications count)
     */
    public DashboardStats getDashboardSummary(int userId) throws SQLException {
        // DashboardDAO handles ALL queries internally and returns
        // a fully populated bean — no need for getRawCounts() etc.
        DashboardStats stats = dao.getDashboardStats(userId);
        return stats;
    }
}