
package com.shopsphere.dao;

import com.shopsphere.model.Product;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Retrieve all active products from the database.
    public List<Product> findAllActive() throws SQLException {

        String sql = """
                SELECT product_id, category_id, name, description,
                       price, stock_quantity, image_url, active, created_at
                FROM products
                WHERE active = TRUE
                ORDER BY product_id DESC
                """;

        List<Product> products = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet result = statement.executeQuery()) {

            while (result.next()) {
                products.add(mapProduct(result));
            }
        }

        return products;
    }

    // Retrieve one active product using its ID.
    public Product findById(long productId) throws SQLException {

        String sql = """
                SELECT product_id, category_id, name, description,
                       price, stock_quantity, image_url, active, created_at
                FROM products
                WHERE product_id = ? AND active = TRUE
                """;

        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, productId);

            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                    return mapProduct(result);
                }
            }
        }

        return null;
    }

    // Convert one database row into a Product object.
    private Product mapProduct(ResultSet result) throws SQLException {

        Product product = new Product();

        product.setProductId(result.getLong("product_id"));
        product.setCategoryId(result.getLong("category_id"));
        product.setName(result.getString("name"));
        product.setDescription(result.getString("description"));
        product.setPrice(result.getBigDecimal("price"));
        product.setStockQuantity(result.getInt("stock_quantity"));
        product.setImageUrl(result.getString("image_url"));
        product.setActive(result.getBoolean("active"));

        Timestamp createdAt = result.getTimestamp("created_at");
        product.setCreatedAt(createdAt);

        return product;
    }
}
