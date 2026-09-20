package com.myptitgroup.web_app_group.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.text.DecimalFormat;

/**
 * Model đại diện cho 1 phần tử trong giỏ hàng (lưu trữ trong HttpSession)
 */
public class CartItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private Product product;
    private int quantity;

    public CartItem() {
    }

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public BigDecimal getSubtotal() {
        if (product == null) return BigDecimal.ZERO;
        return product.getEffectivePrice().multiply(BigDecimal.valueOf(quantity));
    }

    public String getFormattedSubtotal() {
        DecimalFormat df = new DecimalFormat("###,###,### đ");
        return df.format(getSubtotal());
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
