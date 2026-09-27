package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.UserDAO;
import com.myptitgroup.web_app_group.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controller xử lý Đăng nhập tài khoản thành viên (/login)
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            String redirect = request.getParameter("redirect");
            if (redirect != null && redirect.startsWith("/") && !redirect.startsWith("//")) {
                response.sendRedirect(request.getContextPath() + redirect);
            } else {
                response.sendRedirect(request.getContextPath() + "/account/profile");
            }
            return;
        }

        request.setAttribute("pageTitle", "Đăng nhập tài khoản - Bleezy Inverter & Solar Power");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String usernameOrEmail = request.getParameter("username");
        String password = request.getParameter("password");
        String redirect = request.getParameter("redirect");

        if (usernameOrEmail == null || usernameOrEmail.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            request.setAttribute("username", usernameOrEmail);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.authenticate(usernameOrEmail.trim(), password);

        if (user == null) {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            request.setAttribute("username", usernameOrEmail);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (!user.isActive()) {
            request.setAttribute("error", "Tài khoản của bạn đã bị tạm khóa. Vui lòng liên hệ hotline 1900 6868 để được hỗ trợ!");
            request.setAttribute("username", usernameOrEmail);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Đăng nhập thành công -> Tạo phiên làm việc mới
        HttpSession session = request.getSession(true);
        session.removeAttribute("currentAdmin"); // Tách biệt phiên làm việc giữa Admin và User
        session.setAttribute("currentUser", user);

        // Điều hướng thông minh
        if (redirect != null && redirect.startsWith("/") && !redirect.startsWith("//")) {
            response.sendRedirect(request.getContextPath() + redirect);
        } else {
            response.sendRedirect(request.getContextPath() + "/account/profile");
        }
    }
}
