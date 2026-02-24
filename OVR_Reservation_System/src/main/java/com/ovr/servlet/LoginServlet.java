package com.ovr.servlet;

import com.ovr.model.User;
import com.ovr.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private AuthService authService = new AuthService();

    // ── FIX 1: Add doGet so browser can open /login without 405 ──
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // If already logged in, skip login page entirely
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Show login page
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = authService.login(username, password);

        if (user != null) {
            HttpSession session = request.getSession();

            // ── FIX 2: Store individual attributes so ALL servlets
            //           (Dashboard, Guest, Room, etc.) can read them ──
            session.setAttribute("userId",   user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role",     user.getRole());

            // Keep the full object too — nothing breaks if it's there
            session.setAttribute("loggedUser", user);

            // ── FIX 3: Redirect to the SERVLET not the JSP directly
            //           so DashboardServlet runs and loads all stats ──
            response.sendRedirect(request.getContextPath() + "/dashboard");

        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}