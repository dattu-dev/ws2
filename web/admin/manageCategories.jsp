<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories - Admin</title>
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
            max-width: 1200px;
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
                    <li><a href="dashboard.jsp">Dashboard</a></li>
                    <li><a href="../MainController?action=product_list">Products</a></li>
                    <li><a href="../MainController?action=category_list">Categories</a></li>
                    <li><a href="../MainController?action=account_list">Accounts</a></li>
                </ul>
                
                <div class="user-info">
                    <span>${sessionScope.fullName}</span>
                    <a href="../MainController?action=auth_logout" class="btn btn-secondary">Logout</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <div class="page-header-content">
                <h2 class="page-title">Manage Categories</h2>
                <a href="../MainController?action=category_showCreate" class="btn btn-primary">
                    + Add New Category
                </a>
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
        
        <!-- Categories Table -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Category Name</th>
                        <th>Description</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="category" items="${categories}">
                        <tr>
                            <td>${category.typeId}</td>
                            <td><strong>${category.categoryName}</strong></td>
                            <td>${category.memo}</td>
                            <td>
                                <div class="actions">
                                    <a href="../MainController?action=category_showEdit&typeId=${category.typeId}" 
                                       class="btn btn-warning btn-sm">Edit</a>
                                    <c:if test="${sessionScope.role >= 1}">
                                        <a href="../MainController?action=category_delete&typeId=${category.typeId}" 
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Are you sure? This will affect all products in this category!')">Delete</a>
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