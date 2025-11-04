package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    private static final String AUTH_CONTROLLER = "/AuthController";
    private static final String PRODUCT_CONTROLLER = "/ProductController";
    private static final String CATEGORY_CONTROLLER = "/CategoryController";
    private static final String ACCOUNT_CONTROLLER = "/AccountController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        String url = "home.jsp"; // Default page
        
        try {
            if (action == null || action.isEmpty()) {
                // Default action - go to home page
                url = "home.jsp";
            } else {
                // Dispatch to appropriate controller based on action prefix
                if (action.startsWith("auth_")) {
                    // Authentication actions: login, logout, register
                    request.getRequestDispatcher(AUTH_CONTROLLER).forward(request, response);
                    return;
                } else if (action.startsWith("product_")) {
                    // Product actions: list, view, create, update, delete, search, filter
                    request.getRequestDispatcher(PRODUCT_CONTROLLER).forward(request, response);
                    return;
                } else if (action.startsWith("category_")) {
                    // Category actions: list, create, update, delete
                    request.getRequestDispatcher(CATEGORY_CONTROLLER).forward(request, response);
                    return;
                } else if (action.startsWith("account_")) {
                    // Account actions: list, create, update, delete, ban
                    request.getRequestDispatcher(ACCOUNT_CONTROLLER).forward(request, response);
                    return;
                } else {
                    // Unknown action
                    url = "home.jsp";
                }
            }
        } catch (IOException | ServletException e) {
            log("Error in MainController: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("ERROR", "An error occurred: " + e.getMessage());
            url = "error.jsp";
        }
        
        request.getRequestDispatcher(url).forward(request, response);
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
        return "Main Controller - Dispatches requests to appropriate module controllers";
    }
}