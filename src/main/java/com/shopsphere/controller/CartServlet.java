
package com.shopsphere.controller;

import com.shopsphere.dao.CartDAO;
import com.shopsphere.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private CartDAO cartDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        long userId = ((Number) session.getAttribute("userId"))
                .longValue();

        try {
            List<CartItem> items = cartDAO.getCartItems(userId);

            request.setAttribute("cartItems", items);
            request.getRequestDispatcher("/cart.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Unable to load shopping cart.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        long userId = ((Number) session.getAttribute("userId"))
                .longValue();

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {

                long productId = Long.parseLong(
                        request.getParameter("productId"));

                if (productId <= 0) {
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid product ID.");
                    return;
                }

                cartDAO.addToCart(userId, productId);

            } else if ("update".equals(action)) {

                long cartItemId = Long.parseLong(
                        request.getParameter("cartItemId"));
                int quantity = Integer.parseInt(
                        request.getParameter("quantity"));

                if (cartItemId <= 0 || quantity < 1 || quantity > 99) {
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid cart item or quantity.");
                    return;
                }

                boolean updated = cartDAO.updateQuantity(
                        userId, cartItemId, quantity);

                if (!updated) {
                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Cart item not found.");
                    return;
                }

            } else if ("remove".equals(action)) {

                long cartItemId = Long.parseLong(
                        request.getParameter("cartItemId"));

                if (cartItemId <= 0) {
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid cart item ID.");
                    return;
                }

                cartDAO.removeFromCart(userId, cartItemId);

            } else {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid cart action.");
                return;
            }

            response.sendRedirect(
                    request.getContextPath() + "/cart");

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid numeric value.");
        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to update shopping cart.", e);
        }
    }
}
