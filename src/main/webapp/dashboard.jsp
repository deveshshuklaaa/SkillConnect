<%@ page import="jakarta.servlet.http.*" %>
<%
    HttpSession s = request.getSession(false);
    if (s == null || s.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String name = (String) s.getAttribute("userName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Dashboard - SkillConnect</title>
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
      margin: 0;
    }
    .dashboard-container {
      background-color: #0b1220;
      padding: 40px;
      border-radius: 14px;
      box-shadow: 0 6px 18px rgba(2,6,23,0.6);
      width: 100%;
      max-width: 600px;
      text-align: center;
    }
    .dashboard-container h2 {
      color: #6ee7b7;
      margin-bottom: 20px;
    }
    .dashboard-container p {
      color: #9aa4b2;
      margin-bottom: 30px;
    }
    .btn-logout {
      background: #f97316;
      border: none;
      color: #042021;
      font-weight: 600;
      border-radius: 14px;
      padding: 12px 24px;
      transition: 0.3s;
    }
    .btn-logout:hover {
      background: linear-gradient(90deg, #f97316, #6ee7b7);
    }
  </style>
</head>
<body>
  <div class="dashboard-container">
    <h2>Welcome, <%= name %>!</h2>
    <p>This is your protected dashboard. You are successfully logged in to SkillConnect.</p>
    <a href="logout" class="btn-logout">Logout</a>
  </div>
</body>
</html>
