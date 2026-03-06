package com.ovr.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * LoginFilter — redirects unauthenticated users to login page.
 * Applies to every URL except /login, /register, and static assets.
 */
@WebFilter("/*")
public class LoginFilter implements Filter {

    // Public paths that do NOT need authentication
    private static final String[] PUBLIC_PATHS = {
        "/login", "/register", "/forgot-password",
        "/verify-otp", "/reset-password",
        "/login.jsp", "/register.jsp",
        "/forgot-password.jsp", "/otp-verify.jsp", "/reset-password.jsp"
    };

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getServletPath();

        // Allow public paths through
        for (String pub : PUBLIC_PATHS) {
            if (path.equals(pub) || path.startsWith(pub)) {
                chain.doFilter(req, res);
                return;
            }
        }

        // Allow static resources (CSS, JS, images)
        if (path.startsWith("/css/") || path.startsWith("/js/")
                || path.startsWith("/images/") || path.endsWith(".css")
                || path.endsWith(".js") || path.endsWith(".png")
                || path.endsWith(".jpg") || path.endsWith(".ico")) {
            chain.doFilter(req, res);
            return;
        }

        // Check session
        HttpSession session = request.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("userId") != null);

        if (loggedIn) {
            chain.doFilter(req, res);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}
