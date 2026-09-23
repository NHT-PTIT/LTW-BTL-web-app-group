package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.CategoryDAO;
import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.dao.ProductDAO;
import com.myptitgroup.web_app_group.model.Category;
import com.myptitgroup.web_app_group.model.Product;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.Normalizer;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller quản lý Sản phẩm cho Quản trị viên (/admin/products)
 * Hỗ trợ: Danh sách, phân trang, lọc theo danh mục, tìm kiếm, Thêm mới, Sửa và Xóa sản phẩm.
 */
@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin/products"})
public class AdminProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Badge counters for sidebar (phòng thủ an toàn)
        try {
            Map<String, Integer> orderStats = orderDAO.getOrderStatistics();
            request.setAttribute("pendingOrderCount", orderStats != null ? orderStats.getOrDefault("PENDING", 0) : 0);
        } catch (Throwable t) {
            request.setAttribute("pendingOrderCount", 0);
        }
        try {
            request.setAttribute("newInquiryCount", contactDAO.countInquiries("NEW"));
        } catch (Throwable t) {
            request.setAttribute("newInquiryCount", 0);
        }

        String action = request.getParameter("action");

        // Action: Mở form thêm mới sản phẩm
        if ("add".equalsIgnoreCase(action)) {
            List<Category> categories = categoryDAO.getAllActive();
            request.setAttribute("categories", categories);
            request.setAttribute("product", new Product());
            request.setAttribute("isEdit", false);
            request.setAttribute("activeMenu", "products");
            request.setAttribute("pageTitle", "Thêm Sản Phẩm Mới - Bleezy Admin");
            request.getRequestDispatcher("/WEB-INF/views/admin/product/form.jsp").forward(request, response);
            return;
        }

        // Action: Mở form sửa thông tin sản phẩm
        if ("edit".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Product p = productDAO.getById(id);
                if (p == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/products?err=not_found");
                    return;
                }
                List<Category> categories = categoryDAO.getAllActive();
                request.setAttribute("categories", categories);
                request.setAttribute("product", p);
                request.setAttribute("isEdit", true);
                request.setAttribute("activeMenu", "products");
                request.setAttribute("pageTitle", "Sửa Sản Phẩm: " + p.getName() + " - Bleezy Admin");
                request.getRequestDispatcher("/WEB-INF/views/admin/product/form.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/products?err=invalid_id");
                return;
            }
        }

        // Action: Xóa sản phẩm
        if ("delete".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean ok = productDAO.delete(id);
                if (ok) {
                    response.sendRedirect(request.getContextPath() + "/admin/products?msg=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/products?err=delete_failed");
                }
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/products?err=invalid_id");
                return;
            }
        }

        // Action Mặc định: Hiển thị danh sách sản phẩm
        Integer categoryId = null;
        try {
            String catParam = request.getParameter("categoryId");
            if (catParam != null && !catParam.trim().isEmpty() && !"ALL".equalsIgnoreCase(catParam)) {
                categoryId = Integer.parseInt(catParam.trim());
            }
        } catch (NumberFormatException ignored) {}

        String keyword = request.getParameter("keyword");
        if (keyword != null) {
            keyword = keyword.trim();
        }

        int page = 1;
        try {
            String pStr = request.getParameter("page");
            if (pStr != null && !pStr.trim().isEmpty()) {
                page = Math.max(1, Integer.parseInt(pStr.trim()));
            }
        } catch (NumberFormatException ignored) {}

        int pageSize = 10;
        List<Product> products = null;
        int totalProducts = 0;
        try {
            products = productDAO.filterProductsForAdmin(categoryId, keyword, page, pageSize);
            totalProducts = productDAO.countProductsForAdmin(categoryId, keyword);
        } catch (Throwable t) {
            // Fallback sang hàm query thông thường nếu JVM server đang nạp bytecode cũ
            try {
                products = productDAO.filterProducts(categoryId, null, null, null, null, null, keyword, null, page, pageSize);
                totalProducts = productDAO.countFilteredProducts(categoryId, null, null, null, null, null, keyword);
            } catch (Throwable t2) {
                products = new java.util.ArrayList<>();
                totalProducts = 0;
            }
        }
        if (products == null) {
            products = new java.util.ArrayList<>();
        }
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPages < 1) totalPages = 1;

        List<Category> categories = null;
        try {
            categories = categoryDAO.getAllActive();
        } catch (Throwable t) {
            categories = new java.util.ArrayList<>();
        }

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("selectedCategoryId", categoryId);
        request.setAttribute("keyword", keyword);

        request.setAttribute("activeMenu", "products");
        request.setAttribute("pageTitle", "Quản Lý Sản Phẩm - Bleezy Admin");
        request.getRequestDispatcher("/WEB-INF/views/admin/product/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("id");
        boolean isEdit = (idStr != null && !idStr.trim().isEmpty());

        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String sku = request.getParameter("sku") != null ? request.getParameter("sku").trim().toUpperCase() : "";
            String name = request.getParameter("name") != null ? request.getParameter("name").trim() : "";
            String slug = request.getParameter("slug");
            if (slug == null || slug.trim().isEmpty()) {
                slug = toSlug(name);
            } else {
                slug = toSlug(slug);
            }

            String brand = request.getParameter("brand") != null ? request.getParameter("brand").trim() : "";
            String powerStr = request.getParameter("powerStr") != null ? request.getParameter("powerStr").trim() : "";
            
            Double powerVal = null;
            try {
                String pv = request.getParameter("powerVal");
                if (pv != null && !pv.trim().isEmpty()) {
                    powerVal = Double.parseDouble(pv.trim());
                }
            } catch (NumberFormatException ignored) {}

            BigDecimal price = new BigDecimal(request.getParameter("price").replaceAll("[^0-9]", ""));
            
            BigDecimal salePrice = null;
            String spStr = request.getParameter("salePrice");
            if (spStr != null && !spStr.trim().isEmpty()) {
                String cleanSp = spStr.replaceAll("[^0-9]", "");
                if (!cleanSp.isEmpty()) {
                    salePrice = new BigDecimal(cleanSp);
                }
            }

            int stockQuantity = 0;
            try {
                stockQuantity = Integer.parseInt(request.getParameter("stockQuantity").replaceAll("[^0-9]", ""));
            } catch (Exception ignored) {}

            String mainImageUrl = request.getParameter("mainImageUrl") != null ? request.getParameter("mainImageUrl").trim() : "";
            String shortDescription = request.getParameter("shortDescription") != null ? request.getParameter("shortDescription").trim() : "";
            String detailDescription = request.getParameter("detailDescription") != null ? request.getParameter("detailDescription").trim() : "";
            
            boolean isFeatured = "1".equals(request.getParameter("isFeatured")) || "true".equalsIgnoreCase(request.getParameter("isFeatured")) || "on".equalsIgnoreCase(request.getParameter("isFeatured"));
            boolean isActive = "1".equals(request.getParameter("isActive")) || "true".equalsIgnoreCase(request.getParameter("isActive")) || "on".equalsIgnoreCase(request.getParameter("isActive"));

            Product p = new Product();
            p.setCategoryId(categoryId);
            p.setSku(sku);
            p.setName(name);
            p.setSlug(slug);
            p.setBrand(brand);
            p.setPowerStr(powerStr);
            p.setPowerVal(powerVal);
            p.setPrice(price);
            p.setSalePrice(salePrice);
            p.setStockQuantity(stockQuantity);
            p.setMainImageUrl(mainImageUrl);
            p.setShortDescription(shortDescription);
            p.setDetailDescription(detailDescription);
            p.setFeatured(isFeatured);
            p.setActive(isActive);

            boolean success;
            if (isEdit) {
                p.setId(Integer.parseInt(idStr.trim()));
                success = productDAO.update(p);
            } else {
                success = productDAO.insert(p);
            }

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/products?msg=saved");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/products?err=save_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products?err=invalid_input");
        }
    }

    /**
     * Chuyển đổi tên sản phẩm tiếng Việt thành chuỗi slug URL chuẩn SEO
     */
    private static String toSlug(String input) {
        if (input == null) return "";
        String nowhitespace = input.trim().replaceAll("\\s+", "-");
        String normalized = Normalizer.normalize(nowhitespace, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        String slug = pattern.matcher(normalized).replaceAll("")
                .replaceAll("Đ", "D")
                .replaceAll("đ", "d")
                .toLowerCase(Locale.ENGLISH);
        slug = slug.replaceAll("[^a-z0-9-]", "");
        slug = slug.replaceAll("-+", "-");
        if (slug.startsWith("-")) slug = slug.substring(1);
        if (slug.endsWith("-")) slug = slug.substring(0, slug.length() - 1);
        return slug;
    }
}
