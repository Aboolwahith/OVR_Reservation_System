package com.ovr.service;

import com.ovr.dao.ReservationDAO;
import com.ovr.dao.RoomTypeDAO;
import com.ovr.model.Reservation;
import com.ovr.model.RoomType;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public class ReservationService {

    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final RoomTypeDAO    roomTypeDAO    = new RoomTypeDAO();

    // ── Generate unique reservation number: OVR-YYYYMMDD-XXXX ────────────────
    public String generateReservationNumber() {
        String date = LocalDate.now().toString().replace("-", "");
        String uid  = UUID.randomUUID().toString().substring(0, 4).toUpperCase();
        return "OVR-" + date + "-" + uid;
    }

    // ── Validate: check-out must be AFTER check-in ────────────────────────────
    public boolean isValidDateRange(Date checkIn, Date checkOut) {
        if (checkIn == null || checkOut == null) return false;
        return checkOut.toLocalDate().isAfter(checkIn.toLocalDate());
    }

    // ── Add reservation ───────────────────────────────────────────────────────
    public boolean addReservation(Reservation r) {
        if (!isValidDateRange(r.getCheckIn(), r.getCheckOut())) {
            return false;
        }
        return reservationDAO.addReservation(r);
    }

    // ── Find by reservation number ────────────────────────────────────────────
    public Reservation findByNumber(String number) {
        return reservationDAO.findByReservationNumber(number);
    }

    // ── Get all ───────────────────────────────────────────────────────────────
    public List<Reservation> getAllReservations() {
        return reservationDAO.getAllReservations();
    }

    // ── Get all room types (for dropdown) ─────────────────────────────────────
    public List<RoomType> getAllRoomTypes() {
        return roomTypeDAO.getAllRoomTypes();
    }
}
