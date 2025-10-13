<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillconnect.models.User" %>
<%@ page import="com.skillconnect.dao.ServiceDAO" %>
<%@ page import="com.skillconnect.dao.BookingDAO" %>
<%@ page import="com.skillconnect.models.Service" %>
<%@ page import="com.skillconnect.models.Booking" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"customer".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    ServiceDAO serviceDAO = new ServiceDAO();
    BookingDAO bookingDAO = new BookingDAO();
    List<Service> services = serviceDAO.getAllActiveServices();
    List<Booking> bookings = bookingDAO.getBookingsByCustomer(user.getUserId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">SkillConnect</a>
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

        <!-- Service Browsing -->
        <div id="services" class="mt-5">
            <h3>Available Services</h3>
            <div class="row">
                <% for (Service service : services) { %>
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title"><%= service.getServiceName() %></h5>
                                <p class="card-text">Price: $<%= service.getPrice() %></p>
                                <form action="booking" method="post">
                                    <input type="hidden" name="serviceId" value="<%= service.getServiceId() %>">
                                    <input type="hidden" name="workerId" value="<%= service.getWorkerId() %>">
                                    <div class="mb-3">
                                        <label for="date" class="form-label">Date</label>
                                        <input type="date" class="form-control" name="date" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="time" class="form-label">Time</label>
                                        <input type="time" class="form-control" name="time" required>
                                    </div>
                                    <button type="submit" class="btn btn-success">Book Now</button>
                                </form>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>

        <!-- Booking History -->
        <div id="bookings" class="mt-5">
            <h3>My Bookings</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>Service</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Booking booking : bookings) { %>
                        <tr>
                            <td><%= booking.getServiceId() %></td>
                            <td><%= booking.getBookingDate() %></td>
                            <td><%= booking.getBookingTime() %></td>
                            <td><%= booking.getStatus() %></td>
                            <td>
                                <% if ("pending".equals(booking.getStatus())) { %>
                                    <a href="booking?action=cancel&bookingId=<%= booking.getBookingId() %>" class="btn btn-danger btn-sm">Cancel</a>
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
