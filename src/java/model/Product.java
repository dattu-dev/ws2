package model;

import java.sql.Timestamp;

public class Product {
    private String productId;
    private String productName;
    private String productImage;
    private String brief;
    private Timestamp postedDate;
    private int typeId;
    private String account;
    private String unit;
    private int price;
    private int discount;
    
    // Additional fields for display
    private String categoryName;
    private String authorName;
    
    // Constructors
    public Product() {
    }
    
    public Product(String productId, String productName, String productImage, 
                   String brief, Timestamp postedDate, int typeId, String account, 
                   String unit, int price, int discount) {
        this.productId = productId;
        this.productName = productName;
        this.productImage = productImage;
        this.brief = brief;
        this.postedDate = postedDate;
        this.typeId = typeId;
        this.account = account;
        this.unit = unit;
        this.price = price;
        this.discount = discount;
    }
    
    // Getters and Setters
    public String getProductId() {
        return productId;
    }
    
    public void setProductId(String productId) {
        this.productId = productId;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    public String getProductImage() {
        return productImage;
    }
    
    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }
    
    public String getBrief() {
        return brief;
    }
    
    public void setBrief(String brief) {
        this.brief = brief;
    }
    
    public Timestamp getPostedDate() {
        return postedDate;
    }
    
    public void setPostedDate(Timestamp postedDate) {
        this.postedDate = postedDate;
    }
    
    public int getTypeId() {
        return typeId;
    }
    
    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }
    
    public String getAccount() {
        return account;
    }
    
    public void setAccount(String account) {
        this.account = account;
    }
    
    public String getUnit() {
        return unit;
    }
    
    public void setUnit(String unit) {
        this.unit = unit;
    }
    
    public int getPrice() {
        return price;
    }
    
    public void setPrice(int price) {
        this.price = price;
    }
    
    public int getDiscount() {
        return discount;
    }
    
    public void setDiscount(int discount) {
        this.discount = discount;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    public String getAuthorName() {
        return authorName;
    }
    
    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }
    
    // Calculated fields
    public int getFinalPrice() {
        return price - (price * discount / 100);
    }
    
    public boolean hasDiscount() {
        return discount > 0;
    }
}