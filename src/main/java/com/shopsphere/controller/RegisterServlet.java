
package com.shopsphere.controller;

import com.shopsphere.service.AuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() {
        authService = new AuthService();
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            long userId = authService.register(
                    fullName, email, password);

            // Do not keep the submitted password in request data.
            password = null;

            request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute(
                    "successMessage",
                    "Your account has been created successfully.");

            response.sendRedirect(
                    request.getContextPath() + "/products");

        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/register.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            getServletContext().log(
                    "Registration database error", e);

            request.setAttribute(
                    "errorMessage",
                    "We couldn't create your account. "
                            + "Please try again.");

            request.getRequestDispatcher("/register.jsp")
                    .forward(request, response);
        }
    }
}
