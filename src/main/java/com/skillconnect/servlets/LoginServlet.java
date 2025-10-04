package com.skillconnect.servlets;

import java.io.IOException;
import java.sql.*;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.security.SecureRandom;
import java.math.BigInteger;
import at.favre.lib.crypto.bcrypt.BCrypt;

@WebServlet(name="LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");

    private String generateCsrfToken() {
        SecureRandom random = new SecureRandom();
        return new BigInteger(130, random).toString(32);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // CSRF protection
        String sessionToken = (String) request.getSession().getAttribute("csrfToken");
        String requestToken = request.getParameter("csrfToken");
        if (sessionToken == null || !sessionToken.equals(requestToken)) {
            response.sendRedirect("login.jsp?error=csrf");
            return;
        }
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Server-side validation
        if (email == null || !EMAIL_PATTERN.matcher(email).matches() || email.length() > 150) {
            response.sendRedirect("login.jsp?error=invalid");
            return;
        }
        if (password == null || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=invalid");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, name, password FROM users WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email.trim().toLowerCase());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), hashedPassword);
                if (result.verified) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("userName", rs.getString("name"));
                    response.sendRedirect("dashboard.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=invalid");
                }
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }
        } catch (SQLException e) {
            // Log the error internally, don't expose to user
            getServletContext().log("Database error during login", e);
            e.printStackTrace(); // Print stack trace for debugging
            response.sendRedirect("login.jsp?error=server");
        }
    }
}
