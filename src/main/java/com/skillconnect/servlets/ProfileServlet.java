package com.skillconnect.servlets;

import com.skillconnect.dao.UserDAO;
import com.skillconnect.models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");

        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setLocation(location);

        boolean success = userDAO.updateUser(user);
        if (success) {
            session.setAttribute("user", user);
            response.sendRedirect(user.getRole().equals("customer") ? "profile.jsp?message=Profile updated" : "workerDashboard.jsp?message=Profile updated");
        } else {
            response.sendRedirect(user.getRole().equals("customer") ? "profile.jsp?error=Update failed" : "workerDashboard.jsp?error=Update failed");
        }
    }
}
