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
                <a class="nav-link" href="about.jsp">About</a>
                <a class="nav-link" href="contact.jsp">Contact</a>
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
