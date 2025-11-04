package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.AccountDAO;
import java.io.IOException;

@WebFilter(filterName = "SessionControlFilter", urlPatterns = {"/*"})
public class SessionControlFilter implements Filter {

    private AccountDAO accountDAO = new AccountDAO();

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
        
        // Check if user is logged in
        if (session != null && session.getAttribute("username") != null) {
            String username = (String) session.getAttribute("username");
            String sessionId = session.getId();
            
            // Verify that this session is the valid one for this user
            if (!accountDAO.isSessionValid(username, sessionId)) {
                // Session is not valid (user logged in elsewhere)
                session.invalidate();
                httpRequest.setAttribute("ERROR", "Your account has been logged in from another location!");
                httpRequest.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
        }
        
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}