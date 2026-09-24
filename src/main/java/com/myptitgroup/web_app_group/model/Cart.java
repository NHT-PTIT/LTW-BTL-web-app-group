package com.myptitgroup.web_app_group.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Model quản lý Giỏ hàng của khách hàng (lưu trữ trong HttpSession)
 * Sử dụng LinkedHashMap để duy trì thứ tự các sản phẩm được thêm vào giỏ.
 */
public class Cart implements Serializable {
    private static final long serialVersionUID = 1L;

    private final Map<Integer, CartItem> items = new LinkedHashMap<>();
    private Coupon appliedCoupon;

    public Cart() {
    }

    /**
     * Thêm sản phẩm vào giỏ hàng
     * Nếu đã có thì cộng dồn số lượng, kiểm tra giới hạn tồn kho nếu có.
     */
    public void add(Product product, int quantity) {
        if (product == null || quantity <= 0) {
            return;
        }

        int productId = product.getId();
        if (items.containsKey(productId)) {
            CartItem current = items.get(productId);
            int newQty = current.getQuantity() + quantity;
            if (product.getStockQuantity() > 0 && newQty > product.getStockQuantity()) {
                newQty = product.getStockQuantity();
            }
            current.setQuantity(newQty);
        } else {
            int initialQty = quantity;
            if (product.getStockQuantity() > 0 && initialQty > product.getStockQuantity()) {
                initialQty = product.getStockQuantity();
            }
            items.put(productId, new CartItem(product, initialQty));
        }
    }

    /**
     * Cập nhật số lượng của một sản phẩm trong giỏ
     * Nếu quantity <= 0 thì tự động xóa mặt hàng đó khỏi giỏ.
     */
    public void update(int productId, int quantity) {
        if (quantity <= 0) {
            items.remove(productId);
            return;
        }

        CartItem item = items.get(productId);
        if (item != null) {
            int finalQty = quantity;
            if (item.getProduct() != null && item.getProduct().getStockQuantity() > 0 
                    && finalQty > item.getProduct().getStockQuantity()) {
                finalQty = item.getProduct().getStockQuantity();
            }
            item.setQuantity(finalQty);
        }
    }

    /**
     * Xóa 1 sản phẩm khỏi giỏ hàng theo ID
     */
    public void remove(int productId) {
        items.remove(productId);
    }

    /**
     * Xóa toàn bộ giỏ hàng
     */
    public void clear() {
        items.clear();
        appliedCoupon = null;
    }

    /**
     * Lấy danh sách các mặt hàng trong giỏ (dành cho JSTL c:forEach)
     */
    public Collection<CartItem> getItems() {
        return items.values();
    }

    /**
     * Đếm tổng số lượng sản phẩm (Total units) trong giỏ hàng
     */
    public int getTotalQuantity() {
        int total = 0;
        for (CartItem item : items.values()) {
            total += item.getQuantity();
        }
        return total;
    }

    /**
     * Đếm số loại sản phẩm khác nhau (Total unique items)
     */
    public int getSize() {
        return items.size();
    }

    /**
     * Tính tổng số tiền của toàn bộ giỏ hàng (chưa trừ voucher)
     */
    public BigDecimal getTotalAmount() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items.values()) {
            total = total.add(item.getSubtotal());
        }
        return total;
    }

    /**
     * Định dạng tổng tiền gốc theo chuẩn tiền tệ VNĐ (ví dụ: 12.500.000 đ)
     */
    public String getFormattedTotalAmount() {
        DecimalFormat df = new DecimalFormat("###,###,### đ");
        return df.format(getTotalAmount());
    }

    /**
     * Áp dụng mã giảm giá
     */
    public void applyCoupon(Coupon coupon) {
        this.appliedCoupon = coupon;
    }

    /**
     * Hủy bỏ mã giảm giá hiện tại
     */
    public void removeCoupon() {
        this.appliedCoupon = null;
    }

    public Coupon getAppliedCoupon() {
        return appliedCoupon;
    }

    /**
     * Tính số tiền giảm giá theo voucher đã áp dụng
     */
    public BigDecimal getDiscountAmount() {
        if (appliedCoupon == null || items.isEmpty()) {
            return BigDecimal.ZERO;
        }
        BigDecimal total = getTotalAmount();
        return appliedCoupon.calculateDiscount(total);
    }

    public String getFormattedDiscountAmount() {
        BigDecimal discount = getDiscountAmount();
        if (discount.compareTo(BigDecimal.ZERO) <= 0) {
            return "0 đ";
        }
        DecimalFormat df = new DecimalFormat("###,###,### đ");
        return "-" + df.format(discount);
    }

    /**
     * Tính tổng tiền thực thanh toán sau khi trừ khuyến mãi voucher
     */
    public BigDecimal getFinalTotal() {
        BigDecimal total = getTotalAmount();
        BigDecimal discount = getDiscountAmount();
        BigDecimal finalTotal = total.subtract(discount);
        return finalTotal.compareTo(BigDecimal.ZERO) < 0 ? BigDecimal.ZERO : finalTotal;
    }

    public String getFormattedFinalTotal() {
        DecimalFormat df = new DecimalFormat("###,###,### đ");
        return df.format(getFinalTotal());
    }

    /**
     * Kiểm tra giỏ hàng có rỗng không
     */
    public boolean isEmpty() {
        return items.isEmpty();
    }
}
