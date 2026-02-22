package com.ovr.util;

import java.security.MessageDigest;

public class PasswordHashUtil {

    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));

            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Checks if the raw password matches the stored hash
     */
    public static boolean checkPassword(String rawPassword, String storedHash) {
        if (rawPassword == null || storedHash == null) return false;
        
        // Hash the input password using the same logic
        String hashedInput = hashPassword(rawPassword);
        
        // Compare the two hashes
        return hashedInput.equals(storedHash);
    }
}