package com.ovr.servlet;

import com.ovr.dao.DashboardDAO;
import com.ovr.dao.DashboardDAO.RecentReservation;
import com.ovr.model.DashboardStats;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * OVR – Dashboard Servlet (Controller)
 *
 * URL mapping : /dashboard
 * Role guard  : RECEPTIONIST only
 * Populates   : DashboardStats bean + Recent Reservations list → forwarded to dashboard.jsp
 *
 * Flow:
 *   Browser GET /dashboard
 *     → Session check (isLoggedIn?)
 *     → Role check (RECEPTIONIST?)
 *     → DashboardDAO.getDashboardStats()
 *     → Set request attributes
 *     → Forward to WEB-INF/views/dashboard.jsp
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(DashboardServlet.class.getName());

    private final DashboardDAO dashboardDAO = new DashboardDAO();

    // ═══════════════════════════════════════════════════════════
    //  GET — Load the Dashboard
    // ═══════════════════════════════════════════════════════════

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // ── 1. Session Guard ────────────────────────────────────
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ── 2. Role Guard ───────────────────────────────────────
        String role = (String) session.getAttribute("role");
        if (!"RECEPTIONIST".equals(role)) {
            // Admin has no dashboard — redirect to login
            response.sendRedirect(request.getContextPath() + "/login?error=access_denied");
            return;
        }

        // ── 3. Fetch Data from DAO ──────────────────────────────
        int userId = (int) session.getAttribute("userId");

        try {
            DashboardStats stats = dashboardDAO.getDashboardStats(userId);
            List<RecentReservation> recentReservations = dashboardDAO.getRecentReservations();

            // ── 4. Set Request Attributes for JSP ────────────────
            request.setAttribute("stats", stats);
            request.setAttribute("recentReservations", recentReservations);

            // Pass session info for the header
            request.setAttribute("loggedInUser",  session.getAttribute("username"));
            request.setAttribute("loggedInRole",  role);

            // ── 5. Forward to View ────────────────────────────────
            request.getRequestDispatcher("/dashboard.jsp")
            .forward(request, response);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Dashboard DAO error for userId=" + userId, e);
            request.setAttribute("errorMessage", "Unable to load dashboard data. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp")
                   .forward(request, response);
        }
    }

    // ═══════════════════════════════════════════════════════════
    //  POST — Refresh / AJAX endpoint (future use)
    // ═══════════════════════════════════════════════════════════

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Currently delegates to GET — can be extended for AJAX partial refresh
        doGet(request, response);
    }
}
