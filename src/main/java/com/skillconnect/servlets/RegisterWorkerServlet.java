package com.skillconnect.servlets;

import com.skillconnect.dao.UserDAO;
import com.skillconnect.dao.WorkerSkillDAO;
import com.skillconnect.models.User;
import com.skillconnect.models.WorkerSkill;
import java.io.IOException;
import java.util.Arrays;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/registerWorker")
public class RegisterWorkerServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private WorkerSkillDAO skillDAO = new WorkerSkillDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");
        String[] skills = request.getParameterValues("skills");

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("workerRegister.jsp?error=Passwords do not match.");
            return;
        }

        User user = new User(0, name, email, password, phone, "worker", location);
        int result = userDAO.registerUser(user);

        if (result == 0) {
            // Get the user ID
            User registeredUser = userDAO.loginUser(email, password);
            if (registeredUser != null && skills != null) {
                for (String skill : skills) {
                    WorkerSkill workerSkill = new WorkerSkill(registeredUser.getUserId(), skill);
                    skillDAO.addSkill(workerSkill);
                }
            }
            response.sendRedirect("workerRegister.jsp?message=Registration successful! Please login.");
        } else if (result == 1) {
            response.sendRedirect("workerRegister.jsp?error=Email already exists. Please use a different email.");
        } else {
            response.sendRedirect("workerRegister.jsp?error=Registration failed due to database error.");
        }
    }
}
