package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.AccountDAO;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "AccountController", urlPatterns = {"/AccountController"})
public class AccountController extends HttpServlet {

    private AccountDAO accountDAO = new AccountDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        String url = "admin/manageAccounts.jsp";
        
        try {
            if ("account_list".equals(action)) {
                url = handleList(request);
            } else if ("account_showCreate".equals(action)) {
                url = handleShowCreate(request);
            } else if ("account_create".equals(action)) {
                url = handleCreate(request);
            } else if ("account_showEdit".equals(action)) {
                url = handleShowEdit(request);
            } else if ("account_update".equals(action)) {
                url = handleUpdate(request);
            } else if ("account_delete".equals(action)) {
                url = handleDelete(request);
            } else if ("account_ban".equals(action)) {
                url = handleBan(request);
            } else if ("account_unban".equals(action)) {
                url = handleUnban(request);
            } else {
                url = handleList(request);
            }
        } catch (Exception e) {
            log("Error in AccountController: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("ERROR", "An error occurred: " + e.getMessage());
            url = handleList(request);
        }
        
        request.getRequestDispatcher(url).forward(request, response);
    }
    
    private String handleList(HttpServletRequest request) {
        List<Account> accounts = accountDAO.getAllAccounts();
        request.setAttribute("accounts", accounts);
        return "admin/manageAccounts.jsp";
    }
    
    private String handleShowCreate(HttpServletRequest request) {
        return "admin/accountForm.jsp";
    }
    
    private String handleCreate(HttpServletRequest request) {
        String account = request.getParameter("account");
        String pass = request.getParameter("pass");
        String lastName = request.getParameter("lastName");
        String firstName = request.getParameter("firstName");
        String birthdayStr = request.getParameter("birthday");
        String genderStr = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String isUseStr = request.getParameter("isUse");
        String roleStr = request.getParameter("roleInSystem");
        
        Account acc = new Account();
        acc.setAccount(account);
        acc.setPass(pass);
        acc.setLastName(lastName);
        acc.setFirstName(firstName);
        acc.setBirthday(Date.valueOf(birthdayStr));
        acc.setGender("true".equals(genderStr) || "1".equals(genderStr));
        acc.setPhone(phone);
        acc.setUse("true".equals(isUseStr) || "1".equals(isUseStr));
        acc.setRoleInSystem(Integer.parseInt(roleStr));
        
        if (accountDAO.insertAccount(acc)) {
            request.setAttribute("SUCCESS", "Account created successfully!");
            return handleList(request);
        } else {
            request.setAttribute("ERROR", "Failed to create account! Username may already exist.");
            request.setAttribute("account", acc);
            return "admin/accountForm.jsp";
        }
    }
    
    private String handleShowEdit(HttpServletRequest request) {
        String username = request.getParameter("account");
        
        if (username != null && !username.isEmpty()) {
            Account account = accountDAO.getAccountByUsername(username);
            
            request.setAttribute("account", account);
            return "admin/accountForm.jsp";
        }
        
        request.setAttribute("ERROR", "Account not found!");
        return handleList(request);
    }
    
    private String handleUpdate(HttpServletRequest request) {
        String account = request.getParameter("account");
        String pass = request.getParameter("pass");
        String lastName = request.getParameter("lastName");
        String firstName = request.getParameter("firstName");
        String birthdayStr = request.getParameter("birthday");
        String genderStr = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String isUseStr = request.getParameter("isUse");
        String roleStr = request.getParameter("roleInSystem");
        
        Account acc = new Account();
        acc.setAccount(account);
        acc.setPass(pass);
        acc.setLastName(lastName);
        acc.setFirstName(firstName);
        acc.setBirthday(Date.valueOf(birthdayStr));
        acc.setGender("true".equals(genderStr) || "1".equals(genderStr));
        acc.setPhone(phone);
        acc.setUse("true".equals(isUseStr) || "1".equals(isUseStr));
        acc.setRoleInSystem(Integer.parseInt(roleStr));
        
        if (accountDAO.updateAccount(acc)) {
            request.setAttribute("SUCCESS", "Account updated successfully!");
            return handleList(request);
        } else {
            request.setAttribute("ERROR", "Failed to update account!");
            request.setAttribute("account", acc);
            return "admin/accountForm.jsp";
        }
    }
    
    private String handleDelete(HttpServletRequest request) {
        String username = request.getParameter("account");
        
        if (username != null && !username.isEmpty()) {
            if (accountDAO.deleteAccount(username)) {
                request.setAttribute("SUCCESS", "Account deleted successfully!");
            } else {
                request.setAttribute("ERROR", "Failed to delete account! Account may have associated data.");
            }
        }
        
        return handleList(request);
    }
    
    private String handleBan(HttpServletRequest request) {
        String username = request.getParameter("account");
        
        if (username != null && !username.isEmpty()) {
            if (accountDAO.banAccount(username, true)) {
                request.setAttribute("SUCCESS", "Account banned successfully!");
            } else {
                request.setAttribute("ERROR", "Failed to ban account!");
            }
        }
        
        return handleList(request);
    }
    
    private String handleUnban(HttpServletRequest request) {
        String username = request.getParameter("account");
        
        if (username != null && !username.isEmpty()) {
            if (accountDAO.banAccount(username, false)) {
                request.setAttribute("SUCCESS", "Account unbanned successfully!");
            } else {
                request.setAttribute("ERROR", "Failed to unban account!");
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
        return "Account Controller - Handles all account-related operations";
    }
}