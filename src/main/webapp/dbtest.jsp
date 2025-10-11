<%@ page import="com.skillconnect.utils.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>DB Test</title>
</head>
<body>
    <h1>Database Connection Test</h1>
    <%
        try {
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                out.println("<p style='color:green;'>Database connection successful!</p>");
                conn.close();
            } else {
                out.println("<p style='color:red;'>Database connection failed!</p>");
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>
