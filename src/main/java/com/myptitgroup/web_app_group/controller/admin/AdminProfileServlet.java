package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.AdminDAO;
import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.model.Admin;
import com.myptitgroup.web_app_group.util.PasswordUtil;
import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controller Quản lý Hồ sơ Quản trị viên & Đổi mật khẩu Admin an toàn
 * URL: /admin/profile, /admin/change-password
 */
@WebServlet(name = "AdminProfileServlet", urlPatterns = {"/admin/profile", "/admin/change-password"})
public class AdminProfileServlet extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final ContactDAO contactDAO = new ContactDAO();

    private void setSidebarBadges(HttpServletRequest request) {
        try {
            Map<String, Integer> orderStats = orderDAO.getOrderStatistics();
            request.setAttribute("pendingOrderCount", orderStats != null ? orderStats.getOrDefault("PENDING", 0) : 0);
        } catch (Throwable t) {
            request.setAttribute("pendingOrderCount", 0);
        }
        try {
            request.setAttribute("newInquiryCount", contactDAO.countInquiries("NEW"));
        } catch (Throwable t) {
            request.setAttribute("newInquiryCount", 0);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        setSidebarBadges(request);

        HttpSession session = request.getSession(false);
        Admin currentAdmin = (session != null) ? (Admin) session.getAttribute("currentAdmin") : null;
        if (currentAdmin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // Lấy thông tin mới nhất từ DB
        Admin fresh = adminDAO.getById(currentAdmin.getId());
        if (fresh != null) {
            currentAdmin = fresh;
            session.setAttribute("currentAdmin", fresh);
        }

        request.setAttribute("admin", currentAdmin);
        request.setAttribute("activeMenu", "profile");
        request.setAttribute("pageTitle", "Hồ Sơ & Đổi Mật Khẩu Admin - Bleezy Admin");
        request.getRequestDispatcher("/WEB-INF/views/admin/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        Admin currentAdmin = (session != null) ? (Admin) session.getAttribute("currentAdmin") : null;
        if (currentAdmin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");

        // 1. Cập nhật hồ sơ cá nhân
        if ("update-profile".equalsIgnoreCase(action)) {
            String fullName = request.getParameter("fullName") != null ? request.getParameter("fullName").trim() : "";
            String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
            String phone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : "";

            if (fullName.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/profile?err=name_required");
                return;
            }

            currentAdmin.setFullName(fullName);
            currentAdmin.setEmail(email);
            currentAdmin.setPhone(phone);

            boolean ok = adminDAO.updateProfile(currentAdmin);
            if (ok) {
                session.setAttribute("currentAdmin", currentAdmin);
                response.sendRedirect(request.getContextPath() + "/admin/profile?msg=profile_updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/profile?err=update_failed");
            }
            return;
        }

        // 2. Đổi mật khẩu
        if ("change-password".equalsIgnoreCase(action)) {
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (oldPassword == null || oldPassword.trim().isEmpty() ||
                newPassword == null || newPassword.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/profile?err=empty_fields#password-section");
                return;
            }

            if (newPassword.length() < 6) {
                response.sendRedirect(request.getContextPath() + "/admin/profile?err=password_too_short#password-section");
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect(request.getContextPath() + "/admin/profile?err=password_mismatch#password-section");
                return;
            }

            // Kiểm tra mật khẩu cũ
            Admin fresh = adminDAO.getById(currentAdmin.getId());
            if (fresh == null || !PasswordUtil.checkPassword(oldPassword, fresh.getPasswordHash())) {
                response.sendRedirect(request.getContextPath() + "/admin/profile?err=wrong_old_password#password-section");
                return;
            }

            // Mã hóa mật khẩu mới bằng BCrypt và lưu CSDL
            String newHash = PasswordUtil.hashPassword(newPassword);
            boolean ok = adminDAO.updatePassword(currentAdmin.getId(), newHash);
            if (ok) {
                fresh.setPasswordHash(newHash);
                session.setAttribute("currentAdmin", fresh);
                response.sendRedirect(request.getContextPath() + "/admin/profile?msg=password_changed#password-section");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/profile?err=change_failed#password-section");
            }
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/profile");
    }
}
