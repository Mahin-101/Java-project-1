package com.assignment.controller;

import com.assignment.dao.UserDAO;
import com.assignment.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole("student");

        UserDAO dao = new UserDAO();
        boolean success = dao.register(user);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/index.jsp?regSuccess=true");
        } else {
            request.setAttribute("error", "Email already registered. Please use a different email.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/register.jsp");
    }
}