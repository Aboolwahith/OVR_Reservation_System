package com.ovr.servlet;

import com.ovr.service.AuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
            return;
        }

        boolean registered = authService.register(username, password, email);

        if (registered) {
            response.sendRedirect("login.jsp?success=registered");
        } else {
            request.setAttribute("error", "Registration failed. Username may already exist.");
            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
        }
    }
}
