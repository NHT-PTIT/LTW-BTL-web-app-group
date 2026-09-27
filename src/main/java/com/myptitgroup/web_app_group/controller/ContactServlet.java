package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.CompanyInfoDAO;
import com.myptitgroup.web_app_group.dao.ContactDAO;
import com.myptitgroup.web_app_group.model.CompanyInfo;
import com.myptitgroup.web_app_group.model.ContactInquiry;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller xử lý luồng Liên hệ & Tư vấn kỹ thuật (URL: /contact)
 * Hỗ trợ: GET nạp thông tin công ty và render trang; POST nhận form và lưu vào CSDL contact_inquiries.
 */
@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {

    private final ContactDAO contactDAO = new ContactDAO();
    private final CompanyInfoDAO companyInfoDAO = new CompanyInfoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        CompanyInfo companyInfo = companyInfoDAO.getCompanyInfo();
        request.setAttribute("companyInfo", companyInfo);
        request.setAttribute("pageTitle", "Liên hệ & Tư vấn an ninh - Bleezy Security");
        request.setAttribute("activeMenu", "contact");

        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Giữ lại input phòng trường hợp nhập thiếu
        request.setAttribute("formFullName", fullName);
        request.setAttribute("formEmail", email);
        request.setAttribute("formPhone", phone);
        request.setAttribute("formSubject", subject);
        request.setAttribute("formMessage", message);

        // Validation kiểm tra
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ các trường bắt buộc (*): Họ tên, Email, Số điện thoại và Nội dung!");
            doGet(request, response);
            return;
        }

        fullName = fullName.trim();
        email = email.trim();
        phone = phone.trim();
        message = message.trim();
        if (subject != null) {
            subject = subject.trim();
        }
        if (subject == null || subject.isEmpty()) {
            subject = "Yêu cầu tư vấn thiết bị & báo giá";
        }

        // Kiểm tra cơ bản SĐT
        if (!phone.matches("^[0-9+()\\s.-]{8,20}$")) {
            request.setAttribute("errorMessage", "Số điện thoại không đúng định dạng. Vui lòng kiểm tra lại!");
            doGet(request, response);
            return;
        }

        // Tạo ContactInquiry mới
        ContactInquiry inquiry = new ContactInquiry();
        inquiry.setFullName(fullName);
        inquiry.setEmail(email);
        inquiry.setPhone(phone);
        inquiry.setSubject(subject);
        inquiry.setMessage(message);
        inquiry.setStatus("NEW");

        boolean success = contactDAO.insert(inquiry);
        if (success) {
            response.sendRedirect(request.getContextPath() + "/contact?msg=sent_success");
        } else {
            request.setAttribute("errorMessage", "Hệ thống đang bận. Không thể gửi yêu cầu lúc này, vui lòng thử lại sau!");
            doGet(request, response);
        }
    }
}
