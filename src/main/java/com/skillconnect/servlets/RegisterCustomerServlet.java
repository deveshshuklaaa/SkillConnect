package com.skillconnect.servlets;

import com.skillconnect.dao.UserDAO;
import com.skillconnect.models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/registerCustomer")
public class RegisterCustomerServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("customerRegister.jsp?error=Passwords do not match.");
            return;
        }

        User user = new User(0, name, email, password, phone, "customer", location);
        int result = userDAO.registerUser(user);

        if (result == 0) {
            response.sendRedirect("customerRegister.jsp?message=Registration successful! Please login.");
        } else if (result == 1) {
            response.sendRedirect("customerRegister.jsp?error=Email already exists. Please use a different email.");
        } else {
            response.sendRedirect("customerRegister.jsp?error=Registration failed due to database error.");
        }
    }
}
