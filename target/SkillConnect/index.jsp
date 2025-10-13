<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillconnect.models.User" %>
<%
    User user = (User) session.getAttribute("user");
    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillConnect - Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <style>
        body { font-family: 'Montserrat', sans-serif; }
        .hero { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 100px 0; }
        .service-card { border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); transition: transform 0.3s; }
        .service-card:hover { transform: translateY(-5px); }
        .search-form { background: white; border-radius: 10px; padding: 2rem; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .navbar-brand { font-weight: 700; font-size: 1.5rem; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <div class="navbar-nav">
                <a class="navbar-brand" href="index.jsp">SkillConnect</a>
                <% if (user == null || !"admin".equals(user.getRole())) { %>
                    <a class="nav-link" href="serviceList.jsp">Services</a>
                <% } %>
                <a class="nav-link" href="about.jsp">About</a>
                <a class="nav-link" href="contact.jsp">Contact</a>
            </div>
            <div class="navbar-nav ms-auto">
                <% if (user == null) { %>
                    <a class="btn btn-primary me-2" href="login.jsp">Login</a>
                    <button class="btn btn-outline-primary" onclick="showRegisterModal()">Register</button>
                <% } else { %>
                    <span class="navbar-text me-2">Welcome, <%= user.getName() %></span>
                    <a class="nav-link" href="bookingHistory.jsp">My Bookings</a>
                    <% if ("customer".equals(user.getRole())) { %>
                        <a class="nav-link" href="profile.jsp">Profile</a>
                    <% } else { %>
                        <a class="nav-link" href="profile.jsp">Profile</a>
                    <% } %>
                    <a class="btn btn-danger ms-2" href="logout.jsp">Logout</a>
                <% } %>
            </div>
        </div>
    </nav>

    <section class="hero text-center">
        <div class="container">
            <h1 class="display-4 mb-4">Home services at your doorstep</h1>
            <p class="lead mb-5">Book trusted professionals for all your home needs</p>
            <form class="search-form mx-auto" style="max-width: 600px;" method="GET" action="serviceList.jsp">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="city" class="form-label">Select City</label>
                        <select class="form-select" id="city" name="city" required>
                            <option value="">Choose a city</option>
                            <option value="Delhi">Delhi</option>
                            <option value="Mumbai">Mumbai</option>
                            <option value="Bangalore">Bangalore</option>
                            <option value="Chennai">Chennai</option>
                            <option value="Kolkata">Kolkata</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="service" class="form-label">Select Service</label>
                        <select class="form-select" id="service" name="service" required>
                            <option value="">Choose a service</option>
                            <option value="Cleaning">Cleaning</option>
                            <option value="Plumbing">Plumbing</option>
                            <option value="Electrical">Electrical</option>
                            <option value="Carpentry">Carpentry</option>
                            <option value="Painting">Painting</option>
                            <option value="Appliance Repair">Appliance Repair</option>
                            <option value="Pest Control">Pest Control</option>
                            <option value="Home Salon">Home Salon</option>
                            <option value="Car Wash">Car Wash</option>
                            <option value="AC Service">AC Service</option>
                        </select>
                    </div>
                </div>
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary btn-lg">Search</button>
                </div>
            </form>
            <% String messageParam = request.getParameter("message");
               String errorParam = request.getParameter("error");
               if (messageParam != null && !messageParam.isEmpty()) { %>
                <div id="successAlert" class="alert alert-success alert-dismissible fade show mt-4 mx-auto" style="max-width: 600px;" role="alert">
                    <%= messageParam %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } else if (errorParam != null && !errorParam.isEmpty()) { %>
                <div id="errorAlert" class="alert alert-danger alert-dismissible fade show mt-4 mx-auto" style="max-width: 600px;" role="alert">
                    <%= errorParam %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
        </div>
    </section>

    <section class="py-5 bg-light">
        <div class="container">
            <h2 class="text-center mb-5">Popular Services</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card service-card text-center h-100">
                        <div class="card-body">
                            <div style="font-size: 3rem; margin-bottom: 1rem;">🧹</div>
                            <h5 class="card-title">Cleaning</h5>
                            <p class="card-text">Professional home cleaning services to keep your space spotless.</p>
                            <a href="serviceList.jsp" class="btn btn-primary">Book Now</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card service-card text-center h-100">
                        <div class="card-body">
                            <div style="font-size: 3rem; margin-bottom: 1rem;">🔧</div>
                            <h5 class="card-title">Plumbing</h5>
                            <p class="card-text">Expert plumbing services for all your water and drainage needs.</p>
                            <a href="serviceList.jsp" class="btn btn-primary">Book Now</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card service-card text-center h-100">
                        <div class="card-body">
                            <div style="font-size: 3rem; margin-bottom: 1rem;">⚡</div>
                            <h5 class="card-title">Electrical</h5>
                            <p class="card-text">Electrical repairs and installations by certified professionals.</p>
                            <a href="serviceList.jsp" class="btn btn-primary">Book Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="bg-dark text-white text-center py-3">
        <div class="container">
            <p>&copy; 2025 SkillConnect. All rights reserved.</p>
        </div>
    </footer>

    <!-- Register Modal -->
    <div class="modal fade" id="registerModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Register as</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <a href="customerRegister.jsp" class="btn btn-primary w-100 mb-2">Customer</a>
                    <a href="workerRegister.jsp" class="btn btn-secondary w-100">Worker</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showRegisterModal() {
            var registerModal = new bootstrap.Modal(document.getElementById('registerModal'));
            registerModal.show();
        }
        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const successAlert = document.getElementById('successAlert');
            const errorAlert = document.getElementById('errorAlert');
            if (successAlert) {
                setTimeout(() => {
                    const bsAlert = new bootstrap.Alert(successAlert);
                    bsAlert.close();
                }, 5000);
            }
            if (errorAlert) {
                setTimeout(() => {
                    const bsAlert = new bootstrap.Alert(errorAlert);
                    bsAlert.close();
                }, 5000);
            }
        });
    </script>
</body>
</html>
