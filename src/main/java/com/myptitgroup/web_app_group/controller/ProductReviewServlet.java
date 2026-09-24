package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.ProductReviewDAO;
import com.myptitgroup.web_app_group.model.ProductReview;
import com.myptitgroup.web_app_group.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controller tiếp nhận Đánh giá & Bình luận sản phẩm từ khách hàng (URL: /product-review)
 */
@WebServlet(name = "ProductReviewServlet", urlPatterns = {"/product-review"})
public class ProductReviewServlet extends HttpServlet {

    private final ProductReviewDAO reviewDAO = new ProductReviewDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String productIdStr = request.getParameter("productId");
        int productId = 0;
        try {
            productId = Integer.parseInt(productIdStr.trim());
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/shop");
            return;
        }

        String ratingStr = request.getParameter("rating");
        int rating = 5;
        try {
            rating = Integer.parseInt(ratingStr.trim());
            if (rating < 1) rating = 1;
            if (rating > 5) rating = 5;
        } catch (Exception ignored) {}

        String comment = request.getParameter("comment");
        String customerName = request.getParameter("customerName");
        String customerEmail = request.getParameter("customerEmail");

        HttpSession session = request.getSession(false);
        Integer userId = null;
        if (session != null) {
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser != null) {
                userId = currentUser.getId();
                if (customerName == null || customerName.trim().isEmpty()) {
                    customerName = currentUser.getFullName();
                }
                if (customerEmail == null || customerEmail.trim().isEmpty()) {
                    customerEmail = currentUser.getEmail();
                }
            }
        }

        if (customerName == null || customerName.trim().isEmpty()) {
            customerName = "Khách hàng";
        }

        if (comment == null || comment.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/product-detail?id=" + productId + "#reviews&reviewMsg=empty_comment");
            return;
        }

        ProductReview review = new ProductReview();
        review.setProductId(productId);
        review.setUserId(userId);
        review.setCustomerName(customerName.trim());
        review.setCustomerEmail(customerEmail != null ? customerEmail.trim() : null);
        review.setRating(rating);
        review.setComment(comment.trim());
        review.setApproved(true); // Tự động duyệt hiển thị

        boolean saved = reviewDAO.insertReview(review);
        if (saved) {
            response.sendRedirect(request.getContextPath() + "/product-detail?id=" + productId + "&reviewMsg=success#reviews");
        } else {
            response.sendRedirect(request.getContextPath() + "/product-detail?id=" + productId + "&reviewMsg=error#reviews");
        }
    }
}
