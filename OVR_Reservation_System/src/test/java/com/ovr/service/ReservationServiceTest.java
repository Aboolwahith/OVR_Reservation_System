package com.ovr.service;

import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

import java.sql.Date;
import java.time.LocalDate;

/**
 * ============================================================
 *  CIS6003 — Ocean View Resort Reservation System
 *  Test Class : ReservationServiceTest
 *  Tests      : TC-RES-01, TC-RES-02, TC-RES-03, TC-RES-04, TC-RES-05
 *  Author     : ST12345678
 *  Tool       : JUnit 5 (Jupiter)
 *
 *  ✅ No database required — pure unit tests on service logic
 * ============================================================
 */
@TestMethodOrder(MethodOrderer.DisplayName.class)
@DisplayName("ReservationService — Date Validation and Number Generation Tests")
public class ReservationServiceTest {

    private ReservationService service;

    @BeforeEach
    void setUp() {
        service = new ReservationService();
    }

    // ── TC-RES-01 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-RES-01: isValidDateRange() must return TRUE for valid future date range")
    void testValidDateRange() {
        // GIVEN — check-out is 3 days after check-in (both in future)
        Date checkIn  = Date.valueOf(LocalDate.now().plusDays(1));
        Date checkOut = Date.valueOf(LocalDate.now().plusDays(4));

        // WHEN
        boolean result = service.isValidDateRange(checkIn, checkOut);

        // THEN
        assertTrue(result,
            "isValidDateRange() must return true when check-out is after check-in");
    }

    // ── TC-RES-02 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-RES-02: isValidDateRange() must return FALSE when check-in equals check-out")
    void testSameDayCheckoutRejected() {
        // GIVEN — same date for both check-in and check-out
        Date sameDay = Date.valueOf(LocalDate.now().plusDays(2));

        // WHEN
        boolean result = service.isValidDateRange(sameDay, sameDay);

        // THEN — a zero-night stay is not valid
        assertFalse(result,
            "isValidDateRange() must return false when check-in equals check-out (0 nights)");
    }

    // ── TC-RES-03 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-RES-03: isValidDateRange() must return FALSE when check-out is before check-in")
    void testReversedDatesRejected() {
        // GIVEN — check-out is BEFORE check-in (reversed)
        Date checkIn  = Date.valueOf(LocalDate.now().plusDays(5));
        Date checkOut = Date.valueOf(LocalDate.now().plusDays(2));

        // WHEN
        boolean result = service.isValidDateRange(checkIn, checkOut);

        // THEN
        assertFalse(result,
            "isValidDateRange() must return false when check-out is before check-in");
    }

    // ── TC-RES-04 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-RES-04: generateReservationNumber() must start with 'OVR-'")
    void testReservationNumberStartsWithOVR() {
        // WHEN
        String number = service.generateReservationNumber();

        // THEN
        assertNotNull(number, "Generated reservation number must not be null");
        assertTrue(number.startsWith("OVR-"),
            "Reservation number must start with 'OVR-', got: " + number);
    }

    // ── TC-RES-05 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-RES-05: generateReservationNumber() must be exactly 17 characters")
    void testReservationNumberLength() {
        // WHEN — format is OVR-YYYYMMDD-XXXX
        // OVR = 3, - = 1, YYYYMMDD = 8, - = 1, XXXX = 4 → total = 17
        String number = service.generateReservationNumber();

        // THEN
        assertEquals(17, number.length(),
            "OVR-YYYYMMDD-XXXX format must be exactly 17 characters, got: " + number);
    }

    // ── TC-RES-06 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-RES-06: generateReservationNumber() must contain today's date")
    void testReservationNumberContainsTodayDate() {
        // GIVEN — today's date in YYYYMMDD format
        String todayStr = LocalDate.now().toString().replace("-", "");

        // WHEN
        String number = service.generateReservationNumber();

        // THEN — number format: OVR-20260306-XXXX
        assertTrue(number.contains(todayStr),
            "Reservation number must contain today's date ("
            + todayStr + "), got: " + number);
    }

    // ── TC-RES-07 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-RES-07: isValidDateRange() must return FALSE when inputs are null")
    void testNullDatesReturnFalse() {
        assertFalse(service.isValidDateRange(null, null),
            "Both null dates must return false");
        assertFalse(service.isValidDateRange(
            Date.valueOf(LocalDate.now().plusDays(1)), null),
            "Null check-out must return false");
        assertFalse(service.isValidDateRange(
            null, Date.valueOf(LocalDate.now().plusDays(3))),
            "Null check-in must return false");
    }

    // ── TC-RES-08 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-RES-08: Two generated numbers must be unique")
    void testGeneratedNumbersAreUnique() {
        // WHEN — generate two numbers in sequence
        String number1 = service.generateReservationNumber();
        String number2 = service.generateReservationNumber();

        // THEN — UUID suffix ensures uniqueness
        assertNotEquals(number1, number2,
            "Each generated reservation number must be unique");
    }
}
