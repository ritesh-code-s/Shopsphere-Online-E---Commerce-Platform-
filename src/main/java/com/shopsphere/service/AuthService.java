
package com.shopsphere.service;

import com.shopsphere.dao.UserDAO;
import com.shopsphere.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.SQLException;

public class AuthService {

    private final UserDAO userDAO;

    public AuthService() {
        this.userDAO = new UserDAO();
    }

    // Register a new customer.
    public long register(String fullName, String email,
            String plainPassword) throws SQLException {

        if (fullName == null || fullName.isBlank()) {
            throw new IllegalArgumentException(
                    "Full name is required.");
        }

        String normalizedFullName = fullName.trim();
        String normalizedEmail;

        if (normalizedFullName.length() > 100) {
            throw new IllegalArgumentException(
                    "Full name cannot exceed 100 characters.");
        }

        if (email == null || email.isBlank()) {
            throw new IllegalArgumentException(
                    "Email address is required.");
        }

        normalizedEmail = email.trim().toLowerCase(
                java.util.Locale.ROOT);

        if (normalizedEmail.length() > 150
                || !normalizedEmail.matches(
                        "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            throw new IllegalArgumentException(
                    "Enter a valid email address.");
        }

        if (plainPassword == null || plainPassword.length() < 8) {
            throw new IllegalArgumentException(
                    "Password must contain at least 8 characters.");
        }

        // BCrypt has a 72-byte password limit.
        if (plainPassword.getBytes(
                java.nio.charset.StandardCharsets.UTF_8).length > 72) {
            throw new IllegalArgumentException(
                    "Password must not exceed 72 bytes.");
        }

        // Check for an existing account.
        if (userDAO.findByEmail(normalizedEmail) != null) {
            throw new IllegalArgumentException(
                    "An account with this email already exists.");
        }

        // Hash the password before storing it.
        String passwordHash = BCrypt.hashpw(
                plainPassword, BCrypt.gensalt(12));

        User user = new User(
                normalizedFullName,
                normalizedEmail,
                passwordHash,
                "CUSTOMER");

        return userDAO.register(user);
    }

    // Authenticate an existing user.
    public User login(String email, String plainPassword)
            throws SQLException {

        if (email == null || email.isBlank()
                || plainPassword == null || plainPassword.isEmpty()) {
            return null;
        }

        String normalizedEmail = email.trim().toLowerCase(
                java.util.Locale.ROOT);

        if (normalizedEmail.length() > 150) {
            return null;
        }

        User user = userDAO.findByEmail(normalizedEmail);

        if (user == null || user.getPasswordHash() == null) {
            return null;
        }

        if (plainPassword.getBytes(
                java.nio.charset.StandardCharsets.UTF_8).length > 72) {
            return null;
        }

        boolean passwordMatches = BCrypt.checkpw(
                plainPassword, user.getPasswordHash());

        return passwordMatches ? user : null;
    }
}
