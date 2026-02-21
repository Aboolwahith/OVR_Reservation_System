package com.ovr.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/verify-otp")
public class OTPVerifyServlet extends HttpServlet {

    /**
     * Handles the GET request to display the verification page.
     * This is useful if you want to show a "Resend successful" message.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String resend = request.getParameter("resend");
        if ("success".equals(resend)) {
            request.setAttribute("message", "A new code has been sent to your email.");
        }
        request.getRequestDispatcher("otp-verify.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String enteredOtp = request.getParameter("otp");
        
        String sessionOtp = (String) session.getAttribute("otp");
        Long expiryTime = (Long) session.getAttribute("otpExpiry");

        // 1. Check if OTP exists in session
        if (sessionOtp == null || expiryTime == null) {
            request.setAttribute("error", "Session expired. Please request a new OTP.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // 2. Check if OTP is expired (5 minute rule)
        if (System.currentTimeMillis() > expiryTime) {
            session.removeAttribute("otp");
            session.removeAttribute("otpExpiry");
            request.setAttribute("error", "OTP has expired. Please try again.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // 3. Verify OTP Correctness
        // Professional Tip: Use .trim() to avoid issues with accidental spaces
        if (enteredOtp != null && enteredOtp.trim().equals(sessionOtp)) {
            // Mark as verified to prevent URL manipulation of reset-password.jsp
            session.setAttribute("otpVerified", true); 
            response.sendRedirect("reset-password.jsp");
        } else {
            request.setAttribute("error", "Invalid OTP code. Please try again.");
            request.getRequestDispatcher("otp-verify.jsp").forward(request, response);
        }
    }
}