package com.ovr.dao;

import com.ovr.model.Reservation;

import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

import java.sql.Date;
import java.util.List;

/**
 * ============================================================
 *  CIS6003 — Ocean View Resort Reservation System
 *  Test Class : ReservationDAOTest
 *  Tests      : TC-DAO-01, TC-DAO-02, TC-DAO-03, TC-DAO-04
 *  Author     : ST12345678
 *  Tool       : JUnit 5 (Jupiter)
 *
 *  ⚠ IMPORTANT: Requires MySQL running via XAMPP
 *               Database: ovr_reservation_db
 *               Table   : reservations
 *               room_type_id=1 (STANDARD) must exist in room_types
 *
 *  Each test cleans up its own data using @AfterEach
 * ============================================================
 */
@TestMethodOrder(MethodOrderer.DisplayName.class)
@DisplayName("ReservationDAO — Database Integration Tests")
public class ReservationDAOTest {

    private ReservationDAO dao;

    // Unique test reservation number to avoid DB conflicts
    private static final String TEST_NUMBER =
        "OVR-TEST-" + System.currentTimeMillis();

    @BeforeEach
    void setUp() {
        dao = new ReservationDAO();
    }

    @AfterEach
    void cleanUp() {
        // Always delete test reservation after each test
        dao.deleteByReservationNumber(TEST_NUMBER);
    }

    // ── Helper: build a test Reservation object ───────────────────────────────
    private Reservation buildTestReservation() {
        Reservation r = new Reservation();
        r.setReservationNumber(TEST_NUMBER);
        r.setGuestName("Test Guest JUnit");
        r.setAddress("123 JUnit Test Street, Colombo");
        r.setContactNumber("0771234567");
        r.setRoomTypeId(1);  // OVR_001 STANDARD — must exist in DB
        r.setCheckIn(Date.valueOf("2026-06-01"));
        r.setCheckOut(Date.valueOf("2026-06-04"));
        return r;
    }

    // ── TC-DAO-01 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-DAO-01: addReservation() must save reservation to database")
    void testAddReservationSavesToDatabase() {
        // GIVEN
        Reservation r = buildTestReservation();

        // WHEN
        boolean saved = dao.addReservation(r);

        // THEN — addReservation must return true
        assertTrue(saved,
            "addReservation() must return true when reservation is saved successfully");
    }

    // ── TC-DAO-02 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-DAO-02: findByReservationNumber() must retrieve saved reservation")
    void testFindByReservationNumberReturnsCorrectData() {
        // GIVEN — save reservation first
        dao.addReservation(buildTestReservation());

        // WHEN — retrieve by unique number
        Reservation found = dao.findByReservationNumber(TEST_NUMBER);

        // THEN — must return correct data
        assertNotNull(found,
            "findByReservationNumber() must return a Reservation for a saved number");
        assertEquals(TEST_NUMBER, found.getReservationNumber(),
            "Retrieved reservation_number must match the saved value");
        assertEquals("Test Guest JUnit", found.getGuestName(),
            "Retrieved guest_name must match the saved value");
        assertEquals("0771234567", found.getContactNumber(),
            "Retrieved contact_number must match the saved value");
        assertEquals(1, found.getRoomTypeId(),
            "Retrieved room_type_id must match the saved value");
    }

    // ── TC-DAO-03 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-DAO-03: findByReservationNumber() must return null for non-existent number")
    void testFindByInvalidNumberReturnsNull() {
        // WHEN — search for a number that was never saved
        Reservation result = dao.findByReservationNumber("OVR-INVALID-0000");

        // THEN — must return null safely
        assertNull(result,
            "findByReservationNumber() must return null for a non-existent reservation number");
    }

    // ── TC-DAO-04 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-DAO-04: getAllReservations() must return a non-null List")
    void testGetAllReservationsReturnsNonNullList() {
        // WHEN — retrieve all reservations
        List<Reservation> list = dao.getAllReservations();

        // THEN — must never return null (empty list is acceptable)
        assertNotNull(list,
            "getAllReservations() must never return null (return empty List if no data)");
    }

    // ── TC-DAO-05 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-DAO-05: getAllReservations() count must increase after adding a reservation")
    void testGetAllReservationsCountIncreasesAfterSave() {
        // GIVEN — count before
        int countBefore = dao.getAllReservations().size();

        // WHEN — add a reservation
        dao.addReservation(buildTestReservation());

        // THEN — count must be one more
        int countAfter = dao.getAllReservations().size();
        assertEquals(countBefore + 1, countAfter,
            "getAllReservations() count must increase by 1 after saving a new reservation");
    }

    // ── TC-DAO-06 ─────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-DAO-06: deleteByReservationNumber() must remove reservation from database")
    void testDeleteReservationRemovesFromDatabase() {
        // GIVEN — save a reservation
        dao.addReservation(buildTestReservation());
        assertNotNull(dao.findByReservationNumber(TEST_NUMBER),
            "Reservation must exist before delete");

        // WHEN — delete it
        boolean deleted = dao.deleteByReservationNumber(TEST_NUMBER);

        // THEN — delete must succeed
        assertTrue(deleted, "deleteByReservationNumber() must return true");

        // AND — must no longer be retrievable
        Reservation afterDelete = dao.findByReservationNumber(TEST_NUMBER);
        assertNull(afterDelete,
            "Reservation must not be found in database after deletion");
    }
}
