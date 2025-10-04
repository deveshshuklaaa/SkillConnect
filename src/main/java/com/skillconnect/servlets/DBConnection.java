package com.skillconnect.servlets;

import java.sql.*;

public class DBConnection {
    public static Connection getConnection() throws SQLException {
        String url = Config.getDbUrl();
        String user = Config.getDbUser();
        String pass = Config.getDbPassword();
        return DriverManager.getConnection(url, user, pass);
    }
}
