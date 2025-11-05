package com.skillconnect.servlets;

import com.skillconnect.dao.ServiceDAO;
import com.skillconnect.models.Service;
import com.skillconnect.models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/service")
public class ServiceServlet extends HttpServlet {
    private ServiceDAO serviceDAO = new ServiceDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !"worker".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String serviceName = request.getParameter("serviceName");
            String priceStr = request.getParameter("price");
            String status = request.getParameter("status");
            String categoryIdStr = request.getParameter("categoryId");

            if (priceStr == null || priceStr.trim().isEmpty()) {
                response.sendRedirect("workerServices.jsp?error=Price is required");
                return;
            }

            double price = Double.parseDouble(priceStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            Service service = new Service(0, user.getUserId(), serviceName, price, status, categoryId);
            boolean success = serviceDAO.addService(service);
            if (success) {
                response.sendRedirect("workerDashboard.jsp?message=Service added successfully");
            } else {
                response.sendRedirect("workerDashboard.jsp?error=Failed to add service");
            }
        } else if ("update".equals(action)) {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            String serviceName = request.getParameter("serviceName");
            double price = Double.parseDouble(request.getParameter("price"));
            String status = request.getParameter("status");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            Service service = new Service(serviceId, user.getUserId(), serviceName, price, status, categoryId);
            boolean success = serviceDAO.updateService(service);
            if (success) {
                response.sendRedirect("workerDashboard.jsp?message=Service updated successfully");
            } else {
                response.sendRedirect("workerDashboard.jsp?error=Failed to update service");
            }
        } else if ("delete".equals(action)) {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            boolean success = serviceDAO.deleteService(serviceId);
            if (success) {
                response.sendRedirect("workerDashboard.jsp?message=Service deleted successfully");
            } else {
                response.sendRedirect("workerDashboard.jsp?error=Failed to delete service");
            }
        }
    }
}
