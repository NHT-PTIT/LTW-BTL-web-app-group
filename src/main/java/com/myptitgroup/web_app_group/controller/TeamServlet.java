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
 * Controller xử lý trang Đội ngũ kỹ thuật & Nhân sự (URL: /team)
 * Nạp danh sách chuyên gia kỹ thuật và thông tin hỗ trợ từ CSDL.
 */
@WebServlet(name = "TeamServlet", urlPatterns = {"/team"})
public class TeamServlet extends HttpServlet {

    private final CompanyInfoDAO companyInfoDAO = new CompanyInfoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 1. Lấy danh sách đội ngũ kỹ sư đang hoạt động
        List<TeamMember> teamMembers = companyInfoDAO.getActiveTeamMembers();

        // 2. Lấy thông tin công ty CMS
        CompanyInfo companyInfo = companyInfoDAO.getCompanyInfo();

        // 3. Đưa dữ liệu vào Request Attributes
        request.setAttribute("teamMembers", teamMembers);
        request.setAttribute("companyInfo", companyInfo);
        request.setAttribute("pageTitle", "Đội ngũ chuyên gia kỹ thuật - Bleezy Inverter & Solar Power");
        request.setAttribute("activeMenu", "pages");

        // 4. Forward sang View team.jsp
        request.getRequestDispatcher("/team.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
