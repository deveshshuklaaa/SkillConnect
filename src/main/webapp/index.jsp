<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillConnect - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand" href="#">SkillConnect</a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="#home">Home</a>
                <a class="nav-link" href="serviceList.jsp">Services</a>
                <a class="nav-link" href="#about">About</a>
                <a class="nav-link" href="#contact">Contact</a>
                <a class="btn btn-primary ms-2" href="login.jsp">Login</a>
                <button class="btn btn-outline-primary ms-2" onclick="showRegisterModal()">Register</button>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="jumbotron text-center">
            <h1>Welcome to SkillConnect</h1>
            <p>Connect with skilled workers for all your service needs.</p>
            <a class="btn btn-success btn-lg" href="serviceList.jsp">Explore Services</a>
        </div>
    </div>

    <!-- About Section -->
    <section id="about" class="py-5 bg-light">
        <div class="container">
            <h2 class="text-center mb-4">About Us</h2>
            <p>SkillConnect is a platform that bridges the gap between customers and skilled workers. We provide a seamless way to find, book, and manage local services such as electrical repairs, plumbing, carpentry, and more. Our mission is to make it easy for you to get the help you need, when you need it.</p>
            <p>Founded in 2023, SkillConnect has helped thousands of customers connect with reliable professionals. We prioritize quality, safety, and customer satisfaction in everything we do.</p>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="py-5">
        <div class="container">
            <h2 class="text-center mb-4">Contact Us</h2>
            <div class="row">
                <div class="col-md-6">
                    <h5>Get in Touch</h5>
                    <p>Email: support@skillconnect.com</p>
                    <p>Phone: +1 (123) 456-7890</p>
                    <p>Address: 123 Skill Street, Service City, SC 12345</p>
                </div>
                <div class="col-md-6">
                    <h5>Send us a Message</h5>
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
                            <label for="message" class="form-label">Message</label>
                            <textarea class="form-control" id="message" rows="3" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Send</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

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
