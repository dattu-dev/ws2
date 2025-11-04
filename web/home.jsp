<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Introduction - Home</title>
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
        }
        
        .btn-primary {
            background: white;
            color: #667eea;
            font-weight: 600;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        
        .btn-secondary {
            background: rgba(255,255,255,0.2);
            color: white;
            border: 1px solid white;
        }
        
        .btn-secondary:hover {
            background: rgba(255,255,255,0.3);
        }
        
        .hero {
            background: white;
            padding: 60px 0;
            text-align: center;
        }
        
        .hero h2 {
            font-size: 48px;
            color: #333;
            margin-bottom: 20px;
        }
        
        .hero p {
            font-size: 20px;
            color: #666;
            margin-bottom: 30px;
        }
        
        .search-box {
            max-width: 600px;
            margin: 0 auto;
            display: flex;
            gap: 10px;
        }
        
        .search-box input {
            flex: 1;
            padding: 15px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        
        .search-box button {
            padding: 15px 30px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            font-weight: 600;
        }
        
        .search-box button:hover {
            background: #5568d3;
        }
        
        .categories {
            padding: 60px 0;
            background: #f9f9f9;
        }
        
        .section-title {
            text-align: center;
            font-size: 36px;
            color: #333;
            margin-bottom: 40px;
        }
        
        .category-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }
        
        .category-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        
        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        
        .category-card h3 {
            font-size: 24px;
            color: #333;
            margin-bottom: 15px;
        }
        
        .category-card p {
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
                    <h1>ProductIntro</h1>
                </div>
                
                <ul class="nav-menu">
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="MainController?action=product_list">Products</a></li>
                    <c:if test="${not empty sessionScope.account}">
                        <c:if test="${sessionScope.role >= 1}">
                            <li><a href="admin/dashboard.jsp">Admin</a></li>
                        </c:if>
                    </c:if>
                </ul>
                
                <div class="user-info">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <span>Welcome, ${sessionScope.fullName} (${sessionScope.roleName})</span>
                            <a href="MainController?action=auth_logout" class="btn btn-secondary">Logout</a>
                        </c:when>
                        <c:otherwise>
                            <a href="login.jsp" class="btn btn-primary">Login</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Messages -->
    <div class="container">
        <c:if test="${not empty SUCCESS}">
            <div class="alert alert-success">${SUCCESS}</div>
        </c:if>
        
        <c:if test="${not empty ERROR}">
            <div class="alert alert-error">${ERROR}</div>
        </c:if>
    </div>
    
    <!-- Hero Section -->
    <div class="hero">
        <div class="container">
            <h2>Discover Amazing Products</h2>
            <p>Browse our collection of quality products at great prices</p>
            
            <form action="MainController" method="get" class="search-box">
                <input type="hidden" name="action" value="product_search">
                <input type="text" name="keyword" placeholder="Search for products..." required>
                <button type="submit">Search</button>
            </form>
        </div>
    </div>
    
    <!-- Categories Section -->
    <div class="categories">
        <div class="container">
            <h2 class="section-title">Browse by Category</h2>
            
            <div class="category-grid">
                <div class="category-card">
                    <h3>All Products</h3>
                    <p>View our complete collection</p>
                    <a href="MainController?action=product_list" class="btn btn-primary">View All</a>
                </div>
                
                <div class="category-card">
                    <h3>Special Offers</h3>
                    <p>Products with discounts</p>
                    <a href="MainController?action=product_filter&hasDiscount=yes" class="btn btn-primary">View Deals</a>
                </div>
                
                <div class="category-card">
                    <h3>Latest Products</h3>
                    <p>Check out our newest items</p>
                    <a href="MainController?action=product_list&sortBy=date_desc" class="btn btn-primary">View New</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <div class="footer">
        <div class="container">
            <p>&copy; 2025 ProductIntro. All rights reserved.</p>
        </div>
    </div>
</body>
</html>