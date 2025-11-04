package model;

import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "SELECT p.*, c.categoryName, a.firstName + ' ' + a.lastName as authorName " +
                        "FROM products p " +
                        "JOIN categories c ON p.typeId = c.typeId " +
                        "JOIN accounts a ON p.account = a.account " +
                        "ORDER BY p.postedDate DESC";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(extractProductFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, ps, conn);
        }
        return list;
    }
    
    public List<Product> getProductsByCategory(int typeId) {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "SELECT p.*, c.categoryName, a.firstName + ' ' + a.lastName as authorName " +
                        "FROM products p " +
                        "JOIN categories c ON p.typeId = c.typeId " +
                        "JOIN accounts a ON p.account = a.account " +
                        "WHERE p.typeId = ? " +
                        "ORDER BY p.postedDate DESC";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, typeId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(extractProductFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, ps, conn);
        }
        return list;
    }
    
    public List<Product> searchProductsByName(String keyword) {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "SELECT p.*, c.categoryName, a.firstName + ' ' + a.lastName as authorName " +
                        "FROM products p " +
                        "JOIN categories c ON p.typeId = c.typeId " +
                        "JOIN accounts a ON p.account = a.account " +
                        "WHERE p.productName LIKE ? " +
                        "ORDER BY p.postedDate DESC";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(extractProductFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, ps, conn);
        }
        return list;
    }
    
    public List<Product> filterProducts(Integer typeId, Integer minPrice, Integer maxPrice, 
                                        Boolean hasDiscount, String sortBy) {
        List<Product> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();
            StringBuilder sql = new StringBuilder(
                "SELECT p.*, c.categoryName, a.firstName + ' ' + a.lastName as authorName " +
                "FROM products p " +
                "JOIN categories c ON p.typeId = c.typeId " +
                "JOIN accounts a ON p.account = a.account WHERE 1=1 "
            );
            
            if (typeId != null) {
                sql.append("AND p.typeId = ? ");
            }
            if (minPrice != null) {
                sql.append("AND p.price >= ? ");
            }
            if (maxPrice != null) {
                sql.append("AND p.price <= ? ");
            }
            if (hasDiscount != null) {
                if (hasDiscount) {
                    sql.append("AND p.discount > 0 ");
                } else {
                    sql.append("AND p.discount = 0 ");
                }
            }
            
            // Sorting
            if ("price_asc".equals(sortBy)) {
                sql.append("ORDER BY p.price ASC");
            } else if ("price_desc".equals(sortBy)) {
                sql.append("ORDER BY p.price DESC");
            } else {
                sql.append("ORDER BY p.postedDate DESC");
            }
            
            ps = conn.prepareStatement(sql.toString());
            
            int paramIndex = 1;
            if (typeId != null) {
                ps.setInt(paramIndex++, typeId);
            }
            if (minPrice != null) {
                ps.setInt(paramIndex++, minPrice);
            }
            if (maxPrice != null) {
                ps.setInt(paramIndex++, maxPrice);
            }
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(extractProductFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, ps, conn);
        }
        return list;
    }
    
    public Product getProductById(String productId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "SELECT p.*, c.categoryName, a.firstName + ' ' + a.lastName as authorName " +
                        "FROM products p " +
                        "JOIN categories c ON p.typeId = c.typeId " +
                        "JOIN accounts a ON p.account = a.account " +
                        "WHERE p.productId = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, productId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return extractProductFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, ps, conn);
        }
        return null;
    }
    
    public boolean insertProduct(Product product) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "INSERT INTO products (productId, productName, productImage, brief, " +
                        "typeId, account, unit, price, discount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, product.getProductId());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getProductImage());
            ps.setString(4, product.getBrief());
            ps.setInt(5, product.getTypeId());
            ps.setString(6, product.getAccount());
            ps.setString(7, product.getUnit());
            ps.setInt(8, product.getPrice());
            ps.setInt(9, product.getDiscount());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(null, ps, conn);
        }
        return false;
    }
    
    public boolean updateProduct(Product product) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "UPDATE products SET productName = ?, productImage = ?, brief = ?, " +
                        "typeId = ?, unit = ?, price = ?, discount = ? WHERE productId = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getProductImage());
            ps.setString(3, product.getBrief());
            ps.setInt(4, product.getTypeId());
            ps.setString(5, product.getUnit());
            ps.setInt(6, product.getPrice());
            ps.setInt(7, product.getDiscount());
            ps.setString(8, product.getProductId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(null, ps, conn);
        }
        return false;
    }
    
    public boolean deleteProduct(String productId) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBContext.getConnection();
            String sql = "DELETE FROM products WHERE productId = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, productId);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(null, ps, conn);
        }
        return false;
    }
    
    private Product extractProductFromResultSet(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductId(rs.getString("productId"));
        p.setProductName(rs.getString("productName"));
        p.setProductImage(rs.getString("productImage"));
        p.setBrief(rs.getString("brief"));
        p.setPostedDate(rs.getTimestamp("postedDate"));
        p.setTypeId(rs.getInt("typeId"));
        p.setAccount(rs.getString("account"));
        p.setUnit(rs.getString("unit"));
        p.setPrice(rs.getInt("price"));
        p.setDiscount(rs.getInt("discount"));
        p.setCategoryName(rs.getString("categoryName"));
        p.setAuthorName(rs.getString("authorName"));
        return p;
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