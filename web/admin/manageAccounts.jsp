<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Accounts - Admin</title>
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
            max-width: 1400px;
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
        
        .nav-menu {
            display: flex;
            gap: 30px;
            list-style: none;
        }
        
        .nav-menu a {
            color: white;
            text-decoration: none;
            font-weight: 500;
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
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
            font-weight: 600;
        }
        
        .btn-secondary {
            background: rgba(255,255,255,0.2);
            color: white;
            border: 1px solid white;
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
            font-weight: 600;
        }
        
        .btn-warning {
            background: #ffc107;
            color: #333;
            font-weight: 600;
        }
        
        .btn-success {
            background: #28a745;
            color: white;
            font-weight: 600;
        }
        
        .btn-sm {
            padding: 5px 10px;
            font-size: 12px;
        }
        
        .page-header {
            background: white;
            padding: 30px 0;
            margin-bottom: 30px;
        }
        
        .page-header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .page-title {
            font-size: 32px;
            color: #333;
        }
        
        .table-container {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        th {
            background: #f9f9f9;
            font-weight: 600;
            color: #333;
        }
        
        tr:hover {
            background: #f9f9f9;
        }
        
        .actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .badge {
            padding: 5px 10px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .badge-admin {
            background: #dc3545;
            color: white;
        }
        
        .badge-manager {
            background: #ffc107;
            color: #333;
        }
        
        .badge-member {
            background: #6c757d;
            color: white;
        }
        
        .badge-active {
            background: #28a745;
            color: white;
        }
        
        .badge-banned {
            background: #dc3545;
            color: white;
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 5px;
            margin: 20px 0;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
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
                
                <ul class="nav-menu">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/MainController?action=product_list">Products</a></li>
                    <li><a href="${pageContext.request.contextPath}/MainController?action=category_list">Categories</a></li>
                    <li><a href="${pageContext.request.contextPath}/MainController?action=account_list">Accounts</a></li>
                </ul>
                
                <div class="user-info">
                    <span>${sessionScope.fullName}</span>
                    <a href="${pageContext.request.contextPath}/MainController?action=auth_logout" class="btn btn-secondary">Logout</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <div class="page-header-content">
                <h2 class="page-title">Manage Accounts</h2>
                <c:if test="${sessionScope.role == 1}">
                    <a href="${pageContext.request.contextPath}/MainController?action=account_showCreate" class="btn btn-primary">
                        + Add New Account
                    </a>
                </c:if>
            </div>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="container">
        <!-- Messages -->
        <c:if test="${not empty SUCCESS}">
            <div class="alert alert-success">${SUCCESS}</div>
        </c:if>
        
        <c:if test="${not empty ERROR}">
            <div class="alert alert-error">${ERROR}</div>
        </c:if>
        
        <!-- Accounts Table -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Full Name</th>
                        <th>Birthday</th>
                        <th>Gender</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="acc" items="${accounts}">
                        <tr>
                            <td><strong>${acc.account}</strong></td>
                            <td>${acc.fullName}</td>
                            <td><fmt:formatDate value="${acc.birthday}" pattern="dd/MM/yyyy"/></td>
                            <td>${acc.gender ? 'Male' : 'Female'}</td>
                            <td>${acc.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${acc.roleInSystem == 1}">
                                        <span class="badge badge-admin">Admin</span>
                                    </c:when>
                                    <c:when test="${acc.roleInSystem == 2}">
                                        <span class="badge badge-manager">Manager</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-member">Member</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${acc.use}">
                                        <span class="badge badge-active">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-banned">Banned</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="actions">
                                    <a href="${pageContext.request.contextPath}/MainController?action=account_showEdit&account=${acc.account}" 
                                       class="btn btn-warning btn-sm">Edit</a>
                                    
                                    <c:choose>
                                        <c:when test="${acc.use}">
                                            <a href="${pageContext.request.contextPath}/MainController?action=account_ban&account=${acc.account}" 
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Ban this account?')">Ban</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/MainController?action=account_unban&account=${acc.account}" 
                                               class="btn btn-success btn-sm"
                                               onclick="return confirm('Unban this account?')">Unban</a>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <c:if test="${sessionScope.role == 1 && acc.account != sessionScope.username}">
                                        <a href="${pageContext.request.contextPath}/MainController?action=account_delete&account=${acc.account}" 
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Permanently delete this account?')">Delete</a>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>