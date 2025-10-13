<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillconnect.models.Admin" %>
<%@ page import="com.skillconnect.dao.UserDAO" %>
<%@ page import="com.skillconnect.dao.BookingDAO" %>
<%@ page import="com.skillconnect.dao.StatsDAO" %>
<%@ page import="com.skillconnect.dao.CategoryDAO" %>
<%@ page import="com.skillconnect.dao.RatingDAO" %>
<%@ page import="com.skillconnect.models.User" %>
<%@ page import="com.skillconnect.models.Booking" %>
<%@ page import="com.skillconnect.models.Category" %>
<%@ page import="com.skillconnect.models.Rating" %>
<%@ page import="java.util.List" %>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    UserDAO userDAO = new UserDAO();
    BookingDAO bookingDAO = new BookingDAO();
    StatsDAO statsDAO = new StatsDAO();
    CategoryDAO categoryDAO = new CategoryDAO();
    RatingDAO ratingDAO = new RatingDAO();
    List<User> users = userDAO.getAllUsers();
    List<Booking> bookings = bookingDAO.getAllBookings();
    int totalUsers = userDAO.getTotalUsers();
    int activeBookings = statsDAO.getActiveBookingsCount();
    StatsDAO.TopRatedWorker topRatedWorker = statsDAO.getTopRatedWorker();
    List<StatsDAO.PopularService> popularServices = statsDAO.getMostPopularServices();
    List<Category> categories = categoryDAO.getAllCategories();
    List<Rating> ratings = ratingDAO.getAllRatings();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - SkillConnect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .navbar-brand { font-weight: bold; color: #fff !important; }
        .stats-card { transition: transform 0.2s; }
        .stats-card:hover { transform: translateY(-5px); }
        .section-card { margin-bottom: 2rem; }
        .table-hover tbody tr:hover { background-color: rgba(0,0,0,.075); }
        .filter-form { background: #f8f9fa; padding: 1rem; border-radius: 0.5rem; margin-bottom: 1rem; }
        .tab-content { padding-top: 2rem; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"><i class="bi bi-gear-fill"></i> SkillConnect Admin</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#stats"><i class="bi bi-bar-chart"></i> Stats</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#categories"><i class="bi bi-tags"></i> Categories</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#users"><i class="bi bi-people"></i> Users</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#bookings"><i class="bi bi-calendar-check"></i> Bookings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#feedback"><i class="bi bi-chat-quote"></i> Feedback</a>
                    </li>
                </ul>
                <a class="btn btn-outline-light" href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <!-- Main Content -->
            <div class="col-md-12">
                <!-- Stats Overview -->
                <div id="stats" class="section-card">
                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white">
                            <h4 class="card-title mb-0"><i class="bi bi-bar-chart-line"></i> Dashboard Overview</h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <div class="card text-white bg-primary stats-card">
                                        <div class="card-body text-center">
                                            <i class="bi bi-people-fill fs-1"></i>
                                            <h5 class="card-title">Total Users</h5>
                                            <h2 class="card-text"><%= totalUsers %></h2>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card text-white bg-success stats-card">
                                        <div class="card-body text-center">
                                            <i class="bi bi-calendar-event-fill fs-1"></i>
                                            <h5 class="card-title">Active Bookings</h5>
                                            <h2 class="card-text"><%= activeBookings %></h2>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card text-white bg-info stats-card">
                                        <div class="card-body text-center">
                                            <i class="bi bi-star-fill fs-1"></i>
                                            <h5 class="card-title">Top Rated Worker</h5>
                                            <h6 class="card-text"><%= topRatedWorker != null ? topRatedWorker.getName() + " (" + String.format("%.1f", topRatedWorker.getAvgRating()) + ")" : "N/A" %></h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card text-white bg-warning stats-card">
                                        <div class="card-body text-center">
                                            <i class="bi bi-graph-up fs-1"></i>
                                            <h5 class="card-title">Popular Services</h5>
                                            <ul class="list-unstyled mb-0">
                                                <% for (int i = 0; i < Math.min(3, popularServices.size()); i++) { 
                                                    StatsDAO.PopularService ps = popularServices.get(i); %>
                                                    <li><%= ps.getServiceName() %> (<%= ps.getBookingCount() %>)</li>
                                                <% } %>
                                                <% if (popularServices.isEmpty()) { %>
                                                    <li>No data</li>
                                                <% } %>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Manage Categories -->
                <div id="categories" class="section-card">
                    <div class="card shadow-sm">
                        <div class="card-header bg-secondary text-white">
                            <h4 class="card-title mb-0"><i class="bi bi-tags"></i> Manage Categories</h4>
                        </div>
                        <div class="card-body">
                            <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addCategoryModal"><i class="bi bi-plus-circle"></i> Add Category</button>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Description</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Category category : categories) { %>
                                            <tr>
                                                <td><%= category.getCategoryId() %></td>
                                                <td><%= category.getCategoryName() %></td>
                                                <td><%= category.getDescription() %></td>
                                                <td>
                                                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editCategoryModal" onclick="editCategory(<%= category.getCategoryId() %>, '<%= category.getCategoryName().replaceAll("'", "\\\\'") %>', '<%= category.getDescription().replaceAll("'", "\\\\'") %>')"><i class="bi bi-pencil"></i> Edit</button>
                                                    <a href="admin?action=deleteCategory&categoryId=<%= category.getCategoryId() %>" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i> Delete</a>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- User Management -->
                <div id="users" class="section-card">
                    <div class="card shadow-sm">
                        <div class="card-header bg-info text-white">
                            <h4 class="card-title mb-0"><i class="bi bi-people"></i> User Management</h4>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
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
                                                <td><span class="badge bg-<%= user.getRole().equals("worker") ? "success" : "primary" %>"><%= user.getRole() %></span></td>
                                                <td>
                                                    <a href="admin?action=deleteUser&userId=<%= user.getUserId() %>" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i> Delete</a>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Booking Management -->
                <div id="bookings" class="section-card">
                    <div class="card shadow-sm">
                        <div class="card-header bg-success text-white">
                            <h4 class="card-title mb-0"><i class="bi bi-calendar-check"></i> Booking Management</h4>
                        </div>
                        <div class="card-body">
                            <div class="filter-form">
                                <h5><i class="bi bi-funnel"></i> Filter Bookings</h5>
                                <form method="get" action="admin" id="filterForm">
                                    <input type="hidden" name="action" value="filterBookings">
                                    <div class="row g-3">
                                        <div class="col-md-2">
                                            <label class="form-label">Status</label>
                                            <select name="status" class="form-select">
                                                <option value="">All Status</option>
                                                <option value="pending">Pending</option>
                                                <option value="confirmed">Confirmed</option>
                                                <option value="completed">Completed</option>
                                                <option value="cancelled">Cancelled</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label">Start Date</label>
                                            <input type="date" name="startDate" class="form-control">
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label">End Date</label>
                                            <input type="date" name="endDate" class="form-control">
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label">Worker ID</label>
                                            <input type="number" name="workerId" class="form-control" placeholder="Worker ID">
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label">Customer ID</label>
                                            <input type="number" name="customerId" class="form-control" placeholder="Customer ID">
                                        </div>
                                        <div class="col-md-2 d-flex align-items-end">
                                            <button type="submit" class="btn btn-primary me-2"><i class="bi bi-search"></i> Filter</button>
                                            <button type="button" class="btn btn-secondary" onclick="clearFilters()"><i class="bi bi-x-circle"></i> Clear</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Customer</th>
                                            <th>Worker</th>
                                            <th>Service</th>
                                            <th>Date</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List<Booking> displayBookings = (List<Booking>) request.getAttribute("filteredBookings");
                                           if (displayBookings == null) displayBookings = bookings;
                                           for (Booking booking : displayBookings) { %>
                                            <tr>
                                                <td><%= booking.getBookingId() %></td>
                                                <td><%= booking.getCustomerId() %></td>
                                                <td><%= booking.getWorkerId() %></td>
                                                <td><%= booking.getServiceId() %></td>
                                                <td><%= booking.getBookingDate() %></td>
                                                <td><span class="badge bg-<%= booking.getStatus().equals("completed") ? "success" : booking.getStatus().equals("pending") ? "warning" : "secondary" %>"><%= booking.getStatus() %></span></td>
                                                <td>
                                                    <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#reassignModal" onclick="reassignBooking(<%= booking.getBookingId() %>)"><i class="bi bi-arrow-repeat"></i> Reassign</button>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Manage Feedback -->
                <div id="feedback" class="section-card">
                    <div class="card shadow-sm">
                        <div class="card-header bg-warning text-dark">
                            <h4 class="card-title mb-0"><i class="bi bi-chat-quote"></i> Manage Feedback</h4>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Customer</th>
                                            <th>Worker</th>
                                            <th>Rating</th>
                                            <th>Feedback</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Rating rating : ratings) { %>
                                            <tr>
                                                <td><%= rating.getRatingId() %></td>
                                                <td><%= rating.getCustomerId() %></td>
                                                <td><%= rating.getWorkerId() %></td>
                                                <td>
                                                    <% for (int i = 1; i <= 5; i++) { %>
                                                        <i class="bi bi-star<%= i <= rating.getRating() ? "-fill text-warning" : "" %>"></i>
                                                    <% } %>
                                                </td>
                                                <td><%= rating.getFeedback() %></td>
                                                <td>
                                                    <a href="admin?action=deleteRating&ratingId=<%= rating.getRatingId() %>" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i> Delete</a>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modals -->
    <!-- Add Category Modal -->
    <div class="modal fade" id="addCategoryModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="admin" method="post">
                    <input type="hidden" name="action" value="addCategory">
                    <div class="modal-header">
                        <h5 class="modal-title">Add Category</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="categoryName" class="form-label">Category Name</label>
                            <input type="text" class="form-control" id="categoryName" name="categoryName" required>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Add Category</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Category Modal -->
    <div class="modal fade" id="editCategoryModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="admin" method="post">
                    <input type="hidden" name="action" value="editCategory">
                    <input type="hidden" id="editCategoryId" name="categoryId">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Category</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="editCategoryName" class="form-label">Category Name</label>
                            <input type="text" class="form-control" id="editCategoryName" name="categoryName" required>
                        </div>
                        <div class="mb-3">
                            <label for="editDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="editDescription" name="description" rows="3"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Update Category</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Reassign Booking Modal -->
    <div class="modal fade" id="reassignModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="admin" method="post">
                    <input type="hidden" name="action" value="reassignBooking">
                    <input type="hidden" id="reassignBookingId" name="bookingId">
                    <div class="modal-header">
                        <h5 class="modal-title">Reassign Booking</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="newWorkerId" class="form-label">New Worker ID</label>
                            <input type="number" class="form-control" id="newWorkerId" name="newWorkerId" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Reassign</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editCategory(id, name, description) {
            document.getElementById('editCategoryId').value = id;
            document.getElementById('editCategoryName').value = name;
            document.getElementById('editDescription').value = description;
        }
        function reassignBooking(id) {
            document.getElementById('reassignBookingId').value = id;
        }
        function clearFilters() {
            document.getElementById('filterForm').reset();
            window.location.href = 'admin'; // Reload to show all bookings
        }
    </script>
</body>
</html>
