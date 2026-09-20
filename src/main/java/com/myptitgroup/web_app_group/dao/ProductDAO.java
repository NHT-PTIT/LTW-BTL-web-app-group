package com.myptitgroup.web_app_group.dao;

import com.myptitgroup.web_app_group.config.DBContext;
import com.myptitgroup.web_app_group.model.Product;
import com.myptitgroup.web_app_group.model.ProductImage;
import com.myptitgroup.web_app_group.model.ProductSpec;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object quản lý bảng products, product_images, product_specs
 * Tích hợp bộ lọc đa tiêu chí, phân trang và thư viện ảnh/thông số kỹ thuật.
 */
public class ProductDAO {

    /**
     * Map ResultSet sang Product object
     */
    private Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setSku(rs.getString("sku"));
        p.setName(rs.getString("name"));
        p.setSlug(rs.getString("slug"));
        p.setBrand(rs.getString("brand"));
        p.setPowerStr(rs.getString("power_str"));
        double powerVal = rs.getDouble("power_val");
        p.setPowerVal(rs.wasNull() ? null : powerVal);
        p.setPrice(rs.getBigDecimal("price"));
        p.setSalePrice(rs.getBigDecimal("sale_price"));
        p.setStockQuantity(rs.getInt("stock_quantity"));
        p.setShortDescription(rs.getString("short_description"));
        p.setDetailDescription(rs.getString("detail_description"));
        p.setMainImageUrl(rs.getString("main_image_url"));
        p.setFeatured(rs.getBoolean("is_featured"));
        p.setActive(rs.getBoolean("is_active"));
        p.setViewsCount(rs.getInt("views_count"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        p.setUpdatedAt(rs.getTimestamp("updated_at"));

        try {
            p.setCategoryName(rs.getString("category_name"));
        } catch (SQLException ignored) {}

        return p;
    }

    /**
     * Lấy danh sách sản phẩm nổi bật hiển thị ở Trang chủ
     */
    public List<Product> getFeaturedProducts(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.is_featured = 1 AND p.is_active = 1 " +
                     "ORDER BY p.updated_at DESC LIMIT ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
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
     * Lấy sản phẩm mới nhất
     */
    public List<Product> getLatestProducts(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.is_active = 1 " +
                     "ORDER BY p.created_at DESC LIMIT ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
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
     * Tìm sản phẩm theo ID (kèm gallery ảnh và bảng thông số kỹ thuật)
     */
    public Product getById(int id) {
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Product p = mapRow(rs);
                p.setGallery(getImagesByProductId(p.getId()));
                p.setSpecifications(getSpecsByProductId(p.getId()));
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return null;
    }

    /**
     * Tìm sản phẩm theo slug (đường dẫn thân thiện SEO)
     */
    public Product getBySlug(String slug) {
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.slug = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, slug);
            rs = ps.executeQuery();
            if (rs.next()) {
                Product p = mapRow(rs);
                p.setGallery(getImagesByProductId(p.getId()));
                p.setSpecifications(getSpecsByProductId(p.getId()));
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return null;
    }

    /**
     * Lấy các sản phẩm liên quan cùng danh mục
     */
    public List<Product> getRelatedProducts(int categoryId, int excludeId, int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name AS category_name " +
                     "FROM products p " +
                     "JOIN categories c ON p.category_id = c.id " +
                     "WHERE p.category_id = ? AND p.id <> ? AND p.is_active = 1 " +
                     "ORDER BY p.id DESC LIMIT ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ps.setInt(2, excludeId);
            ps.setInt(3, limit);
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
     * BỘ LỌC ĐA TIÊU CHÍ & TÌM KIẾM SẢN PHẨM (Faceted Filter & Search with Pagination)
     */
    public List<Product> filterProducts(Integer categoryId, String brand, Double minPrice, Double maxPrice, 
                                        Double minPower, Double maxPower, String keyword, String sortBy, 
                                        int page, int pageSize) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, c.name AS category_name " +
            "FROM products p " +
            "JOIN categories c ON p.category_id = c.id " +
            "WHERE p.is_active = 1 "
        );

        List<Object> params = new ArrayList<>();

        // 1. Lọc theo danh mục (hỗ trợ cả danh mục con của nó)
        if (categoryId != null && categoryId > 0) {
            sql.append("AND (p.category_id = ? OR p.category_id IN (SELECT id FROM categories WHERE parent_id = ?)) ");
            params.add(categoryId);
            params.add(categoryId);
        }

        // 2. Lọc theo thương hiệu
        if (brand != null && !brand.trim().isEmpty()) {
            sql.append("AND p.brand = ? ");
            params.add(brand.trim());
        }

        // 3. Lọc theo khoảng giá (ưu tiên sale_price nếu có)
        if (minPrice != null && minPrice > 0) {
            sql.append("AND COALESCE(p.sale_price, p.price) >= ? ");
            params.add(BigDecimal.valueOf(minPrice));
        }
        if (maxPrice != null && maxPrice > 0) {
            sql.append("AND COALESCE(p.sale_price, p.price) <= ? ");
            params.add(BigDecimal.valueOf(maxPrice));
        }

        // 4. Lọc theo dải công suất (power_val theo đơn vị kW)
        if (minPower != null && minPower >= 0) {
            sql.append("AND p.power_val >= ? ");
            params.add(minPower);
        }
        if (maxPower != null && maxPower > 0) {
            sql.append("AND p.power_val <= ? ");
            params.add(maxPower);
        }

        // 5. Tìm kiếm theo từ khóa (tên, mã SKU, mô tả)
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (p.name LIKE ? OR p.sku LIKE ? OR p.brand LIKE ? OR p.short_description LIKE ?) ");
            String searchPattern = "%" + keyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        // 6. Sắp xếp
        if ("price_asc".equalsIgnoreCase(sortBy)) {
            sql.append("ORDER BY COALESCE(p.sale_price, p.price) ASC ");
        } else if ("price_desc".equalsIgnoreCase(sortBy)) {
            sql.append("ORDER BY COALESCE(p.sale_price, p.price) DESC ");
        } else if ("name_asc".equalsIgnoreCase(sortBy)) {
            sql.append("ORDER BY p.name ASC ");
        } else {
            sql.append("ORDER BY p.created_at DESC ");
        }

        // 7. Phân trang
        sql.append("LIMIT ? OFFSET ?");
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
     * Đếm tổng số sản phẩm thỏa mãn điều kiện lọc (để tính tổng số trang)
     */
    public int countFilteredProducts(Integer categoryId, String brand, Double minPrice, Double maxPrice, 
                                     Double minPower, Double maxPower, String keyword) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM products p " +
            "JOIN categories c ON p.category_id = c.id " +
            "WHERE p.is_active = 1 "
        );

        List<Object> params = new ArrayList<>();

        if (categoryId != null && categoryId > 0) {
            sql.append("AND (p.category_id = ? OR p.category_id IN (SELECT id FROM categories WHERE parent_id = ?)) ");
            params.add(categoryId);
            params.add(categoryId);
        }
        if (brand != null && !brand.trim().isEmpty()) {
            sql.append("AND p.brand = ? ");
            params.add(brand.trim());
        }
        if (minPrice != null && minPrice > 0) {
            sql.append("AND COALESCE(p.sale_price, p.price) >= ? ");
            params.add(BigDecimal.valueOf(minPrice));
        }
        if (maxPrice != null && maxPrice > 0) {
            sql.append("AND COALESCE(p.sale_price, p.price) <= ? ");
            params.add(BigDecimal.valueOf(maxPrice));
        }
        if (minPower != null && minPower >= 0) {
            sql.append("AND p.power_val >= ? ");
            params.add(minPower);
        }
        if (maxPower != null && maxPower > 0) {
            sql.append("AND p.power_val <= ? ");
            params.add(maxPower);
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (p.name LIKE ? OR p.sku LIKE ? OR p.brand LIKE ? OR p.short_description LIKE ?) ");
            String searchPattern = "%" + keyword.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
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
     * Lấy danh sách thương hiệu phân biệt để tạo danh sách checkbox lọc
     */
    public List<String> getAllBrands() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT brand FROM products WHERE is_active = 1 AND brand IS NOT NULL ORDER BY brand ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("brand"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return list;
    }

    /**
     * Lấy thư viện ảnh chi tiết theo ID sản phẩm
     */
    public List<ProductImage> getImagesByProductId(int productId) {
        List<ProductImage> list = new ArrayList<>();
        String sql = "SELECT * FROM product_images WHERE product_id = ? ORDER BY sort_order ASC, id ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            while (rs.next()) {
                ProductImage img = new ProductImage(
                    rs.getInt("id"),
                    rs.getInt("product_id"),
                    rs.getString("image_url"),
                    rs.getBoolean("is_primary"),
                    rs.getInt("sort_order")
                );
                img.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(img);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return list;
    }

    /**
     * Lấy thông số kỹ thuật theo ID sản phẩm
     */
    public List<ProductSpec> getSpecsByProductId(int productId) {
        List<ProductSpec> list = new ArrayList<>();
        String sql = "SELECT * FROM product_specs WHERE product_id = ? ORDER BY sort_order ASC, id ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ProductSpec(
                    rs.getInt("id"),
                    rs.getInt("product_id"),
                    rs.getString("spec_name"),
                    rs.getString("spec_value"),
                    rs.getInt("sort_order")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, rs);
        }
        return list;
    }

    /**
     * Thêm sản phẩm mới (dành cho Admin)
     */
    public boolean insert(Product p) {
        String sql = "INSERT INTO products (category_id, sku, name, slug, brand, power_str, power_val, " +
                     "price, sale_price, stock_quantity, short_description, detail_description, " +
                     "main_image_url, is_featured, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, p.getCategoryId());
            ps.setString(2, p.getSku());
            ps.setString(3, p.getName());
            ps.setString(4, p.getSlug());
            ps.setString(5, p.getBrand());
            ps.setString(6, p.getPowerStr());
            if (p.getPowerVal() != null) {
                ps.setDouble(7, p.getPowerVal());
            } else {
                ps.setNull(7, Types.DOUBLE);
            }
            ps.setBigDecimal(8, p.getPrice());
            ps.setBigDecimal(9, p.getSalePrice());
            ps.setInt(10, p.getStockQuantity());
            ps.setString(11, p.getShortDescription());
            ps.setString(12, p.getDetailDescription());
            ps.setString(13, p.getMainImageUrl());
            ps.setBoolean(14, p.isFeatured());
            ps.setBoolean(15, p.isActive());

            int affected = ps.executeUpdate();
            if (affected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    p.setId(rs.getInt(1));
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
     * Cập nhật sản phẩm
     */
    public boolean update(Product p) {
        String sql = "UPDATE products SET category_id = ?, sku = ?, name = ?, slug = ?, brand = ?, " +
                     "power_str = ?, power_val = ?, price = ?, sale_price = ?, stock_quantity = ?, " +
                     "short_description = ?, detail_description = ?, main_image_url = ?, " +
                     "is_featured = ?, is_active = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, p.getCategoryId());
            ps.setString(2, p.getSku());
            ps.setString(3, p.getName());
            ps.setString(4, p.getSlug());
            ps.setString(5, p.getBrand());
            ps.setString(6, p.getPowerStr());
            if (p.getPowerVal() != null) {
                ps.setDouble(7, p.getPowerVal());
            } else {
                ps.setNull(7, Types.DOUBLE);
            }
            ps.setBigDecimal(8, p.getPrice());
            ps.setBigDecimal(9, p.getSalePrice());
            ps.setInt(10, p.getStockQuantity());
            ps.setString(11, p.getShortDescription());
            ps.setString(12, p.getDetailDescription());
            ps.setString(13, p.getMainImageUrl());
            ps.setBoolean(14, p.isFeatured());
            ps.setBoolean(15, p.isActive());
            ps.setInt(16, p.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    /**
     * Xóa sản phẩm
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
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

    /**
     * Thêm ảnh chi tiết vào gallery
     */
    public boolean insertImage(ProductImage img) {
        String sql = "INSERT INTO product_images (product_id, image_url, is_primary, sort_order) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, img.getProductId());
            ps.setString(2, img.getImageUrl());
            ps.setBoolean(3, img.isPrimary());
            ps.setInt(4, img.getSortOrder());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    /**
     * Xóa ảnh chi tiết
     */
    public boolean deleteImage(int imageId) {
        String sql = "DELETE FROM product_images WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, imageId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    /**
     * Thêm thông số kỹ thuật
     */
    public boolean insertSpec(ProductSpec spec) {
        String sql = "INSERT INTO product_specs (product_id, spec_name, spec_value, sort_order) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, spec.getProductId());
            ps.setString(2, spec.getSpecName());
            ps.setString(3, spec.getSpecValue());
            ps.setInt(4, spec.getSortOrder());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }

    /**
     * Xóa thông số kỹ thuật
     */
    public boolean deleteSpec(int specId) {
        String sql = "DELETE FROM product_specs WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, specId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBContext.close(conn, ps, null);
        }
        return false;
    }
}
