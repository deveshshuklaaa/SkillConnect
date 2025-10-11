<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillconnect.models.User" %>
<%@ page import="com.skillconnect.dao.ServiceDAO" %>
<%@ page import="com.skillconnect.dao.UserDAO" %>
<%@ page import="com.skillconnect.models.Service" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    ServiceDAO serviceDAO = new ServiceDAO();
    UserDAO userDAO = new UserDAO();
    List<Service> services = serviceDAO.getAllActiveServices();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Services - SkillConnect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">SkillConnect</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="index.jsp">Home</a>
                <a class="nav-link active" href="serviceList.jsp">Services</a>
                <a class="nav-link" href="index.jsp#about">About</a>
                <a class="nav-link" href="index.jsp#contact">Contact</a>
                <% if (user != null) { %>
                    <a class="btn btn-danger ms-2" href="logout.jsp">Logout</a>
                <% } else { %>
                    <a class="btn btn-primary ms-2" href="login.jsp">Login</a>
                <% } %>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2>Available Services</h2>
        <div class="mb-4">
            <form class="row g-3">
                <div class="col-md-4">
                    <label for="locationFilter" class="form-label">Filter by Location</label>
                    <select class="form-select" id="locationFilter">
                        <option value="">All Locations</option>
                        <option value="New York">New York</option>
                        <option value="Los Angeles">Los Angeles</option>
                        <!-- Add more locations as needed -->
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="serviceFilter" class="form-label">Filter by Service Type</label>
                    <select class="form-select" id="serviceFilter">
                        <option value="">All Services</option>
                        <option value="Electrical">Electrical</option>
                        <option value="Plumbing">Plumbing</option>
                        <option value="Woodwork">Woodwork</option>
                        <option value="Furniture">Furniture</option>
                        <option value="Cabinet">Cabinet</option>
                    </select>
                </div>
            </form>
        </div>
        <div class="row" id="servicesContainer">
            <% for (Service service : services) { %>
                <%
                    User worker = userDAO.getUserById(service.getWorkerId());
                    String location = worker != null ? worker.getLocation() : "";
                    String serviceType = service.getServiceName().split(" ")[0]; // e.g., Electrical from Electrical Repair
                %>
                <div class="col-md-4 mb-4" data-location="<%= location %>" data-service="<%= serviceType %>">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title"><%= service.getServiceName() %></h5>
                            <p class="card-text">Price: $<%= service.getPrice() %></p>
                            <p class="card-text">Location: <%= location %></p>
                            <p class="card-text">Status: <%= service.getStatus() %></p>
                            <% if (user != null && "customer".equals(user.getRole())) { %>
                                <form action="booking" method="post">
                                    <input type="hidden" name="serviceId" value="<%= service.getServiceId() %>">
                                    <input type="hidden" name="workerId" value="<%= service.getWorkerId() %>">
                                    <div class="mb-3">
                                        <label for="date_<%= service.getServiceId() %>" class="form-label">Date</label>
                                        <input type="date" class="form-control" name="date" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="time_<%= service.getServiceId() %>" class="form-label">Time</label>
                                        <input type="time" class="form-control" name="time" required>
                                    </div>
                                    <button type="submit" class="btn btn-success">Book Now</button>
                                </form>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const locationFilter = document.getElementById('locationFilter');
            const serviceFilter = document.getElementById('serviceFilter');
            const serviceCards = document.querySelectorAll('#servicesContainer .col-md-4');

            function filterServices() {
                const selectedLocation = locationFilter.value.toLowerCase();
                const selectedService = serviceFilter.value.toLowerCase();

                serviceCards.forEach(card => {
                    const cardLocation = card.dataset.location.toLowerCase();
                    const cardService = card.dataset.service.toLowerCase();

                    const matchesLocation = selectedLocation === '' || cardLocation.includes(selectedLocation);
                    const matchesService = selectedService === '' || cardService.includes(selectedService);

                    if (matchesLocation && matchesService) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
            }

            locationFilter.addEventListener('change', filterServices);
            serviceFilter.addEventListener('change', filterServices);
        });
    </script>
</body>
</html>
