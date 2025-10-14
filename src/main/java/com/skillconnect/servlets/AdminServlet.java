package com.skillconnect.servlets;

import com.skillconnect.dao.UserDAO;
import com.skillconnect.dao.CategoryDAO;
import com.skillconnect.dao.ServiceDAO;
import com.skillconnect.dao.BookingDAO;
import com.skillconnect.dao.RatingDAO;
import com.skillconnect.dao.StatsDAO;
import com.skillconnect.dao.ContactDAO;
import com.skillconnect.models.Admin;
import com.skillconnect.models.Category;
import com.skillconnect.models.Service;
import com.skillconnect.models.Booking;
import com.skillconnect.models.Rating;
import com.skillconnect.models.User;
import com.skillconnect.models.Contact;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private ServiceDAO serviceDAO = new ServiceDAO();
    private BookingDAO bookingDAO = new BookingDAO();
    private RatingDAO ratingDAO = new RatingDAO();
    private StatsDAO statsDAO = new StatsDAO();
    private ContactDAO contactDAO = new ContactDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("deleteUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userDAO.deleteUser(userId);
        } else if ("addCategory".equals(action)) {
            String categoryName = request.getParameter("categoryName");
            String description = request.getParameter("description");
            Category category = new Category(0, categoryName, description);
            categoryDAO.addCategory(category);
        } else if ("editCategory".equals(action)) {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String categoryName = request.getParameter("categoryName");
            String description = request.getParameter("description");
            Category category = new Category(categoryId, categoryName, description);
            categoryDAO.updateCategory(category);
        } else if ("deleteCategory".equals(action)) {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            categoryDAO.deleteCategory(categoryId);
        } else if ("addService".equals(action)) {
            int workerId = Integer.parseInt(request.getParameter("workerId"));
            String serviceName = request.getParameter("serviceName");
            double price = Double.parseDouble(request.getParameter("price"));
            String status = request.getParameter("status");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            Service service = new Service(0, workerId, serviceName, price, status, categoryId);
            serviceDAO.addService(service);
        } else if ("editService".equals(action)) {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int workerId = Integer.parseInt(request.getParameter("workerId"));
            String serviceName = request.getParameter("serviceName");
            double price = Double.parseDouble(request.getParameter("price"));
            String status = request.getParameter("status");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            Service service = new Service(serviceId, workerId, serviceName, price, status, categoryId);
            serviceDAO.updateService(service);
        } else if ("deleteService".equals(action)) {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            serviceDAO.deleteService(serviceId);
        } else if ("filterBookings".equals(action)) {
            String status = request.getParameter("status");
            Date startDate = request.getParameter("startDate") != null && !request.getParameter("startDate").isEmpty() ? Date.valueOf(request.getParameter("startDate")) : null;
            Date endDate = request.getParameter("endDate") != null && !request.getParameter("endDate").isEmpty() ? Date.valueOf(request.getParameter("endDate")) : null;
            Integer workerId = request.getParameter("workerId") != null && !request.getParameter("workerId").isEmpty() ? Integer.parseInt(request.getParameter("workerId")) : null;
            Integer customerId = request.getParameter("customerId") != null && !request.getParameter("customerId").isEmpty() ? Integer.parseInt(request.getParameter("customerId")) : null;
            List<Booking> filteredBookings = bookingDAO.getBookingsByFilter(status, startDate, endDate, workerId, customerId);
            request.setAttribute("filteredBookings", filteredBookings);
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
            return;
        } else if ("reassignBooking".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int newWorkerId = Integer.parseInt(request.getParameter("newWorkerId"));
            bookingDAO.updateBookingWorker(bookingId, newWorkerId);
        } else if ("deleteRating".equals(action)) {
            int ratingId = Integer.parseInt(request.getParameter("ratingId"));
            ratingDAO.deleteRating(ratingId);
        } else if ("deleteContact".equals(action)) {
            int contactId = Integer.parseInt(request.getParameter("contactId"));
            contactDAO.deleteContact(contactId);
        } else if ("getStats".equals(action)) {
            int totalUsers = userDAO.getTotalUsers();
            int activeBookings = statsDAO.getActiveBookingsCount();
            StatsDAO.TopRatedWorker topRatedWorker = statsDAO.getTopRatedWorker();
            List<StatsDAO.PopularService> popularServices = statsDAO.getMostPopularServices();
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("activeBookings", activeBookings);
            request.setAttribute("topRatedWorker", topRatedWorker);
            request.setAttribute("popularServices", popularServices);
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
            return;
        }
        response.sendRedirect("adminDashboard.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
