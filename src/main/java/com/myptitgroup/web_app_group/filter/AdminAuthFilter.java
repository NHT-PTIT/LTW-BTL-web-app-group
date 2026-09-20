package com.myptitgroup.web_app_group.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Filter bảo vệ phân hệ quản trị Admin
 * Chặn truy cập trái phép vào các đường dẫn /admin/* khi chưa đăng nhập
 */
@WebFilter(filterName = "AdminAuthFilter", urlPatterns = {"/admin/*"})
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        // Cho phép truy cập vào trang login và action xử lý đăng nhập
        if (uri.endsWith("/admin/login") || uri.endsWith("/admin/login.jsp")) {
            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra phiên đăng nhập của Admin
        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("currentAdmin") != null);

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            // Chuyển hướng về trang đăng nhập admin
            res.sendRedirect(contextPath + "/admin/login?error=unauthorized");
        }
    }

    @Override
    public void destroy() {
    }
}
