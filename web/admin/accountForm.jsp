<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty account ? 'Edit' : 'Create'} Account - Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo h1 {
            font-size: 28px;
            font-weight: 600;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
            font-size: 14px;
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
            font-weight: 600;
        }
        
        .btn-primary:hover {
            background: #5568d3;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
            font-weight: 600;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
        }
        
        .page-header {
            background: white;
            padding: 30px 0;
            margin-bottom: 30px;
        }
        
        .page-title {
            font-size: 32px;
            color: #333;
            text-align: center;
        }
        
        .form-container {
            background: white;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            font-family: inherit;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .required {
            color: #dc3545;
        }
        
        .radio-group {
            display: flex;
            gap: 20px;
        }
        
        .radio-group label {
            display: flex;
            align-items: center;
            gap: 5px;
            font-weight: normal;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <h1>ProductIntro Admin</h1>
                </div>
                
                <div class="user-info">
                    <span>${sessionScope.fullName}</span>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h2 class="page-title">
                <c:choose>
                    <c:when test="${not empty account}">Edit Account</c:when>
                    <c:otherwise>Create New Account</c:otherwise>
                </c:choose>
            </h2>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="container">
        <!-- Error Messages -->
        <c:if test="${not empty ERROR}">
            <div class="alert alert-error">${ERROR}</div>
        </c:if>
        
        <!-- Account Form -->
        <div class="form-container">
            <form action="../MainController" method="post">
                <input type="hidden" name="action" 
                       value="${not empty account ? 'account_update' : 'account_create'}">
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="account">Username <span class="required">*</span></label>
                        <input type="text" id="account" name="account" 
                               value="${account.account}" 
                               ${not empty account ? 'readonly' : ''} 
                               required autofocus>
                    </div>
                    
                    <div class="form-group">
                        <label for="pass">Password <span class="required">*</span></label>
                        <input type="password" id="pass" name="pass" 
                               value="${account.pass}" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="lastName">Last Name <span class="required">*</span></label>
                        <input type="text" id="lastName" name="lastName" 
                               value="${account.lastName}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="firstName">First Name <span class="required">*</span></label>
                        <input type="text" id="firstName" name="firstName" 
                               value="${account.firstName}" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="birthday">Birthday <span class="required">*</span></label>
                        <input type="date" id="birthday" name="birthday" 
                               value="<fmt:formatDate value='${account.birthday}' pattern='yyyy-MM-dd'/>" 
                               required>
                    </div>
                    
                    <div class="form-group">
                        <label>Gender <span class="required">*</span></label>
                        <div class="radio-group">
                            <label>
                                <input type="radio" name="gender" value="true" 
                                       ${account.gender || empty account ? 'checked' : ''}>
                                Male
                            </label>
                            <label>
                                <input type="radio" name="gender" value="false" 
                                       ${!account.gender && not empty account ? 'checked' : ''}>
                                Female
                            </label>
                        </div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone Number <span class="required">*</span></label>
                        <input type="tel" id="phone" name="phone" 
                               value="${account.phone}" 
                               pattern="0[3|5|7|8|9][0-9]{8}"
                               placeholder="0xxxxxxxxx" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="roleInSystem">Role <span class="required">*</span></label>
                        <select id="roleInSystem" name="roleInSystem" required>
                            <option value="0" ${account.roleInSystem == 0 ? 'selected' : ''}>Member</option>
                            <option value="2" ${account.roleInSystem == 2 ? 'selected' : ''}>Manager</option>
                            <c:if test="${sessionScope.role == 1}">
                                <option value="1" ${account.roleInSystem == 1 ? 'selected' : ''}>Admin</option>
                            </c:if>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Account Status <span class="required">*</span></label>
                    <div class="radio-group">
                        <label>
                            <input type="radio" name="isUse" value="true" 
                                   ${account.use || empty account ? 'checked' : ''}>
                            Active
                        </label>
                        <label>
                            <input type="radio" name="isUse" value="false" 
                                   ${!account.use && not empty account ? 'checked' : ''}>
                            Banned
                        </label>
                    </div>
                </div>
                
                <div class="form-actions">
                    <a href="../MainController?action=account_list" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty account}">Update Account</c:when>
                            <c:otherwise>Create Account</c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>