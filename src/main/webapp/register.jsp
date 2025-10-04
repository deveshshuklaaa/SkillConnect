<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register - SkillConnect</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body {
      background-color: #071023;
      color: #e6eef6;
      font-family: Inter, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .register-container {
      background-color: #0b1220;
      padding: 40px;
      border-radius: 14px;
      box-shadow: 0 6px 18px rgba(2,6,23,0.6);
      width: 100%;
      max-width: 400px;
    }
    .register-container h2 {
      color: #6ee7b7;
      margin-bottom: 30px;
      text-align: center;
    }
    .form-control, .form-select {
      background: rgba(255,255,255,0.05);
      border: none;
      color: #e6eef6;
      border-radius: 14px;
      margin-bottom: 15px;
    }
    .form-control::placeholder {
      color: #9aa4b2;
      opacity: 1;
    }
    .btn-register {
      background: #6ee7b7;
      border: none;
      color: #042021;
      font-weight: 600;
      border-radius: 14px;
      width: 100%;
      padding: 12px;
      transition: 0.3s;
    }
    .btn-register:hover {
      background: linear-gradient(90deg, #6ee7b7, #f97316);
    }
    .error-message {
      color: #f44336;
      text-align: center;
      margin-top: 10px;
    }
    .success-message {
      color: #4caf50;
      text-align: center;
      margin-top: 10px;
    }
  </style>
</head>
<body>
  <div class="register-container">
    <h2>Register</h2>
    <form action="${pageContext.request.contextPath}/register" method="post">
      <input type="hidden" name="csrfToken" value="<%= request.getSession().getAttribute("csrfToken") %>">
      <input type="text" class="form-control" name="fullname" placeholder="Full name" required>
      <input type="email" class="form-control" name="email" placeholder="Email" required>
      <input type="password" class="form-control" name="password" placeholder="Password" required>
      <input type="text" class="form-control" name="phone" placeholder="Phone" required>
      <select class="form-select" name="role" required>
        <option value="">Select Role</option>
        <option value="Worker">Worker</option>
        <option value="Employer">Employer</option>
      </select>
      <input type="text" class="form-control" name="location" placeholder="Location" required>
      <input type="text" class="form-control" name="skills" placeholder="Skills" required>
      <button type="submit" class="btn-register">Register</button>
    </form>
    <p class="text-center mt-3">
      <a href="login.jsp" style="color:#6ee7b7;">Login</a> | <a href="index.html" style="color:#6ee7b7;">Home</a>
    </p>
    <p class="error-message">
      <%
        String error = request.getParameter("error");
        if ("name".equals(error) || "fullname".equals(error)) out.print("Invalid name.");
        else if ("email".equals(error)) out.print("Invalid email.");
        else if ("password".equals(error)) out.print("Password must be at least 6 characters.");
        else if ("phone".equals(error)) out.print("Invalid phone number.");
        else if ("role".equals(error)) out.print("Role is required.");
        else if ("location".equals(error)) out.print("Location is too long.");
        else if ("skills".equals(error)) out.print("Skills input is too long.");
        else if ("server".equals(error)) out.print("Server error. Please try again.");
        else if ("csrf".equals(error)) out.print("CSRF token invalid.");
      %>
    </p>
  </div>
</body>
</html>
