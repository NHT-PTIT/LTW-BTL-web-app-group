package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.model.Order;
import com.myptitgroup.web_app_group.model.OrderItem;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller quản lý đơn hàng cho Quản trị viên (/admin/orders)
 * Hỗ trợ: Xem danh sách, lọc trạng thái, tìm kiếm, xem chi tiết và đổi trạng thái duyệt đơn.
 */
@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin/orders"})
public class AdminOrderServlet extends HttpServlet {

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

        // Action xem chi tiết đơn hàng
        if ("detail".equalsIgnoreCase(action) || (action == null && request.getParameter("id") != null)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Order order = orderDAO.getOrderById(id);
                if (order == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/orders?err=not_found");
                    return;
                }
                List<OrderItem> items = orderDAO.getOrderItems(id);
                order.setItems(items);

                request.setAttribute("order", order);
                request.setAttribute("activeMenu", "orders");
                request.setAttribute("pageTitle", "Chi Tiết Đơn Hàng #" + order.getOrderCode() + " - Bleezy Admin");
                request.getRequestDispatcher("/WEB-INF/views/admin/order/detail.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?err=invalid_id");
                return;
            }
        }

        // Action xem danh sách đơn hàng
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
        List<Order> orders = orderDAO.getOrders(status, keyword, page, pageSize);
        int totalOrders = orderDAO.countOrders(status, keyword);
        int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
        if (totalPages < 1) totalPages = 1;

        request.setAttribute("orders", orders);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("currentStatus", status);
        request.setAttribute("keyword", keyword);
        request.setAttribute("orderStats", orderStats);

        request.setAttribute("activeMenu", "orders");
        request.setAttribute("pageTitle", "Quản Lý Đơn Hàng - Bleezy Admin");
        request.getRequestDispatcher("/WEB-INF/views/admin/order/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("update-status".equalsIgnoreCase(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                String newStatus = request.getParameter("status");

                if (newStatus != null && !newStatus.trim().isEmpty()) {
                    boolean success = orderDAO.updateOrderStatus(orderId, newStatus.trim().toUpperCase());
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + orderId + "&msg=status_updated");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + orderId + "&err=update_failed");
                    }
                    return;
                }
            } catch (NumberFormatException e) {
                // Ignore and redirect
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/orders");
    }
}
