package com.myptitgroup.web_app_group.dao;

import com.myptitgroup.web_app_group.config.DBContext;
import com.myptitgroup.web_app_group.model.User;
import com.myptitgroup.web_app_group.util.SecurityUtils;
import java.math.BigDecimal;
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
 * Data Access Object quản lý bảng users (Tài khoản Khách hàng mua sắm)
 * Hỗ trợ các nghiệp vụ phía Client (Đăng ký, Đăng nhập, Hồ sơ, Đổi mật khẩu)
 * và phía Admin (Danh sách khách hàng, Thống kê đơn mua & chi tiêu, Khóa/Mở khóa tài khoản).
 */
public class UserDAO {

    private User mapRow(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPasswordHash(rs.getString("password_hash"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setAddress(rs.getString("address"));
        u.setActive(rs.getBoolean("is_active"));
        u.setCreatedAt(rs.getTimestamp("created_at"));
        u.setUpdatedAt(rs.getTimestamp("updated_at"));

        // Nếu câu query có join tính thống kê đơn hàng
        try {
            u.setTotalOrders(rs.getInt("total_orders"));
        } catch (SQLException ignored) {}

        try {
            BigDecimal spent = rs.getBigDecimal("total_spent");
            u.setTotalSpent(spent != null ? spent : BigDecimal.ZERO);
        } catch (SQLException ignored) {}

        return u;
    }

    // =========================================================================
    // CÁC HÀM DÀNH CHO PHÍA KHÁCH HÀNG (CLIENT STOREFRONT)
    // =========================================================================

    /**
     * Xác thực đăng nhập bằng Username hoặc Email
     */
    public User authenticate(String usernameOrEmail, String rawPassword) {
        if (usernameOrEmail == null || rawPassword == null) {
            return null;
        }
        String sql = "SELECT * FROM users WHERE (username = ? OR email = ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, usernameOrEmail.trim());
            ps.setString(2, usernameOrEmail.trim());
            rs = ps.executeQuery();
            if (rs.next()) {
                User u = mapRow(rs);
                if (SecurityUtils.verifyPassword(rawPassword, u.getPasswordHash())) {
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return null;
    }

    /**
     * Kiểm tra username đã tồn tại chưa
     */
    public boolean existsByUsername(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username.trim());
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return false;
    }

    /**
     * Kiểm tra email đã tồn tại chưa
     */
    public boolean existsByEmail(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, email.trim());
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return false;
    }

    /**
     * Đăng ký tài khoản thành viên mới
     */
    public boolean register(User user) {
        String sql = "INSERT INTO users (username, password_hash, full_name, email, phone, address, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, user.getUsername().trim());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getFullName().trim());
            ps.setString(4, user.getEmail().trim());
            ps.setString(5, user.getPhone() != null ? user.getPhone().trim() : null);
            ps.setString(6, user.getAddress() != null ? user.getAddress().trim() : null);
            ps.setBoolean(7, user.isActive());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    user.setId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return false;
    }

    /**
     * Lấy thông tin user theo ID
     */
    public User getById(int id) {
        String sql = "SELECT u.*, " +
                     "(SELECT COUNT(*) FROM orders o WHERE o.user_id = u.id) AS total_orders, " +
                     "(SELECT COALESCE(SUM(o.total_amount), 0) FROM orders o WHERE o.user_id = u.id AND o.status != 'CANCELLED') AS total_spent " +
                     "FROM users u WHERE u.id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return null;
    }

    /**
     * Cập nhật thông tin hồ sơ cá nhân
     */
    public boolean updateProfile(User user) {
        String sql = "UPDATE users SET full_name = ?, phone = ?, address = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getFullName().trim());
            ps.setString(2, user.getPhone() != null ? user.getPhone().trim() : null);
            ps.setString(3, user.getAddress() != null ? user.getAddress().trim() : null);
            ps.setInt(4, user.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    /**
     * Đổi mật khẩu tài khoản (Tự động hash SHA-256 nếu chưa được hash)
     */
    public boolean changePassword(int userId, String rawOrHashedPassword) {
        String passwordHash = rawOrHashedPassword;
        if (passwordHash != null && passwordHash.length() != 64) {
            passwordHash = SecurityUtils.hashPassword(passwordHash);
        }
        String sql = "UPDATE users SET password_hash = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, passwordHash);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    // =========================================================================
    // CÁC HÀM DÀNH CHO PHÍA QUẢN TRỊ VIÊN (ADMIN PORTAL)
    // =========================================================================

    /**
     * Overload: Lấy danh sách khách hàng hỗ trợ status dạng String ("ALL", "ACTIVE", "LOCKED")
     */
    public List<User> getAllUsers(String statusStr, String keyword, int page, int pageSize) {
        Integer statusInt = null;
        if ("ACTIVE".equalsIgnoreCase(statusStr)) {
            statusInt = 1;
        } else if ("LOCKED".equalsIgnoreCase(statusStr)) {
            statusInt = 0;
        }
        return getAllUsers(keyword, statusInt, page, pageSize);
    }

    /**
     * Lấy danh sách khách hàng có phân trang, tìm kiếm và thống kê đơn hàng
     */
    public List<User> getAllUsers(String keyword, Integer status, int page, int pageSize) {
        List<User> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT u.*, " +
            "(SELECT COUNT(*) FROM orders o WHERE o.user_id = u.id) AS total_orders, " +
            "(SELECT COALESCE(SUM(o.total_amount), 0) FROM orders o WHERE o.user_id = u.id AND o.status != 'CANCELLED') AS total_spent " +
            "FROM users u WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (status != null && status >= 0) {
            sql.append("AND u.is_active = ? ");
            params.add(status == 1);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.username LIKE ? OR u.full_name LIKE ? OR u.email LIKE ? OR u.phone LIKE ?) ");
            String kw = "%" + keyword.trim() + "%";
            params.add(kw);
            params.add(kw);
            params.add(kw);
            params.add(kw);
        }

        sql.append("ORDER BY u.id DESC LIMIT ? OFFSET ?");
        int offset = Math.max(0, (page - 1) * pageSize);
        params.add(pageSize);
        params.add(offset);

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return list;
    }

    /**
     * Đếm tổng số người dùng trong hệ thống (không lọc)
     */
     public int countUsers() {
         return countUsers((String) null, (Integer) null);
     }

    /**
     * Overload: Đếm tổng số khách hàng hỗ trợ status dạng String ("ALL", "ACTIVE", "LOCKED")
     */
    public int countUsers(String statusStr, String keyword) {
        Integer statusInt = null;
        if ("ACTIVE".equalsIgnoreCase(statusStr)) {
            statusInt = 1;
        } else if ("LOCKED".equalsIgnoreCase(statusStr)) {
            statusInt = 0;
        }
        return countUsers(keyword, statusInt);
    }

    /**
     * Đếm tổng số khách hàng theo bộ lọc
     */
    public int countUsers(String keyword, Integer status) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM users u WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (status != null && status >= 0) {
            sql.append("AND u.is_active = ? ");
            params.add(status == 1);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.username LIKE ? OR u.full_name LIKE ? OR u.email LIKE ? OR u.phone LIKE ?) ");
            String kw = "%" + keyword.trim() + "%";
            params.add(kw);
            params.add(kw);
            params.add(kw);
            params.add(kw);
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return 0;
    }

    /**
     * Đảo trạng thái kích hoạt của tài khoản khách hàng (Active <-> Locked)
     */
    public boolean toggleActiveStatus(int userId) {
        String sql = "UPDATE users SET is_active = NOT is_active WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    /**
     * Khóa hoặc mở khóa tài khoản khách hàng
     */
    public boolean toggleActiveStatus(int userId, boolean isActive) {
        String sql = "UPDATE users SET is_active = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setBoolean(1, isActive);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    /**
     * Thống kê số lượng khách hàng theo trạng thái
     */
    public Map<String, Integer> getUserStatistics() {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("TOTAL", 0);
        stats.put("ACTIVE", 0);
        stats.put("LOCKED", 0);

        String sql = "SELECT is_active, COUNT(*) FROM users GROUP BY is_active";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            int total = 0;
            while (rs.next()) {
                boolean active = rs.getBoolean(1);
                int count = rs.getInt(2);
                total += count;
                if (active) {
                    stats.put("ACTIVE", count);
                } else {
                    stats.put("LOCKED", count);
                }
            }
            stats.put("TOTAL", total);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return stats;
    }
}
