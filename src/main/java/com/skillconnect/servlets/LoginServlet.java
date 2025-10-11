package com.skillconnect.servlets;

import com.skillconnect.dao.AdminDAO;
import com.skillconnect.dao.UserDAO;
import com.skillconnect.models.Admin;
import com.skillconnect.models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private AdminDAO adminDAO = new AdminDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Try user login
        User user = userDAO.loginUser(email, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            if ("customer".equals(user.getRole())) {
                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("workerDashboard.jsp");
            }
            return;
        }

        // Try admin login
        Admin admin = adminDAO.loginAdmin(email, password); // Assuming email as username for simplicity
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            response.sendRedirect("adminDashboard.jsp");
            return;
        }

        // Failed
        response.sendRedirect("login.jsp?error=Invalid credentials");
    }
}
