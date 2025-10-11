<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillconnect.models.User" %>
<%@ page import="com.skillconnect.dao.ServiceDAO" %>
<%@ page import="com.skillconnect.dao.BookingDAO" %>
<%@ page import="com.skillconnect.dao.UserDAO" %>
<%@ page import="com.skillconnect.models.Service" %>
<%@ page import="com.skillconnect.models.Booking" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"worker".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    ServiceDAO serviceDAO = new ServiceDAO();
    BookingDAO bookingDAO = new BookingDAO();
    UserDAO userDAO = new UserDAO();
    List<Service> services = serviceDAO.getServicesByWorker(user.getUserId());
    List<Booking> bookings = bookingDAO.getBookingsByWorker(user.getUserId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Worker Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="#">SkillConnect</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="#profile">Profile</a>
                <a class="nav-link" href="#services">Services</a>
                <a class="nav-link" href="#bookings">Bookings</a>
                <a class="btn btn-danger" href="logout.jsp">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2>Welcome, <%= user.getName() %></h2>
        <% String message = request.getParameter("message"); %>
        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>
        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <!-- Profile Management -->
        <div id="profile" class="mt-5">
            <h3>Profile Management</h3>
            <form action="profile" method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone</label>
                    <input type="text" class="form-control" id="phone" name="phone" value="<%= user.getPhone() %>">
                </div>
                <div class="mb-3">
                    <label for="location" class="form-label">Location</label>
                    <input type="text" class="form-control" id="location" name="location" value="<%= user.getLocation() %>">
                </div>
                <button type="submit" class="btn btn-primary">Update Profile</button>
            </form>
        </div>

        <!-- Service Management -->
        <div id="services" class="mt-5">
            <h3>My Services</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>Service Name</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Service service : services) { %>
                        <tr>
                            <td><%= service.getServiceName() %></td>
                            <td>$<%= service.getPrice() %></td>
                            <td><%= service.getStatus() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Booking Management -->
        <div id="bookings" class="mt-5">
            <h3>My Bookings</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>Customer</th>
                        <th>Service</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Booking booking : bookings) { %>
                        <%
                            User customer = userDAO.getUserById(booking.getCustomerId());
                            Service service = serviceDAO.getServiceById(booking.getServiceId());
                        %>
                        <tr>
                            <td><%= customer != null ? customer.getName() : "Unknown" %></td>
                            <td><%= service != null ? service.getServiceName() : "Unknown" %></td>
                            <td><%= booking.getBookingDate() %></td>
                            <td><%= booking.getBookingTime() %></td>
                            <td><%= booking.getStatus() %></td>
                            <td>
                                <% if ("pending".equals(booking.getStatus())) { %>
                                    <a href="booking?action=accept&bookingId=<%= booking.getBookingId() %>" class="btn btn-success btn-sm">Accept</a>
                                    <a href="booking?action=cancel&bookingId=<%= booking.getBookingId() %>" class="btn btn-danger btn-sm">Reject</a>
                                <% } else if ("confirmed".equals(booking.getStatus())) { %>
                                    <a href="booking?action=complete&bookingId=<%= booking.getBookingId() %>" class="btn btn-primary btn-sm">Mark Complete</a>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
