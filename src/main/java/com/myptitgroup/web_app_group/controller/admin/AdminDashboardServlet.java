package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.dao.ProductDAO;
import com.myptitgroup.web_app_group.model.Order;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller hiển thị Bảng điều khiển tổng quan (Dashboard) cho Quản trị viên
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Thống kê đơn hàng theo trạng thái
        Map<String, Integer> orderStats = orderDAO.getOrderStatistics();

        // Danh sách 5 đơn hàng mới nhất
        List<Order> recentOrders = orderDAO.getOrders(null, null, 1, 5);

        // Tổng số sản phẩm trong hệ thống
        int totalProducts = productDAO.countFilteredProducts(null, null, null, null, null, null, null);

        // Tổng số liên hệ/tư vấn
        int totalInquiries = contactDAO.countInquiries(null);

        request.setAttribute("orderStats", orderStats);
        request.setAttribute("recentOrders", recentOrders);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalInquiries", totalInquiries);
        request.setAttribute("activeMenu", "dashboard");
        request.setAttribute("pageTitle", "Bảng Điều Khiển Quản Trị - PTIT Tech");

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
