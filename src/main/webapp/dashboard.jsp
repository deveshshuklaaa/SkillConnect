<%@ page import="jakarta.servlet.http.*" %>
<%
    HttpSession s = request.getSession(false);
    if (s == null || s.getAttribute("userId") == null) {
        response.sendRedirect("login.html");
        return;
    }
    String name = (String) s.getAttribute("userName");
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Dashboard - SkillConnect</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <div class="container">
    <h2>Welcome, <%= name %></h2>
    <p>This is a protected dashboard.</p>
    <p><a href="logout">Logout</a></p>
  </div>
</body>
</html>
