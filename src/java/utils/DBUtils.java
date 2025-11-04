package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtils {
    private static final String DB_NAME = "ProductIntro";
    private static final String DB_USER_NAME = "sa";
    private static final String DB_PASSWORD = "12345";
    
    public static Connection makeConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://localhost:1433;databaseName=" + DB_NAME 
                   + ";encrypt=true;trustServerCertificate=true";
        return DriverManager.getConnection(url, DB_USER_NAME, DB_PASSWORD);
    }
    
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}