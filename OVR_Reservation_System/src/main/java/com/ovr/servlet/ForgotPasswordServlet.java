package com.ovr.servlet;

import com.ovr.dao.UserDAO;
import com.ovr.model.User;
import com.ovr.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Random;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    /**
     * Handles the initial Forgot Password form submission
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        User user = userDAO.findByUsername(username);

        // Verify if user exists and email matches
        if (user != null && user.getEmail().equalsIgnoreCase(email)) {
            generateAndSendOTP(request, user);
            response.sendRedirect("otp-verify.jsp");
        } else {
            request.setAttribute("error", "Username and Email do not match our records.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
        }
    }

    /**
     * Handles the "Resend OTP" request from the verification page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("resetUser");

        if (username != null) {
            User user = userDAO.findByUsername(username);
            if (user != null) {
                generateAndSendOTP(request, user);
                // Redirect back with a success message for the UI
                response.sendRedirect("otp-verify.jsp?resend=success");
                return;
            }
        }
        
        // If session expired or user not found, send back to start
        response.sendRedirect("forgot-password.jsp");
    }

    /**
     * Helper method to generate OTP, set session attributes, and send email
     */
    private void generateAndSendOTP(HttpServletRequest request, User user) {
        // Generate 6-digit OTP
        String otp = String.valueOf(100000 + new Random().nextInt(900000));
        
        // Set Expiration Time (Current Time + 5 Minutes)
        long expiryTime = System.currentTimeMillis() + (5 * 60 * 1000);

        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("otpExpiry", expiryTime);
        session.setAttribute("resetUser", user.getUsername());

        // Send the real email via SMTP
        EmailUtil.sendOTP(user.getEmail(), otp);
        
        // Optional: Log to console for debugging
        System.out.println("OTP sent to: " + user.getEmail() + " | Code: " + otp);
    }
}