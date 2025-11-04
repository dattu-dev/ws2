package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Account;
import model.AccountDAO;
import java.io.IOException;

@WebServlet(name = "AuthController", urlPatterns = {"/AuthController"})
public class AuthController extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String HOME_PAGE = "home.jsp";
    private static final String ADMIN_HOME = "admin/dashboard.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        String url = LOGIN_PAGE;
        
        try {
            if ("auth_login".equals(action)) {
                url = handleLogin(request, response);
            } else if ("auth_logout".equals(action)) {
                url = handleLogout(request, response);
            } else if ("auth_showLogin".equals(action)) {
                url = LOGIN_PAGE;
            } else {
                url = LOGIN_PAGE;
            }
        } catch (Exception e) {
            log("Error in AuthController: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("ERROR", "Authentication error: " + e.getMessage());
            url = LOGIN_PAGE;
        }
        
        request.getRequestDispatcher(url).forward(request, response);
    }
    
    private String handleLogin(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        AccountDAO dao = new AccountDAO();
        Account account = dao.login(username, password);
        
        if (account != null) {
            HttpSession session = request.getSession();
            
            // Check if already logged in elsewhere
            if (!dao.registerSession(username, session.getId())) {
                request.setAttribute("ERROR", "This account is already logged in on another browser/device!");
                return LOGIN_PAGE;
            }
            
            // Store user info in session
            session.setAttribute("account", account);
            session.setAttribute("username", account.getAccount());
            session.setAttribute("fullName", account.getFullName());
            session.setAttribute("role", account.getRoleInSystem());
            session.setAttribute("roleName", account.getRoleName());
            
            request.setAttribute("SUCCESS", "Welcome, " + account.getFullName() + "!");
            
            // Redirect based on role
            if (account.getRoleInSystem() >= 1) { // Admin or Manager
                return ADMIN_HOME;
            } else {
                return HOME_PAGE;
            }
        } else {
            request.setAttribute("ERROR", "Invalid username or password, or account is banned!");
            return LOGIN_PAGE;
        }
    }
    
    private String handleLogout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            String username = (String) session.getAttribute("username");
            
            // Unregister session
            if (username != null) {
                AccountDAO dao = new AccountDAO();
                dao.unregisterSession(username);
            }
            
            session.invalidate();
        }
        
        request.setAttribute("SUCCESS", "You have been logged out successfully!");
        return HOME_PAGE;
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
        return "Authentication Controller - Handles login and logout";
    }
}