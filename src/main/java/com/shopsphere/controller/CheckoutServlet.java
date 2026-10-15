
package com.shopsphere.controller;

import com.shopsphere.dao.CartDAO;
import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private CartDAO cartDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
        orderDAO = new OrderDAO();
    }

    private Long getLoggedInUserId(HttpSession session) {
        Object value = session.getAttribute("userId");

        if (value instanceof Number) {
            return ((Number) value).longValue();
        }

        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || getLoggedInUserId(session) == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            Long userId = getLoggedInUserId(session);
            List<CartItem> items = cartDAO.getCartItems(userId);

            if (items.isEmpty()) {
                session.setAttribute(
                        "checkoutError",
                        "Your cart is empty. Add a product first.");

                response.sendRedirect(
                        request.getContextPath() + "/cart");
                return;
            }

            BigDecimal total = BigDecimal.ZERO;

            for (CartItem item : items) {
                total = total.add(
                        item.getProductPrice().multiply(
                                BigDecimal.valueOf(item.getQuantity())));
            }

            request.setAttribute("cartItems", items);
            request.setAttribute("totalAmount", total);

            request.getRequestDispatcher("/checkout.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to load checkout.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || getLoggedInUserId(session) == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        String address = request.getParameter("shippingAddress");

        if (address == null || address.trim().isEmpty()
                || address.trim().length() > 500) {

            request.setAttribute(
                    "errorMessage",
                    "Enter a shipping address of up to 500 characters.");

            request.setAttribute("submittedAddress",
                    address == null ? "" : address);

            doGet(request, response);
            return;
        }
        try {
            long userId = getLoggedInUserId(session);

            long orderId = orderDAO.placeOrder(userId, address);

            response.sendRedirect(
                    request.getContextPath()
                            + "/order-success?orderId=" + orderId);

        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            doGet(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to place your order.", e);
        }
    }
}
