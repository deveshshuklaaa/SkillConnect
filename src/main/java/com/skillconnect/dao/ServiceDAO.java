package com.skillconnect.dao;

import com.skillconnect.models.Service;
import com.skillconnect.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO {

    public boolean addService(Service service) {
        String sql = "INSERT INTO services (worker_id, service_name, price, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, service.getWorkerId());
            stmt.setString(2, service.getServiceName());
            stmt.setDouble(3, service.getPrice());
            stmt.setString(4, service.getStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Service> getServicesByWorker(int workerId) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE worker_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, workerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                services.add(new Service(
                    rs.getInt("service_id"),
                    rs.getInt("worker_id"),
                    rs.getString("service_name"),
                    rs.getDouble("price"),
                    rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    public List<Service> getAllActiveServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE status = 'active'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                services.add(new Service(
                    rs.getInt("service_id"),
                    rs.getInt("worker_id"),
                    rs.getString("service_name"),
                    rs.getDouble("price"),
                    rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    public boolean updateService(Service service) {
        String sql = "UPDATE services SET service_name = ?, price = ?, status = ? WHERE service_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, service.getServiceName());
            stmt.setDouble(2, service.getPrice());
            stmt.setString(3, service.getStatus());
            stmt.setInt(4, service.getServiceId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteService(int serviceId) {
        String sql = "DELETE FROM services WHERE service_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, serviceId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Service getServiceById(int serviceId) {
        String sql = "SELECT * FROM services WHERE service_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, serviceId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Service(
                    rs.getInt("service_id"),
                    rs.getInt("worker_id"),
                    rs.getString("service_name"),
                    rs.getDouble("price"),
                    rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
