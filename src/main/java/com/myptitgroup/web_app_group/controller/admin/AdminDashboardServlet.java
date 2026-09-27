package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.dao.ProductDAO;
import com.myptitgroup.web_app_group.dao.UserDAO;
import com.myptitgroup.web_app_group.model.Order;
import com.myptitgroup.web_app_group.model.Product;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
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
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin", "/admin/", "/admin/dashboard", "/admin/index"})
public class AdminDashboardServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final ProductDAO productDAO = new ProductDAO();
    private final ContactDAO contactDAO = new ContactDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Thống kê đơn hàng theo trạng thái
        Map<String, Integer> orderStats = orderDAO.getOrderStatistics();
        int pendingOrderCount = orderStats.getOrDefault("PENDING", 0);
        BigDecimal totalRevenue = orderDAO.getTotalRevenue();
        DecimalFormat df = new DecimalFormat("#,### đ");
        String formattedRevenue = df.format(totalRevenue);

        // 2. Danh sách 5 đơn hàng mới nhất
        List<Order> recentOrders = orderDAO.getOrders(null, null, 1, 5);

        // 3. Tổng số sản phẩm trong hệ thống & sản phẩm sắp hết hàng (< 5 chiếc)
        int totalProducts = productDAO.countFilteredProducts(null, null, null, null, null, null, null);
        int lowStockCount = productDAO.countLowStock(5);
        List<Product> lowStockProducts = productDAO.getLowStockProducts(5, 5);

        // 4. Tổng số liên hệ/tư vấn mới & khách hàng
        int totalInquiries = contactDAO.countInquiries(null);
        int newInquiryCount = contactDAO.countInquiries("NEW");
        int totalUsers = userDAO.countUsers();

        request.setAttribute("orderStats", orderStats);
        request.setAttribute("pendingOrderCount", pendingOrderCount);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("formattedRevenue", formattedRevenue);
        request.setAttribute("recentOrders", recentOrders);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("lowStockCount", lowStockCount);
        request.setAttribute("lowStockProducts", lowStockProducts);
        request.setAttribute("totalInquiries", totalInquiries);
        request.setAttribute("newInquiryCount", newInquiryCount);
        request.setAttribute("totalUsers", totalUsers);

        request.setAttribute("activeMenu", "dashboard");
        request.setAttribute("pageTitle", "Bảng Điều Khiển Quản Trị - Bleezy Solar Admin");

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
