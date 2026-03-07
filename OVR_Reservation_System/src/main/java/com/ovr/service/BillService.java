package com.ovr.service;

import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 * ============================================================
 *  CIS6003 — Ocean View Resort Reservation System
 *  Service   : BillService
 *  Purpose   : Calculates stay duration and total billing amount
 *              Bill is NOT stored in DB — derived at runtime.
 *  Author    : ST12345678
 * ============================================================
 */
public class BillService {

    // ── Used by BillServlet (passes LocalDate from Reservation) ──────────────
    public long calculateNights(LocalDate checkIn, LocalDate checkOut) {
        if (checkIn == null || checkOut == null) return 1;
        long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
        return Math.max(1, nights);
    }

    // ── Used by JUnit tests (passes java.sql.Date) ────────────────────────────
    public long calculateNights(Date checkIn, Date checkOut) {
        if (checkIn == null || checkOut == null) return 1;
        long nights = ChronoUnit.DAYS.between(
            checkIn.toLocalDate(),
            checkOut.toLocalDate()
        );
        return Math.max(1, nights);
    }

    // ── Used by both BillServlet and JUnit tests ──────────────────────────────
    public double calculateTotal(long nights, double pricePerNight) {
        return nights * pricePerNight;
    }
}
