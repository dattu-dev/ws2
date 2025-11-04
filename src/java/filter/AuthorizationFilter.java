package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AuthorizationFilter", urlPatterns = {
    "/ProductController",
    "/CategoryController",
    "/AccountController"
})
public class AuthorizationFilter implements Filter {

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
        
        String action = httpRequest.getParameter("action");
        
        // Check if action requires authorization
        if (action != null && (action.endsWith("_delete") || action.endsWith("_create") || action.endsWith("_update"))) {
            
            if (session != null && session.getAttribute("role") != null) {
                Integer role = (Integer) session.getAttribute("role");
                
                // Only Admin (1) or Manager (2) can delete, create, or update
                if (role >= 1) {
                    chain.doFilter(request, response);
                } else {
                    httpRequest.setAttribute("ERROR", "You don't have permission to perform this action! Only Admin or Manager can modify data.");
                    httpRequest.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
                }
            } else {
                httpRequest.setAttribute("ERROR", "Please login to perform this action!");
                httpRequest.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else {
            // Action doesn't require special authorization
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}