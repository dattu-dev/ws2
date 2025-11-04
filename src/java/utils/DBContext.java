/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author uydat
 */
public class DBContext {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=ProductIntro;characterEncoding=UTF-8";
    private static final String USER = "sa";
    private static final String PASSWORD = "12345"; 

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("SQL Server JDBC Driver not found", e);
        }
    }
    
    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            System.out.println("Connection test successful!");
            conn.close();
        } catch (SQLException e) {
            System.out.println("Connection test failed: " + e.getMessage());
        }
    }
}
