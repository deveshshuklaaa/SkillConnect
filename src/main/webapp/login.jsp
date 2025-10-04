<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login - SkillConnect</title>
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
    .login-container {
      background-color: #0b1220;
      padding: 40px;
      border-radius: 14px;
      box-shadow: 0 6px 18px rgba(2,6,23,0.6);
      width: 100%;
      max-width: 400px;
    }
    .login-container h2 {
      color: #6ee7b7;
      margin-bottom: 30px;
      text-align: center;
    }
    .form-control {
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
    .btn-login {
      background: #6ee7b7;
      border: none;
      color: #042021;
      font-weight: 600;
      border-radius: 14px;
      width: 100%;
      padding: 12px;
      transition: 0.3s;
    }
    .btn-login:hover {
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
  <div class="login-container">
    <h2>Login</h2>
    <%
      if (request.getSession().getAttribute("csrfToken") == null) {
        java.security.SecureRandom random = new java.security.SecureRandom();
        String token = new java.math.BigInteger(130, random).toString(32);
        request.getSession().setAttribute("csrfToken", token);
      }
    %>
    <form action="${pageContext.request.contextPath}/login" method="post">
      <input type="hidden" name="csrfToken" value="<%= request.getSession().getAttribute("csrfToken") %>">
      <input type="email" class="form-control" name="email" placeholder="Email" required>
      <input type="password" class="form-control" name="password" placeholder="Password" required>
      <button type="submit" class="btn-login">Login</button>
    </form>
    <p class="text-center mt-3">
      <a href="register.jsp" style="color:#6ee7b7;">Register</a> | <a href="index.html" style="color:#6ee7b7;">Home</a>
    </p>
    <p class="success-message">
      <%= request.getParameter("registered") != null ? "Registration successful, please login." : "" %>
    </p>
    <p class="error-message">
      <%
        String error = request.getParameter("error");
        if ("invalid".equals(error)) out.print("Invalid email or password.");
        else if ("server".equals(error)) out.print("Server error. Please try again.");
        else if ("csrf".equals(error)) out.print("CSRF token invalid.");
      %>
    </p>
  </div>
</body>
</html>
