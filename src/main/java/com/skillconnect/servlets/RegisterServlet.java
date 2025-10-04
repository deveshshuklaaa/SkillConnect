package com.skillconnect.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.SecureRandom;
import java.math.BigInteger;
import at.favre.lib.crypto.bcrypt.BCrypt;

@WebServlet(name="RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // CSRF protection
        String sessionToken = (String) request.getSession().getAttribute("csrfToken");
        String requestToken = request.getParameter("csrfToken");
        if (sessionToken == null || !sessionToken.equals(requestToken)) {
            response.sendRedirect("register.jsp?error=csrf");
            return;
        }
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Server-side validation
        if (name == null || name.trim().isEmpty() || name.length() > 150) {
            response.sendRedirect("register.jsp?error=name");
            return;
        }
        if (email == null || !EMAIL_PATTERN.matcher(email).matches() || email.length() > 150) {
            response.sendRedirect("register.jsp?error=email");
            return;
        }
        if (password == null || password.length() < 6) {
            response.sendRedirect("register.jsp?error=password");
            return;
        }

        // Hash the password
        String hashedPassword = BCrypt.withDefaults().hashToString(12, password.toCharArray());

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name.trim());
            ps.setString(2, email.trim().toLowerCase());
            ps.setString(3, hashedPassword);
            ps.executeUpdate();
            response.sendRedirect("login.jsp?registered=true");
        } catch (SQLException e) {
            // Log the error internally, don't expose to user
            getServletContext().log("Database error during registration", e);
            response.sendRedirect("register.jsp?error=server");
        }
    }
}
