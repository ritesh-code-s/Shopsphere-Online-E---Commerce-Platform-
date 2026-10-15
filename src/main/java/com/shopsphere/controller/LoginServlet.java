
package com.shopsphere.controller;

import com.shopsphere.model.User;
import com.shopsphere.service.AuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

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

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = authService.login(email, password);
            password = null;

            if (user == null) {
                request.setAttribute(
                        "errorMessage",
                        "Invalid email or password.");

                request.getRequestDispatcher("/login.jsp")
                        .forward(request, response);
                return;
            }

            // Create a fresh session after authentication.
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session = request.getSession(true);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", user.getFullName());
            session.setAttribute("userRole", user.getRole());

            response.sendRedirect(
                    request.getContextPath() + "/products");

        } catch (SQLException e) {
            getServletContext().log("Login database error", e);

            request.setAttribute(
                    "errorMessage",
                    "Login is temporarily unavailable. Please try again.");

            request.getRequestDispatcher("/login.jsp")
                    .forward(request, response);
        }
    }
}
