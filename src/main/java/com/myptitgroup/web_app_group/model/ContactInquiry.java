package com.myptitgroup.web_app_group.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 * JavaBean ánh xạ bảng contact_inquiries (Liên hệ & Yêu cầu tư vấn)
 */
public class ContactInquiry implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String fullName;
    private String email;
    private String phone;
    private String subject;
    private String message;
    private String status; // 'NEW', 'PROCESSING', 'RESOLVED'
    private String adminNotes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public ContactInquiry() {
    }

    public ContactInquiry(String fullName, String email, String phone, String subject, String message) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.subject = subject;
        this.message = message;
        this.status = "NEW";
    }

    public String getStatusDisplayName() {
        if (status == null) return "Chưa xử lý";
        switch (status) {
            case "NEW":
                return "Mới tiếp nhận";
            case "PROCESSING":
                return "Đang liên hệ";
            case "RESOLVED":
                return "Đã giải quyết";
            default:
                return status;
        }
    }

    public String getStatusBadgeClass() {
        if (status == null) return "secondary";
        switch (status) {
            case "NEW":
                return "danger";
            case "PROCESSING":
                return "warning";
            case "RESOLVED":
                return "success";
            default:
                return "secondary";
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAdminNotes() {
        return adminNotes;
    }

    public void setAdminNotes(String adminNotes) {
        this.adminNotes = adminNotes;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getFormattedCreatedAt() {
        if (createdAt == null) return "";
        return new SimpleDateFormat("dd/MM/yyyy HH:mm").format(createdAt);
    }
}
