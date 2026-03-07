package com.ovr.util;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer;

import static org.junit.jupiter.api.Assertions.*;

/**
 * ============================================================
 *  CIS6003 — Ocean View Resort Reservation System
 *  Test Class : PasswordHashUtilTest
 *  Tests      : TC-HASH-01, TC-HASH-02, TC-HASH-03, TC-HASH-04
 *  Author     : ST12345678
 *  Tool       : JUnit 5 (Jupiter)
 * ============================================================
 */
@TestMethodOrder(MethodOrderer.DisplayName.class)
@DisplayName("PasswordHashUtil — SHA-256 Hashing Tests")
public class PasswordHashUtilTest {

    // ── TC-HASH-01 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-HASH-01: hashPassword() must be deterministic for same input")
    void testHashingIsDeterministic() {
        // GIVEN — same plain text password
        String password = "staff123";

        // WHEN — hashed twice separately
        String hash1 = PasswordHashUtil.hashPassword(password);
        String hash2 = PasswordHashUtil.hashPassword(password);

        // THEN — both hashes must be identical
        assertNotNull(hash1, "Hash must not be null");
        assertNotNull(hash2, "Hash must not be null");
        assertEquals(hash1, hash2,
            "SHA-256 must produce the same hash for the same input every time");
    }

    // ── TC-HASH-02 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-HASH-02: hashPassword() must NOT return plain text")
    void testHashIsNotPlainText() {
        // GIVEN
        String password = "staff123";

        // WHEN
        String hash = PasswordHashUtil.hashPassword(password);

        // THEN — hash must never equal the plain text
        assertNotEquals(password, hash,
            "Stored hash must never equal the original plain-text password");

        // AND — SHA-256 hex string is always 64 characters
        assertEquals(64, hash.length(),
            "SHA-256 hex output must always be exactly 64 characters");
    }

    // ── TC-HASH-03 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-HASH-03: checkPassword() must return TRUE for correct password")
    void testCorrectPasswordVerifiesTrue() {
        // GIVEN — password hashed at registration
        String plainPassword = "securePass99";
        String storedHash    = PasswordHashUtil.hashPassword(plainPassword);

        // WHEN — same password checked at login
        boolean result = PasswordHashUtil.checkPassword(plainPassword, storedHash);

        // THEN — must return true
        assertTrue(result,
            "checkPassword() must return true when the correct password is supplied");
    }

    // ── TC-HASH-04 ────────────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-HASH-04: checkPassword() must return FALSE for wrong password")
    void testWrongPasswordVerifiesFalse() {
        // GIVEN — password hashed at registration
        String storedHash = PasswordHashUtil.hashPassword("securePass99");

        // WHEN — wrong password supplied at login
        boolean result = PasswordHashUtil.checkPassword("wrongPassword", storedHash);

        // THEN — must return false
        assertFalse(result,
            "checkPassword() must return false when an incorrect password is supplied");
    }

    // ── BONUS: Null safety ────────────────────────────────────────────────────
    @Test
    @DisplayName("TC-HASH-05: checkPassword() must return FALSE when inputs are null")
    void testNullInputReturnsFalse() {
        // GIVEN / WHEN / THEN
        assertFalse(PasswordHashUtil.checkPassword(null, "somehash"),
            "Null plain password must return false safely");
        assertFalse(PasswordHashUtil.checkPassword("password", null),
            "Null stored hash must return false safely");
    }
}
