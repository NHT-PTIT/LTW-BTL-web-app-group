package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.CategoryDAO;
import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.model.Category;
import java.io.IOException;
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
 * Controller quản lý Danh mục sản phẩm cho Quản trị viên (/admin/categories)
 * Hỗ trợ: Danh sách cây danh mục Cha - Con, Thêm mới, Sửa và Xóa danh mục.
 */
@WebServlet(name = "AdminCategoryServlet", urlPatterns = {"/admin/categories"})
public class AdminCategoryServlet extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Badge counters for sidebar
        Map<String, Integer> orderStats = orderDAO.getOrderStatistics();
        request.setAttribute("pendingOrderCount", orderStats.getOrDefault("PENDING", 0));
        request.setAttribute("newInquiryCount", contactDAO.countInquiries("NEW"));

        String action = request.getParameter("action");

        // Action: Form Thêm Mới
        if ("add".equalsIgnoreCase(action)) {
            List<Category> rootCategories = categoryDAO.getRootCategories();
            request.setAttribute("rootCategories", rootCategories);
            request.setAttribute("category", new Category());
            request.setAttribute("isEdit", false);
            request.setAttribute("activeMenu", "categories");
            request.setAttribute("pageTitle", "Thêm Danh Mục Mới - Bleezy Admin");
            request.getRequestDispatcher("/WEB-INF/views/admin/category/form.jsp").forward(request, response);
            return;
        }

        // Action: Form Sửa
        if ("edit".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Category c = categoryDAO.getById(id);
                if (c == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/categories?err=not_found");
                    return;
                }
                List<Category> rootCategories = categoryDAO.getRootCategories();
                request.setAttribute("rootCategories", rootCategories);
                request.setAttribute("category", c);
                request.setAttribute("isEdit", true);
                request.setAttribute("activeMenu", "categories");
                request.setAttribute("pageTitle", "Sửa Danh Mục: " + c.getName() + " - Bleezy Admin");
                request.getRequestDispatcher("/WEB-INF/views/admin/category/form.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?err=invalid_id");
                return;
            }
        }

        // Action: Xóa Danh Mục
        if ("delete".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean ok = categoryDAO.delete(id);
                if (ok) {
                    response.sendRedirect(request.getContextPath() + "/admin/categories?msg=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/categories?err=delete_failed");
                }
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?err=invalid_id");
                return;
            }
        }

        // Action Mặc định: Hiển thị danh mục dạng cây phân cấp
        List<Category> categoryTree = categoryDAO.getCategoryTree();
        request.setAttribute("categoryTree", categoryTree);
        request.setAttribute("activeMenu", "categories");
        request.setAttribute("pageTitle", "Quản Lý Danh Mục - Bleezy Admin");
        request.getRequestDispatcher("/WEB-INF/views/admin/category/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("id");
        boolean isEdit = (idStr != null && !idStr.trim().isEmpty());

        try {
            String name = request.getParameter("name") != null ? request.getParameter("name").trim() : "";
            String slug = request.getParameter("slug");
            if (slug == null || slug.trim().isEmpty()) {
                slug = toSlug(name);
            } else {
                slug = toSlug(slug);
            }

            Integer parentId = null;
            String parentStr = request.getParameter("parentId");
            if (parentStr != null && !parentStr.trim().isEmpty() && !"NONE".equalsIgnoreCase(parentStr)) {
                parentId = Integer.parseInt(parentStr.trim());
            }

            String description = request.getParameter("description") != null ? request.getParameter("description").trim() : "";
            String imageUrl = request.getParameter("imageUrl") != null ? request.getParameter("imageUrl").trim() : "";
            
            int sortOrder = 0;
            try {
                sortOrder = Integer.parseInt(request.getParameter("sortOrder").trim());
            } catch (Exception ignored) {}

            boolean isActive = "1".equals(request.getParameter("isActive")) || "true".equalsIgnoreCase(request.getParameter("isActive")) || "on".equalsIgnoreCase(request.getParameter("isActive"));

            Category c = new Category();
            c.setName(name);
            c.setSlug(slug);
            c.setParentId(parentId);
            c.setDescription(description);
            c.setImageUrl(imageUrl);
            c.setSortOrder(sortOrder);
            c.setActive(isActive);

            boolean success;
            if (isEdit) {
                c.setId(Integer.parseInt(idStr.trim()));
                success = categoryDAO.update(c);
            } else {
                success = categoryDAO.insert(c);
            }

            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/categories?msg=saved");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/categories?err=save_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/categories?err=invalid_input");
        }
    }

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
