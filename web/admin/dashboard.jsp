<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ProductIntro</title>
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
            transition: opacity 0.3s;
        }
        
        .nav-menu a:hover {
            opacity: 0.8;
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
            text-align: center;
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
            background: rgba(255,255,255,0.2);
            color: white;
            border: 1px solid white;
        }
        
        .btn-secondary:hover {
            background: rgba(255,255,255,0.3);
        }
        
        .page-title {
            text-align: center;
            padding: 40px 0;
            background: white;
            margin-bottom: 30px;
        }
        
        .page-title h2 {
            font-size: 36px;
            color: #333;
        }
        
        .page-title p {
            color: #666;
            margin-top: 10px;
        }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin: 30px 0;
        }
        
        .dashboard-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            text-align: center;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        
        .card-icon {
            font-size: 48px;
            margin-bottom: 20px;
        }
        
        .card-title {
            font-size: 24px;
            color: #333;
            margin-bottom: 15px;
        }
        
        .card-description {
            color: #666;
            margin-bottom: 20px;
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
        
        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 20px 0;
            margin-top: 60px;
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
                    <li><a href="${pageContext.request.contextPath}/home.jsp">Public Site</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/MainController?action=product_list">Products</a></li>
                </ul>
                
                <div class="user-info">
                    <span>Welcome, ${sessionScope.fullName} (${sessionScope.roleName})</span>
                    <a href="${pageContext.request.contextPath}/MainController?action=auth_logout" class="btn btn-secondary">Logout</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Page Title -->
    <div class="page-title">
        <h2>Admin Dashboard</h2>
        <p>Manage your products, categories, and user accounts</p>
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
        
        <!-- Dashboard Cards -->
        <div class="dashboard-grid">
            <!-- Manage Products -->
            <div class="dashboard-card">
                <div class="card-icon">📦</div>
                <h3 class="card-title">Manage Products</h3>
                <p class="card-description">Create, edit, and delete products in your catalog</p>
                <a href="${pageContext.request.contextPath}/MainController?action=product_list" class="btn btn-primary" style="width: 100%;">
                    Go to Products
                </a>
            </div>
            
            <!-- Manage Categories -->
            <div class="dashboard-card">
                <div class="card-icon">📁</div>
                <h3 class="card-title">Manage Categories</h3>
                <p class="card-description">Organize your products with categories</p>
                <a href="${pageContext.request.contextPath}/MainController?action=category_list" class="btn btn-primary" style="width: 100%;">
                    Go to Categories
                </a>
            </div>
            
            <!-- Manage Accounts -->
            <div class="dashboard-card">
                <div class="card-icon">👥</div>
                <h3 class="card-title">Manage Accounts</h3>
                <p class="card-description">Control user access and permissions</p>
                <a href="${pageContext.request.contextPath}/MainController?action=account_list" class="btn btn-primary" style="width: 100%;">
                    Go to Accounts
                </a>
            </div>
            
            <!-- Add New Product -->
            <div class="dashboard-card">
                <div class="card-icon">➕</div>
                <h3 class="card-title">Add New Product</h3>
                <p class="card-description">Quickly add a new product to your catalog</p>
                <a href="${pageContext.request.contextPath}/MainController?action=product_showCreate" class="btn btn-primary" style="width: 100%;">
                    Create Product
                </a>
            </div>
            
            <!-- Add New Category -->
            <div class="dashboard-card">
                <div class="card-icon">🆕</div>
                <h3 class="card-title">Add New Category</h3>
                <p class="card-description">Create a new product category</p>
                <a href="${pageContext.request.contextPath}/MainController?action=category_showCreate" class="btn btn-primary" style="width: 100%;">
                    Create Category
                </a>
            </div>
            
            <!-- Add New Account -->
            <c:if test="${sessionScope.role == 1}">
                <div class="dashboard-card">
                    <div class="card-icon">👤</div>
                    <h3 class="card-title">Add New Account</h3>
                    <p class="card-description">Create a new user account</p>
                    <a href="${pageContext.request.contextPath}/MainController?action=account_showCreate" class="btn btn-primary" style="width: 100%;">
                        Create Account
                    </a>
                </div>
            </c:if>
        </div>
    </div>
    
    <!-- Footer -->
    <div class="footer">
        <div class="container">
            <p>&copy; 2025 ProductIntro Admin Panel. All rights reserved.</p>
        </div>
    </div>
</body>
</html>