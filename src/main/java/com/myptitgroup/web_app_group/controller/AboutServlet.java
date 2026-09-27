package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.CompanyInfoDAO;
import com.myptitgroup.web_app_group.model.CompanyInfo;
import com.myptitgroup.web_app_group.model.TeamMember;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller xử lý trang Giới thiệu công ty (URL: /about)
 * Nạp thông tin công ty (company_info) và danh sách chuyên gia kỹ thuật (team_members) từ CSDL.
 */
@WebServlet(name = "AboutServlet", urlPatterns = {"/about"})
public class AboutServlet extends HttpServlet {

    private final CompanyInfoDAO companyInfoDAO = new CompanyInfoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 1. Lấy thông tin công ty CMS
        CompanyInfo companyInfo = companyInfoDAO.getCompanyInfo();

        // 2. Lấy danh sách nhân sự / chuyên gia kỹ thuật đang hoạt động
        List<TeamMember> teamMembers = companyInfoDAO.getActiveTeamMembers();

        // 3. Đưa dữ liệu vào Request Attributes
        request.setAttribute("companyInfo", companyInfo);
        request.setAttribute("teamMembers", teamMembers);
        request.setAttribute("pageTitle", "Về chúng tôi - Bleezy Security");
        request.setAttribute("activeMenu", "about");

        // 4. Forward sang View about.jsp
        request.getRequestDispatcher("/about.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
