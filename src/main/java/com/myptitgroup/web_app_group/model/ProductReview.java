package com.myptitgroup.web_app_group.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 * JavaBean ánh xạ bảng product_reviews (Đánh giá & Nhận xét sản phẩm)
 */
public class ProductReview implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int productId;
    private Integer userId;
    private String customerName;
    private String customerEmail;
    private int rating = 5; // 1 to 5
    private String comment;
    private boolean approved = true;
    private Timestamp createdAt;

    // Transient fields cho việc hiển thị ở Admin / Client
    private String productName;

    public ProductReview() {
    }

    public ProductReview(int productId, Integer userId, String customerName, String customerEmail, int rating, String comment) {
        this.productId = productId;
        this.userId = userId;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.rating = rating;
        this.comment = comment;
        this.approved = true;
    }

    public String getFormattedCreatedAt() {
        if (createdAt == null) return "";
        return new SimpleDateFormat("dd/MM/yyyy HH:mm").format(createdAt);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        if (rating < 1) rating = 1;
        if (rating > 5) rating = 5;
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public boolean isApproved() {
        return approved;
    }

    public void setApproved(boolean approved) {
        this.approved = approved;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
}
