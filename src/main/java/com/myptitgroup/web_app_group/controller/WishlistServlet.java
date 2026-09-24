package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.WishlistDAO;
import com.myptitgroup.web_app_group.model.Product;
import com.myptitgroup.web_app_group.model.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controller xử lý Danh sách sản phẩm yêu thích (Wishlist) của khách hàng
 * URLs: /account/wishlist, /wishlist-action
 */
@WebServlet(name = "WishlistServlet", urlPatterns = {"/account/wishlist", "/wishlist-action"})
public class WishlistServlet extends HttpServlet {

    private final WishlistDAO wishlistDAO = new WishlistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        // 1. Thao tác toggle / remove yêu thích
        if ("/wishlist-action".equals(path)) {
            String redirect = request.getParameter("redirect");
            String productIdStr = request.getParameter("productId");
            int productId = 0;
            try {
                if (productIdStr != null) productId = Integer.parseInt(productIdStr.trim());
            } catch (Exception ignored) {}

            if (currentUser == null) {
                // Khách chưa đăng nhập: chuyển hướng sang trang đăng nhập
                String redirectTarget = "/shop";
                if ("detail".equalsIgnoreCase(redirect) && productId > 0) {
                    redirectTarget = "/product-detail?id=" + productId;
                } else if ("wishlist".equalsIgnoreCase(redirect)) {
                    redirectTarget = "/account/wishlist";
                }
                response.sendRedirect(request.getContextPath() + "/login?redirect=" + redirectTarget);
                return;
            }

            String action = request.getParameter("action");
            if ("remove".equalsIgnoreCase(action)) {
                wishlistDAO.removeFromWishlist(currentUser.getId(), productId);
            } else {
                wishlistDAO.toggleWishlist(currentUser.getId(), productId);
            }

            // Chuyển hướng quay lại trang thích hợp
            if ("detail".equalsIgnoreCase(redirect) && productId > 0) {
                response.sendRedirect(request.getContextPath() + "/product-detail?id=" + productId);
            } else if ("shop".equalsIgnoreCase(redirect)) {
                response.sendRedirect(request.getContextPath() + "/shop");
            } else {
                response.sendRedirect(request.getContextPath() + "/account/wishlist");
            }
            return;
        }

        // 2. Trang xem Danh sách yêu thích (/account/wishlist)
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=/account/wishlist");
            return;
        }

        List<Product> wishlist = wishlistDAO.getWishlistProducts(currentUser.getId());
        request.setAttribute("wishlistProducts", wishlist);
        request.setAttribute("activeTab", "wishlist");
        request.setAttribute("pageTitle", "Sản phẩm yêu thích - Bleezy Inverter & Solar");
        request.getRequestDispatcher("/account-wishlist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
