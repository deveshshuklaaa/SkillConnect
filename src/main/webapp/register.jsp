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
  <title>Register - SkillConnect</title>
  <link rel="stylesheet" href="css/style.css">
  <script src="js/script.js"></script>
</head>
<body>
  <div class="container">
    <h2>Register</h2>
    <form action="register" method="post" onsubmit="return validateRegister()">
      <input type="hidden" name="csrfToken" value="<%= sess.getAttribute("csrfToken") %>">
      <input type="text" name="name" placeholder="Full name" required><br>
      <input type="email" name="email" placeholder="Email" required><br>
      <input type="password" name="password" placeholder="Password" required><br>
      <button type="submit">Register</button>
    </form>
    <p>Already a user? <a href="login.jsp">Login</a></p>
    <p style="color:red;">
      <%
        String error = request.getParameter("error");
        if ("name".equals(error)) out.print("Invalid name.");
        else if ("email".equals(error)) out.print("Invalid email.");
        else if ("password".equals(error)) out.print("Password must be at least 6 characters.");
        else if ("server".equals(error)) out.print("Server error. Please try again.");
        else if ("csrf".equals(error)) out.print("CSRF token invalid.");
      %>
    </p>
  </div>
</body>
</html>
