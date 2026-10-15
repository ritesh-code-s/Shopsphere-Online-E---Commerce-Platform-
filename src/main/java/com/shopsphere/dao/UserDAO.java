
package com.shopsphere.dao;

import com.shopsphere.model.User;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

public class UserDAO {

    // Register a user and return the generated user ID.
    public long register(User user) throws SQLException {

        String sql = """
                INSERT INTO users
                    (full_name, email, password_hash)
                VALUES (?, ?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(
                        sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, user.getFullName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPasswordHash());

            int rowsInserted = statement.executeUpdate();

            if (rowsInserted == 0) {
                throw new SQLException("User registration failed.");
            }

            try (ResultSet keys = statement.getGeneratedKeys()) {
                if (keys.next()) {
                    long userId = keys.getLong(1);
                    user.setUserId(userId);
                    return userId;
                }
            }

            throw new SQLException("No user ID was generated.");
        }
    }

    // Find a user by email. Returns null if no user exists.
    public User findByEmail(String email) throws SQLException {

        String sql = """
                SELECT user_id, full_name, email, password_hash,
                       role, created_at
                FROM users
                WHERE email = ?
                """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet result = statement.executeQuery()) {

                if (result.next()) {
                    User user = new User();

                    user.setUserId(result.getLong("user_id"));
                    user.setFullName(result.getString("full_name"));
                    user.setEmail(result.getString("email"));
                    user.setPasswordHash(
                            result.getString("password_hash"));
                    user.setRole(result.getString("role"));

                    Timestamp createdAt = result.getTimestamp("created_at");
                    user.setCreatedAt(createdAt);

                    return user;
                }
            }
        }

        return null;
    }
}
