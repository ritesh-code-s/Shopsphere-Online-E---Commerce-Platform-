
package com.shopsphere.controller;

import com.shopsphere.dao.OrderDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/order-success")
public class OrderSuccessServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || !(session.getAttribute("userId") instanceof Number)) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        String orderIdParam = request.getParameter("orderId");

        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        final long orderId;

        try {
            orderId = Long.parseLong(orderIdParam);

            if (orderId <= 0) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        long userId = ((Number) session.getAttribute("userId")).longValue();

        try {
            if (!orderDAO.orderBelongsToUser(orderId, userId)) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            request.setAttribute("orderId", orderId);

            request.getRequestDispatcher("/order-success.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to verify the order.", e);
        }
    }
}
