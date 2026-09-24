package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.dao.ProductReviewDAO;
import com.myptitgroup.web_app_group.model.ProductReview;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller kiểm duyệt và quản lý Đánh giá / Bình luận sản phẩm (/admin/reviews)
 */
@WebServlet(name = "AdminReviewServlet", urlPatterns = {"/admin/reviews"})
public class AdminReviewServlet extends HttpServlet {

    private final ProductReviewDAO reviewDAO = new ProductReviewDAO();
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

        // Action: Bật / Tắt duyệt hiển thị đánh giá
        if ("toggle".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                reviewDAO.toggleApproval(id);
                response.sendRedirect(request.getContextPath() + "/admin/reviews?msg=toggled");
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/reviews?err=invalid_id");
                return;
            }
        }

        // Action: Xóa vĩnh viễn đánh giá
        if ("delete".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                reviewDAO.deleteReview(id);
                response.sendRedirect(request.getContextPath() + "/admin/reviews?msg=deleted");
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/reviews?err=invalid_id");
                return;
            }
        }

        // Mặc định: Hiển thị danh sách đánh giá
        List<ProductReview> reviews = reviewDAO.getAllReviews();
        int pendingCount = reviewDAO.countPendingReviews();

        request.setAttribute("reviews", reviews);
        request.setAttribute("pendingReviewCount", pendingCount);
        request.setAttribute("activeMenu", "reviews");
        request.setAttribute("pageTitle", "Quản Lý Đánh Giá Sản Phẩm - Bleezy Admin");
        request.getRequestDispatcher("/WEB-INF/views/admin/review/list.jsp").forward(request, response);
    }
}
