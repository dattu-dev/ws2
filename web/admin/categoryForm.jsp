<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty category ? 'Edit' : 'Create'} Category - Admin</title>
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
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            font-family: inherit;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .form-group textarea {
            min-height: 100px;
            resize: vertical;
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
                    <c:when test="${not empty category}">Edit Category</c:when>
                    <c:otherwise>Create New Category</c:otherwise>
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
        
        <!-- Category Form -->
        <div class="form-container">
            <form action="../MainController" method="post">
                <input type="hidden" name="action" 
                       value="${not empty category ? 'category_update' : 'category_create'}">
                <c:if test="${not empty category}">
                    <input type="hidden" name="typeId" value="${category.typeId}">
                </c:if>
                
                <div class="form-group">
                    <label for="categoryName">Category Name <span class="required">*</span></label>
                    <input type="text" id="categoryName" name="categoryName" 
                           value="${category.categoryName}" required autofocus>
                </div>
                
                <div class="form-group">
                    <label for="memo">Description</label>
                    <textarea id="memo" name="memo" 
                              placeholder="Enter category description...">${category.memo}</textarea>
                </div>
                
                <div class="form-actions">
                    <a href="../MainController?action=category_list" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty category}">Update Category</c:when>
                            <c:otherwise>Create Category</c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>