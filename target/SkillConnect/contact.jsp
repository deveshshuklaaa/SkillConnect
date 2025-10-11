<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.skillconnect.models.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact - SkillConnect</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <style>
        body { font-family: 'Montserrat', sans-serif; }
        .hero { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 100px 0; }
        .contact-info { background: #f8f9fa; padding: 3rem 0; }
        .contact-form { padding: 3rem 0; }
    </style>
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">SkillConnect</a>
                <div class="navbar-nav ms-auto">
                    <% if (user == null || !"admin".equals(user.getRole())) { %>
                        <a class="nav-link" href="serviceList.jsp">Services</a>
                    <% } %>
                    <a class="nav-link" href="about.jsp">About</a>
                    <a class="nav-link active" href="contact.jsp">Contact</a>
                    <% if (user == null) { %>
                        <a class="btn btn-primary ms-2" href="login.jsp">Login</a>
                        <button class="btn btn-outline-primary ms-2" onclick="showRegisterModal()">Register</button>
                    <% } else { %>
                        <span class="navbar-text me-2">Welcome, <%= user.getName() %></span>
                        <a class="btn btn-outline-secondary ms-2" href="profile.jsp">Profile</a>
                        <a class="btn btn-danger ms-2" href="logout.jsp">Logout</a>
                    <% } %>
                </div>
            </div>
        </nav>
    </header>

    <main>
        <section class="hero text-center">
            <div class="container">
                <h1>Contact Us</h1>
                <p>Get in touch with our team for any questions or support</p>
            </div>
        </section>

        <section class="contact-info">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 text-center">
                        <h5>📧 Email</h5>
                        <p>support@skillconnect.com</p>
                    </div>
                    <div class="col-md-4 text-center">
                        <h5>📞 Phone</h5>
                        <p>+1 (123) 456-7890</p>
                    </div>
                    <div class="col-md-4 text-center">
                        <h5>📍 Address</h5>
                        <p>123 Skill Street<br>Service City, SC 12345</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="contact-form">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <h2 class="text-center mb-4">Send us a Message</h2>
                        <form>
                            <div class="mb-3">
                                <label for="name" class="form-label">Name</label>
                                <input type="text" class="form-control" id="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="subject" class="form-label">Subject</label>
                                <input type="text" class="form-control" id="subject" required>
                            </div>
                            <div class="mb-3">
                                <label for="message" class="form-label">Message</label>
                                <textarea class="form-control" id="message" rows="5" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Send Message</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </main>

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
                    <a href="customerRegister.jsp" class="btn btn-primary">Customer</a>
                    <a href="workerRegister.jsp" class="btn btn-secondary">Worker</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>
