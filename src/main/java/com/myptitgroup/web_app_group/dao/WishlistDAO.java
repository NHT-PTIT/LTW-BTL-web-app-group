package com.myptitgroup.web_app_group.dao;

import com.myptitgroup.web_app_group.config.DBContext;
import com.myptitgroup.web_app_group.model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Data Access Object quản lý bảng wishlists (Danh sách sản phẩm yêu thích của khách hàng)
 */
public class WishlistDAO {

    private final ProductDAO productDAO = new ProductDAO();

    /**
     * Lấy tập hợp các ID sản phẩm mà người dùng đã bấm yêu thích
     */
    public Set<Integer> getWishlistProductIds(int userId) {
        Set<Integer> set = new HashSet<>();
        if (userId <= 0) return set;

        String sql = "SELECT product_id FROM wishlists WHERE user_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    set.add(rs.getInt("product_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return set;
    }

    /**
     * Lấy danh sách đầy đủ các Product trong danh sách yêu thích của người dùng
     */
    public List<Product> getWishlistProducts(int userId) {
        List<Product> list = new ArrayList<>();
        if (userId <= 0) return list;

        String sql = "SELECT p.* FROM wishlists w " +
                     "JOIN products p ON w.product_id = p.id " +
                     "WHERE w.user_id = ? ORDER BY w.id DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = productDAO.getById(rs.getInt("id"));
                    if (p != null) {
                        list.add(p);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Kiểm tra một sản phẩm đã có trong wishlist hay chưa
     */
    public boolean isInWishlist(int userId, int productId) {
        if (userId <= 0 || productId <= 0) return false;
        String sql = "SELECT id FROM wishlists WHERE user_id = ? AND product_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Chuyển đổi trạng thái yêu thích (Toggle): Nếu chưa có thì thêm, nếu có rồi thì xóa
     * @return true nếu đã thêm vào yêu thích, false nếu đã gỡ bỏ khỏi yêu thích
     */
    public boolean toggleWishlist(int userId, int productId) {
        if (userId <= 0 || productId <= 0) return false;

        if (isInWishlist(userId, productId)) {
            removeFromWishlist(userId, productId);
            return false;
        } else {
            addToWishlist(userId, productId);
            return true;
        }
    }

    public boolean addToWishlist(int userId, int productId) {
        if (userId <= 0 || productId <= 0) return false;
        String sql = "INSERT IGNORE INTO wishlists (user_id, product_id) VALUES (?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeFromWishlist(int userId, int productId) {
        if (userId <= 0 || productId <= 0) return false;
        String sql = "DELETE FROM wishlists WHERE user_id = ? AND product_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
