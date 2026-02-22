package com.ovr.servlet;

import com.ovr.dao.DashboardDAO;
import com.ovr.model.DashboardStats;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private DashboardDAO dashboardDAO = new DashboardDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        DashboardStats stats = dashboardDAO.getCounts();
        stats.setUpcomingCheckOuts(dashboardDAO.getUpcomingCheckOuts());
        
        Map<String, Integer> chartData = dashboardDAO.getMonthlyReservations();
        
        request.setAttribute("stats", stats);
        request.setAttribute("chartLabels", chartData.keySet());
        request.setAttribute("chartValues", chartData.values());
        
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}