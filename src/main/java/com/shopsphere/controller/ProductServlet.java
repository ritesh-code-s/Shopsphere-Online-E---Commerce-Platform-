
package com.shopsphere.controller;

import com.shopsphere.model.Product;
import com.shopsphere.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Product> products = productService.getAllProducts();

            request.setAttribute("products", products);

            request.getRequestDispatcher("/products.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            getServletContext().log("Unable to load products", e);

            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            request.setAttribute(
                    "errorMessage",
                    "We couldn't load the products right now. Please try again.");

            request.getRequestDispatcher("/products.jsp")
                    .forward(request, response);
        }
    }
}
