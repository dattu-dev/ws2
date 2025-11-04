<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - ProductIntro</title>
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
        }
        
        .page-title h2 {
            font-size: 36px;
            color: #333;
        }
        
        .filter-section {
            background: white;
            padding: 30px;
            margin: 20px 0;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .filter-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            align-items: end;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
        }
        
        .form-group label {
            margin-bottom: 5px;
            color: #333;
            font-weight: 600;
        }
        
        .form-group input,
        .form-group select {
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin: 30px 0;
        }
        
        .product-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        
        .product-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 48px;
        }
        
        .product-info {
            padding: 20px;
        }
        
        .product-category {
            color: #667eea;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 5px;
        }
        
        .product-name {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
            min-height: 50px;
        }
        
        .product-brief {
            color: #666;
            font-size: 14px;
            margin-bottom: 15px;
            min-height: 40px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        
        .product-price {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }
        
        .price {
            font-size: 24px;
            font-weight: 700;
            color: #667eea;
        }
        
        .original-price {
            font-size: 16px;
            color: #999;
            text-decoration: line-through;
        }
        
        .discount-badge {
            background: #ff4444;
            color: white;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: 600;
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
        
        .no-products {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 10px;
        }
        
        .no-products h3 {
            font-size: 24px;
            color: #666;
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
                            <span>Welcome, ${sessionScope.fullName}</span>
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
    
    <!-- Page Title -->
    <div class="page-title">
        <h2>
            <c:choose>
                <c:when test="${not empty selectedCategory}">
                    ${selectedCategory.categoryName}
                </c:when>
                <c:when test="${not empty keyword}">
                    Search Results for "${keyword}"
                </c:when>
                <c:otherwise>
                    All Products
                </c:otherwise>
            </c:choose>
        </h2>
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
        
        <!-- Filter Section -->
        <div class="filter-section">
            <form action="MainController" method="get" class="filter-form">
                <input type="hidden" name="action" value="product_filter">
                
                <div class="form-group">
                    <label for="typeId">Category</label>
                    <select id="typeId" name="typeId">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.typeId}" 
                                    ${selectedTypeId == cat.typeId ? 'selected' : ''}>
                                ${cat.categoryName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="minPrice">Min Price</label>
                    <input type="number" id="minPrice" name="minPrice" 
                           value="${selectedMinPrice}" placeholder="0">
                </div>
                
                <div class="form-group">
                    <label for="maxPrice">Max Price</label>
                    <input type="number" id="maxPrice" name="maxPrice" 
                           value="${selectedMaxPrice}" placeholder="1000000">
                </div>
                
                <div class="form-group">
                    <label for="hasDiscount">Discount</label>
                    <select id="hasDiscount" name="hasDiscount">
                        <option value="">All Products</option>
                        <option value="yes" ${selectedHasDiscount == 'yes' ? 'selected' : ''}>
                            With Discount
                        </option>
                        <option value="no" ${selectedHasDiscount == 'no' ? 'selected' : ''}>
                            No Discount
                        </option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="sortBy">Sort By</label>
                    <select id="sortBy" name="sortBy">
                        <option value="date_desc" ${selectedSortBy == 'date_desc' ? 'selected' : ''}>
                            Newest First
                        </option>
                        <option value="price_asc" ${selectedSortBy == 'price_asc' ? 'selected' : ''}>
                            Price: Low to High
                        </option>
                        <option value="price_desc" ${selectedSortBy == 'price_desc' ? 'selected' : ''}>
                            Price: High to Low
                        </option>
                    </select>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn btn-primary" style="width: 100%;">
                        Apply Filters
                    </button>
                </div>
            </form>
        </div>
        
        <!-- Product Grid -->
        <c:choose>
            <c:when test="${not empty products}">
                <div class="product-grid">
                    <c:forEach var="product" items="${products}">
                        <div class="product-card">
                            <div class="product-image">
                                <c:choose>
                                    <c:when test="${not empty product.productImage}">
                                        <img src="${product.productImage}" alt="${product.productName}" 
                                             style="width: 100%; height: 100%; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        📦
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="product-info">
                                <div class="product-category">${product.categoryName}</div>
                                <div class="product-name">${product.productName}</div>
                                <div class="product-brief">${product.brief}</div>
                                
                                <div class="product-price">
                                    <span class="price">
                                        <fmt:formatNumber value="${product.finalPrice}" type="number" groupingUsed="true"/>đ
                                    </span>
                                    
                                    <c:if test="${product.discount > 0}">
                                        <span class="original-price">
                                            <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ
                                        </span>
                                        <span class="discount-badge">-${product.discount}%</span>
                                    </c:if>
                                </div>
                                
                                <a href="MainController?action=product_view&productId=${product.productId}" 
                                   class="btn btn-primary" style="width: 100%; text-align: center;">
                                    View Details
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-products">
                    <h3>No products found</h3>
                    <p>Try adjusting your filters or search criteria</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Footer -->
    <div class="footer">
        <div class="container">
            <p>&copy; 2025 ProductIntro. All rights reserved.</p>
        </div>
    </div>
</body>
</html>