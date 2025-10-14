package com.skillconnect.servlets;

import com.skillconnect.dao.ContactDAO;
import com.skillconnect.models.Contact;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private ContactDAO contactDAO = new ContactDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            subject == null || subject.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {
            response.sendRedirect("contact.jsp?error=All fields are required");
            return;
        }

        Contact contact = new Contact(name, email, subject, message);
        boolean success = contactDAO.addContact(contact);
        if (success) {
            response.sendRedirect("contact.jsp?message=Message sent successfully");
        } else {
            response.sendRedirect("contact.jsp?error=Failed to send message");
        }
    }
}
