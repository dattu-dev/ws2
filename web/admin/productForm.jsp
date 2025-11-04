<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty product ? 'Edit' : 'Create'} Product - Admin</title>
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
            max-width: 900px;
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
        .form-group select,
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
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .form-row-3 {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
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
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .required {
            color: #dc3545;
        }
        
        .image-preview {
            margin-top: 10px;
            max-width: 200px;
            border-radius: 5px;
            display: none;
        }
        
        .image-preview img {
            width: 100%;
            border-radius: 5px;
            border: 2px solid #ddd;
        }
        
        .help-text {
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
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
                    <c:when test="${not empty product}">Edit Product</c:when>
                    <c:otherwise>Create New Product</c:otherwise>
                </c:choose>
            </h2>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="container">
        <!-- Messages -->
        <c:if test="${not empty ERROR}">
            <div class="alert alert-error">${ERROR}</div>
        </c:if>
        
        <c:if test="${not empty SUCCESS}">
            <div class="alert alert-success">${SUCCESS}</div>
        </c:if>
        
        <!-- Product Form -->
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/MainController" method="post" id="productForm">
                <input type="hidden" name="action" 
                       value="${not empty product ? 'product_update' : 'product_create'}">
                
                <!-- Product ID and Name -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="productId">Product ID <span class="required">*</span></label>
                        <input type="text" id="productId" name="productId" 
                               value="${product.productId}" 
                               ${not empty product ? 'readonly' : ''} 
                               pattern="[A-Z0-9]{3,10}"
                               placeholder="e.g. P001, PROD001"
                               required autofocus>
                        <div class="help-text">3-10 characters, uppercase letters and numbers only</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="productName">Product Name <span class="required">*</span></label>
                        <input type="text" id="productName" name="productName" 
                               value="${product.productName}" 
                               maxlength="500"
                               required>
                    </div>
                </div>
                
                <!-- Category and Unit -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="typeId">Category <span class="required">*</span></label>
                        <select id="typeId" name="typeId" required>
                            <option value="">-- Select Category --</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.typeId}" 
                                        ${product.typeId == cat.typeId ? 'selected' : ''}>
                                    ${cat.categoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="unit">Unit <span class="required">*</span></label>
                        <input type="text" id="unit" name="unit" 
                               value="${not empty product.unit ? product.unit : 'chiếc'}" 
                               maxlength="32"
                               placeholder="e.g. chiếc, cái, bộ, hộp"
                               required>
                    </div>
                </div>
                
                <!-- Price, Discount -->
                <div class="form-row-3">
                    <div class="form-group">
                        <label for="price">Price (VNĐ) <span class="required">*</span></label>
                        <input type="number" id="price" name="price" 
                               value="${product.price}" 
                               min="0" 
                               step="1000"
                               placeholder="0"
                               required>
                    </div>
                    
                    <div class="form-group">
                        <label for="discount">Discount (%) <span class="required">*</span></label>
                        <input type="number" id="discount" name="discount" 
                               value="${not empty product ? product.discount : 0}" 
                               min="0" 
                               max="100"
                               required>
                        <div class="help-text">0-100%</div>
                    </div>
                    
                    <div class="form-group">
                        <label>Final Price</label>
                        <input type="text" id="finalPrice" 
                               value="${product.finalPrice}" 
                               readonly 
                               style="background: #e9ecef; cursor: not-allowed;">
                    </div>
                </div>
                
                <!-- Product Image URL -->
                <div class="form-group">
                    <label for="productImage">Product Image URL <span class="required">*</span></label>
                    <input type="url" id="productImage" name="productImage" 
                           value="${product.productImage}" 
                           placeholder="https://example.com/image.jpg"
                           required>
                    <div class="help-text">Enter full URL of product image</div>
                    
                    <!-- Image Preview -->
                    <div class="image-preview" id="imagePreview">
                        <img src="${product.productImage}" alt="Preview" 
                             onerror="this.parentElement.style.display='none'">
                    </div>
                </div>
                
                <!-- Brief Description -->
                <div class="form-group">
                    <label for="brief">Brief Description <span class="required">*</span></label>
                    <textarea id="brief" name="brief" 
                              maxlength="2000"
                              placeholder="Enter product description..."
                              required>${product.brief}</textarea>
                    <div class="help-text">Maximum 2000 characters</div>
                </div>
                
                <!-- Form Actions -->
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/MainController?action=product_list" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty product}">Update Product</c:when>
                            <c:otherwise>Create Product</c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Auto calculate final price
        const priceInput = document.getElementById('price');
        const discountInput = document.getElementById('discount');
        const finalPriceInput = document.getElementById('finalPrice');
        
        function calculateFinalPrice() {
            const price = parseInt(priceInput.value) || 0;
            const discount = parseInt(discountInput.value) || 0;
            const finalPrice = price - (price * discount / 100);
            finalPriceInput.value = finalPrice.toLocaleString('vi-VN') + ' VNĐ';
        }
        
        priceInput.addEventListener('input', calculateFinalPrice);
        discountInput.addEventListener('input', calculateFinalPrice);
        
        // Initial calculation
        calculateFinalPrice();
        
        // Image preview
        const imageInput = document.getElementById('productImage');
        const imagePreview = document.getElementById('imagePreview');
        
        imageInput.addEventListener('input', function() {
            const url = this.value;
            if (url) {
                imagePreview.style.display = 'block';
                imagePreview.querySelector('img').src = url;
            } else {
                imagePreview.style.display = 'none';
            }
        });
        
        // Show preview if editing
        if (imageInput.value) {
            imagePreview.style.display = 'block';
        }
        
        // Form validation
        document.getElementById('productForm').addEventListener('submit', function(e) {
            const productId = document.getElementById('productId').value;
            const price = parseInt(document.getElementById('price').value);
            const discount = parseInt(document.getElementById('discount').value);
            
            // Validate Product ID format
            if (!/^[A-Z0-9]{3,10}$/.test(productId)) {
                alert('Product ID must be 3-10 characters, uppercase letters and numbers only!');
                e.preventDefault();
                return false;
            }
            
            // Validate price
            if (price < 0) {
                alert('Price must be greater than or equal to 0!');
                e.preventDefault();
                return false;
            }
            
            // Validate discount
            if (discount < 0 || discount > 100) {
                alert('Discount must be between 0 and 100!');
                e.preventDefault();
                return false;
            }
            
            return true;
        });
    </script>
</body>
</html>