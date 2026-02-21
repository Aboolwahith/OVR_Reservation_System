package com.ovr.servlet;

import com.ovr.dao.UserDAO;
import com.ovr.util.PasswordHashUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Boolean isVerified = (Boolean) session.getAttribute("otpVerified");

        // Security check: If they didn't verify OTP, kick them out
        if (isVerified == null || !isVerified) {
            response.sendRedirect("forgot-password.jsp");
            return;
        }

        String username = (String) session.getAttribute("resetUser");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        String hashedPassword = PasswordHashUtil.hashPassword(password);
        boolean updated = userDAO.updatePassword(username, hashedPassword);

        if (updated) {
            // Clean up session completely
            session.invalidate(); 
            response.sendRedirect("login.jsp?success=reset");
        } else {
            request.setAttribute("error", "Database error. Failed to reset password.");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }
    }
}