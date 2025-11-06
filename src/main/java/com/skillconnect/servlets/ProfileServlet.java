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

        String action = request.getParameter("action");
        if ("changePassword".equals(action)) {
            // Handle password change
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect(user.getRole().equals("customer") ? "profile.jsp?error=New passwords do not match" : "workerProfile.jsp?error=New passwords do not match");
                return;
            }

            boolean success = userDAO.changePassword(user.getUserId(), currentPassword, newPassword);
            if (success) {
                response.sendRedirect(user.getRole().equals("customer") ? "profile.jsp?message=Password changed successfully" : "workerProfile.jsp?message=Password changed successfully");
            } else {
                response.sendRedirect(user.getRole().equals("customer") ? "profile.jsp?error=Current password is incorrect" : "workerProfile.jsp?error=Current password is incorrect");
            }
            return;
        } else if ("deleteAccount".equals(action)) {
            // Handle account deletion
            String password = request.getParameter("password");
            User verifiedUser = userDAO.loginUser(user.getEmail(), password);
            if (verifiedUser == null) {
                response.sendRedirect(user.getRole().equals("customer") ? "profile.jsp?error=Incorrect password" : "workerProfile.jsp?error=Incorrect password");
                return;
            }
            boolean success = userDAO.deleteUser(user.getUserId());
            if (success) {
                session.invalidate();
                response.sendRedirect("index.jsp?message=Account deleted successfully");
            } else {
                response.sendRedirect(user.getRole().equals("customer") ? "profile.jsp?error=Failed to delete account" : "workerProfile.jsp?error=Failed to delete account");
            }
            return;
        }

        // Handle profile update
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
            response.sendRedirect(user.getRole().equals("customer") ? "profile.jsp?message=Profile updated successfully" : "workerProfile.jsp?message=Profile updated successfully");
        } else {
            response.sendRedirect(user.getRole().equals("customer") ? "profile.jsp?error=Profile update failed" : "workerProfile.jsp?error=Profile update failed");
        }
    }
}
