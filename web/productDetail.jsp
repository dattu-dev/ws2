<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName} - ProductIntro</title>
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
        
        .breadcrumb {
            background: white;
            padding: 15px 0;
            margin-bottom: 30px;
        }
        
        .breadcrumb a {
            color: #667eea;
            text-decoration: none;
        }
        
        .breadcrumb a:hover {
            text-decoration: underline;
        }
        
        .product-detail {
            background: white;
            border-radius: 10px;
            padding: 40px;
            margin: 30px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .product-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
        }
        
        .product-image-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            height: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 120px;
        }
        
        .product-info-section {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .product-category-badge {
            color: #667eea;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .product-title {
            font-size: 32px;
            color: #333;
            font-weight: 700;
            line-height: 1.2;
        }
        
        .product-meta {
            display: flex;
            gap: 20px;
            padding: 15px 0;
            border-top: 1px solid #eee;
            border-bottom: 1px solid #eee;
        }
        
        .meta-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        
        .meta-label {
            font-size: 12px;
            color: #999;
            text-transform: uppercase;
        }
        
        .meta-value {
            font-size: 14px;
            color: #333;
            font-weight: 600;
        }
        
        .product-price-section {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
        }
        
        .price-container {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .current-price {
            font-size: 36px;
            font-weight: 700;
            color: #667eea;
        }
        
        .original-price {
            font-size: 20px;
            color: #999;
            text-decoration: line-through;
        }
        
        .discount-badge {
            background: #ff4444;
            color: white;
            padding: 5px 12px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .product-description {
            line-height: 1.8;
            color: #666;
        }
        
        .product-description h3 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        
        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 20px 0;
            margin-top: 60px;
        }
        
        @media (max-width: 768px) {
            .product-content {
                grid-template-columns: 1fr;
            }
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
                    <li><a href="${pageContext.request.contextPath}/home.jsp">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/MainController?action=product_list">Products</a></li>
                    <c:if test="${not empty sessionScope.account}">
                        <c:if test="${sessionScope.role >= 1}">
                            <li><a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Admin</a></li>
                        </c:if>
                    </c:if>
                </ul>
                
                <div class="user-info">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <span>Welcome, ${sessionScope.fullName}</span>
                            <a href="${pageContext.request.contextPath}/MainController?action=auth_logout" class="btn btn-secondary">Logout</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">Login</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Breadcrumb -->
    <div class="breadcrumb">
        <div class="container">
            <a href="${pageContext.request.contextPath}/home.jsp">Home</a> / 
            <a href="${pageContext.request.contextPath}/MainController?action=product_list">Products</a> / 
            <a href="${pageContext.request.contextPath}/MainController?action=product_listByCategory&typeId=${product.typeId}">${product.categoryName}</a> / 
            <span>${product.productName}</span>
        </div>
    </div>
    
    <!-- Product Detail -->
    <div class="container">
        <c:if test="${not empty product}">
            <div class="product-detail">
                <div class="product-content">
                    <!-- Product Image -->
                    <div class="product-image-section">
                        <c:choose>
                            <c:when test="${not empty product.productImage}">
                                <img src="${product.productImage}" alt="${product.productName}" 
                                     style="width: 100%; height: 100%; object-fit: cover; border-radius: 10px;">
                            </c:when>
                            <c:otherwise>
                                📦
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Product Info -->
                    <div class="product-info-section">
                        <div class="product-category-badge">${product.categoryName}</div>
                        
                        <h1 class="product-title">${product.productName}</h1>
                        
                        <div class="product-meta">
                            <div class="meta-item">
                                <span class="meta-label">Product ID</span>
                                <span class="meta-value">${product.productId}</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-label">Unit</span>
                                <span class="meta-value">${product.unit}</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-label">Posted Date</span>
                                <span class="meta-value">
                                    <fmt:formatDate value="${product.postedDate}" pattern="dd/MM/yyyy"/>
                                </span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-label">Posted By</span>
                                <span class="meta-value">${product.authorName}</span>
                            </div>
                        </div>
                        
                        <div class="product-price-section">
                            <div class="price-container">
                                <span class="current-price">
                                    <fmt:formatNumber value="${product.finalPrice}" type="number" groupingUsed="true"/>đ
                                </span>
                                
                                <c:if test="${product.discount > 0}">
                                    <span class="original-price">
                                        <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ
                                    </span>
                                    <span class="discount-badge">Save ${product.discount}%</span>
                                </c:if>
                            </div>
                        </div>
                        
                        <div class="product-description">
                            <h3>Product Description</h3>
                            <p>${product.brief}</p>
                        </div>
                        
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/MainController?action=product_list" class="btn btn-secondary">
                                ← Back to Products
                            </a>
                            <c:if test="${sessionScope.role >= 1}">
                                <a href="${pageContext.request.contextPath}/MainController?action=product_showEdit&productId=${product.productId}" 
                                   class="btn btn-primary">
                                    Edit Product
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <!-- Footer -->
    <div class="footer">
        <div class="container">
            <p>&copy; 2025 ProductIntro. All rights reserved.</p>
        </div>
    </div>
</body>
</html>