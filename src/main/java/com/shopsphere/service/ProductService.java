
package com.shopsphere.service;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.Product;

import java.sql.SQLException;
import java.util.List;

public class ProductService {

    private final ProductDAO productDAO;

    public ProductService() {
        this.productDAO = new ProductDAO();
    }

    // Return all active products for the catalogue.
    public List<Product> getAllProducts() throws SQLException {
        return productDAO.findAllActive();
    }

    // Return one active product, or null if it does not exist.
    public Product getProductById(long productId) throws SQLException {

        if (productId <= 0) {
            return null;
        }

        return productDAO.findById(productId);
    }
}
