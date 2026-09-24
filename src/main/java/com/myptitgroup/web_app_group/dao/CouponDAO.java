package com.myptitgroup.web_app_group.dao;

import com.myptitgroup.web_app_group.config.DBContext;
import com.myptitgroup.web_app_group.model.Coupon;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object quản lý bảng coupons (Mã giảm giá / Voucher)
 */
public class CouponDAO {

    private Coupon mapRow(ResultSet rs) throws SQLException {
        Coupon c = new Coupon();
        c.setId(rs.getInt("id"));
        c.setCode(rs.getString("code"));
        c.setDescription(rs.getString("description"));
        c.setDiscountType(rs.getString("discount_type"));
        c.setDiscountValue(rs.getBigDecimal("discount_value"));
        c.setMinOrderAmount(rs.getBigDecimal("min_order_amount"));
        c.setMaxDiscountAmount(rs.getBigDecimal("max_discount_amount"));
        c.setUsageLimit(rs.getInt("usage_limit"));
        c.setUsedCount(rs.getInt("used_count"));
        c.setStartDate(rs.getTimestamp("start_date"));
        c.setEndDate(rs.getTimestamp("end_date"));
        c.setActive(rs.getBoolean("is_active"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        c.setUpdatedAt(rs.getTimestamp("updated_at"));
        return c;
    }

    /**
     * Tra cứu và kiểm tra tính hợp lệ của mã giảm giá cho giỏ hàng
     * @param code Mã coupon nhập vào (vd: SOLAR2026)
     * @param orderTotal Tổng tiền giỏ hàng hiện tại
     * @return Coupon nếu hợp lệ, null nếu không tìm thấy hoặc không thỏa mãn điều kiện
     */
    public Coupon getValidCoupon(String code, BigDecimal orderTotal) {
        if (code == null || code.trim().isEmpty()) {
            return null;
        }

        String sql = "SELECT * FROM coupons " +
                     "WHERE UPPER(code) = UPPER(?) " +
                     "  AND is_active = 1 " +
                     "  AND (usage_limit = 0 OR used_count < usage_limit) " +
                     "  AND (start_date IS NULL OR start_date <= NOW()) " +
                     "  AND (end_date IS NULL OR end_date >= NOW())";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, code.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Coupon coupon = mapRow(rs);
                    // Kiểm tra điều kiện đơn hàng tối thiểu
                    if (coupon.getMinOrderAmount() != null && orderTotal != null 
                            && orderTotal.compareTo(coupon.getMinOrderAmount()) < 0) {
                        return null;
                    }
                    return coupon;
                }
            }
        } catch (SQLException e) {
            System.err.println("[CouponDAO] Lỗi kiểm tra coupon: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Tìm coupon theo mã code (không phân biệt hoa thường)
     */
    public Coupon getCouponByCode(String code) {
        if (code == null || code.trim().isEmpty()) {
            return null;
        }
        String sql = "SELECT * FROM coupons WHERE UPPER(code) = UPPER(?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Tìm coupon theo ID
     */
    public Coupon getCouponById(int id) {
        String sql = "SELECT * FROM coupons WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy toàn bộ danh sách mã giảm giá cho trang quản trị Admin
     */
    public List<Coupon> getAllCoupons() {
        List<Coupon> list = new ArrayList<>();
        String sql = "SELECT * FROM coupons ORDER BY id DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Thêm mới một coupon vào CSDL
     */
    public boolean insert(Coupon coupon) {
        if (coupon == null || coupon.getCode() == null) {
            return false;
        }
        String sql = "INSERT INTO coupons (code, description, discount_type, discount_value, min_order_amount, " +
                     "max_discount_amount, usage_limit, used_count, start_date, end_date, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, coupon.getCode().trim().toUpperCase());
            ps.setString(2, coupon.getDescription());
            ps.setString(3, coupon.getDiscountType() != null ? coupon.getDiscountType() : "PERCENT");
            ps.setBigDecimal(4, coupon.getDiscountValue() != null ? coupon.getDiscountValue() : BigDecimal.ZERO);
            ps.setBigDecimal(5, coupon.getMinOrderAmount() != null ? coupon.getMinOrderAmount() : BigDecimal.ZERO);
            if (coupon.getMaxDiscountAmount() != null && coupon.getMaxDiscountAmount().compareTo(BigDecimal.ZERO) > 0) {
                ps.setBigDecimal(6, coupon.getMaxDiscountAmount());
            } else {
                ps.setNull(6, java.sql.Types.DECIMAL);
            }
            ps.setInt(7, coupon.getUsageLimit());
            ps.setInt(8, coupon.getUsedCount());
            ps.setTimestamp(9, coupon.getStartDate());
            ps.setTimestamp(10, coupon.getEndDate());
            ps.setBoolean(11, coupon.isActive());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        coupon.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("[CouponDAO] Lỗi thêm mới coupon: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Cập nhật thông tin coupon
     */
    public boolean update(Coupon coupon) {
        if (coupon == null || coupon.getId() <= 0) {
            return false;
        }
        String sql = "UPDATE coupons SET code = ?, description = ?, discount_type = ?, discount_value = ?, " +
                     "min_order_amount = ?, max_discount_amount = ?, usage_limit = ?, used_count = ?, " +
                     "start_date = ?, end_date = ?, is_active = ? WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, coupon.getCode().trim().toUpperCase());
            ps.setString(2, coupon.getDescription());
            ps.setString(3, coupon.getDiscountType());
            ps.setBigDecimal(4, coupon.getDiscountValue());
            ps.setBigDecimal(5, coupon.getMinOrderAmount());
            if (coupon.getMaxDiscountAmount() != null && coupon.getMaxDiscountAmount().compareTo(BigDecimal.ZERO) > 0) {
                ps.setBigDecimal(6, coupon.getMaxDiscountAmount());
            } else {
                ps.setNull(6, java.sql.Types.DECIMAL);
            }
            ps.setInt(7, coupon.getUsageLimit());
            ps.setInt(8, coupon.getUsedCount());
            ps.setTimestamp(9, coupon.getStartDate());
            ps.setTimestamp(10, coupon.getEndDate());
            ps.setBoolean(11, coupon.isActive());
            ps.setInt(12, coupon.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[CouponDAO] Lỗi cập nhật coupon: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa một coupon
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM coupons WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[CouponDAO] Lỗi xóa coupon: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Tăng số lượt sử dụng sau khi đơn hàng đặt thành công
     */
    public boolean incrementUsedCount(String code) {
        if (code == null || code.trim().isEmpty()) {
            return false;
        }
        String sql = "UPDATE coupons SET used_count = used_count + 1 WHERE UPPER(code) = UPPER(?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code.trim());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
