package com.ovr.service;

import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

import java.sql.Date;

/**
 * ============================================================
 *  CIS6003 — Ocean View Resort Reservation System
 *  Test Class : BillServiceTest
 *  Tests      : TC-BILL-01, TC-BILL-02, TC-BILL-03, TC-BILL-04
 *  Author     : ST12345678
 *  Tool       : JUnit 5 (Jupiter)
 *
 *  ✅ No database required — pure unit tests on billing logic
 *
 *  Room Rates Reference:
 *    OVR_001 STANDARD  Rs. 8,000 / night
 *    OVR_002 DELUXE    Rs.12,000 / night
 *    OVR_003 SUITE     Rs.18,000 / night
 * ============================================================
 */
@TestMethodOrder(MethodOrderer.DisplayName.class)
@DisplayName("BillService — Billing Calculation Tests")
public class BillServiceTest {

    private BillService billService;

    @BeforeEach
    void setUp() {
        billService = new BillService();
    }

    // ── TC-BILL-01 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-BILL-01: 3-night DELUXE stay must total Rs.36,000")
    void testStandardBillCalculation() {
        // GIVEN — guest checks in 2026-03-01 and checks out 2026-03-04 (3 nights)
        //         room type: DELUXE at Rs.12,000 per night
        Date checkIn  = Date.valueOf("2026-03-01");
        Date checkOut = Date.valueOf("2026-03-04");

        // WHEN
        long   nights = billService.calculateNights(checkIn, checkOut);
        double total  = billService.calculateTotal(nights, 12000.0);

        // THEN
        assertEquals(3, nights,
            "3-night stay (2026-03-01 to 2026-03-04) must calculate as 3 nights");
        assertEquals(36000.0, total, 0.01,
            "3 nights x Rs.12,000 must equal Rs.36,000");
    }

    // ── TC-BILL-02 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-BILL-02: Same-day checkout must charge minimum 1 night")
    void testMinimumOneNightEnforced() {
        // GIVEN — same date for check-in and check-out (0 raw nights)
        Date same = Date.valueOf("2026-03-01");

        // WHEN
        long nights = billService.calculateNights(same, same);

        // THEN — minimum 1 night must always be charged
        assertEquals(1, nights,
            "Minimum billing must always be 1 night even for same-day checkout");
    }

    // ── TC-BILL-03 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-BILL-03: 5-night STANDARD stay must total Rs.40,000")
    void testStandardRoomFiveNights() {
        // GIVEN — 5 nights, STANDARD room at Rs.8,000 per night
        Date checkIn  = Date.valueOf("2026-04-01");
        Date checkOut = Date.valueOf("2026-04-06");

        // WHEN
        long   nights = billService.calculateNights(checkIn, checkOut);
        double total  = billService.calculateTotal(nights, 8000.0);

        // THEN
        assertEquals(5, nights, "Must calculate 5 nights correctly");
        assertEquals(40000.0, total, 0.01,
            "5 nights x Rs.8,000 must equal Rs.40,000");
    }

    // ── TC-BILL-04 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-BILL-04: 2-night SUITE stay must total Rs.36,000")
    void testSuiteRoomTwoNights() {
        // GIVEN — 2 nights, SUITE at Rs.18,000 per night
        Date checkIn  = Date.valueOf("2026-05-10");
        Date checkOut = Date.valueOf("2026-05-12");

        // WHEN
        long   nights = billService.calculateNights(checkIn, checkOut);
        double total  = billService.calculateTotal(nights, 18000.0);

        // THEN
        assertEquals(2, nights, "Must calculate 2 nights correctly");
        assertEquals(36000.0, total, 0.01,
            "2 nights x Rs.18,000 must equal Rs.36,000");
    }

    // ── TC-BILL-05 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-BILL-05: calculateNights() must return 1 when checkOut is before checkIn")
    void testReversedDatesReturnMinimumOneNight() {
        // GIVEN — reversed dates (should not happen but system must handle safely)
        Date checkIn  = Date.valueOf("2026-03-05");
        Date checkOut = Date.valueOf("2026-03-02");

        // WHEN
        long nights = billService.calculateNights(checkIn, checkOut);

        // THEN — negative result clamped to minimum 1
        assertEquals(1, nights,
            "Reversed dates must return minimum 1 night (Math.max(1, negative))");
    }

    // ── TC-BILL-06 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-BILL-06: calculateNights() must return 1 when inputs are null")
    void testNullDatesReturnMinimumNight() {
        // GIVEN / WHEN / THEN
        // Cast to Date so Java knows which overloaded method to call
        assertEquals(1, billService.calculateNights((Date) null, (Date) null),
            "Null inputs must safely return minimum 1 night");
    }

    // ── TC-BILL-07 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-BILL-07: calculateTotal() must return 0.0 when nights is 0")
    void testZeroNightsProducesZeroTotal() {
        // Edge case: if nights is passed as 0 directly (bypassing calculateNights)
        double total = billService.calculateTotal(0, 12000.0);
        assertEquals(0.0, total, 0.01,
            "0 nights x any rate must equal Rs.0.00");
    }
}
