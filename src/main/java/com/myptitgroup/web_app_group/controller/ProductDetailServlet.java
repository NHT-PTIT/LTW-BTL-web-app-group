package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.CategoryDAO;
import com.myptitgroup.web_app_group.dao.ProductDAO;
import com.myptitgroup.web_app_group.model.Category;
import com.myptitgroup.web_app_group.model.Product;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller xử lý hiển thị chi tiết sản phẩm, thư viện ảnh, thông số kỹ thuật và sản phẩm liên quan (URL: /product-detail, /product)
 */
@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/product-detail", "/product"})
public class ProductDetailServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        Product product = null;

        // 1. Tìm theo ID
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam.trim());
                product = productDAO.getById(id);
            } catch (NumberFormatException ignored) {}
        }

        // 2. Nếu không có id, tìm theo slug
        if (product == null) {
            String slug = request.getParameter("slug");
            if (slug != null && !slug.trim().isEmpty()) {
                product = productDAO.getBySlug(slug.trim());
            }
        }

        // 3. Fallback: Lấy sản phẩm đầu tiên nếu chưa truyền param
        if (product == null) {
            List<Product> defaults = productDAO.getLatestProducts(1);
            if (!defaults.isEmpty()) {
                product = productDAO.getById(defaults.get(0).getId());
            }
        }

        // Nếu DB chưa có sản phẩm nào
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/shop");
            return;
        }

        // 4. Lấy thông tin danh mục của sản phẩm
        Category category = categoryDAO.getById(product.getCategoryId());

        // 5. Lấy danh sách sản phẩm liên quan (cùng danh mục)
        List<Product> relatedProducts = productDAO.getRelatedProducts(product.getCategoryId(), product.getId(), 4);

        // 6. Lấy đánh giá và thống kê sao của sản phẩm
        com.myptitgroup.web_app_group.dao.ProductReviewDAO reviewDAO = new com.myptitgroup.web_app_group.dao.ProductReviewDAO();
        request.setAttribute("reviews", reviewDAO.getApprovedReviewsByProductId(product.getId()));
        request.setAttribute("reviewStats", reviewDAO.getReviewStats(product.getId()));

        // 7. Đính kèm dữ liệu vào Request
        request.setAttribute("product", product);
        request.setAttribute("category", category);
        request.setAttribute("relatedProducts", relatedProducts);
        request.setAttribute("pageTitle", product.getName() + " - Bleezy Inverter & Solar Power");
        request.setAttribute("isProductDetailLoaded", true);

        // 7. Forward sang View product-detail.jsp
        request.getRequestDispatcher("/product-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
