package com.myptitgroup.web_app_group.dao;

import com.myptitgroup.web_app_group.config.DBContext;
import com.myptitgroup.web_app_group.model.ProductReview;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Data Access Object quản lý bảng product_reviews (Đánh giá & Nhận xét sản phẩm)
 */
public class ProductReviewDAO {

    private ProductReview mapRow(ResultSet rs) throws SQLException {
        ProductReview r = new ProductReview();
        r.setId(rs.getInt("id"));
        r.setProductId(rs.getInt("product_id"));
        int uId = rs.getInt("user_id");
        r.setUserId(rs.wasNull() ? null : uId);
        r.setCustomerName(rs.getString("customer_name"));
        r.setCustomerEmail(rs.getString("customer_email"));
        r.setRating(rs.getInt("rating"));
        r.setComment(rs.getString("comment"));
        r.setApproved(rs.getBoolean("is_approved"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        try {
            r.setProductName(rs.getString("product_name"));
        } catch (SQLException ignored) {}
        return r;
    }

    /**
     * Lấy danh sách các đánh giá đã được duyệt của một sản phẩm (hiển thị trang chi tiết)
     */
    public List<ProductReview> getApprovedReviewsByProductId(int productId) {
        List<ProductReview> list = new ArrayList<>();
        String sql = "SELECT r.*, p.name AS product_name FROM product_reviews r " +
                     "LEFT JOIN products p ON r.product_id = p.id " +
                     "WHERE r.product_id = ? AND r.is_approved = 1 ORDER BY r.id DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Thống kê điểm đánh giá trung bình và số lượng review cho sản phẩm
     * Trả về Map chứa: averageRating (double), totalReviews (int), star5, star4, star3, star2, star1 (int)
     */
    public Map<String, Object> getReviewStats(int productId) {
        Map<String, Object> stats = new HashMap<>();
        stats.put("averageRating", 5.0);
        stats.put("totalReviews", 0);
        stats.put("star5", 0);
        stats.put("star4", 0);
        stats.put("star3", 0);
        stats.put("star2", 0);
        stats.put("star1", 0);

        String sql = "SELECT rating, COUNT(*) AS cnt FROM product_reviews " +
                     "WHERE product_id = ? AND is_approved = 1 GROUP BY rating";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                int totalCount = 0;
                int totalScore = 0;
                while (rs.next()) {
                    int r = rs.getInt("rating");
                    int count = rs.getInt("cnt");
                    totalCount += count;
                    totalScore += r * count;
                    stats.put("star" + r, count);
                }
                if (totalCount > 0) {
                    double avg = Math.round(((double) totalScore / totalCount) * 10.0) / 10.0;
                    stats.put("averageRating", avg);
                    stats.put("totalReviews", totalCount);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    /**
     * Thêm mới một đánh giá từ khách hàng
     */
    public boolean insertReview(ProductReview review) {
        if (review == null || review.getProductId() <= 0) {
            return false;
        }
        String sql = "INSERT INTO product_reviews (product_id, user_id, customer_name, customer_email, rating, comment, is_approved) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, review.getProductId());
            if (review.getUserId() != null && review.getUserId() > 0) {
                ps.setInt(2, review.getUserId());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }
            ps.setString(3, review.getCustomerName());
            ps.setString(4, review.getCustomerEmail());
            ps.setInt(5, review.getRating());
            ps.setString(6, review.getComment());
            ps.setBoolean(7, review.isApproved());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        review.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("[ProductReviewDAO] Lỗi thêm review: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Lấy toàn bộ đánh giá cho trang quản trị Admin
     */
    public List<ProductReview> getAllReviews() {
        List<ProductReview> list = new ArrayList<>();
        String sql = "SELECT r.*, p.name AS product_name FROM product_reviews r " +
                     "LEFT JOIN products p ON r.product_id = p.id ORDER BY r.id DESC";
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
     * Đếm số lượng review đang chờ duyệt
     */
    public int countPendingReviews() {
        String sql = "SELECT COUNT(*) FROM product_reviews WHERE is_approved = 0";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Bật / Tắt duyệt hiển thị đánh giá
     */
    public boolean toggleApproval(int id) {
        String sql = "UPDATE product_reviews SET is_approved = NOT is_approved WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa đánh giá
     */
    public boolean deleteReview(int id) {
        String sql = "DELETE FROM product_reviews WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
