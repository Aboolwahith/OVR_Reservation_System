package com.ovr.servlet;

import com.ovr.dao.RoomTypeDAO;
import com.ovr.model.Reservation;
import com.ovr.model.RoomType;
import com.ovr.service.BillService;
import com.ovr.service.ReservationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();
    private final RoomTypeDAO        roomTypeDAO        = new RoomTypeDAO();
    private final BillService        billService        = new BillService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String number = request.getParameter("number");

        if (number == null || number.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/view-reservation");
            return;
        }

        Reservation r = reservationService.findByNumber(number.trim());

        if (r == null) {
            request.setAttribute("error", "Reservation not found: " + number);
            request.getRequestDispatcher("bill.jsp").forward(request, response);
            return;
        }

        RoomType rt = roomTypeDAO.findById(r.getRoomTypeId());

        long   nights = billService.calculateNights(
                            r.getCheckIn().toLocalDate(),
                            r.getCheckOut().toLocalDate());
        double total  = billService.calculateTotal(nights, rt.getPricePerNight().doubleValue());

        request.setAttribute("reservation", r);
        request.setAttribute("roomType",    rt);
        request.setAttribute("nights",      nights);
        request.setAttribute("total",       total);

        request.getRequestDispatcher("bill.jsp").forward(request, response);
    }
}
