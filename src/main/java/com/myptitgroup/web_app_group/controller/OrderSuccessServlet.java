package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.model.Order;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller hiển thị trang Xác nhận đặt hàng thành công (URL: /order-success)
 * Nạp thông tin chi tiết đơn hàng thực tế từ CSDL theo orderCode.
 */
@WebServlet(name = "OrderSuccessServlet", urlPatterns = {"/order-success"})
public class OrderSuccessServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderCode = request.getParameter("orderCode");
        if (orderCode == null || orderCode.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        Order order = orderDAO.getOrderByCode(orderCode.trim());
        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/shop");
            return;
        }

        request.setAttribute("order", order);
        com.myptitgroup.web_app_group.dao.CompanyInfoDAO companyInfoDAO = new com.myptitgroup.web_app_group.dao.CompanyInfoDAO();
        request.setAttribute("companyInfo", companyInfoDAO.getCompanyInfo());
        request.setAttribute("pageTitle", "Đặt hàng thành công #" + order.getOrderCode() + " - Bleezy Security");
        request.getRequestDispatcher("/order-success.jsp").forward(request, response);
    }
}
