<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillconnect.models.Admin" %>
<%@ page import="com.skillconnect.dao.UserDAO" %>
<%@ page import="com.skillconnect.dao.BookingDAO" %>
<%@ page import="com.skillconnect.models.User" %>
<%@ page import="com.skillconnect.models.Booking" %>
<%@ page import="java.util.List" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    UserDAO userDAO = new UserDAO();
    BookingDAO bookingDAO = new BookingDAO();
    List<User> users = userDAO.getAllUsers();
    List<Booking> bookings = bookingDAO.getAllBookings();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="#">SkillConnect Admin</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="#users">Users</a>
                <a class="nav-link" href="#bookings">Bookings</a>
                <a class="btn btn-danger" href="logout.jsp">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2>Admin Dashboard</h2>

        <!-- User Management -->
        <div id="users" class="mt-5">
            <h3>User Management</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (User user : users) { %>
                        <tr>
                            <td><%= user.getUserId() %></td>
                            <td><%= user.getName() %></td>
                            <td><%= user.getEmail() %></td>
                            <td><%= user.getRole() %></td>
                            <td>
                                <a href="admin?action=deleteUser&userId=<%= user.getUserId() %>" class="btn btn-danger btn-sm">Delete</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Booking Management -->
        <div id="bookings" class="mt-5">
            <h3>All Bookings</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Worker</th>
                        <th>Service</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Booking booking : bookings) { %>
                        <tr>
                            <td><%= booking.getBookingId() %></td>
                            <td><%= booking.getCustomerId() %></td>
                            <td><%= booking.getWorkerId() %></td>
                            <td><%= booking.getServiceId() %></td>
                            <td><%= booking.getBookingDate() %></td>
                            <td><%= booking.getStatus() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
