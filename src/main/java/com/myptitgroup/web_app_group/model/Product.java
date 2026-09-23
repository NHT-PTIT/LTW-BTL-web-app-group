package com.myptitgroup.web_app_group.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * JavaBean ánh xạ bảng products (Sản phẩm kỹ thuật/thiết bị điện)
 */
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int categoryId;
    private String sku;
    private String name;
    private String slug;
    private String brand;
    private String powerStr;
    private Double powerVal;
    private BigDecimal price;
    private BigDecimal salePrice;
    private int stockQuantity;
    private String shortDescription;
    private String detailDescription;
    private String mainImageUrl;
    private boolean isFeatured;
    private boolean isActive;
    private int viewsCount;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Các trường quan hệ & mở rộng
    private String categoryName;
    private List<ProductImage> gallery = new ArrayList<>();
    private List<ProductSpec> specifications = new ArrayList<>();

    public Product() {
    }

    public Product(int id, int categoryId, String sku, String name, String slug, String brand, 
                   String powerStr, Double powerVal, BigDecimal price, BigDecimal salePrice, 
                   int stockQuantity, String shortDescription, String detailDescription, 
                   String mainImageUrl, boolean isFeatured, boolean isActive, int viewsCount, 
                   Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.categoryId = categoryId;
        this.sku = sku;
        this.name = name;
        this.slug = slug;
        this.brand = brand;
        this.powerStr = powerStr;
        this.powerVal = powerVal;
        this.price = price;
        this.salePrice = salePrice;
        this.stockQuantity = stockQuantity;
        this.shortDescription = shortDescription;
        this.detailDescription = detailDescription;
        this.mainImageUrl = mainImageUrl;
        this.isFeatured = isFeatured;
        this.isActive = isActive;
        this.viewsCount = viewsCount;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Tiện ích tính giá và hiển thị định dạng tiền tệ VNĐ
    public BigDecimal getEffectivePrice() {
        if (salePrice != null && salePrice.compareTo(BigDecimal.ZERO) > 0) {
            return salePrice;
        }
        return price != null ? price : BigDecimal.ZERO;
    }

    public boolean hasDiscount() {
        return salePrice != null && price != null && 
               salePrice.compareTo(BigDecimal.ZERO) > 0 && 
               salePrice.compareTo(price) < 0;
    }

    public int getDiscountPercent() {
        if (hasDiscount()) {
            double p = price.doubleValue();
            double sp = salePrice.doubleValue();
            return (int) Math.round(((p - sp) / p) * 100);
        }
        return 0;
    }

    public String getFormattedPrice() {
        if (price == null) return "0 đ";
        DecimalFormat df = new DecimalFormat("###,###,### đ");
        return df.format(price);
    }

    public String getFormattedSalePrice() {
        if (salePrice == null) return "";
        DecimalFormat df = new DecimalFormat("###,###,### đ");
        return df.format(salePrice);
    }

    public String getFormattedEffectivePrice() {
        DecimalFormat df = new DecimalFormat("###,###,### đ");
        return df.format(getEffectivePrice());
    }

    // Getters và Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getPowerStr() {
        return powerStr;
    }

    public void setPowerStr(String powerStr) {
        this.powerStr = powerStr;
    }

    public Double getPowerVal() {
        return powerVal;
    }

    public void setPowerVal(Double powerVal) {
        this.powerVal = powerVal;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(BigDecimal salePrice) {
        this.salePrice = salePrice;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getDetailDescription() {
        return detailDescription;
    }

    public void setDetailDescription(String detailDescription) {
        this.detailDescription = detailDescription;
    }

    public String getMainImageUrl() {
        return mainImageUrl;
    }

    public void setMainImageUrl(String mainImageUrl) {
        this.mainImageUrl = mainImageUrl;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public boolean getFeatured() {
        return isFeatured;
    }

    public boolean getIsFeatured() {
        return isFeatured;
    }

    public void setFeatured(boolean featured) {
        isFeatured = featured;
    }

    public boolean isActive() {
        return isActive;
    }

    public boolean getActive() {
        return isActive;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public int getViewsCount() {
        return viewsCount;
    }

    public void setViewsCount(int viewsCount) {
        this.viewsCount = viewsCount;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<ProductImage> getGallery() {
        return gallery;
    }

    public void setGallery(List<ProductImage> gallery) {
        this.gallery = gallery;
    }

    public List<ProductSpec> getSpecifications() {
        return specifications;
    }

    public void setSpecifications(List<ProductSpec> specifications) {
        this.specifications = specifications;
    }
}
