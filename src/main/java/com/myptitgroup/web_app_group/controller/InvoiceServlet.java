package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.CompanyInfoDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.model.CompanyInfo;
import com.myptitgroup.web_app_group.model.Order;
import com.myptitgroup.web_app_group.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controller xuất / in Hóa đơn bán lẻ & Phiếu xuất kho chuẩn A4
 * Hỗ trợ in cho cả Khách hàng và Quản trị viên (Admin).
 * URL: /invoice, /order/invoice
 */
@WebServlet(name = "InvoiceServlet", urlPatterns = {"/invoice", "/order/invoice"})
public class InvoiceServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final CompanyInfoDAO companyInfoDAO = new CompanyInfoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String idParam = request.getParameter("id");
        String codeParam = request.getParameter("code");

        Order order = null;

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int orderId = Integer.parseInt(idParam.trim());
                order = orderDAO.getOrderById(orderId);
            } catch (NumberFormatException ignored) {}
        } else if (codeParam != null && !codeParam.trim().isEmpty()) {
            order = orderDAO.getOrderByCode(codeParam.trim());
        }

        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Kiểm tra phân quyền truy cập
        HttpSession session = request.getSession(false);
        boolean isAdmin = (session != null && session.getAttribute("currentAdmin") != null);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        // Cho phép nếu là Admin, hoặc tra cứu bằng mã code cụ thể, hoặc là chủ sở hữu đơn hàng
        boolean isOwner = (currentUser != null && order.getUserId() != null && order.getUserId().equals(currentUser.getId()));
        boolean hasCodeAccess = (codeParam != null && !codeParam.trim().isEmpty() && order.getOrderCode().equalsIgnoreCase(codeParam.trim()));

        if (!isAdmin && !isOwner && !hasCodeAccess) {
            // Khách vãng lai nhưng biết ID mà không có code và không đăng nhập
            if (currentUser == null) {
                response.sendRedirect(request.getContextPath() + "/login?redirect=" + request.getRequestURI());
            } else {
                response.sendRedirect(request.getContextPath() + "/account/orders");
            }
            return;
        }

        CompanyInfo companyInfo = companyInfoDAO.getCompanyInfo();
        if (companyInfo == null) {
            companyInfo = new CompanyInfo();
            companyInfo.setCompanyName("BLEEZY SOLAR & INVERTER");
            companyInfo.setHotline("1900 6868 - 0988 123 456");
            companyInfo.setEmail("contact@bleezysolar.vn");
            companyInfo.setAddress("Km10, Đường Nguyễn Trãi, Q. Thanh Xuân, TP. Hà Nội");
        }

        request.setAttribute("order", order);
        request.setAttribute("companyInfo", companyInfo);
        request.setAttribute("isAdmin", isAdmin);

        request.getRequestDispatcher("/invoice-print.jsp").forward(request, response);
    }
}
