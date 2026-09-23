package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.model.Cart;
import com.myptitgroup.web_app_group.model.CartItem;
import com.myptitgroup.web_app_group.model.Order;
import com.myptitgroup.web_app_group.model.OrderItem;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.myptitgroup.web_app_group.model.User;

/**
 * Controller xử lý luồng Thanh toán & Đặt hàng (URL: /checkout)
 * Kiểm tra giỏ hàng, nhận form thông tin giao nhận, gọi OrderDAO Transaction và chuyển hướng sang Order Success.
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Cart cart = (session != null) ? (Cart) session.getAttribute("cart") : null;

        // Nếu giỏ hàng chưa có hoặc rỗng thì chuyển về /cart
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?msg=empty_cart");
            return;
        }

        // Nếu người dùng đã đăng nhập và chưa có giá trị input điền sẵn, tự động điền thông tin tài khoản
        if (session != null) {
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser != null) {
                if (request.getAttribute("customerName") == null) {
                    request.setAttribute("customerName", currentUser.getFullName());
                }
                if (request.getAttribute("customerPhone") == null) {
                    request.setAttribute("customerPhone", currentUser.getPhone());
                }
                if (request.getAttribute("customerEmail") == null) {
                    request.setAttribute("customerEmail", currentUser.getEmail());
                }
                if (request.getAttribute("shippingAddress") == null) {
                    request.setAttribute("shippingAddress", currentUser.getAddress());
                }
            }
        }

        request.setAttribute("pageTitle", "Thanh toán & Đặt hàng - Bleezy Inverter & Solar Power");
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        Cart cart = (session != null) ? (Cart) session.getAttribute("cart") : null;

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?msg=empty_cart");
            return;
        }

        // Lấy dữ liệu từ form thanh toán
        String customerName = request.getParameter("customerName");
        String customerPhone = request.getParameter("customerPhone");
        String customerEmail = request.getParameter("customerEmail");
        String shippingAddress = request.getParameter("shippingAddress");
        String city = request.getParameter("city");
        String note = request.getParameter("note");
        String paymentMethod = request.getParameter("paymentMethod");

        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "COD";
        }

        // Ghép tỉnh thành nếu có
        String fullAddress = shippingAddress != null ? shippingAddress.trim() : "";
        if (city != null && !city.trim().isEmpty() && !fullAddress.toLowerCase().contains(city.trim().toLowerCase())) {
            fullAddress += ", " + city.trim();
        }

        // Validation kiểm tra hợp lệ
        if (customerName == null || customerName.trim().isEmpty() ||
            customerPhone == null || customerPhone.trim().isEmpty() ||
            fullAddress.isEmpty()) {

            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ các trường bắt buộc (*): Họ tên, Số điện thoại và Địa chỉ!");
            request.setAttribute("customerName", customerName);
            request.setAttribute("customerPhone", customerPhone);
            request.setAttribute("customerEmail", customerEmail);
            request.setAttribute("shippingAddress", shippingAddress);
            request.setAttribute("city", city);
            request.setAttribute("note", note);
            request.setAttribute("paymentMethod", paymentMethod);
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
            return;
        }

        // Chuẩn bị Order object
        Order order = new Order();
        if (session != null) {
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser != null) {
                order.setUserId(currentUser.getId());
            }
        }
        order.setCustomerName(customerName.trim());
        order.setCustomerPhone(customerPhone.trim());
        order.setCustomerEmail(customerEmail != null ? customerEmail.trim() : "");
        order.setShippingAddress(fullAddress);
        order.setNote(note != null ? note.trim() : "");
        order.setTotalAmount(cart.getTotalAmount());
        order.setPaymentMethod(paymentMethod.trim());
        order.setStatus("PENDING");

        // Chuẩn bị danh sách OrderItem từ Cart
        List<OrderItem> items = new ArrayList<>();
        for (CartItem ci : cart.getItems()) {
            OrderItem oi = new OrderItem();
            if (ci.getProduct() != null) {
                oi.setProductId(ci.getProduct().getId());
                oi.setProductSku(ci.getProduct().getSku());
                oi.setProductName(ci.getProduct().getName());
                oi.setProductImage(ci.getProduct().getMainImageUrl());
                oi.setUnitPrice(ci.getProduct().getEffectivePrice());
            }
            oi.setQuantity(ci.getQuantity());
            oi.setSubtotal(ci.getSubtotal());
            items.add(oi);
        }

        // Ghi vào CSDL bằng Transaction
        boolean created = orderDAO.createOrder(order, items);

        if (created && order.getOrderCode() != null) {
            // Xóa sạch giỏ hàng trong session
            cart.clear();

            // Chuyển hướng tới trang xác nhận đặt hàng thành công
            response.sendRedirect(request.getContextPath() + "/order-success?orderCode=" + order.getOrderCode());
        } else {
            request.setAttribute("errorMessage", "Không thể xử lý đơn hàng lúc này do lỗi hệ thống CSDL. Vui lòng thử lại!");
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        }
    }
}
