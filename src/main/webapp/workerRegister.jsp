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
                <% String error = (String) session.getAttribute("error"); %>
                <% if (error != null) { %>
                    <div class="alert alert-danger"><%= error %></div>
                    <% session.removeAttribute("error"); %>
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
                        <input type="password" class="form-control" id="password" name="password" required>
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
                        <label class="form-label">Skills</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="Electrician" id="electrician">
                            <label class="form-check-label" for="electrician">Electrician</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="Plumber" id="plumber">
                            <label class="form-check-label" for="plumber">Plumber</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="skills" value="Carpenter" id="carpenter">
                            <label class="form-check-label" for="carpenter">Carpenter</label>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Register</button>
                </form>
                <p class="mt-3">Already have an account? <a href="login.jsp">Login</a></p>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
