
package com.shopsphere.dao;

import com.shopsphere.util.DBConnection;

import com.shopsphere.model.Order;
import java.util.Collections;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // Stores the details of each item during checkout.
    private static class CheckoutLine {
        private final long productId;
        private final int quantity;
        private final BigDecimal unitPrice;

        private CheckoutLine(long productId, int quantity,
                BigDecimal unitPrice) {
            this.productId = productId;
            this.quantity = quantity;
            this.unitPrice = unitPrice;
        }
    }

    // Places an order and saves its items in the database.
    public long placeOrder(long userId, String shippingAddress)
            throws SQLException {

        if (shippingAddress == null
                || shippingAddress.trim().isEmpty()
                || shippingAddress.trim().length() > 500) {
            throw new IllegalArgumentException(
                    "Please enter a valid shipping address.");
        }

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {
                List<CheckoutLine> lines = new ArrayList<>();
                BigDecimal total = BigDecimal.ZERO;

                // Read the user's cart and current product prices.
                String cartSql = "SELECT ci.product_id, ci.quantity, p.price " +
                        "FROM cart_items ci " +
                        "JOIN products p " +
                        "ON ci.product_id = p.product_id " +
                        "WHERE ci.user_id = ? " +
                        "FOR UPDATE";

                try (PreparedStatement ps = con.prepareStatement(cartSql)) {

                    ps.setLong(1, userId);

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {

                            long productId = rs.getLong("product_id");

                            int quantity = rs.getInt("quantity");

                            BigDecimal price = rs.getBigDecimal("price");

                            if (quantity <= 0
                                    || price == null
                                    || price.signum() < 0) {
                                throw new SQLException(
                                        "Invalid cart item or product price.");
                            }

                            lines.add(new CheckoutLine(
                                    productId, quantity, price));

                            BigDecimal itemTotal = price.multiply(
                                    BigDecimal.valueOf(quantity));

                            total = total.add(itemTotal);
                        }
                    }
                }

                // Do not place an order if the cart is empty.
                if (lines.isEmpty()) {
                    throw new SQLException(
                            "Your cart is empty. Add a product first.");
                }

                // Insert the main order record.
                long orderId;

                String orderSql = "INSERT INTO orders " +
                        "(user_id, total_amount, shipping_address) " +
                        "VALUES (?, ?, ?)";

                try (PreparedStatement ps = con.prepareStatement(
                        orderSql, Statement.RETURN_GENERATED_KEYS)) {

                    ps.setLong(1, userId);
                    ps.setBigDecimal(2, total);
                    ps.setString(3, shippingAddress.trim());

                    int rowsInserted = ps.executeUpdate();

                    if (rowsInserted != 1) {
                        throw new SQLException(
                                "Could not create the order.");
                    }

                    try (ResultSet keys = ps.getGeneratedKeys()) {

                        if (!keys.next()) {
                            throw new SQLException(
                                    "Could not retrieve the order ID.");
                        }

                        orderId = keys.getLong(1);
                    }
                }

                // Insert each product into order_items.
                String itemSql = "INSERT INTO order_items " +
                        "(order_id, product_id, quantity, unit_price) " +
                        "VALUES (?, ?, ?, ?)";

                try (PreparedStatement ps = con.prepareStatement(itemSql)) {

                    for (CheckoutLine line : lines) {
                        ps.setLong(1, orderId);
                        ps.setLong(2, line.productId);
                        ps.setInt(3, line.quantity);
                        ps.setBigDecimal(4, line.unitPrice);
                        ps.addBatch();
                    }

                    ps.executeBatch();
                }

                // Clear the cart only after order records are inserted.
                String clearCartSql = "DELETE FROM cart_items WHERE user_id = ?";

                try (PreparedStatement ps = con.prepareStatement(clearCartSql)) {

                    ps.setLong(1, userId);
                    ps.executeUpdate();
                }

                // Commit all database changes together.
                con.commit();

                return orderId;

            } catch (SQLException | RuntimeException e) {

                // Undo all changes if any step fails.
                try {
                    con.rollback();
                } catch (SQLException rollbackError) {
                    e.addSuppressed(rollbackError);
                }

                throw e;
            }
        }
    }

    // Checks that an order belongs to the specified user.
    public boolean orderBelongsToUser(long orderId, long userId)
            throws SQLException {

        String sql = "SELECT 1 FROM orders " +
                "WHERE order_id = ? AND user_id = ?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, orderId);
            ps.setLong(2, userId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public List<Order> getOrdersByUserId(long userId)
            throws SQLException {

        List<Order> orders = new ArrayList<>();

        String sql = "SELECT order_id, user_id, total_amount, status, " +
                "shipping_address, created_at " +
                "FROM orders " +
                "WHERE user_id = ? " +
                "ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Order order = new Order();

                    order.setOrderId(rs.getLong("order_id"));
                    order.setUserId(rs.getLong("user_id"));
                    order.setTotalAmount(
                            rs.getBigDecimal("total_amount"));
                    order.setStatus(rs.getString("status"));
                    order.setShippingAddress(
                            rs.getString("shipping_address"));
                    order.setCreatedAt(
                            rs.getTimestamp("created_at"));

                    orders.add(order);
                }
            }
        }

        return orders;
    }

}
