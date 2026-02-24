package com.ovr.servlet;

import com.ovr.dao.GuestDAO;
import com.ovr.model.Guest;

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
 * OVR – Guest Servlet (Controller)
 *
 * URL Mapping : /guests
 * Role guard  : RECEPTIONIST only
 *
 * GET  /guests              → show all guests
 * GET  /guests?search=x     → filtered list
 * GET  /guests?action=get&id=x → JSON for edit modal pre-fill
 *
 * POST /guests?action=add    → insert new guest
 * POST /guests?action=edit   → update guest
 * POST /guests?action=delete → delete guest (guarded)
 */
@WebServlet("/guests")
public class GuestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(GuestServlet.class.getName());

    private final GuestDAO guestDAO = new GuestDAO();

    // ═══════════════════════════════════════════════════════════
    //  GET
    // ═══════════════════════════════════════════════════════════

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isReceptionist(request, response)) return;

        String action = request.getParameter("action");

        // ── Fetch single guest as JSON (for Edit modal pre-fill) ─
        if ("get".equals(action)) {
            fetchGuestJson(request, response);
            return;
        }

        // ── List / Search ────────────────────────────────────────
        try {
            String search = request.getParameter("search");
            List<Guest> guests;

            if (search != null && !search.isBlank()) {
                guests = guestDAO.searchGuests(search);
                request.setAttribute("searchKeyword", search);
            } else {
                guests = guestDAO.getAllGuests();
            }

            request.setAttribute("guests", guests);
            request.setAttribute("totalGuests", guests.size());

            // Pass any flash messages from redirect
            HttpSession session = request.getSession(false);
            if (session != null) {
                request.setAttribute("successMsg", session.getAttribute("successMsg"));
                request.setAttribute("errorMsg",   session.getAttribute("errorMsg"));
                session.removeAttribute("successMsg");
                session.removeAttribute("errorMsg");
            }

            request.getRequestDispatcher("/guests.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "GuestDAO error on GET", e);
            setFlash(request, "errorMsg", "Failed to load guests. Please try again.");
            response.sendRedirect(request.getContextPath() + "/guests");
        }
    }

    // ═══════════════════════════════════════════════════════════
    //  POST
    // ═══════════════════════════════════════════════════════════

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isReceptionist(request, response)) return;

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        switch (action == null ? "" : action) {
            case "add"    -> handleAdd(request, response);
            case "edit"   -> handleEdit(request, response);
            case "delete" -> handleDelete(request, response);
            default       -> response.sendRedirect(request.getContextPath() + "/guests");
        }
    }

    // ═══════════════════════════════════════════════════════════
    //  ACTION HANDLERS
    // ═══════════════════════════════════════════════════════════

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            Guest guest = buildGuestFromRequest(request);

            // Validation — full_name, country, phone_number are NOT NULL in DB
            String validationError = validate(guest);
            if (validationError != null) {
                setFlash(request, "errorMsg", validationError);
                response.sendRedirect(request.getContextPath() + "/guests");
                return;
            }

            int newId = guestDAO.addGuest(guest);
            if (newId > 0) {
                setFlash(request, "successMsg",
                        "Guest '" + guest.getFullName() + "' added successfully. ID: #" + newId);
            } else {
                setFlash(request, "errorMsg", "Failed to add guest. Please try again.");
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "GuestDAO error on add", e);
            setFlash(request, "errorMsg", "Database error while adding guest.");
        }
        response.sendRedirect(request.getContextPath() + "/guests");
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            Guest guest = buildGuestFromRequest(request);
            guest.setGuestId(parseInt(request.getParameter("guestId"), 0));

            if (guest.getGuestId() == 0) {
                setFlash(request, "errorMsg", "Invalid guest ID.");
                response.sendRedirect(request.getContextPath() + "/guests");
                return;
            }

            String validationError = validate(guest);
            if (validationError != null) {
                setFlash(request, "errorMsg", validationError);
                response.sendRedirect(request.getContextPath() + "/guests");
                return;
            }

            boolean updated = guestDAO.updateGuest(guest);
            setFlash(request,
                    updated ? "successMsg" : "errorMsg",
                    updated ? "Guest updated successfully."
                            : "No changes were saved. Guest not found.");

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "GuestDAO error on edit", e);
            setFlash(request, "errorMsg", "Database error while updating guest.");
        }
        response.sendRedirect(request.getContextPath() + "/guests");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int guestId = parseInt(request.getParameter("guestId"), 0);
            if (guestId == 0) {
                setFlash(request, "errorMsg", "Invalid guest ID.");
                response.sendRedirect(request.getContextPath() + "/guests");
                return;
            }

            String result = guestDAO.deleteGuest(guestId);
            switch (result) {
                case "DELETED" ->
                    setFlash(request, "successMsg", "Guest removed from the system.");
                case "HAS_RESERVATIONS" ->
                    setFlash(request, "errorMsg",
                            "Cannot delete guest — they have existing reservation records. " +
                            "Archive the reservation first.");
                default ->
                    setFlash(request, "errorMsg", "Guest not found.");
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "GuestDAO error on delete", e);
            setFlash(request, "errorMsg", "Database error while deleting guest.");
        }
        response.sendRedirect(request.getContextPath() + "/guests");
    }

    /**
     * Returns a single guest as a JSON object for the Edit modal's AJAX call.
     * GET /guests?action=get&id=5
     */
    private void fetchGuestJson(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = parseInt(request.getParameter("id"), 0);
            Guest g = guestDAO.getGuestById(id);
            response.setContentType("application/json; charset=UTF-8");
            if (g == null) {
                response.getWriter().write("{\"error\":\"Guest not found\"}");
            } else {
                response.getWriter().write(String.format(
                    "{\"guestId\":%d,\"fullName\":\"%s\",\"address\":\"%s\"," +
                    "\"country\":\"%s\",\"phoneCode\":\"%s\",\"phoneNumber\":\"%s\"}",
                    g.getGuestId(),
                    escapeJson(g.getFullName()),
                    escapeJson(g.getAddress()),
                    escapeJson(g.getCountry()),
                    escapeJson(g.getPhoneCode()),
                    escapeJson(g.getPhoneNumber())
                ));
            }
        } catch (SQLException e) {
            response.setContentType("application/json; charset=UTF-8");
            response.getWriter().write("{\"error\":\"Database error\"}");
        }
    }

    // ═══════════════════════════════════════════════════════════
    //  HELPERS
    // ═══════════════════════════════════════════════════════════

    private Guest buildGuestFromRequest(HttpServletRequest req) {
        Guest g = new Guest();
        g.setFullName(req.getParameter("fullName"));
        g.setAddress(req.getParameter("address"));
        g.setCountry(req.getParameter("country"));
        g.setPhoneCode(req.getParameter("phoneCode"));
        g.setPhoneNumber(req.getParameter("phoneNumber"));
        return g;
    }

    private String validate(Guest g) {
        if (g.getFullName() == null || g.getFullName().isBlank())
            return "Guest full name is required.";
        if (g.getCountry() == null || g.getCountry().isBlank())
            return "Country is required.";
        if (g.getPhoneNumber() == null || g.getPhoneNumber().isBlank())
            return "Phone number is required.";
        if (!g.getPhoneNumber().matches("\\d{6,15}"))
            return "Phone number must be 6–15 digits only.";
        return null;
    }

    private boolean isReceptionist(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        if (!"RECEPTIONIST".equals(session.getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/login?error=access_denied");
            return false;
        }
        return true;
    }

    private void setFlash(HttpServletRequest req, String key, String msg) {
        req.getSession().setAttribute(key, msg);
    }

    private int parseInt(String value, int fallback) {
        try { return Integer.parseInt(value); }
        catch (NumberFormatException | NullPointerException e) { return fallback; }
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"")
                .replace("\n", "\\n").replace("\r", "\\r");
    }
}
