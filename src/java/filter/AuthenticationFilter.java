package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {"/admin/*"})
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String loginURI = httpRequest.getContextPath() + "/login.jsp";
        String authControllerURI = httpRequest.getContextPath() + "/AuthController";
        
        boolean loggedIn = (session != null && session.getAttribute("account") != null);
        boolean loginRequest = httpRequest.getRequestURI().equals(loginURI);
        boolean authRequest = httpRequest.getRequestURI().equals(authControllerURI);
        
        if (loggedIn || loginRequest || authRequest) {
            // User is logged in or requesting login page or auth controller
            chain.doFilter(request, response);
        } else {
            // User is not logged in, redirect to login page
            httpRequest.setAttribute("ERROR", "Please login to access admin pages!");
            httpRequest.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}