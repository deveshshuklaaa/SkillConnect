<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillconnect.models.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"customer".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Home - SkillConnect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="customerHome.jsp">SkillConnect</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="customerHome.jsp">Home</a>
                <a class="nav-link" href="serviceList.jsp">Browse Services</a>
                <a class="nav-link" href="bookingHistory.jsp">My Bookings</a>
                <a class="nav-link" href="profile.jsp">Profile</a>
                <a class="btn btn-danger ms-2" href="logout.jsp">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2>Welcome, <%= user.getName() %>!</h2>
        <p>Find and book skilled workers for your needs.</p>

        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body text-center">
                        <h5 class="card-title">Browse Services</h5>
                        <p class="card-text">Explore available services from skilled workers.</p>
                        <a href="serviceList.jsp" class="btn btn-primary">View Services</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body text-center">
                        <h5 class="card-title">My Bookings</h5>
                        <p class="card-text">View and manage your bookings.</p>
                        <a href="bookingHistory.jsp" class="btn btn-primary">View Bookings</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body text-center">
                        <h5 class="card-title">Profile</h5>
                        <p class="card-text">Update your profile information.</p>
                        <a href="profile.jsp" class="btn btn-primary">Edit Profile</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
