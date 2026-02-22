package com.ovr.util;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class PasswordHashUtilTest {

    @Test
    void testHashingLogic() {
        String pass = "staff123";
        String hash1 = PasswordHashUtil.hashPassword(pass);
        String hash2 = PasswordHashUtil.hashPassword(pass);
        
        assertEquals(hash1, hash2, "Same password must produce same hash in SHA-256");
    }

    @Test
    void testVerification() {
        String pass = "staff123";
        String hash = PasswordHashUtil.hashPassword(pass);
        
        assertTrue(PasswordHashUtil.checkPassword(pass, hash), "Correct password should verify");
        assertFalse(PasswordHashUtil.checkPassword("wrongpass", hash), "Wrong password should fail");
    }
}