package com.myptitgroup.web_app_group.controller.admin;

import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.dao.CouponDAO;
import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.model.Coupon;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller quản lý Mã giảm giá / Voucher cho Quản trị viên (/admin/coupons)
 */
@WebServlet(name = "AdminCouponServlet", urlPatterns = {"/admin/coupons"})
public class AdminCouponServlet extends HttpServlet {

    private final CouponDAO couponDAO = new CouponDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Badge counters for sidebar
        Map<String, Integer> orderStats = orderDAO.getOrderStatistics();
        request.setAttribute("pendingOrderCount", orderStats.getOrDefault("PENDING", 0));
        request.setAttribute("newInquiryCount", contactDAO.countInquiries("NEW"));

        String action = request.getParameter("action");

        // Action: Form Thêm Mới
        if ("add".equalsIgnoreCase(action)) {
            Coupon c = new Coupon();
            c.setUsageLimit(100);
            c.setActive(true);
            request.setAttribute("coupon", c);
            request.setAttribute("isEdit", false);
            request.setAttribute("activeMenu", "coupons");
            request.setAttribute("pageTitle", "Tạo Mã Giảm Giá Mới - Bleezy Admin");
            request.getRequestDispatcher("/WEB-INF/views/admin/coupon/form.jsp").forward(request, response);
            return;
        }

        // Action: Form Sửa
        if ("edit".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Coupon c = couponDAO.getCouponById(id);
                if (c == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/coupons?err=not_found");
                    return;
                }
                request.setAttribute("coupon", c);
                request.setAttribute("isEdit", true);
                request.setAttribute("activeMenu", "coupons");
                request.setAttribute("pageTitle", "Chỉnh Sửa Mã #" + c.getCode() + " - Bleezy Admin");
                request.getRequestDispatcher("/WEB-INF/views/admin/coupon/form.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/coupons?err=invalid_id");
                return;
            }
        }

        // Action: Xóa
        if ("delete".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                couponDAO.delete(id);
                response.sendRedirect(request.getContextPath() + "/admin/coupons?msg=deleted");
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/coupons?err=invalid_id");
                return;
            }
        }

        // Action: Bật / Tắt trạng thái
        if ("toggle".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Coupon c = couponDAO.getCouponById(id);
                if (c != null) {
                    c.setActive(!c.isActive());
                    couponDAO.update(c);
                }
                response.sendRedirect(request.getContextPath() + "/admin/coupons?msg=toggled");
                return;
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/coupons?err=invalid_id");
                return;
            }
        }

        // Mặc định: Danh sách coupons
        List<Coupon> coupons = couponDAO.getAllCoupons();
        request.setAttribute("coupons", coupons);
        request.setAttribute("activeMenu", "coupons");
        request.setAttribute("pageTitle", "Quản Lý Mã Giảm Giá - Bleezy Admin");
        request.getRequestDispatcher("/WEB-INF/views/admin/coupon/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("id");
        boolean isEdit = (idStr != null && !idStr.trim().isEmpty() && !"0".equals(idStr.trim()));
        int id = isEdit ? Integer.parseInt(idStr.trim()) : 0;

        String code = request.getParameter("code");
        String description = request.getParameter("description");
        String discountType = request.getParameter("discountType");
        String discountValueStr = request.getParameter("discountValue");
        String minOrderAmountStr = request.getParameter("minOrderAmount");
        String maxDiscountAmountStr = request.getParameter("maxDiscountAmount");
        String usageLimitStr = request.getParameter("usageLimit");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        boolean isActive = "1".equals(request.getParameter("isActive")) || "true".equalsIgnoreCase(request.getParameter("isActive"));

        // Validation
        if (code == null || code.trim().isEmpty() || discountValueStr == null || discountValueStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ Mã code và Giá trị giảm giá!");
            Coupon c = populateCoupon(id, code, description, discountType, discountValueStr, minOrderAmountStr, maxDiscountAmountStr, usageLimitStr, startDateStr, endDateStr, isActive);
            request.setAttribute("coupon", c);
            request.setAttribute("isEdit", isEdit);
            request.setAttribute("activeMenu", "coupons");
            request.setAttribute("pageTitle", (isEdit ? "Chỉnh Sửa" : "Tạo Mới") + " Mã Giảm Giá");
            request.getRequestDispatcher("/WEB-INF/views/admin/coupon/form.jsp").forward(request, response);
            return;
        }

        String normalizedCode = code.trim().toUpperCase();
        Coupon existing = couponDAO.getCouponByCode(normalizedCode);
        if (existing != null && (!isEdit || existing.getId() != id)) {
            request.setAttribute("errorMessage", "Mã giảm giá [" + normalizedCode + "] đã tồn tại trên hệ thống. Vui lòng chọn mã khác!");
            Coupon c = populateCoupon(id, code, description, discountType, discountValueStr, minOrderAmountStr, maxDiscountAmountStr, usageLimitStr, startDateStr, endDateStr, isActive);
            request.setAttribute("coupon", c);
            request.setAttribute("isEdit", isEdit);
            request.setAttribute("activeMenu", "coupons");
            request.setAttribute("pageTitle", (isEdit ? "Chỉnh Sửa" : "Tạo Mới") + " Mã Giảm Giá");
            request.getRequestDispatcher("/WEB-INF/views/admin/coupon/form.jsp").forward(request, response);
            return;
        }

        Coupon coupon = populateCoupon(id, normalizedCode, description, discountType, discountValueStr, minOrderAmountStr, maxDiscountAmountStr, usageLimitStr, startDateStr, endDateStr, isActive);

        boolean success;
        if (isEdit) {
            // Giữ nguyên usedCount cũ
            if (existing != null) {
                coupon.setUsedCount(existing.getUsedCount());
            } else {
                Coupon old = couponDAO.getCouponById(id);
                if (old != null) coupon.setUsedCount(old.getUsedCount());
            }
            success = couponDAO.update(coupon);
        } else {
            success = couponDAO.insert(coupon);
        }

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/coupons?msg=saved");
        } else {
            request.setAttribute("errorMessage", "Lỗi lưu CSDL! Vui lòng thử lại.");
            request.setAttribute("coupon", coupon);
            request.setAttribute("isEdit", isEdit);
            request.setAttribute("activeMenu", "coupons");
            request.getRequestDispatcher("/WEB-INF/views/admin/coupon/form.jsp").forward(request, response);
        }
    }

    private Coupon populateCoupon(int id, String code, String description, String discountType, 
                                   String discountValueStr, String minOrderAmountStr, String maxDiscountAmountStr, 
                                   String usageLimitStr, String startDateStr, String endDateStr, boolean isActive) {
        Coupon c = new Coupon();
        c.setId(id);
        c.setCode(code != null ? code.trim().toUpperCase() : "");
        c.setDescription(description != null ? description.trim() : "");
        c.setDiscountType("FIXED".equalsIgnoreCase(discountType) ? "FIXED" : "PERCENT");

        try {
            c.setDiscountValue(new BigDecimal(discountValueStr.trim().replace(",", "")));
        } catch (Exception e) {
            c.setDiscountValue(BigDecimal.ZERO);
        }

        try {
            if (minOrderAmountStr != null && !minOrderAmountStr.trim().isEmpty()) {
                c.setMinOrderAmount(new BigDecimal(minOrderAmountStr.trim().replace(",", "")));
            } else {
                c.setMinOrderAmount(BigDecimal.ZERO);
            }
        } catch (Exception e) {
            c.setMinOrderAmount(BigDecimal.ZERO);
        }

        try {
            if (maxDiscountAmountStr != null && !maxDiscountAmountStr.trim().isEmpty()) {
                c.setMaxDiscountAmount(new BigDecimal(maxDiscountAmountStr.trim().replace(",", "")));
            }
        } catch (Exception ignored) {}

        try {
            c.setUsageLimit(Integer.parseInt(usageLimitStr.trim()));
        } catch (Exception e) {
            c.setUsageLimit(100);
        }

        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
        try {
            if (startDateStr != null && !startDateStr.trim().isEmpty()) {
                Date d = sdfDate.parse(startDateStr.trim());
                c.setStartDate(new Timestamp(d.getTime()));
            }
        } catch (Exception ignored) {}

        try {
            if (endDateStr != null && !endDateStr.trim().isEmpty()) {
                Date d = sdfDate.parse(endDateStr.trim());
                // Set to 23:59:59 of end date
                c.setEndDate(new Timestamp(d.getTime() + (24 * 60 * 60 * 1000 - 1000)));
            }
        } catch (Exception ignored) {}

        c.setActive(isActive);
        return c;
    }
}
