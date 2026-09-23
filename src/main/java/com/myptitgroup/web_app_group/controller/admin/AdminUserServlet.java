package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.dao.UserDAO;
import com.myptitgroup.web_app_group.model.Order;
import com.myptitgroup.web_app_group.model.User;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller quản lý Khách hàng / Thành viên trong phân hệ Quản trị (/admin/users)
 * Hỗ trợ: Xem danh sách, phân trang, tìm kiếm, xem hồ sơ & lịch sử mua hàng, khóa/mở khóa tài khoản.
 */
@WebServlet(name = "AdminUserServlet", urlPatterns = {"/admin/users"})
public class AdminUserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
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

        // Action xem chi tiết hồ sơ khách hàng và các đơn hàng đã đặt
        if ("detail".equalsIgnoreCase(action) || (action == null && request.getParameter("id") != null)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                User user = userDAO.getById(id);
                if (user == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/users?err=not_found");
                    return;
                }

                List<Order> customerOrders = orderDAO.getOrdersByUserId(id);
                request.setAttribute("customer", user);
                request.setAttribute("customerOrders", customerOrders);
                request.setAttribute("activeMenu", "users");
                request.setAttribute("pageTitle", "Hồ sơ Khách hàng #" + user.getId() + " - " + user.getFullName() + " - Bleezy Admin");
                request.getRequestDispatcher("/WEB-INF/views/admin/user/detail.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/users?err=invalid_id");
                return;
            }
        }

        // Action xem danh sách khách hàng
        String status = request.getParameter("status");
        if (status == null || status.trim().isEmpty()) {
            status = "ALL";
        }
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
        List<User> users = userDAO.getAllUsers(status, keyword, page, pageSize);
        int totalUsers = userDAO.countUsers(status, keyword);
        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
        if (totalPages < 1) totalPages = 1;

        Map<String, Integer> userStats = userDAO.getUserStatistics();

        request.setAttribute("users", users);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("currentStatus", status);
        request.setAttribute("keyword", keyword);
        request.setAttribute("userStats", userStats);

        request.setAttribute("activeMenu", "users");
        request.setAttribute("pageTitle", "Quản Lý Khách Hàng - Bleezy Admin");
        request.getRequestDispatcher("/WEB-INF/views/admin/user/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("toggle-status".equalsIgnoreCase(action)) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean success = userDAO.toggleActiveStatus(userId);
                String redirectUrl = request.getParameter("redirectUrl");
                if (redirectUrl != null && !redirectUrl.trim().isEmpty()) {
                    response.sendRedirect(redirectUrl + (redirectUrl.contains("?") ? "&" : "?") + (success ? "msg=status_updated" : "err=update_failed"));
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/users?" + (success ? "msg=status_updated" : "err=update_failed"));
                }
                return;
            } catch (NumberFormatException ignored) {}
        } else if ("reset-password".equalsIgnoreCase(action)) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String newPassword = request.getParameter("newPassword");
                if (newPassword == null || newPassword.trim().isEmpty()) {
                    newPassword = "Password@123";
                }
                boolean success = userDAO.changePassword(userId, newPassword.trim());
                response.sendRedirect(request.getContextPath() + "/admin/users?action=detail&id=" + userId + (success ? "&msg=pwd_reset_success" : "&err=pwd_reset_failed"));
                return;
            } catch (NumberFormatException ignored) {}
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
