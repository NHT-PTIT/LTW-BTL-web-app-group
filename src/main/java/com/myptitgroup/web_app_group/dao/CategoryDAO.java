package com.myptitgroup.web_app_group.dao;

import com.myptitgroup.web_app_group.config.DBContext;
import com.myptitgroup.web_app_group.model.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object quản lý bảng categories (Danh mục đa cấp)
 */
public class CategoryDAO {

    /**
     * Map ResultSet sang đối tượng Category
     */
    private Category mapRow(ResultSet rs) throws SQLException {
        Category c = new Category();
        c.setId(rs.getInt("id"));
        int parentId = rs.getInt("parent_id");
        c.setParentId(rs.wasNull() ? null : parentId);
        c.setName(rs.getString("name"));
        c.setSlug(rs.getString("slug"));
        c.setDescription(rs.getString("description"));
        c.setImageUrl(rs.getString("image_url"));
        c.setSortOrder(rs.getInt("sort_order"));
        c.setActive(rs.getBoolean("is_active"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        try {
            c.setParentName(rs.getString("parent_name"));
        } catch (SQLException ignored) {}
        return c;
    }

    /**
     * Lấy toàn bộ danh mục đang hoạt động kèm tên danh mục cha
     */
    public List<Category> getAllActive() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT c.*, p.name AS parent_name " +
                     "FROM categories c " +
                     "LEFT JOIN categories p ON c.parent_id = p.id " +
                     "WHERE c.is_active = 1 " +
                     "ORDER BY c.sort_order ASC, c.id ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
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
     * Lấy tất cả danh mục gốc cấp 1 (parent_id IS NULL)
     */
    public List<Category> getRootCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories WHERE parent_id IS NULL AND is_active = 1 ORDER BY sort_order ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
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
     * Lấy danh sách danh mục con theo parent_id
     */
    public List<Category> getSubCategories(int parentId) {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories WHERE parent_id = ? AND is_active = 1 ORDER BY sort_order ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, parentId);
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
     * Lấy cây danh mục lồng nhau (cha chứa các con) phục vụ thanh điều hướng Header/Navbar
     */
    public List<Category> getCategoryTree() {
        List<Category> roots = getRootCategories();
        for (Category root : roots) {
            root.setSubCategories(getSubCategories(root.getId()));
        }
        return roots;
    }

    /**
     * Tìm danh mục theo ID
     */
    public Category getById(int id) {
        String sql = "SELECT c.*, p.name AS parent_name " +
                     "FROM categories c " +
                     "LEFT JOIN categories p ON c.parent_id = p.id " +
                     "WHERE c.id = ?";
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
     * Tìm danh mục theo slug
     */
    public Category getBySlug(String slug) {
        String sql = "SELECT c.*, p.name AS parent_name " +
                     "FROM categories c " +
                     "LEFT JOIN categories p ON c.parent_id = p.id " +
                     "WHERE c.slug = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, slug);
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
     * Thêm danh mục mới (dành cho Admin)
     */
    public boolean insert(Category c) {
        String sql = "INSERT INTO categories (parent_id, name, slug, description, image_url, sort_order, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            if (c.getParentId() != null && c.getParentId() > 0) {
                ps.setInt(1, c.getParentId());
            } else {
                ps.setNull(1, Types.INTEGER);
            }
            ps.setString(2, c.getName());
            ps.setString(3, c.getSlug());
            ps.setString(4, c.getDescription());
            ps.setString(5, c.getImageUrl());
            ps.setInt(6, c.getSortOrder());
            ps.setBoolean(7, c.isActive());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    c.setId(rs.getInt(1));
                }
                rs.close();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    /**
     * Cập nhật danh mục
     */
    public boolean update(Category c) {
        String sql = "UPDATE categories SET parent_id = ?, name = ?, slug = ?, description = ?, " +
                     "image_url = ?, sort_order = ?, is_active = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            if (c.getParentId() != null && c.getParentId() > 0) {
                ps.setInt(1, c.getParentId());
            } else {
                ps.setNull(1, Types.INTEGER);
            }
            ps.setString(2, c.getName());
            ps.setString(3, c.getSlug());
            ps.setString(4, c.getDescription());
            ps.setString(5, c.getImageUrl());
            ps.setInt(6, c.getSortOrder());
            ps.setBoolean(7, c.isActive());
            ps.setInt(8, c.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    /**
     * Xóa danh mục
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM categories WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }
}
