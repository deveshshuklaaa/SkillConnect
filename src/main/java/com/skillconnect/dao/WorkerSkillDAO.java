package com.skillconnect.dao;

import com.skillconnect.models.WorkerSkill;
import com.skillconnect.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WorkerSkillDAO {

    public boolean addSkill(WorkerSkill skill) {
        String sql = "INSERT INTO worker_skills (worker_id, skill_name) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, skill.getWorkerId());
            stmt.setString(2, skill.getSkillName());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<String> getSkillsByWorker(int workerId) {
        List<String> skills = new ArrayList<>();
        String sql = "SELECT skill_name FROM worker_skills WHERE worker_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, workerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                skills.add(rs.getString("skill_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return skills;
    }

    public boolean removeSkill(int workerId, String skillName) {
        String sql = "DELETE FROM worker_skills WHERE worker_id = ? AND skill_name = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, workerId);
            stmt.setString(2, skillName);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
