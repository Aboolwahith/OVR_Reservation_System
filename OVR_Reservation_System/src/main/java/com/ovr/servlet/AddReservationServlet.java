package com.ovr.servlet;

import com.ovr.model.Reservation;
import com.ovr.model.RoomType;
import com.ovr.service.ReservationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/add-reservation")
public class AddReservationServlet extends HttpServlet {

    private final ReservationService service = new ReservationService();

    // ── GET: show the form ────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<RoomType> roomTypes = service.getAllRoomTypes();
        request.setAttribute("roomTypes", roomTypes);
        request.getRequestDispatcher("add-reservation.jsp").forward(request, response);
    }

    // ── POST: save reservation ────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String guestName     = request.getParameter("guestName")     != null ? request.getParameter("guestName").trim()     : "";
        String address       = request.getParameter("address")       != null ? request.getParameter("address").trim()       : "";
        String contactNumber = request.getParameter("contactNumber") != null ? request.getParameter("contactNumber").trim() : "";
        String roomTypeIdStr = request.getParameter("roomTypeId");
        String checkInStr    = request.getParameter("checkIn");
        String checkOutStr   = request.getParameter("checkOut");

        // ── Validation ────────────────────────────────────────────────────────
        if (guestName.isEmpty() || address.isEmpty() || contactNumber.isEmpty()
                || roomTypeIdStr == null || checkInStr == null || checkOutStr == null
                || checkInStr.isEmpty() || checkOutStr.isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            reloadForm(request, response);
            return;
        }

        Date checkIn, checkOut;
        try {
            checkIn  = Date.valueOf(checkInStr);
            checkOut = Date.valueOf(checkOutStr);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date format.");
            reloadForm(request, response);
            return;
        }

        if (!service.isValidDateRange(checkIn, checkOut)) {
            request.setAttribute("error", "Check-out date must be after check-in date.");
            reloadForm(request, response);
            return;
        }

        // ── Build & save ──────────────────────────────────────────────────────
        Reservation r = new Reservation();
        r.setReservationNumber(service.generateReservationNumber());
        r.setGuestName        (guestName);
        r.setAddress          (address);
        r.setContactNumber    (contactNumber);
        r.setRoomTypeId       (Integer.parseInt(roomTypeIdStr));
        r.setCheckIn          (checkIn);
        r.setCheckOut         (checkOut);

        boolean saved = service.addReservation(r);

        if (saved) {
            response.sendRedirect(request.getContextPath()
                + "/view-reservation?number=" + r.getReservationNumber()
                + "&success=added");
        } else {
            request.setAttribute("error", "Failed to save reservation. Please try again.");
            reloadForm(request, response);
        }
    }

    private void reloadForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("roomTypes", service.getAllRoomTypes());
        request.getRequestDispatcher("add-reservation.jsp").forward(request, response);
    }
}
