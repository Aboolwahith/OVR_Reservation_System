package com.ovr.service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 * BillService — pure business logic (no DB, no servlets).
 * Easy to unit-test with JUnit 5.
 */
public class BillService {

    /**
     * Calculate the number of nights between check-in and check-out.
     * A same-day check-in/check-out = 1 night (minimum billable stay).
     */
    public long calculateNights(LocalDate checkIn, LocalDate checkOut) {
        if (checkIn == null || checkOut == null) return 0;
        long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
        return nights <= 0 ? 1 : nights;   // minimum 1 night
    }

    /**
     * Calculate total bill amount.
     */
    public double calculateTotal(long nights, double pricePerNight) {
        if (nights <= 0 || pricePerNight <= 0) return 0.0;
        return nights * pricePerNight;
    }
}
