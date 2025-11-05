<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillconnect.models.User" %>
<%@ page import="com.skillconnect.dao.ServiceDAO" %>
<%@ page import="com.skillconnect.dao.CategoryDAO" %>
<%@ page import="com.skillconnect.models.Service" %>
<%@ page import="com.skillconnect.models.Category" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"worker".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    ServiceDAO serviceDAO = new ServiceDAO();
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Service> services = serviceDAO.getServicesByWorker(user.getUserId());
    List<Category> categories = categoryDAO.getAllCategories();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Worker Services</title>
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
                <a class="nav-link" href="workerBookings.jsp">Bookings</a>
                <a class="btn btn-danger" href="logout.jsp">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2>My Services</h2>
        <% String message = request.getParameter("message"); %>
        <% if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
        <% } %>
        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>
        <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addServiceModal">Add New Service</button>
        <table class="table">
            <thead>
                <tr>
                    <th>Service Name</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Service service : services) { %>
                    <tr>
                        <td><%= service.getServiceName() %></td>
                        <td>$<%= service.getPrice() %></td>
                        <td><%= service.getStatus() %></td>
                        <td>
                            <button class="btn btn-sm btn-warning" onclick="editService(<%= service.getServiceId() %>, '<%= service.getServiceName() %>', <%= service.getPrice() %>, '<%= service.getStatus() %>', <%= service.getCategoryId() %>)">Edit</button>
                            <form action="service" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="serviceId" value="<%= service.getServiceId() %>">
                                <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
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
                            <label for="categoryId" class="form-label">Category</label>
                            <select class="form-select" id="categoryId" name="categoryId" required>
                                <% for (Category category : categories) { %>
                                    <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
                                <% } %>
                            </select>
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
        function editService(id, name, price, status, categoryId) {
            document.getElementById('serviceModalTitle').textContent = 'Edit Service';
            document.getElementById('serviceAction').value = 'update';
            document.getElementById('serviceId').value = id;
            document.getElementById('serviceName').value = name;
            document.getElementById('price').value = price;
            document.getElementById('status').value = status;
            document.getElementById('categoryId').value = categoryId;
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
