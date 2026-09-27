package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.dao.UserDAO;
import com.myptitgroup.web_app_group.model.Order;
import com.myptitgroup.web_app_group.model.User;
import com.myptitgroup.web_app_group.util.SecurityUtils;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controller Quản lý Tài khoản Khách hàng (/account, /account/profile, /account/orders)
 */
@WebServlet(name = "AccountServlet", urlPatterns = {"/account", "/account/profile", "/account/orders", "/account/change-password"})
public class AccountServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            String target = request.getServletPath();
            if (request.getQueryString() != null) {
                target += "?" + request.getQueryString();
            }
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + target);
            return;
        }

        // Luôn làm mới thông tin User từ DB
        User refreshedUser = userDAO.getById(currentUser.getId());
        if (refreshedUser != null) {
            currentUser = refreshedUser;
            session.setAttribute("currentUser", currentUser);
        }

        String servletPath = request.getServletPath();

        // 1. Phân hệ Lịch sử đơn mua (/account/orders)
        if ("/account/orders".equals(servletPath)) {
            String action = request.getParameter("action");
            if ("detail".equalsIgnoreCase(action)) {
                try {
                    int orderId = Integer.parseInt(request.getParameter("id"));
                    Order order = orderDAO.getOrderByIdAndUserId(orderId, currentUser.getId());
                    if (order == null) {
                        response.sendRedirect(request.getContextPath() + "/account/orders?err=not_found");
                        return;
                    }
                    request.setAttribute("orderDetail", order);
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/account/orders?err=invalid_id");
                    return;
                }
            } else {
                List<Order> orders = orderDAO.getOrdersByUserId(currentUser.getId());
                request.setAttribute("orders", orders);
            }

            request.setAttribute("companyInfo", new com.myptitgroup.web_app_group.dao.CompanyInfoDAO().getCompanyInfo());
            request.setAttribute("activeTab", "orders");
            request.setAttribute("pageTitle", "Đơn hàng của tôi - Bleezy Security");
            request.getRequestDispatcher("/account-orders.jsp").forward(request, response);
            return;
        }

        // 2. Mặc định: Phân hệ Hồ sơ cá nhân (/account hoặc /account/profile)
        request.setAttribute("activeTab", "profile");
        request.setAttribute("pageTitle", "Hồ sơ tài khoản - Bleezy Security");
        request.getRequestDispatcher("/account-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        // Action 1: Cập nhật thông tin hồ sơ
        if ("update-profile".equalsIgnoreCase(action)) {
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            if (fullName == null || fullName.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/account/profile?err=empty_name");
                return;
            }

            currentUser.setFullName(fullName.trim());
            currentUser.setPhone(phone != null ? phone.trim() : "");
            currentUser.setAddress(address != null ? address.trim() : "");

            boolean ok = userDAO.updateProfile(currentUser);
            if (ok) {
                session.setAttribute("currentUser", currentUser);
                response.sendRedirect(request.getContextPath() + "/account/profile?msg=profile_updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/account/profile?err=update_failed");
            }
            return;
        }

        // Action 2: Đổi mật khẩu
        if ("change-password".equalsIgnoreCase(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (currentPassword == null || newPassword == null || confirmPassword == null) {
                response.sendRedirect(request.getContextPath() + "/account/profile?err=pwd_missing#pwdSection");
                return;
            }

            // Kiểm tra mật khẩu hiện tại
            if (!SecurityUtils.verifyPassword(currentPassword, currentUser.getPasswordHash())) {
                response.sendRedirect(request.getContextPath() + "/account/profile?err=pwd_incorrect#pwdSection");
                return;
            }

            if (newPassword.length() < 6) {
                response.sendRedirect(request.getContextPath() + "/account/profile?err=pwd_short#pwdSection");
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect(request.getContextPath() + "/account/profile?err=pwd_mismatch#pwdSection");
                return;
            }

            String newHash = SecurityUtils.hashPassword(newPassword);
            boolean ok = userDAO.changePassword(currentUser.getId(), newHash);
            if (ok) {
                currentUser.setPasswordHash(newHash);
                session.setAttribute("currentUser", currentUser);
                response.sendRedirect(request.getContextPath() + "/account/profile?msg=pwd_updated#pwdSection");
            } else {
                response.sendRedirect(request.getContextPath() + "/account/profile?err=pwd_failed#pwdSection");
            }
            return;
        }

        // Action 3: Khách hàng hủy đơn hàng (chỉ khi đơn đang ở trạng thái PENDING)
        if ("cancel-order".equalsIgnoreCase(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                boolean ok = orderDAO.cancelOrder(orderId, currentUser.getId());
                if (ok) {
                    response.sendRedirect(request.getContextPath() + "/account/orders?action=detail&id=" + orderId + "&msg=cancel_success");
                } else {
                    response.sendRedirect(request.getContextPath() + "/account/orders?action=detail&id=" + orderId + "&err=cancel_failed");
                }
                return;
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/account/orders?err=invalid_id");
                return;
            }
        }

        response.sendRedirect(request.getContextPath() + "/account/profile");
    }
}
