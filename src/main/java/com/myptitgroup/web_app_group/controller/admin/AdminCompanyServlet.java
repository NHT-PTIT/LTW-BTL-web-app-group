package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.CompanyInfoDAO;
import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.model.CompanyInfo;
import java.io.IOException;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller Admin Quản lý Thông tin Doanh nghiệp / Giới thiệu / Liên hệ (CMS)
 * URL: /admin/company
 */
@WebServlet(name = "AdminCompanyServlet", urlPatterns = {"/admin/company"})
public class AdminCompanyServlet extends HttpServlet {

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

        CompanyInfo info = companyInfoDAO.getCompanyInfo();
        if (info == null) {
            info = new CompanyInfo();
            info.setId(1);
            info.setCompanyName("Bleezy Security Solutions");
            info.setHotline("1900 6868");
            info.setEmail("contact@bleezysecurity.vn");
            info.setAddress("Hà Nội, Việt Nam");
        }

        request.setAttribute("company", info);
        request.setAttribute("activeMenu", "company");
        request.setAttribute("pageTitle", "Cài Đặt Thông Tin Công Ty - Bleezy Admin");
        request.getRequestDispatcher("/WEB-INF/views/admin/cms/company.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            int id = 1;
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    id = Integer.parseInt(idStr.trim());
                } catch (NumberFormatException ignored) {}
            }

            CompanyInfo info = new CompanyInfo();
            info.setId(id);
            info.setCompanyName(request.getParameter("companyName"));
            info.setSlogan(request.getParameter("slogan"));
            info.setHotline(request.getParameter("hotline"));
            info.setEmail(request.getParameter("email"));
            info.setAddress(request.getParameter("address"));
            info.setAboutSummary(request.getParameter("aboutSummary"));
            info.setAboutDetail(request.getParameter("aboutDetail"));
            info.setVision(request.getParameter("vision"));
            info.setMission(request.getParameter("mission"));
            info.setCoreValues(request.getParameter("coreValues"));
            info.setLogoUrl(request.getParameter("logoUrl"));
            info.setFacebookUrl(request.getParameter("facebookUrl"));
            info.setYoutubeUrl(request.getParameter("youtubeUrl"));
            info.setWorkingHours(request.getParameter("workingHours"));
            info.setBankName(request.getParameter("bankName"));
            info.setBankAccountNo(request.getParameter("bankAccountNo"));
            info.setBankAccountName(request.getParameter("bankAccountName"));

            boolean ok = companyInfoDAO.updateCompanyInfo(info);
            if (ok) {
                response.sendRedirect(request.getContextPath() + "/admin/company?msg=saved");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/company?err=save_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/company?err=server_error");
        }
    }
}
