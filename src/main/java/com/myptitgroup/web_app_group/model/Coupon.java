package com.myptitgroup.web_app_group.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.text.DecimalFormat;

/**
 * JavaBean ánh xạ bảng coupons (Mã giảm giá / Voucher)
 */
public class Coupon implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String code;
    private String description;
    private String discountType = "PERCENT"; // PERCENT hoặc FIXED
    private BigDecimal discountValue = BigDecimal.ZERO;
    private BigDecimal minOrderAmount = BigDecimal.ZERO;
    private BigDecimal maxDiscountAmount;
    private int usageLimit = 100;
    private int usedCount = 0;
    private Timestamp startDate;
    private Timestamp endDate;
    private boolean active = true;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Coupon() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code != null ? code.trim().toUpperCase() : null;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public BigDecimal getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(BigDecimal discountValue) {
        this.discountValue = discountValue;
    }

    public BigDecimal getMinOrderAmount() {
        return minOrderAmount;
    }

    public void setMinOrderAmount(BigDecimal minOrderAmount) {
        this.minOrderAmount = minOrderAmount;
    }

    public BigDecimal getMaxDiscountAmount() {
        return maxDiscountAmount;
    }

    public void setMaxDiscountAmount(BigDecimal maxDiscountAmount) {
        this.maxDiscountAmount = maxDiscountAmount;
    }

    public int getUsageLimit() {
        return usageLimit;
    }

    public void setUsageLimit(int usageLimit) {
        this.usageLimit = usageLimit;
    }

    public int getUsedCount() {
        return usedCount;
    }

    public void setUsedCount(int usedCount) {
        this.usedCount = usedCount;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
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

    /**
     * Tính toán số tiền được giảm giá thực tế cho đơn hàng
     */
    public BigDecimal calculateDiscount(BigDecimal orderTotal) {
        if (orderTotal == null || orderTotal.compareTo(BigDecimal.ZERO) <= 0) {
            return BigDecimal.ZERO;
        }

        // Kiểm tra đơn hàng tối thiểu
        if (minOrderAmount != null && orderTotal.compareTo(minOrderAmount) < 0) {
            return BigDecimal.ZERO;
        }

        BigDecimal discount = BigDecimal.ZERO;
        if ("PERCENT".equalsIgnoreCase(discountType)) {
            // Giảm theo %
            discount = orderTotal.multiply(discountValue).divide(new BigDecimal(100), 0, RoundingMode.HALF_UP);
            // Giới hạn giảm tối đa nếu có cấu hình
            if (maxDiscountAmount != null && maxDiscountAmount.compareTo(BigDecimal.ZERO) > 0 && discount.compareTo(maxDiscountAmount) > 0) {
                discount = maxDiscountAmount;
            }
        } else {
            // Giảm số tiền cố định
            discount = discountValue;
        }

        // Không giảm vượt quá tổng tiền đơn
        if (discount.compareTo(orderTotal) > 0) {
            discount = orderTotal;
        }

        return discount;
    }

    /**
     * Kiểm tra coupon có đang hợp lệ tại thời điểm hiện tại
     */
    public boolean isValidNow(BigDecimal orderTotal) {
        if (!active) {
            return false;
        }
        if (usageLimit > 0 && usedCount >= usageLimit) {
            return false;
        }
        long now = System.currentTimeMillis();
        if (startDate != null && now < startDate.getTime()) {
            return false;
        }
        if (endDate != null && now > endDate.getTime()) {
            return false;
        }
        if (minOrderAmount != null && orderTotal != null && orderTotal.compareTo(minOrderAmount) < 0) {
            return false;
        }
        return true;
    }

    public String getFormattedDiscountValue() {
        if ("PERCENT".equalsIgnoreCase(discountType)) {
            return discountValue.stripTrailingZeros().toPlainString() + "%";
        }
        DecimalFormat df = new DecimalFormat("###,###,### đ");
        return df.format(discountValue);
    }

    public String getFormattedMinOrderAmount() {
        if (minOrderAmount == null || minOrderAmount.compareTo(BigDecimal.ZERO) == 0) {
            return "0 đ";
        }
        DecimalFormat df = new DecimalFormat("###,###,### đ");
        return df.format(minOrderAmount);
    }
}
