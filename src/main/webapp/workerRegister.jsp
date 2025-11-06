<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Worker Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2>Worker Registration</h2>
                <% String message = request.getParameter("message"); %>
                <% if (message != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <%= message %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                <% String error = request.getParameter("error"); %>
                <% if (error != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <%= error %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                <form action="registerWorker" method="post">
                    <div class="mb-3">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="password" name="password" required>
                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                            <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="text" class="form-control" id="phone" name="phone" required>
                    </div>
                    <div class="mb-3">
                        <label for="location" class="form-label">Location</label>
                        <input type="text" class="form-control" id="location" name="location" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Skills (Select multiple)</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="Cleaning" id="cleaning">
                            <label class="form-check-label" for="cleaning">Cleaning</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="Plumbing" id="plumbing">
                            <label class="form-check-label" for="plumbing">Plumbing</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="Electrical" id="electrical">
                            <label class="form-check-label" for="electrical">Electrical</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="Carpentry" id="carpentry">
                            <label class="form-check-label" for="carpentry">Carpentry</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="Painting" id="painting">
                            <label class="form-check-label" for="painting">Painting</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="Appliance Repair" id="appliance">
                            <label class="form-check-label" for="appliance">Appliance Repair</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="Pest Control" id="pest">
                            <label class="form-check-label" for="pest">Pest Control</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="Home Salon" id="salon">
                            <label class="form-check-label" for="salon">Home Salon</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="Car Wash" id="carwash">
                            <label class="form-check-label" for="carwash">Car Wash</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="AC Service" id="acservice">
                            <label class="form-check-label" for="acservice">AC Service</label>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Register</button>
                </form>
                <p class="mt-3">Already have an account? <a href="login.jsp">Login</a></p>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            this.querySelector('i').classList.toggle('bi-eye');
            this.querySelector('i').classList.toggle('bi-eye-slash');
        });

        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const type = confirmPasswordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            confirmPasswordInput.setAttribute('type', type);
            this.querySelector('i').classList.toggle('bi-eye');
            this.querySelector('i').classList.toggle('bi-eye-slash');
        });
    </script>
</body>
</html>
