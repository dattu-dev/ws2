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

    private static final String LOGIN_PAGE = "/login.jsp";
    private static final String HOME_PAGE = "/home.jsp";
    private static final String ADMIN_HOME = "/admin/dashboard.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        String url = LOGIN_PAGE;
        
        try {
            if ("auth_login".equals(action)) {
                handleLogin(request, response);
                return; // handleLogin now uses redirect
            } else if ("auth_logout".equals(action)) {
                handleLogout(request, response);
                return; // handleLogout now uses redirect
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
    
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        AccountDAO dao = new AccountDAO();
        Account account = dao.login(username, password);
        
        if (account != null) {
            HttpSession session = request.getSession();
            
            // Check if already logged in elsewhere
            if (!dao.registerSession(username, session.getId())) {
                request.setAttribute("ERROR", "This account is already logged in on another browser/device!");
                request.getRequestDispatcher(LOGIN_PAGE).forward(request, response);
                return;
            }
            
            // Store user info in session
            session.setAttribute("account", account);
            session.setAttribute("username", account.getAccount());
            session.setAttribute("fullName", account.getFullName());
            session.setAttribute("role", account.getRoleInSystem());
            session.setAttribute("roleName", account.getRoleName());
            
            session.setAttribute("SUCCESS", "Welcome, " + account.getFullName() + "!");
            
            // Redirect based on role
            String redirectUrl = request.getContextPath();
            if (account.getRoleInSystem() >= 1) { // Admin or Manager
                redirectUrl += ADMIN_HOME;
            } else {
                redirectUrl += HOME_PAGE;
            }
            response.sendRedirect(redirectUrl);
        } else {
            request.setAttribute("ERROR", "Invalid username or password, or account is banned!");
            request.getRequestDispatcher(LOGIN_PAGE).forward(request, response);
        }
    }
    
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
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
        
        // Create new session for success message
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute("SUCCESS", "You have been logged out successfully!");
        
        // Redirect to home page
        response.sendRedirect(request.getContextPath() + HOME_PAGE);
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