package com.myptitgroup.web_app_group.dao;

import com.myptitgroup.web_app_group.config.DBContext;
import com.myptitgroup.web_app_group.model.Order;
import com.myptitgroup.web_app_group.model.OrderItem;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * Data Access Object quản lý bảng orders và order_items
 * Quản lý Transaction an toàn cho quá trình đặt hàng và cập nhật kho hàng.
 */
public class OrderDAO {

    /**
     * Sinh mã đơn hàng tự động duy nhất (Ví dụ: ORD-20260921-9B2F)
     */
    public static String generateOrderCode() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String datePart = sdf.format(new Date());
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        StringBuilder sb = new StringBuilder();
        Random rnd = new Random();
        for (int i = 0; i < 4; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return "ORD-" + datePart + "-" + sb.toString();
    }

    private Order mapRow(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getInt("id"));
        o.setOrderCode(rs.getString("order_code"));
        o.setCustomerName(rs.getString("customer_name"));
        o.setCustomerPhone(rs.getString("customer_phone"));
        o.setCustomerEmail(rs.getString("customer_email"));
        o.setShippingAddress(rs.getString("shipping_address"));
        o.setNote(rs.getString("note"));
        o.setTotalAmount(rs.getBigDecimal("total_amount"));
        o.setPaymentMethod(rs.getString("payment_method"));
        o.setStatus(rs.getString("status"));
        o.setCreatedAt(rs.getTimestamp("created_at"));
        o.setUpdatedAt(rs.getTimestamp("updated_at"));
        try {
            int uId = rs.getInt("user_id");
            o.setUserId(rs.wasNull() ? null : uId);
        } catch (SQLException ignored) {}
        return o;
    }

    /**
     * TẠO ĐƠN HÀNG VỚI TRANSACTION QUẢN LÝ
     * Thực hiện 3 bước trong 1 transaction:
     * 1. Lưu thông tin đơn hàng vào bảng orders
     * 2. Lưu từng mặt hàng vào bảng order_items
     * 3. Trừ số lượng tồn kho stock_quantity của sản phẩm
     */
    public boolean createOrder(Order order, List<OrderItem> items) {
        if (order == null || items == null || items.isEmpty()) {
            return false;
        }

        if (order.getOrderCode() == null || order.getOrderCode().trim().isEmpty()) {
            order.setOrderCode(generateOrderCode());
        }

        String sqlOrder = "INSERT INTO orders (order_code, user_id, customer_name, customer_phone, customer_email, " +
                          "shipping_address, note, total_amount, payment_method, status) " +
                          "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String sqlItem = "INSERT INTO order_items (order_id, product_id, product_sku, product_name, " +
                         "product_image, unit_price, quantity, subtotal) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        String sqlStock = "UPDATE products SET stock_quantity = GREATEST(0, stock_quantity - ?) WHERE id = ?";

        Connection conn = null;
        PreparedStatement psOrder = null;
        PreparedStatement psItem = null;
        PreparedStatement psStock = null;
        ResultSet rsKeys = null;

        try {
            conn = DBContext.getConnection();
            // Bắt đầu Transaction
            conn.setAutoCommit(false);

            // 1. Lưu đơn hàng
            psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setString(1, order.getOrderCode());
            if (order.getUserId() != null && order.getUserId() > 0) {
                psOrder.setInt(2, order.getUserId());
            } else {
                psOrder.setNull(2, java.sql.Types.INTEGER);
            }
            psOrder.setString(3, order.getCustomerName());
            psOrder.setString(4, order.getCustomerPhone());
            psOrder.setString(5, order.getCustomerEmail());
            psOrder.setString(6, order.getShippingAddress());
            psOrder.setString(7, order.getNote());
            psOrder.setBigDecimal(8, order.getTotalAmount());
            psOrder.setString(9, order.getPaymentMethod() != null ? order.getPaymentMethod() : "COD");
            psOrder.setString(10, order.getStatus() != null ? order.getStatus() : "PENDING");

            int affected = psOrder.executeUpdate();
            if (affected == 0) {
                conn.rollback();
                return false;
            }

            rsKeys = psOrder.getGeneratedKeys();
            if (rsKeys.next()) {
                order.setId(rsKeys.getInt(1));
            } else {
                conn.rollback();
                return false;
            }

            // 2. Lưu từng chi tiết mặt hàng & cập nhật tồn kho
            psItem = conn.prepareStatement(sqlItem);
            psStock = conn.prepareStatement(sqlStock);

            for (OrderItem item : items) {
                item.setOrderId(order.getId());
                psItem.setInt(1, order.getId());
                if (item.getProductId() != null && item.getProductId() > 0) {
                    psItem.setInt(2, item.getProductId());
                } else {
                    psItem.setNull(2, java.sql.Types.INTEGER);
                }
                psItem.setString(3, item.getProductSku());
                psItem.setString(4, item.getProductName());
                psItem.setString(5, item.getProductImage());
                psItem.setBigDecimal(6, item.getUnitPrice());
                psItem.setInt(7, item.getQuantity());
                psItem.setBigDecimal(8, item.getSubtotal());
                psItem.addBatch();

                // Trừ tồn kho nếu có productId
                if (item.getProductId() != null && item.getProductId() > 0) {
                    psStock.setInt(1, item.getQuantity());
                    psStock.setInt(2, item.getProductId());
                    psStock.addBatch();
                }
            }

            psItem.executeBatch();
            psStock.executeBatch();

            // Cam kết toàn bộ giao dịch (Commit)
            conn.commit();
            return true;

        } catch (SQLException e) {
            System.err.println("[OrderDAO] Lỗi khi tạo đơn hàng, thực hiện Rollback: " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException ignored) {}
            }
            DBContext.close(null, psOrder, rsKeys);
            DBContext.close(null, psItem, null);
            DBContext.close(conn, psStock, null);
        }
    }

    /**
     * Lấy danh sách đơn hàng cho Admin (có lọc theo trạng thái và tìm kiếm từ khóa)
     */
    public List<Order> getOrders(String status, String keyword, int page, int pageSize) {
        List<Order> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM orders WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
            sql.append("AND status = ? ");
            params.add(status.trim());
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (order_code LIKE ? OR customer_name LIKE ? OR customer_phone LIKE ? OR customer_email LIKE ?) ");
            String pat = "%" + keyword.trim() + "%";
            params.add(pat);
            params.add(pat);
            params.add(pat);
            params.add(pat);
        }

        sql.append("ORDER BY created_at DESC LIMIT ? OFFSET ?");
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
     * Đếm tổng số đơn hàng thỏa mãn điều kiện lọc
     */
    public int countOrders(String status, String keyword) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM orders WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
            sql.append("AND status = ? ");
            params.add(status.trim());
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (order_code LIKE ? OR customer_name LIKE ? OR customer_phone LIKE ? OR customer_email LIKE ?) ");
            String pat = "%" + keyword.trim() + "%";
            params.add(pat);
            params.add(pat);
            params.add(pat);
            params.add(pat);
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
     * Lấy chi tiết đơn hàng theo ID (kèm danh sách mặt hàng đã mua)
     */
    public Order getOrderById(int id) {
        String sql = "SELECT * FROM orders WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Order o = mapRow(rs);
                o.setItems(getOrderItems(o.getId()));
                return o;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return null;
    }

    /**
     * Lấy chi tiết đơn hàng theo mã đơn order_code (dành cho trang xác nhận thành công)
     */
    public Order getOrderByCode(String code) {
        String sql = "SELECT * FROM orders WHERE order_code = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, code);
            rs = ps.executeQuery();
            if (rs.next()) {
                Order o = mapRow(rs);
                o.setItems(getOrderItems(o.getId()));
                return o;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return null;
    }

    /**
     * Lấy danh sách các mặt hàng trong đơn hàng
     */
    public List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ? ORDER BY id ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                int pId = rs.getInt("product_id");
                item.setProductId(rs.wasNull() ? null : pId);
                item.setProductSku(rs.getString("product_sku"));
                item.setProductName(rs.getString("product_name"));
                item.setProductImage(rs.getString("product_image"));
                item.setUnitPrice(rs.getBigDecimal("unit_price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setSubtotal(rs.getBigDecimal("subtotal"));
                list.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return list;
    }

    /**
     * Cập nhật trạng thái đơn hàng (PENDING, SHIPPING, COMPLETED, CANCELLED)
     */
    public boolean updateOrderStatus(int orderId, String newStatus) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    /**
     * Thống kê số lượng đơn hàng theo trạng thái phục vụ Admin Dashboard
     */
    public Map<String, Integer> getOrderStatistics() {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("PENDING", 0);
        stats.put("SHIPPING", 0);
        stats.put("COMPLETED", 0);
        stats.put("CANCELLED", 0);
        stats.put("TOTAL", 0);

        String sql = "SELECT status, COUNT(*) AS cnt FROM orders GROUP BY status";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            int total = 0;
            while (rs.next()) {
                String st = rs.getString("status");
                int count = rs.getInt("cnt");
                stats.put(st, count);
                total += count;
            }
            stats.put("TOTAL", total);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return stats;
    }

    /**
     * Tính tổng doanh thu từ các đơn hàng thành công (COMPLETED)
     */
    public java.math.BigDecimal getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE status = 'COMPLETED'";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return java.math.BigDecimal.ZERO;
    }

    /**
     * Lấy toàn bộ lịch sử đơn hàng của một khách hàng cụ thể
     */
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY id DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order o = mapRow(rs);
                o.setItems(getOrderItems(o.getId()));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return list;
    }

    /**
     * Lấy chi tiết đơn hàng của người dùng (kèm kiểm tra quyền sở hữu chống IDOR)
     */
    public Order getOrderByIdAndUserId(int orderId, int userId) {
        String sql = "SELECT * FROM orders WHERE id = ? AND user_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Order o = mapRow(rs);
                o.setItems(getOrderItems(o.getId()));
                return o;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return null;
    }
}
