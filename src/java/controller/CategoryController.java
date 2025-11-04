package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Category;
import model.CategoryDAO;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryController", urlPatterns = {"/CategoryController"})
public class CategoryController extends HttpServlet {

    private CategoryDAO categoryDAO = new CategoryDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        String url = "admin/manageCategories.jsp";
        
        try {
            if ("category_list".equals(action)) {
                url = handleList(request);
            } else if ("category_showCreate".equals(action)) {
                url = handleShowCreate(request);
            } else if ("category_create".equals(action)) {
                url = handleCreate(request);
            } else if ("category_showEdit".equals(action)) {
                url = handleShowEdit(request);
            } else if ("category_update".equals(action)) {
                url = handleUpdate(request);
            } else if ("category_delete".equals(action)) {
                url = handleDelete(request);
            } else {
                url = handleList(request);
            }
        } catch (Exception e) {
            log("Error in CategoryController: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("ERROR", "An error occurred: " + e.getMessage());
            url = handleList(request);
        }
        
        request.getRequestDispatcher(url).forward(request, response);
    }
    
    private String handleList(HttpServletRequest request) {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        return "admin/manageCategories.jsp";
    }
    
    private String handleShowCreate(HttpServletRequest request) {
        return "admin/categoryForm.jsp";
    }
    
    private String handleCreate(HttpServletRequest request) {
        String categoryName = request.getParameter("categoryName");
        String memo = request.getParameter("memo");
        
        Category category = new Category();
        category.setCategoryName(categoryName);
        category.setMemo(memo);
        
        if (categoryDAO.insertCategory(category)) {
            request.setAttribute("SUCCESS", "Category created successfully!");
            return handleList(request);
        } else {
            request.setAttribute("ERROR", "Failed to create category!");
            request.setAttribute("category", category);
            return "admin/categoryForm.jsp";
        }
    }
    
    private String handleShowEdit(HttpServletRequest request) {
        String typeIdStr = request.getParameter("typeId");
        
        if (typeIdStr != null && !typeIdStr.isEmpty()) {
            int typeId = Integer.parseInt(typeIdStr);
            Category category = categoryDAO.getCategoryById(typeId);
            
            request.setAttribute("category", category);
            return "admin/categoryForm.jsp";
        }
        
        request.setAttribute("ERROR", "Category not found!");
        return handleList(request);
    }
    
    private String handleUpdate(HttpServletRequest request) {
        String typeIdStr = request.getParameter("typeId");
        String categoryName = request.getParameter("categoryName");
        String memo = request.getParameter("memo");
        
        int typeId = Integer.parseInt(typeIdStr);
        Category category = new Category();
        category.setTypeId(typeId);
        category.setCategoryName(categoryName);
        category.setMemo(memo);
        
        if (categoryDAO.updateCategory(category)) {
            request.setAttribute("SUCCESS", "Category updated successfully!");
            return handleList(request);
        } else {
            request.setAttribute("ERROR", "Failed to update category!");
            request.setAttribute("category", category);
            return "admin/categoryForm.jsp";
        }
    }
    
    private String handleDelete(HttpServletRequest request) {
        String typeIdStr = request.getParameter("typeId");
        
        if (typeIdStr != null && !typeIdStr.isEmpty()) {
            int typeId = Integer.parseInt(typeIdStr);
            
            if (categoryDAO.deleteCategory(typeId)) {
                request.setAttribute("SUCCESS", "Category deleted successfully!");
            } else {
                request.setAttribute("ERROR", "Failed to delete category! It may have associated products.");
            }
        }
        
        return handleList(request);
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
        return "Category Controller - Handles all category-related operations";
    }
}