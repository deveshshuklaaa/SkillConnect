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
    <title>About - SkillConnect</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <style>
        body { font-family: 'Montserrat', sans-serif; }
        .hero { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 100px 0; }
        .feature-icon { font-size: 3rem; margin-bottom: 1rem; }
        .team-member { text-align: center; padding: 2rem; }
        .team-avatar { font-size: 4rem; margin-bottom: 1rem; }
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
                    <a class="nav-link active" href="about.jsp">About</a>
                    <a class="nav-link" href="contact.jsp">Contact</a>
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
                <h1>About SkillConnect</h1>
                <p>Connecting skilled workers with customers for seamless service experiences</p>
            </div>
        </section>

        <section class="py-5">
            <div class="container">
                <h2 class="text-center mb-4">Our Mission</h2>
                <p class="text-center">At SkillConnect, our mission is to bridge the gap between skilled professionals and customers in need of quality services. We strive to create a platform that fosters trust, reliability, and convenience in the service industry.</p>
            </div>
        </section>

        <section class="py-5 bg-light">
            <div class="container">
                <h2 class="text-center mb-5">Our Features</h2>
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="text-center">
                            <div class="feature-icon">✅</div>
                            <h5>Verified Professionals</h5>
                            <p>All workers are thoroughly vetted to ensure quality and reliability.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="text-center">
                            <div class="feature-icon">📅</div>
                            <h5>Easy Booking</h5>
                            <p>Schedule services at your convenience with our user-friendly booking system.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="text-center">
                            <div class="feature-icon">💳</div>
                            <h5>Secure Payments</h5>
                            <p>Safe and secure payment processing for all transactions.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="text-center">
                            <div class="feature-icon">🛠️</div>
                            <h5>Wide Range of Services</h5>
                            <p>From electrical work to plumbing, we cover all your home service needs.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="text-center">
                            <div class="feature-icon">📞</div>
                            <h5>24/7 Support</h5>
                            <p>Our customer support team is always ready to assist you.</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="text-center">
                            <div class="feature-icon">⭐</div>
                            <h5>Rating System</h5>
                            <p>Rate and review services to help others make informed decisions.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="py-5">
            <div class="container">
                <h2 class="text-center mb-5">Our Team</h2>
                <div class="row">
                    <div class="col-md-3 mb-4">
                        <div class="team-member">
                            <div class="team-avatar">👨‍💼</div>
                            <h5>Arvind Shekhawat</h5>
                            <p>CEO & Founder</p>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4">
                        <div class="team-member">
                            <div class="team-avatar">👩‍💻</div>
                            <h5>Devesh Shukla</h5>
                            <p>Lead Developer</p>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4">
                        <div class="team-member">
                            <div class="team-avatar">👨‍🔧</div>
                            <h5>Dhruv Sharma</h5>
                            <p>Operations Manager</p>
                        </div>
                    </div>
                    <div class="col-md-3 mb-4">
                        <div class="team-member">
                            <div class="team-avatar">👨‍🎨</div>
                            <h5>Arnav Tawar</h5>
                            <p>UI Designer</p>
                        </div>
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
