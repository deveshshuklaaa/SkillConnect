<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillconnect.models.User" %>
<%@ page import="com.skillconnect.dao.BookingDAO" %>
<%@ page import="com.skillconnect.dao.ServiceDAO" %>
<%@ page import="com.skillconnect.dao.UserDAO" %>
<%@ page import="com.skillconnect.dao.RatingDAO" %>
<%@ page import="com.skillconnect.models.Booking" %>
<%@ page import="com.skillconnect.models.Service" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    BookingDAO bookingDAO = new BookingDAO();
    ServiceDAO serviceDAO = new ServiceDAO();
    UserDAO userDAO = new UserDAO();
    RatingDAO ratingDAO = new RatingDAO();
    List<Booking> bookings = bookingDAO.getBookingsByCustomer(user.getUserId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking History - SkillConnect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">SkillConnect</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="customerDashboard.jsp">Dashboard</a>
                <a class="nav-link active" href="bookingHistory.jsp">Booking History</a>
                <a class="btn btn-danger ms-2" href="logout.jsp">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2>My Booking History</h2>
        <table class="table">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Service</th>
                    <th>Worker</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Booking booking : bookings) { %>
                    <%
                        Service service = serviceDAO.getServiceById(booking.getServiceId());
                        User worker = userDAO.getUserById(booking.getWorkerId());
                        boolean hasRating = ratingDAO.getRatingByBooking(booking.getBookingId()) != null;
                    %>
                    <tr>
                        <td><%= booking.getBookingId() %></td>
                        <td><%= service != null ? service.getServiceName() : "Unknown" %></td>
                        <td><%= worker != null ? worker.getName() : "Unknown" %></td>
                        <td><%= booking.getBookingDate() %></td>
                        <td><%= booking.getBookingTime() %></td>
                        <td><%= booking.getStatus() %></td>
                        <td>
                            <% if ("pending".equals(booking.getStatus())) { %>
                                <a href="booking?action=cancel&bookingId=<%= booking.getBookingId() %>" class="btn btn-danger btn-sm">Cancel</a>
                            <% } else if ("completed".equals(booking.getStatus()) && !hasRating) { %>
                                <a href="rate.jsp?bookingId=<%= booking.getBookingId() %>" class="btn btn-warning btn-sm">Rate</a>
                            <% } %>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
