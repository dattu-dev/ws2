package model;

import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "SELECT * FROM categories ORDER BY categoryName";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(extractCategoryFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, ps, conn);
        }
        return list;
    }
    
    public Category getCategoryById(int typeId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "SELECT * FROM categories WHERE typeId = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, typeId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return extractCategoryFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, ps, conn);
        }
        return null;
    }
    
    public boolean insertCategory(Category category) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "INSERT INTO categories (categoryName, memo) VALUES (?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getMemo());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(null, ps, conn);
        }
        return false;
    }
    
    public boolean updateCategory(Category category) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "UPDATE categories SET categoryName = ?, memo = ? WHERE typeId = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getMemo());
            ps.setInt(3, category.getTypeId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(null, ps, conn);
        }
        return false;
    }
    
    public boolean deleteCategory(int typeId) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "DELETE FROM categories WHERE typeId = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, typeId);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(null, ps, conn);
        }
        return false;
    }
    
    private Category extractCategoryFromResultSet(ResultSet rs) throws SQLException {
        Category cat = new Category();
        cat.setTypeId(rs.getInt("typeId"));
        cat.setCategoryName(rs.getString("categoryName"));
        cat.setMemo(rs.getString("memo"));
        return cat;
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