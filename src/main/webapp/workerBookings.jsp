<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillconnect.models.User" %>
<%@ page import="com.skillconnect.dao.BookingDAO" %>
<%@ page import="com.skillconnect.dao.UserDAO" %>
<%@ page import="com.skillconnect.dao.ServiceDAO" %>
<%@ page import="com.skillconnect.dao.RatingDAO" %>
<%@ page import="com.skillconnect.models.Booking" %>
<%@ page import="com.skillconnect.models.Service" %>
<%@ page import="com.skillconnect.models.Rating" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"worker".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    BookingDAO bookingDAO = new BookingDAO();
    UserDAO userDAO = new UserDAO();
    ServiceDAO serviceDAO = new ServiceDAO();
    RatingDAO ratingDAO = new RatingDAO();
    List<Booking> bookings = bookingDAO.getBookingsByWorker(user.getUserId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Worker Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="workerDashboard.jsp">SkillConnect</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="workerDashboard.jsp">Dashboard</a>
                <a class="nav-link" href="workerProfile.jsp">Profile</a>
                <a class="nav-link" href="workerServices.jsp">Services</a>
                <a class="btn btn-danger" href="logout.jsp">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2>My Bookings</h2>
        <% String message = request.getParameter("message"); %>
        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>
        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>
        <table class="table">
            <thead>
                <tr>
                    <th>Customer</th>
                    <th>Service</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Status</th>
                    <th>Rating</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Booking booking : bookings) { %>
                    <%
                        User customer = userDAO.getUserById(booking.getCustomerId());
                        Service service = serviceDAO.getServiceById(booking.getServiceId());
                        Rating rating = ratingDAO.getRatingByBooking(booking.getBookingId());
                    %>
                    <tr>
                        <td>
                            <%= customer != null ? customer.getName() : "Unknown" %>
                            <% if (customer != null && customer.getPhone() != null && !customer.getPhone().isEmpty()) { %>
                                <br><%= customer.getPhone() %>
                            <% } %>
                            <% if (customer != null && customer.getLocation() != null && !customer.getLocation().isEmpty()) { %>
                                <br><%= customer.getLocation() %>
                            <% } %>
                        </td>
                        <td><%= service != null ? service.getServiceName() : "Unknown" %></td>
                        <td><%= booking.getBookingDate() %></td>
                        <td><%= booking.getBookingTime() %></td>
                        <td><%= booking.getStatus() %></td>
                        <td>
                            <% if (rating != null) { %>
                                <span class="badge bg-warning text-dark"><%= rating.getRating() %> ★</span>
                                <% if (rating.getFeedback() != null && !rating.getFeedback().isEmpty()) { %>
                                    <br><small class="text-muted"><%= rating.getFeedback() %></small>
                                <% } %>
                            <% } else { %>
                                <span class="text-muted">Not rated</span>
                            <% } %>
                        </td>
                        <td>
                            <% if ("pending".equals(booking.getStatus())) { %>
                                <a href="booking?action=accept&bookingId=<%= booking.getBookingId() %>" class="btn btn-success btn-sm">Accept</a>
                                <a href="booking?action=reject&bookingId=<%= booking.getBookingId() %>" class="btn btn-danger btn-sm">Reject</a>
                            <% } else if ("confirmed".equals(booking.getStatus())) { %>
                                <a href="booking?action=complete&bookingId=<%= booking.getBookingId() %>" class="btn btn-primary btn-sm">Mark Complete</a>
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
