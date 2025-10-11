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
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");

        User user = new User(0, name, email, password, phone, "customer", location);
        int result = userDAO.registerUser(user);

        if (result == 0) {
            request.getSession().setAttribute("message", "Registration successful! Please login.");
            response.sendRedirect("login.jsp");
        } else if (result == 1) {
            request.getSession().setAttribute("error", "Email already exists. Please use a different email.");
            response.sendRedirect("customerRegister.jsp");
        } else {
            request.getSession().setAttribute("error", "Registration failed due to database error.");
            response.sendRedirect("customerRegister.jsp");
        }
    }
}
