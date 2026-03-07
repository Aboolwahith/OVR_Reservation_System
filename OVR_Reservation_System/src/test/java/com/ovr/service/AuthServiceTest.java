package com.ovr.service;

import com.ovr.dao.UserDAO;
import com.ovr.model.User;

import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

/**
 * ============================================================
 *  CIS6003 — Ocean View Resort Reservation System
 *  Test Class : AuthServiceTest
 *  Tests      : TC-AUTH-01, TC-AUTH-02, TC-AUTH-03, TC-AUTH-04
 *  Author     : ST12345678
 *  Tool       : JUnit 5 (Jupiter)
 *
 *  ⚠ IMPORTANT: Requires MySQL running via XAMPP
 *               Database: ovr_reservation_db
 *               Each test cleans up its own data using @AfterEach
 * ============================================================
 */
@TestMethodOrder(MethodOrderer.DisplayName.class)
@DisplayName("AuthService — Registration and Login Tests")
public class AuthServiceTest {

    // ── Test dependencies ─────────────────────────────────────────────────────
    private AuthService authService;
    private UserDAO     userDAO;

    // Unique username per test run to avoid conflicts with existing data
    private static final String TEST_USERNAME =
        "testUser_" + System.currentTimeMillis();
    private static final String TEST_PASSWORD = "secure123";
    private static final String TEST_EMAIL    =
        "testuser_" + System.currentTimeMillis() + "@ovr.test";

    // ── Setup & Teardown ──────────────────────────────────────────────────────
    @BeforeEach
    void setUp() {
        authService = new AuthService();
        userDAO     = new UserDAO();
    }

    @AfterEach
    void cleanUp() {
        // Remove any test user created during the test
        userDAO.deleteUser(TEST_USERNAME);
        userDAO.deleteUser(TEST_USERNAME + "_dup");
    }

    // ── TC-AUTH-01 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-AUTH-01: register() must save new user to database")
    void testRegistrationSavesUser() {
        // WHEN — register a new receptionist account
        boolean result = authService.register(TEST_USERNAME, TEST_PASSWORD, TEST_EMAIL);

        // THEN — registration must succeed
        assertTrue(result,
            "register() must return true when a new user is saved successfully");

        // AND — user must exist in the database
        User saved = userDAO.findByUsername(TEST_USERNAME);
        assertNotNull(saved,
            "User must exist in the database after successful registration");
        assertEquals(TEST_USERNAME, saved.getUsername(),
            "Saved username must match the registered username");
    }

    // ── TC-AUTH-02 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-AUTH-02: login() must succeed after registration with correct password")
    void testLoginSucceedsAfterRegistration() {
        // GIVEN — user is registered first
        authService.register(TEST_USERNAME, TEST_PASSWORD, TEST_EMAIL);

        // WHEN — login with correct credentials
        User result = authService.login(TEST_USERNAME, TEST_PASSWORD);

        // THEN — login must return the User object
        assertNotNull(result,
            "login() must return a User object for valid credentials");
        assertEquals(TEST_USERNAME, result.getUsername(),
            "Returned User must have the correct username");
        assertEquals("RECEPTIONIST", result.getRole(),
            "Default role must be RECEPTIONIST");
    }

    // ── TC-AUTH-03 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-AUTH-03: login() must return null when wrong password supplied")
    void testLoginFailsWithWrongPassword() {
        // GIVEN — user is registered first
        authService.register(TEST_USERNAME, TEST_PASSWORD, TEST_EMAIL);

        // WHEN — login with wrong password
        User result = authService.login(TEST_USERNAME, "completelyWrongPass");

        // THEN — login must return null
        assertNull(result,
            "login() must return null when an incorrect password is supplied");
    }

    // ── TC-AUTH-04 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-AUTH-04: register() must return false for duplicate username")
    void testDuplicateUsernameRejected() {
        // GIVEN — first registration succeeds
        boolean first = authService.register(TEST_USERNAME, TEST_PASSWORD, TEST_EMAIL);
        assertTrue(first, "First registration must succeed");

        // WHEN — attempt to register same username again
        boolean duplicate = authService.register(
            TEST_USERNAME, "differentPass", "other@ovr.test");

        // THEN — second registration must fail
        assertFalse(duplicate,
            "register() must return false when the username already exists in the database");
    }

    // ── TC-AUTH-05 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-AUTH-05: login() must return null for non-existent username")
    void testLoginFailsForNonExistentUser() {
        // WHEN — login with a username that does not exist
        User result = authService.login("ghost_user_xyz_999", "anyPassword");

        // THEN — must return null safely
        assertNull(result,
            "login() must return null when the username does not exist in the database");
    }

    // ── TC-AUTH-06 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-AUTH-06: Password must be stored as SHA-256 hash, never plain text")
    void testPasswordIsStoredHashed() {
        // GIVEN — register a new user
        authService.register(TEST_USERNAME, TEST_PASSWORD, TEST_EMAIL);

        // WHEN — retrieve from DB directly
        User saved = userDAO.findByUsername(TEST_USERNAME);

        // THEN — stored password must NOT equal the plain text
        assertNotNull(saved);
        assertNotEquals(TEST_PASSWORD, saved.getPassword(),
            "Password must never be stored as plain text in the database");

        // AND — SHA-256 hex is always 64 chars
        assertEquals(64, saved.getPassword().length(),
            "Stored password hash must be exactly 64 characters (SHA-256 hex)");
    }
}
