package com.skillconnect.servlets;

import com.skillconnect.dao.AdminDAO;
import com.skillconnect.dao.BookingDAO;
import com.skillconnect.dao.UserDAO;
import com.skillconnect.models.Admin;
import com.skillconnect.models.Booking;
import com.skillconnect.models.User;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
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
                // Check for pending booking
                Integer pendingServiceId = (Integer) session.getAttribute("pendingServiceId");
                Integer pendingWorkerId = (Integer) session.getAttribute("pendingWorkerId");
                Date pendingDate = (Date) session.getAttribute("pendingDate");
                Time pendingTime = (Time) session.getAttribute("pendingTime");
                if (pendingServiceId != null && pendingWorkerId != null && pendingDate != null && pendingTime != null) {
                    // Create booking
                    BookingDAO bookingDAO = new BookingDAO();
                    Booking booking = new Booking(0, user.getUserId(), pendingWorkerId, pendingServiceId, pendingDate, pendingTime, "pending");
                    boolean success = bookingDAO.createBooking(booking);
                    // Clear pending attributes
                    session.removeAttribute("pendingServiceId");
                    session.removeAttribute("pendingWorkerId");
                    session.removeAttribute("pendingDate");
                    session.removeAttribute("pendingTime");
                    if (success) {
                        response.sendRedirect("index.jsp?message=Booking created successfully");
                    } else {
                        response.sendRedirect("index.jsp?error=Booking failed");
                    }
                } else {
                    response.sendRedirect("index.jsp");
                }
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
