package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.AdminDAO;
import com.myptitgroup.web_app_group.model.Admin;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controller xử lý đăng nhập & đăng xuất cho Quản trị viên
 */
@WebServlet(name = "AdminLoginServlet", urlPatterns = {"/admin/login", "/admin/logout"})
public class AdminLoginServlet extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        // Xử lý đăng xuất
        if ("/admin/logout".equals(path)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.removeAttribute("currentAdmin");
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/admin/login?msg=logged_out");
            return;
        }

        // Kiểm tra nếu đã đăng nhập thì chuyển luôn tới Dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("currentAdmin") != null) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        String error = request.getParameter("error");
        if ("unauthorized".equals(error)) {
            request.setAttribute("errorMessage", "Vui lòng đăng nhập để truy cập trang quản trị.");
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Admin admin = adminDAO.authenticate(username, password);

        if (admin != null) {
            // Đăng nhập thành công -> Lưu vào Session
            HttpSession session = request.getSession(true);
            session.setAttribute("currentAdmin", admin);
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            // Đăng nhập thất bại
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("/WEB-INF/views/admin/login.jsp").forward(request, response);
        }
    }
}
