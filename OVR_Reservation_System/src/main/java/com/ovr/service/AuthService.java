package com.ovr.service;

import com.ovr.dao.UserDAO;
import com.ovr.model.User;
import com.ovr.util.PasswordHashUtil;

public class AuthService {

    private UserDAO userDAO = new UserDAO();

    public User login(String username, String password) {
        User user = userDAO.findByUsername(username);

        // This line will now work perfectly!
        if (user != null && PasswordHashUtil.checkPassword(password, user.getPassword())) {
            return user;
        }

        return null;
    }

    public boolean register(String username, String password, String email) {
        String hashedPassword = PasswordHashUtil.hashPassword(password);
        User user = new User(username, hashedPassword, email, "RECEPTIONIST");
        return userDAO.registerUser(user);
    }
}