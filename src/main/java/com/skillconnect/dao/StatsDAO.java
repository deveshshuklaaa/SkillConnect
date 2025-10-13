package com.skillconnect.dao;

import com.skillconnect.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StatsDAO {

    public int getActiveBookingsCount() {
        String sql = "SELECT COUNT(*) FROM bookings WHERE status != 'cancelled'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static class TopRatedWorker {
        private int workerId;
        private String name;
        private double avgRating;

        public TopRatedWorker(int workerId, String name, double avgRating) {
            this.workerId = workerId;
            this.name = name;
            this.avgRating = avgRating;
        }

        public int getWorkerId() { return workerId; }
        public String getName() { return name; }
        public double getAvgRating() { return avgRating; }
    }

    public TopRatedWorker getTopRatedWorker() {
        String sql = "SELECT u.user_id, u.name, AVG(r.rating) AS avg_rating FROM ratings r JOIN users u ON r.worker_id = u.user_id GROUP BY r.worker_id ORDER BY avg_rating DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return new TopRatedWorker(rs.getInt("user_id"), rs.getString("name"), rs.getDouble("avg_rating"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static class PopularService {
        private int serviceId;
        private String serviceName;
        private int bookingCount;

        public PopularService(int serviceId, String serviceName, int bookingCount) {
            this.serviceId = serviceId;
            this.serviceName = serviceName;
            this.bookingCount = bookingCount;
        }

        public int getServiceId() { return serviceId; }
        public String getServiceName() { return serviceName; }
        public int getBookingCount() { return bookingCount; }
    }

    public List<PopularService> getMostPopularServices() {
        List<PopularService> services = new ArrayList<>();
        String sql = "SELECT s.service_id, s.service_name, COUNT(b.booking_id) AS booking_count FROM services s LEFT JOIN bookings b ON s.service_id = b.service_id GROUP BY s.service_id ORDER BY booking_count DESC LIMIT 5";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                services.add(new PopularService(rs.getInt("service_id"), rs.getString("service_name"), rs.getInt("booking_count")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }
}
