package com.skillconnect.servlets;

import com.skillconnect.dao.BookingDAO;
import com.skillconnect.dao.RatingDAO;
import com.skillconnect.models.Booking;
import com.skillconnect.models.Rating;
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

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("rate".equals(action)) {
            if (!"customer".equals(user.getRole())) {
                response.sendRedirect("login.jsp");
                return;
            }
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int ratingValue = Integer.parseInt(request.getParameter("rating"));
            String feedback = request.getParameter("feedback");

            RatingDAO ratingDAO = new RatingDAO();
            Booking booking = bookingDAO.getBookingById(bookingId);
            if (booking != null && booking.getCustomerId() == user.getUserId()) {
                Rating rating = new Rating(0, bookingId, user.getUserId(), booking.getWorkerId(), ratingValue, feedback);
                ratingDAO.createRating(rating);
            }
            response.sendRedirect("bookingHistory.jsp?message=Rating submitted");
        } else {
            if (!"customer".equals(user.getRole())) {
                response.sendRedirect("login.jsp");
                return;
            }

            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int workerId = Integer.parseInt(request.getParameter("workerId"));
            Date date = Date.valueOf(request.getParameter("date"));
            Time time = Time.valueOf(request.getParameter("time") + ":00");

            Booking booking = new Booking(0, user.getUserId(), workerId, serviceId, date, time, "pending");
            boolean success = bookingDAO.createBooking(booking);

            if (success) {
                response.sendRedirect("customerDashboard.jsp?message=Booking created successfully");
            } else {
                response.sendRedirect("customerDashboard.jsp?error=Booking failed");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("cancel".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            bookingDAO.cancelBooking(bookingId);
            response.sendRedirect("customerDashboard.jsp");
        } else if ("accept".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            bookingDAO.updateBookingStatus(bookingId, "confirmed");
            response.sendRedirect("workerDashboard.jsp");
        } else if ("complete".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            bookingDAO.updateBookingStatus(bookingId, "completed");
            response.sendRedirect("workerDashboard.jsp");
        }
    }
}
