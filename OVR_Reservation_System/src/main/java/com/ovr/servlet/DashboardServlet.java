package com.ovr.servlet;

import com.ovr.model.DashboardStats;
import com.ovr.service.DashboardService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final DashboardService dashboardService = new DashboardService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DashboardStats stats = dashboardService.getStats();
        request.setAttribute("stats", stats);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
