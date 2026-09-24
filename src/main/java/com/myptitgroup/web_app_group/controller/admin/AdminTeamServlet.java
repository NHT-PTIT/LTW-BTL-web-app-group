package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.CompanyInfoDAO;
import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.model.TeamMember;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller Admin Quản lý Đội ngũ Nhân sự / Chuyên gia (CMS Team Members)
 * URL: /admin/team
 */
@WebServlet(name = "AdminTeamServlet", urlPatterns = {"/admin/team"})
public class AdminTeamServlet extends HttpServlet {

    private final CompanyInfoDAO companyInfoDAO = new CompanyInfoDAO();
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
        String action = request.getParameter("action");

        // Action: Form thêm mới thành viên
        if ("add".equalsIgnoreCase(action)) {
            request.setAttribute("member", new TeamMember());
            request.setAttribute("isEdit", false);
            request.setAttribute("activeMenu", "team");
            request.setAttribute("pageTitle", "Thêm Thành Viên Mới - Bleezy Admin");
            request.getRequestDispatcher("/WEB-INF/views/admin/cms/team-form.jsp").forward(request, response);
            return;
        }

        // Action: Form sửa thông tin thành viên
        if ("edit".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                TeamMember member = companyInfoDAO.getTeamMemberById(id);
                if (member == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/team?err=not_found");
                    return;
                }
                request.setAttribute("member", member);
                request.setAttribute("isEdit", true);
                request.setAttribute("activeMenu", "team");
                request.setAttribute("pageTitle", "Sửa Nhân Sự: " + member.getFullName() + " - Bleezy Admin");
                request.getRequestDispatcher("/WEB-INF/views/admin/cms/team-form.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/team?err=invalid_id");
                return;
            }
        }

        // Action: Xóa thành viên
        if ("delete".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean ok = companyInfoDAO.deleteTeamMember(id);
                if (ok) {
                    response.sendRedirect(request.getContextPath() + "/admin/team?msg=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/team?err=delete_failed");
                }
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/team?err=invalid_id");
                return;
            }
        }

        // Mặc định: Danh sách thành viên
        List<TeamMember> members = companyInfoDAO.getAllTeamMembers();
        request.setAttribute("members", members);
        request.setAttribute("activeMenu", "team");
        request.setAttribute("pageTitle", "Quản Lý Đội Ngũ Nhân Sự - Bleezy Admin");
        request.getRequestDispatcher("/WEB-INF/views/admin/cms/team-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            String idStr = request.getParameter("id");
            boolean isEdit = (idStr != null && !idStr.trim().isEmpty() && !"0".equals(idStr.trim()));

            String fullName = request.getParameter("fullName") != null ? request.getParameter("fullName").trim() : "";
            String position = request.getParameter("position") != null ? request.getParameter("position").trim() : "";
            String avatarUrl = request.getParameter("avatarUrl") != null ? request.getParameter("avatarUrl").trim() : "";
            String bio = request.getParameter("bio") != null ? request.getParameter("bio").trim() : "";
            String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
            
            int sortOrder = 0;
            try {
                String so = request.getParameter("sortOrder");
                if (so != null && !so.trim().isEmpty()) {
                    sortOrder = Integer.parseInt(so.trim());
                }
            } catch (NumberFormatException ignored) {}

            boolean isActive = "1".equals(request.getParameter("isActive")) || "true".equalsIgnoreCase(request.getParameter("isActive")) || "on".equalsIgnoreCase(request.getParameter("isActive"));

            TeamMember m = new TeamMember();
            m.setFullName(fullName);
            m.setPosition(position);
            m.setAvatarUrl(avatarUrl);
            m.setBio(bio);
            m.setEmail(email);
            m.setSortOrder(sortOrder);
            m.setActive(isActive);

            boolean ok;
            if (isEdit) {
                m.setId(Integer.parseInt(idStr.trim()));
                ok = companyInfoDAO.updateTeamMember(m);
            } else {
                ok = companyInfoDAO.insertTeamMember(m);
            }

            if (ok) {
                response.sendRedirect(request.getContextPath() + "/admin/team?msg=saved");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/team?err=save_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/team?err=server_error");
        }
    }
}
