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
            <a class="navbar-brand" href="workerDashboard.jsp">SkillConnect</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="workerProfile.jsp">Profile</a>
                <a class="nav-link" href="workerServices.jsp">Services</a>
                <a class="nav-link" href="workerBookings.jsp">Bookings</a>
                <a class="btn btn-danger" href="logout.jsp">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="hero text-center bg-primary text-white py-5 rounded">
            <h1>Welcome back, <%= user.getName() %>!</h1>
            <p class="lead">Manage your services and bookings efficiently with SkillConnect.</p>
        </div>

        <% String message = request.getParameter("message"); %>
        <% if (message != null) { %>
            <div class="alert alert-success mt-3"><%= message %></div>
        <% } %>
        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-danger mt-3"><%= error %></div>
        <% } %>

        <div class="row mt-5">
            <div class="col-md-4">
                <div class="card text-center h-100 shadow">
                    <div class="card-body">
                        <div class="display-4 text-primary mb-3">🔧</div>
                        <h5 class="card-title">My Services</h5>
                        <p class="card-text">Manage your offered services. Add, edit, or remove services to keep your profile up to date.</p>
                        <a href="workerServices.jsp" class="btn btn-primary">View Services</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center h-100 shadow">
                    <div class="card-body">
                        <div class="display-4 text-success mb-3">📅</div>
                        <h5 class="card-title">Bookings</h5>
                        <p class="card-text">View and manage your bookings. Accept, reject, or mark bookings as complete.</p>
                        <a href="workerBookings.jsp" class="btn btn-success">View Bookings</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center h-100 shadow">
                    <div class="card-body">
                        <div class="display-4 text-info mb-3">👤</div>
                        <h5 class="card-title">Profile</h5>
                        <p class="card-text">Update your personal information and preferences to enhance your profile.</p>
                        <a href="workerProfile.jsp" class="btn btn-info">Edit Profile</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-5">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-light">
                        <h5>Quick Stats</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Total Services:</strong> <%= services.size() %></p>
                        <p><strong>Pending Bookings:</strong> <%= bookings.stream().filter(b -> "pending".equals(b.getStatus())).count() %></p>
                        <p><strong>Completed Bookings:</strong> <%= bookings.stream().filter(b -> "completed".equals(b.getStatus())).count() %></p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-light">
                        <h5>Recent Activity</h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled">
                            <% for (int i = 0; i < Math.min(3, bookings.size()); i++) { %>
                                <li><%= bookings.get(i).getStatus() %> booking on <%= bookings.get(i).getBookingDate() %></li>
                            <% } %>
                            <% if (bookings.isEmpty()) { %>
                                <li>No recent activity.</li>
                            <% } %>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Service Modal -->
    <div class="modal fade" id="addServiceModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="serviceModalTitle">Add New Service</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="serviceForm" action="service" method="post">
                        <input type="hidden" name="action" id="serviceAction" value="add">
                        <input type="hidden" name="serviceId" id="serviceId">
                        <div class="mb-3">
                            <label for="serviceName" class="form-label">Service Name</label>
                            <input type="text" class="form-control" id="serviceName" name="serviceName" required>
                        </div>
                        <div class="mb-3">
                            <label for="price" class="form-label">Price</label>
                            <input type="number" step="0.01" class="form-control" id="price" name="price" required>
                        </div>
                        <div class="mb-3">
                            <label for="status" class="form-label">Status</label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="active">Active</option>
                                <option value="inactive">Inactive</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Save Service</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editService(id, name, price, status) {
            document.getElementById('serviceModalTitle').textContent = 'Edit Service';
            document.getElementById('serviceAction').value = 'update';
            document.getElementById('serviceId').value = id;
            document.getElementById('serviceName').value = name;
            document.getElementById('price').value = price;
            document.getElementById('status').value = status;
            var modal = new bootstrap.Modal(document.getElementById('addServiceModal'));
            modal.show();
        }

        // Reset modal when closed
        document.getElementById('addServiceModal').addEventListener('hidden.bs.modal', function () {
            document.getElementById('serviceModalTitle').textContent = 'Add New Service';
            document.getElementById('serviceAction').value = 'add';
            document.getElementById('serviceId').value = '';
            document.getElementById('serviceForm').reset();
        });
    </script>
</body>
</html>
