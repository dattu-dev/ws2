package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Product;
import model.ProductDAO;
import model.Category;
import model.CategoryDAO;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        String url = "products.jsp";
        
        try {
            if ("product_list".equals(action)) {
                url = handleListProducts(request);
            } else if ("product_listByCategory".equals(action)) {
                url = handleListByCategory(request);
            } else if ("product_view".equals(action)) {
                url = handleViewProduct(request);
            } else if ("product_search".equals(action)) {
                url = handleSearch(request);
            } else if ("product_filter".equals(action)) {
                url = handleFilter(request);
            } else if ("product_showCreate".equals(action)) {
                url = handleShowCreate(request);
            } else if ("product_create".equals(action)) {
                url = handleCreate(request);
            } else if ("product_showEdit".equals(action)) {
                url = handleShowEdit(request);
            } else if ("product_update".equals(action)) {
                url = handleUpdate(request);
            } else if ("product_delete".equals(action)) {
                url = handleDelete(request);
            } else {
                url = handleListProducts(request);
            }
        } catch (Exception e) {
            log("Error in ProductController: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("ERROR", "An error occurred: " + e.getMessage());
            url = "products.jsp";
        }
        
        request.getRequestDispatcher(url).forward(request, response);
    }
    
    private String handleListProducts(HttpServletRequest request) {
        List<Product> products = productDAO.getAllProducts();
        List<Category> categories = categoryDAO.getAllCategories();
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        
        return "products.jsp";
    }
    
    private String handleListByCategory(HttpServletRequest request) {
        String typeIdStr = request.getParameter("typeId");
        List<Category> categories = categoryDAO.getAllCategories();
        
        if (typeIdStr != null && !typeIdStr.isEmpty()) {
            int typeId = Integer.parseInt(typeIdStr);
            List<Product> products = productDAO.getProductsByCategory(typeId);
            Category selectedCategory = categoryDAO.getCategoryById(typeId);
            
            request.setAttribute("products", products);
            request.setAttribute("selectedCategory", selectedCategory);
        } else {
            List<Product> products = productDAO.getAllProducts();
            request.setAttribute("products", products);
        }
        
        request.setAttribute("categories", categories);
        return "products.jsp";
    }
    
    private String handleViewProduct(HttpServletRequest request) {
        String productId = request.getParameter("productId");
        
        if (productId != null && !productId.isEmpty()) {
            Product product = productDAO.getProductById(productId);
            request.setAttribute("product", product);
            return "productDetail.jsp";
        }
        
        request.setAttribute("ERROR", "Product not found!");
        return handleListProducts(request);
    }
    
    private String handleSearch(HttpServletRequest request) {
        String keyword = request.getParameter("keyword");
        List<Category> categories = categoryDAO.getAllCategories();
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            List<Product> products = productDAO.searchProductsByName(keyword);
            request.setAttribute("products", products);
            request.setAttribute("keyword", keyword);
        } else {
            List<Product> products = productDAO.getAllProducts();
            request.setAttribute("products", products);
        }
        
        request.setAttribute("categories", categories);
        return "products.jsp";
    }
    
    private String handleFilter(HttpServletRequest request) {
        String typeIdStr = request.getParameter("typeId");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String hasDiscountStr = request.getParameter("hasDiscount");
        String sortBy = request.getParameter("sortBy");
        
        Integer typeId = (typeIdStr != null && !typeIdStr.isEmpty()) ? Integer.parseInt(typeIdStr) : null;
        Integer minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Integer.parseInt(minPriceStr) : null;
        Integer maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Integer.parseInt(maxPriceStr) : null;
        Boolean hasDiscount = null;
        
        if ("yes".equals(hasDiscountStr)) {
            hasDiscount = true;
        } else if ("no".equals(hasDiscountStr)) {
            hasDiscount = false;
        }
        
        List<Product> products = productDAO.filterProducts(typeId, minPrice, maxPrice, hasDiscount, sortBy);
        List<Category> categories = categoryDAO.getAllCategories();
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedTypeId", typeId);
        request.setAttribute("selectedMinPrice", minPrice);
        request.setAttribute("selectedMaxPrice", maxPrice);
        request.setAttribute("selectedHasDiscount", hasDiscountStr);
        request.setAttribute("selectedSortBy", sortBy);
        
        return "products.jsp";
    }
    
    private String handleShowCreate(HttpServletRequest request) {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        return "admin/productForm.jsp";
    }
    
    private String handleCreate(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");
        
        String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String productImage = request.getParameter("productImage");
        String brief = request.getParameter("brief");
        String typeIdStr = request.getParameter("typeId");
        String unit = request.getParameter("unit");
        String priceStr = request.getParameter("price");
        String discountStr = request.getParameter("discount");
        
        Product product = new Product();
        product.setProductId(productId);
        product.setProductName(productName);
        product.setProductImage(productImage);
        product.setBrief(brief);
        product.setTypeId(Integer.parseInt(typeIdStr));
        product.setAccount(username);
        product.setUnit(unit);
        product.setPrice(Integer.parseInt(priceStr));
        product.setDiscount(Integer.parseInt(discountStr));
        
        if (productDAO.insertProduct(product)) {
            request.setAttribute("SUCCESS", "Product created successfully!");
            return "MainController?action=product_list";
        } else {
            request.setAttribute("ERROR", "Failed to create product!");
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.setAttribute("product", product);
            return "admin/productForm.jsp";
        }
    }
    
    private String handleShowEdit(HttpServletRequest request) {
        String productId = request.getParameter("productId");
        
        if (productId != null && !productId.isEmpty()) {
            Product product = productDAO.getProductById(productId);
            List<Category> categories = categoryDAO.getAllCategories();
            
            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            return "admin/productForm.jsp";
        }
        
        request.setAttribute("ERROR", "Product not found!");
        return "MainController?action=product_list";
    }
    
    private String handleUpdate(HttpServletRequest request) {
        String productId = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String productImage = request.getParameter("productImage");
        String brief = request.getParameter("brief");
        String typeIdStr = request.getParameter("typeId");
        String unit = request.getParameter("unit");
        String priceStr = request.getParameter("price");
        String discountStr = request.getParameter("discount");
        
        Product product = productDAO.getProductById(productId);
        if (product != null) {
            product.setProductName(productName);
            product.setProductImage(productImage);
            product.setBrief(brief);
            product.setTypeId(Integer.parseInt(typeIdStr));
            product.setUnit(unit);
            product.setPrice(Integer.parseInt(priceStr));
            product.setDiscount(Integer.parseInt(discountStr));
            
            if (productDAO.updateProduct(product)) {
                request.setAttribute("SUCCESS", "Product updated successfully!");
                return "MainController?action=product_list";
            } else {
                request.setAttribute("ERROR", "Failed to update product!");
            }
        } else {
            request.setAttribute("ERROR", "Product not found!");
        }
        
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("product", product);
        return "admin/productForm.jsp";
    }
    
    private String handleDelete(HttpServletRequest request) {
        String productId = request.getParameter("productId");
        
        if (productId != null && !productId.isEmpty()) {
            if (productDAO.deleteProduct(productId)) {
                request.setAttribute("SUCCESS", "Product deleted successfully!");
            } else {
                request.setAttribute("ERROR", "Failed to delete product!");
            }
        }
        
        return handleListProducts(request);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Product Controller - Handles all product-related operations";
    }
}