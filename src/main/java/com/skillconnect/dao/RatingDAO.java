package com.skillconnect.dao;

import com.skillconnect.models.Rating;
import com.skillconnect.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RatingDAO {

    public boolean createRating(Rating rating) {
        return addRating(rating);
    }

    public boolean addRating(Rating rating) {
        String sql = "INSERT INTO ratings (booking_id, customer_id, worker_id, rating, feedback) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, rating.getBookingId());
            stmt.setInt(2, rating.getCustomerId());
            stmt.setInt(3, rating.getWorkerId());
            stmt.setInt(4, rating.getRating());
            stmt.setString(5, rating.getFeedback());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Rating> getRatingsByWorker(int workerId) {
        List<Rating> ratings = new ArrayList<>();
        String sql = "SELECT * FROM ratings WHERE worker_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, workerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ratings.add(new Rating(
                    rs.getInt("rating_id"),
                    rs.getInt("booking_id"),
                    rs.getInt("customer_id"),
                    rs.getInt("worker_id"),
                    rs.getInt("rating"),
                    rs.getString("feedback")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ratings;
    }

    public double getAverageRating(int workerId) {
        String sql = "SELECT AVG(rating) AS avg_rating FROM ratings WHERE worker_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, workerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("avg_rating");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public List<Rating> getAllRatings() {
        List<Rating> ratings = new ArrayList<>();
        String sql = "SELECT * FROM ratings";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                ratings.add(new Rating(
                    rs.getInt("rating_id"),
                    rs.getInt("booking_id"),
                    rs.getInt("customer_id"),
                    rs.getInt("worker_id"),
                    rs.getInt("rating"),
                    rs.getString("feedback")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ratings;
    }

    public Rating getRatingByBooking(int bookingId) {
        String sql = "SELECT * FROM ratings WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Rating(
                    rs.getInt("rating_id"),
                    rs.getInt("booking_id"),
                    rs.getInt("customer_id"),
                    rs.getInt("worker_id"),
                    rs.getInt("rating"),
                    rs.getString("feedback")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
