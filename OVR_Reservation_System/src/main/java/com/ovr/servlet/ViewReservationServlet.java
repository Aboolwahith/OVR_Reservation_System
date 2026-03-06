package com.ovr.servlet;

import com.ovr.dao.RoomTypeDAO;
import com.ovr.model.Reservation;
import com.ovr.model.RoomType;
import com.ovr.service.ReservationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/view-reservation")
public class ViewReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ReservationService service     = new ReservationService();
    private final RoomTypeDAO        roomTypeDAO = new RoomTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Always load all reservations for the dropdown ─────────────────────
        List<Reservation> allReservations = service.getAllReservations();
        request.setAttribute("allReservations", allReservations);

        // ── Search if number param provided ───────────────────────────────────
        String number = request.getParameter("number");
        if (number != null && !number.trim().isEmpty()) {
            Reservation r = service.findByNumber(number.trim());
            if (r != null) {
                RoomType rt = roomTypeDAO.findById(r.getRoomTypeId());
                request.setAttribute("reservation", r);
                request.setAttribute("roomType",    rt);
            } else {
                request.setAttribute("searchError",
                    "No reservation found for number: " + number.trim());
            }
        }

        request.getRequestDispatcher("view-reservation.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
