package com.myptitgroup.web_app_group.model;

import java.io.Serializable;

/**
 * JavaBean ánh xạ bảng product_specs (Thông số kỹ thuật sản phẩm)
 */
public class ProductSpec implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int productId;
    private String specName;
    private String specValue;
    private int sortOrder;

    public ProductSpec() {
    }

    public ProductSpec(int id, int productId, String specName, String specValue, int sortOrder) {
        this.id = id;
        this.productId = productId;
        this.specName = specName;
        this.specValue = specValue;
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

    public String getSpecName() {
        return specName;
    }

    public void setSpecName(String specName) {
        this.specName = specName;
    }

    public String getSpecValue() {
        return specValue;
    }

    public void setSpecValue(String specValue) {
        this.specValue = specValue;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }
}
