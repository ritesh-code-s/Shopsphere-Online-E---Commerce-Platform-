
package com.shopsphere.dao;

import com.shopsphere.model.CartItem;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // Add a product to the cart or increase its quantity.
    public void addToCart(long userId, long productId)
            throws SQLException {

        String checkSql = "SELECT cart_item_id FROM cart_items " +
                "WHERE user_id = ? AND product_id = ?";

        String insertSql = "INSERT INTO cart_items " +
                "(user_id, product_id, quantity) VALUES (?, ?, 1)";

        String updateSql = "UPDATE cart_items SET quantity = quantity + 1 " +
                "WHERE user_id = ? AND product_id = ?";

        try (Connection con = DBConnection.getConnection()) {

            try (PreparedStatement check = con.prepareStatement(checkSql)) {

                check.setLong(1, userId);
                check.setLong(2, productId);

                try (ResultSet rs = check.executeQuery()) {
                    if (rs.next()) {
                        try (PreparedStatement update = con.prepareStatement(updateSql)) {

                            update.setLong(1, userId);
                            update.setLong(2, productId);
                            update.executeUpdate();
                        }
                        return;
                    }
                }
            }

            try (PreparedStatement insert = con.prepareStatement(insertSql)) {

                insert.setLong(1, userId);
                insert.setLong(2, productId);
                insert.executeUpdate();
            }
        }
    }

    // Retrieve cart items along with their product details.
    public List<CartItem> getCartItems(long userId)
            throws SQLException {

        List<CartItem> items = new ArrayList<>();

        String sql = "SELECT ci.cart_item_id, ci.user_id, " +
                "ci.product_id, ci.quantity, " +
                "p.name, p.price, p.image_url " +
                "FROM cart_items ci " +
                "JOIN products p ON ci.product_id = p.product_id " +
                "WHERE ci.user_id = ? " +
                "ORDER BY ci.cart_item_id DESC";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    CartItem item = new CartItem();

                    item.setCartItemId(
                            rs.getLong("cart_item_id"));
                    item.setUserId(rs.getLong("user_id"));
                    item.setProductId(rs.getLong("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setProductName(rs.getString("name"));
                    item.setProductPrice(
                            rs.getBigDecimal("price"));
                    item.setImageUrl(rs.getString("image_url"));

                    items.add(item);
                }
            }
        }

        return items;
    }

    // Update quantity for a cart item belonging to the user.
    public boolean updateQuantity(long userId,
            long cartItemId,
            int quantity)
            throws SQLException {

        if (quantity < 1) {
            return false;
        }

        String sql = "UPDATE cart_items SET quantity = ? " +
                "WHERE cart_item_id = ? AND user_id = ?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setLong(2, cartItemId);
            ps.setLong(3, userId);

            return ps.executeUpdate() == 1;
        }
    }

    // Remove one cart item belonging to the user.
    public boolean removeFromCart(long userId, long cartItemId)
            throws SQLException {

        String sql = "DELETE FROM cart_items " +
                "WHERE cart_item_id = ? AND user_id = ?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, cartItemId);
            ps.setLong(2, userId);

            return ps.executeUpdate() == 1;
        }
    }

    // Remove all cart items belonging to the user.
    public void clearCart(long userId) throws SQLException {

        String sql = "DELETE FROM cart_items WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, userId);
            ps.executeUpdate();
        }
    }
}
