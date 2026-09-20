package com.myptitgroup.web_app_group.model;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * JavaBean ánh xạ bảng product_images (Thư viện ảnh chi tiết sản phẩm)
 */
public class ProductImage implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int productId;
    private String imageUrl;
    private boolean isPrimary;
    private int sortOrder;
    private Timestamp createdAt;

    public ProductImage() {
    }

    public ProductImage(int id, int productId, String imageUrl, boolean isPrimary, int sortOrder) {
        this.id = id;
        this.productId = productId;
        this.imageUrl = imageUrl;
        this.isPrimary = isPrimary;
        this.sortOrder = sortOrder;
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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isPrimary() {
        return isPrimary;
    }

    public void setPrimary(boolean primary) {
        isPrimary = primary;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
