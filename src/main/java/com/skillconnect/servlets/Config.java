package com.skillconnect.servlets;

public class Config {
    public static String getDbUrl() {
        String host = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "localhost";
        String port = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "3306";
        String dbName = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "skillconnect";
        return "jdbc:mysql://" + host + ":" + port + "/" + dbName + "?useSSL=true&serverTimezone=UTC";
    }

    public static String getDbUser() {
        return System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
    }

    public static String getDbPassword() {
        return System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "password";
    }
}
