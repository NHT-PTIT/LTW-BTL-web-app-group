package com.myptitgroup.web_app_group.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

/**
 * JavaBean ánh xạ bảng users (Tài khoản Khách hàng mua sắm)
 */
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String username;
    private String passwordHash;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private boolean isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Các trường thống kê mở rộng (dành cho Admin quản lý khách hàng)
    private int totalOrders;
    private BigDecimal totalSpent;

    public User() {
        this.isActive = true;
    }

    public User(String username, String passwordHash, String fullName, String email, String phone, String address) {
        this.username = username;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.isActive = true;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isActive() {
        return isActive;
    }

    public boolean getIsActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public void setIsActive(boolean active) {
        isActive = active;
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

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public BigDecimal getTotalSpent() {
        return totalSpent;
    }

    public void setTotalSpent(BigDecimal totalSpent) {
        this.totalSpent = totalSpent;
    }

    public String getFormattedTotalSpent() {
        if (totalSpent == null) return "0 đ";
        DecimalFormat df = new DecimalFormat("###,###,### đ");
        return df.format(totalSpent);
    }

    public String getFormattedCreatedAt() {
        if (createdAt == null) return "";
        return new SimpleDateFormat("dd/MM/yyyy HH:mm").format(createdAt);
    }

    public String getAvatarInitial() {
        if (fullName != null && !fullName.trim().isEmpty()) {
            return fullName.trim().substring(0, 1).toUpperCase();
        }
        if (username != null && !username.trim().isEmpty()) {
            return username.trim().substring(0, 1).toUpperCase();
        }
        return "U";
    }
}
