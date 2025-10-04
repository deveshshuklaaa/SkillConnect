<%@ page import="jakarta.servlet.http.*" %>
<%
    HttpSession sess = request.getSession();
    if (sess.getAttribute("csrfToken") == null) {
        sess.setAttribute("csrfToken", java.util.UUID.randomUUID().toString());
    }
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Login - SkillConnect</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <div class="container">
    <h2>Login</h2>
    <form action="login" method="post">
      <input type="hidden" name="csrfToken" value="<%= sess.getAttribute("csrfToken") %>">
      <input type="email" name="email" placeholder="Email" required><br>
      <input type="password" name="password" placeholder="Password" required><br>
      <button type="submit">Login</button>
    </form>
    <p><a href="register.jsp">Register</a></p>
    <p style="color:green;">${param.registered != null ? 'Registration successful, please login.' : ''}</p>
    <p style="color:red;">
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
