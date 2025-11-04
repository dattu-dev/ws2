package model;

import utils.DBUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AccountDAO {
    
    // Track active sessions to prevent multiple logins
    private static Map<String, String> activeSessions = new HashMap<>();
    
    public Account login(String account, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtils.makeConnection();
            String sql = "SELECT * FROM accounts WHERE account = ? AND pass = ? AND isUse = 1";
            ps = conn.prepareStatement(sql);
            ps.setString(1, account);
            ps.setString(2, password);
            
            rs = ps.executeQuery();
            if (rs.next()) {
                return extractAccountFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, ps, conn);
        }
        return null;
    }
    
    public List<Account> getAllAccounts() {
        List<Account> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtils.makeConnection();
            String sql = "SELECT * FROM accounts ORDER BY roleInSystem DESC, account";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(extractAccountFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, ps, conn);
        }
        return list;
    }
    
    public Account getAccountByUsername(String account) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtils.makeConnection();
            String sql = "SELECT * FROM accounts WHERE account = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, account);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return extractAccountFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, ps, conn);
        }
        return null;
    }
    
    public boolean insertAccount(Account acc) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBUtils.makeConnection();
            String sql = "INSERT INTO accounts (account, pass, lastName, firstName, birthday, " +
                        "gender, phone, isUse, roleInSystem) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, acc.getAccount());
            ps.setString(2, acc.getPass());
            ps.setString(3, acc.getLastName());
            ps.setString(4, acc.getFirstName());
            ps.setDate(5, acc.getBirthday());
            ps.setBoolean(6, acc.isGender());
            ps.setString(7, acc.getPhone());
            ps.setBoolean(8, acc.isUse());
            ps.setInt(9, acc.getRoleInSystem());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(null, ps, conn);
        }
        return false;
    }
    
    public boolean updateAccount(Account acc) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBUtils.makeConnection();
            String sql = "UPDATE accounts SET pass = ?, lastName = ?, firstName = ?, " +
                        "birthday = ?, gender = ?, phone = ?, isUse = ?, roleInSystem = ? " +
                        "WHERE account = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, acc.getPass());
            ps.setString(2, acc.getLastName());
            ps.setString(3, acc.getFirstName());
            ps.setDate(4, acc.getBirthday());
            ps.setBoolean(5, acc.isGender());
            ps.setString(6, acc.getPhone());
            ps.setBoolean(7, acc.isUse());
            ps.setInt(8, acc.getRoleInSystem());
            ps.setString(9, acc.getAccount());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(null, ps, conn);
        }
        return false;
    }
    
    public boolean deleteAccount(String account) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBUtils.makeConnection();
            String sql = "DELETE FROM accounts WHERE account = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, account);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(null, ps, conn);
        }
        return false;
    }
    
    public boolean banAccount(String account, boolean ban) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBUtils.makeConnection();
            String sql = "UPDATE accounts SET isUse = ? WHERE account = ?";
            ps = conn.prepareStatement(sql);
            ps.setBoolean(1, !ban); // isUse = true means active, false means banned
            ps.setString(2, account);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(null, ps, conn);
        }
        return false;
    }
    
    // Session management methods
    public synchronized boolean registerSession(String username, String sessionId) {
        if (activeSessions.containsKey(username)) {
            return false; // Already logged in
        }
        activeSessions.put(username, sessionId);
        return true;
    }
    
    public synchronized void unregisterSession(String username) {
        activeSessions.remove(username);
    }
    
    public synchronized boolean isSessionValid(String username, String sessionId) {
        String storedSessionId = activeSessions.get(username);
        return storedSessionId != null && storedSessionId.equals(sessionId);
    }
    
    private Account extractAccountFromResultSet(ResultSet rs) throws SQLException {
        Account acc = new Account();
        acc.setAccount(rs.getString("account"));
        acc.setPass(rs.getString("pass"));
        acc.setLastName(rs.getString("lastName"));
        acc.setFirstName(rs.getString("firstName"));
        acc.setBirthday(rs.getDate("birthday"));
        acc.setGender(rs.getBoolean("gender"));
        acc.setPhone(rs.getString("phone"));
        acc.setUse(rs.getBoolean("isUse"));
        acc.setRoleInSystem(rs.getInt("roleInSystem"));
        return acc;
    }
    
    private void closeResources(ResultSet rs, PreparedStatement ps, Connection conn) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}