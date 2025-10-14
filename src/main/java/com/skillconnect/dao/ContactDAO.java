package com.skillconnect.dao;

import com.skillconnect.models.Contact;
import com.skillconnect.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO {

    public boolean addContact(Contact contact) {
        String sql = "INSERT INTO contacts (name, email, subject, message) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, contact.getName());
            stmt.setString(2, contact.getEmail());
            stmt.setString(3, contact.getSubject());
            stmt.setString(4, contact.getMessage());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Contact> getAllContacts() {
        List<Contact> contacts = new ArrayList<>();
        String sql = "SELECT * FROM contacts ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                contacts.add(new Contact(
                    rs.getInt("contact_id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("subject"),
                    rs.getString("message"),
                    rs.getTimestamp("created_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contacts;
    }

    public boolean deleteContact(int contactId) {
        String sql = "DELETE FROM contacts WHERE contact_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, contactId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
