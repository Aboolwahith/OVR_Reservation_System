package com.ovr.service;

import com.ovr.model.User;
import com.ovr.dao.UserDAO;
import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

public class AuthServiceTest {

    private AuthService authService = new AuthService();
    private UserDAO userDAO = new UserDAO();
    private final String TEST_USER = "auth_test_admin";

    @Test
    @DisplayName("Complete Registration and Login Flow")
    void testAuthFlow() {
        // 1. Register a test user
        boolean registered = authService.register(TEST_USER, "secret123", "test@ovr.com");
        assertTrue(registered);

        // 2. Try Login (Testing your fixed logic!)
        User result = authService.login(TEST_USER, "secret123");
        assertNotNull(result, "User should be able to login after registration");
        assertEquals(TEST_USER, result.getUsername());

        // 3. Cleanup Database
        userDAO.deleteUser(TEST_USER);
    }
}