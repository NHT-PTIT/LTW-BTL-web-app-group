package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.model.ContactInquiry;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller quản lý Yêu cầu tư vấn & Liên hệ cho Quản trị viên (/admin/contacts)
 * Hỗ trợ: Danh sách liên hệ, lọc theo trạng thái (NEW, PROCESSING, RESOLVED), đổi trạng thái và ghi chú tư vấn.
 */
@WebServlet(name = "AdminContactServlet", urlPatterns = {"/admin/contacts"})
public class AdminContactServlet extends HttpServlet {

    private final ContactDAO contactDAO = new ContactDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Badge counters for sidebar
        Map<String, Integer> orderStats = orderDAO.getOrderStatistics();
        int pendingOrderCount = orderStats.getOrDefault("PENDING", 0);
        int newInquiryCount = contactDAO.countInquiries("NEW");
        request.setAttribute("pendingOrderCount", pendingOrderCount);
        request.setAttribute("newInquiryCount", newInquiryCount);

        String status = request.getParameter("status");
        if (status == null || status.trim().isEmpty()) {
            status = "ALL";
        }

        int page = 1;
        try {
            String pStr = request.getParameter("page");
            if (pStr != null && !pStr.trim().isEmpty()) {
                page = Math.max(1, Integer.parseInt(pStr.trim()));
            }
        } catch (NumberFormatException ignored) {}

        int pageSize = 10;
        List<ContactInquiry> inquiries = contactDAO.getInquiries(status, page, pageSize);
        int totalInquiries = contactDAO.countInquiries(status);
        int totalPages = (int) Math.ceil((double) totalInquiries / pageSize);
        if (totalPages < 1) totalPages = 1;

        int totalAll = contactDAO.countInquiries(null);
        int countNew = newInquiryCount;
        int countProcessing = contactDAO.countInquiries("PROCESSING");
        int countResolved = contactDAO.countInquiries("RESOLVED");

        request.setAttribute("inquiries", inquiries);
        request.setAttribute("totalInquiries", totalInquiries);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("currentStatus", status);

        request.setAttribute("totalAll", totalAll);
        request.setAttribute("countNew", countNew);
        request.setAttribute("countProcessing", countProcessing);
        request.setAttribute("countResolved", countResolved);

        request.setAttribute("activeMenu", "contacts");
        request.setAttribute("pageTitle", "Yêu Cầu Tư Vấn & Liên Hệ - Bleezy Admin");
        request.getRequestDispatcher("/WEB-INF/views/admin/contact/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            String adminNotes = request.getParameter("adminNotes");

            boolean ok = contactDAO.updateStatus(id, status, adminNotes);
            if (ok) {
                response.sendRedirect(request.getContextPath() + "/admin/contacts?msg=status_updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/contacts?err=update_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/contacts?err=invalid_input");
        }
    }
}
