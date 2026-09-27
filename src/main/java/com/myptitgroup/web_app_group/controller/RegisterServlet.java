package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.UserDAO;
import com.myptitgroup.web_app_group.model.User;
import com.myptitgroup.web_app_group.util.SecurityUtils;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controller xử lý Đăng ký tài khoản thành viên mới (/register)
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            response.sendRedirect(request.getContextPath() + "/account/profile");
            return;
        }

        request.setAttribute("pageTitle", "Đăng ký tài khoản - Bleezy Security");
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Giữ lại giá trị input khi có lỗi
        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.setAttribute("fullName", fullName);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);

        // Validation kiểm tra hợp lệ
        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            fullName == null || fullName.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "Vui lòng điền đầy đủ các thông tin bắt buộc (*)");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        username = username.trim();
        email = email.trim().toLowerCase();
        fullName = fullName.trim();

        if (username.length() < 3 || username.contains(" ")) {
            request.setAttribute("error", "Tên đăng nhập phải có ít nhất 3 ký tự và không chứa khoảng trắng!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có độ dài tối thiểu 6 ký tự!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra trùng lặp
        if (userDAO.existsByUsername(username)) {
            request.setAttribute("error", "Tên đăng nhập '" + username + "' đã được sử dụng. Vui lòng chọn tên khác!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.existsByEmail(email)) {
            request.setAttribute("error", "Địa chỉ email '" + email + "' đã được đăng ký!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.getLastError() != null) {
            request.setAttribute("error", "Lỗi kết nối cơ sở dữ liệu: " + userDAO.getLastError());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Tạo user mới
        String passwordHash = SecurityUtils.hashPassword(password);
        User newUser = new User(username, passwordHash, fullName, email, phone, address);

        boolean success = userDAO.register(newUser);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/login?msg=reg_success");
        } else {
            String errorMsg = "Đăng ký không thành công do lỗi hệ thống.";
            if (userDAO.getLastError() != null && !userDAO.getLastError().trim().isEmpty()) {
                errorMsg += " Chi tiết: " + userDAO.getLastError();
            }
            request.setAttribute("error", errorMsg);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
