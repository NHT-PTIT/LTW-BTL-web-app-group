<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div style="display: flex; align-items: center; gap: 14px;">
            <div>
                <div class="admin-topbar-title">CÀI ĐẶT THÔNG TIN DOANH NGHIỆP</div>
                <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                    Quản lý thông tin liên hệ, mạng xã hội, giờ làm việc và nội dung giới thiệu hiển thị trên toàn website.
                </p>
            </div>
        </div>
        <div style="display: flex; align-items: center; gap: 10px;">
            <a href="${pageContext.request.contextPath}/about" target="_blank" class="admin-btn admin-btn-secondary">
                <i class="fa-solid fa-arrow-up-right-from-square"></i> Xem Trang About
            </a>
            <a href="${pageContext.request.contextPath}/contact" target="_blank" class="admin-btn admin-btn-secondary">
                <i class="fa-solid fa-arrow-up-right-from-square"></i> Xem Trang Contact
            </a>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <!-- Thông báo -->
        <c:if test="${param.msg == 'saved'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Thông tin doanh nghiệp đã được cập nhật thành công và áp dụng ngay lập tức!
            </div>
        </c:if>
        <c:if test="${param.err == 'save_failed'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-circle-exclamation"></i> Không thể lưu thông tin. Vui lòng kiểm tra dữ liệu và thử lại.
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/company" method="post">
            <input type="hidden" name="id" value="${company.id}">

            <div class="form-grid-3">
                <!-- Cột Trái & Giữa: Thông tin cơ bản & Bài giới thiệu -->
                <div style="grid-column: span 2;">
                    
                    <!-- Card 1: Thông tin cơ bản & Hotline -->
                    <div class="admin-card">
                        <div class="admin-card-header">
                            <div class="admin-card-title">
                                <i class="fa-solid fa-building" style="color: var(--admin-primary);"></i> THÔNG TIN CƠ BẢN & LIÊN HỆ
                            </div>
                        </div>
                        <div class="admin-card-body">
                            <div class="form-grid-2">
                                <div class="admin-form-group">
                                    <label class="admin-form-label">TÊN DOANH NGHIỆP / THƯƠNG HIỆU <span class="required">*</span></label>
                                    <input type="text" name="companyName" value="<c:out value='${company.companyName}' />" class="admin-input" required>
                                </div>
                                <div class="admin-form-group">
                                    <label class="admin-form-label">SLOGAN / KHẨU HIỆU</label>
                                    <input type="text" name="slogan" value="<c:out value='${company.slogan}' />" class="admin-input" 
                                           placeholder="Ví dụ: Giải pháp an ninh và kiểm soát thông minh toàn diện">
                                </div>
                            </div>

                            <div class="form-grid-3">
                                <div class="admin-form-group">
                                    <label class="admin-form-label">HOTLINE TỔNG ĐÀI <span class="required">*</span></label>
                                    <input type="text" name="hotline" value="<c:out value='${company.hotline}' />" class="admin-input" required>
                                </div>
                                <div class="admin-form-group">
                                    <label class="admin-form-label">EMAIL TIẾP NHẬN <span class="required">*</span></label>
                                    <input type="email" name="email" value="<c:out value='${company.email}' />" class="admin-input" required>
                                </div>
                                <div class="admin-form-group">
                                    <label class="admin-form-label">GIỜ LÀM VIỆC</label>
                                    <input type="text" name="workingHours" value="<c:out value='${company.workingHours}' />" class="admin-input"
                                           placeholder="T2 - T7: 08:00 - 18:00">
                                </div>
                            </div>

                            <div class="admin-form-group" style="margin-bottom: 0;">
                                <label class="admin-form-label">ĐỊA CHỈ TRỤ SỞ CHÍNH <span class="required">*</span></label>
                                <input type="text" name="address" value="<c:out value='${company.address}' />" class="admin-input" required>
                            </div>
                        </div>
                    </div>

                    <!-- Card 2: Nội dung Giới Thiệu (About CMS) -->
                    <div class="admin-card">
                        <div class="admin-card-header">
                            <div class="admin-card-title">
                                <i class="fa-solid fa-file-pen" style="color: var(--admin-primary);"></i> NỘI DUNG TRANG GIỚI THIỆU (ABOUT US)
                            </div>
                        </div>
                        <div class="admin-card-body">
                            <div class="admin-form-group">
                                <label class="admin-form-label">ĐOẠN TÓM TẮT MỞ ĐẦU (Hiển thị đầu trang & Footer)</label>
                                <textarea name="aboutSummary" class="admin-textarea" rows="3" 
                                          placeholder="Tóm tắt ngắn gọn về quy mô, sứ mệnh cốt lõi...">${company.aboutSummary}</textarea>
                            </div>

                            <div class="admin-form-group">
                                <label class="admin-form-label">BÀI VIẾT GIỚI THIỆU CHI TIẾT (Lịch sử, năng lực kỹ thuật)</label>
                                <textarea name="aboutDetail" class="admin-textarea" rows="6" 
                                          placeholder="Chi tiết về quá trình thành lập, các mốc phát triển, năng lực thi công...">${company.aboutDetail}</textarea>
                            </div>

                            <div class="form-grid-3">
                                <div class="admin-form-group">
                                    <label class="admin-form-label">TẦM NHÌN (VISION)</label>
                                    <textarea name="vision" class="admin-textarea" rows="3" 
                                              placeholder="Tầm nhìn định hướng tương lai...">${company.vision}</textarea>
                                </div>
                                <div class="admin-form-group">
                                    <label class="admin-form-label">SỨ MỆNH (MISSION)</label>
                                    <textarea name="mission" class="admin-textarea" rows="3" 
                                              placeholder="Sứ mệnh phục vụ khách hàng...">${company.mission}</textarea>
                                </div>
                                <div class="admin-form-group">
                                    <label class="admin-form-label">GIÁ TRỊ CỐT LÕI</label>
                                    <textarea name="coreValues" class="admin-textarea" rows="3" 
                                              placeholder="Chất lượng, Uy tín, Đồng hành...">${company.coreValues}</textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Cột Phải: Logo, Mạng Xã Hội & Nút Lưu -->
                <div>
                    <!-- Logo & Mạng xã hội -->
                    <div class="admin-card">
                        <div class="admin-card-header">
                            <div class="admin-card-title">
                                <i class="fa-solid fa-share-nodes" style="color: var(--admin-primary);"></i> TRUYỀN THÔNG & MẠNG XÃ HỘI
                            </div>
                        </div>
                        <div class="admin-card-body">
                            <div class="admin-form-group">
                                <label class="admin-form-label">ĐƯỜNG DẪN LOGO (URL)</label>
                                <input type="text" name="logoUrl" value="<c:out value='${company.logoUrl}' />" class="admin-input" 
                                       placeholder="assets/img/site-logo.png hoặc https://...">
                            </div>

                            <div class="admin-form-group">
                                <label class="admin-form-label">FACEBOOK FANPAGE (URL)</label>
                                <input type="url" name="facebookUrl" value="<c:out value='${company.facebookUrl}' />" class="admin-input" 
                                       placeholder="https://facebook.com/bleezysecurity">
                            </div>

                            <div class="admin-form-group" style="margin-bottom: 0;">
                                <label class="admin-form-label">KÊNH YOUTUBE / VIDEO (URL)</label>
                                <input type="url" name="youtubeUrl" value="<c:out value='${company.youtubeUrl}' />" class="admin-input" 
                                       placeholder="https://youtube.com/@bleezysecurity">
                            </div>
                        </div>
                    </div>

                    <!-- Thông tin Tài khoản Ngân hàng (VietQR) -->
                    <div class="admin-card">
                        <div class="admin-card-header">
                            <div class="admin-card-title">
                                <i class="fa-solid fa-qrcode" style="color: var(--admin-primary);"></i> TÀI KHOẢN VIETQR THỤ HƯỞNG
                            </div>
                        </div>
                        <div class="admin-card-body">
                            <div class="admin-form-group">
                                <label class="admin-form-label">NGÂN HÀNG THỤ HƯỞNG <span class="required">*</span></label>
                                <input type="text" name="bankName" value="<c:out value='${company.bankName}' />" class="admin-input" 
                                       placeholder="MBBank, VCB, TCB, VPBank..." required>
                                <span style="font-size: 11px; color: var(--admin-muted);">Mã/Tên viết tắt ngân hàng theo chuẩn Napas.</span>
                            </div>

                            <div class="admin-form-group">
                                <label class="admin-form-label">SỐ TÀI KHOẢN NGÂN HÀNG <span class="required">*</span></label>
                                <input type="text" name="bankAccountNo" value="<c:out value='${company.bankAccountNo}' />" class="admin-input" 
                                       placeholder="Ví dụ: 0988123456" required>
                            </div>

                            <div class="admin-form-group" style="margin-bottom: 0;">
                                <label class="admin-form-label">TÊN CHỦ TÀI KHOẢN (IN HOA) <span class="required">*</span></label>
                                <input type="text" name="bankAccountName" value="<c:out value='${company.bankAccountName}' />" class="admin-input" 
                                       placeholder="CTY TNHH BLEEZY SECURITY" required style="text-transform: uppercase;">
                            </div>
                        </div>
                    </div>

                    <!-- Thao tác Lưu -->
                    <div class="admin-card" style="background: #f8fafc;">
                        <div class="admin-card-body">
                            <p style="font-size: 13px; color: var(--admin-muted); margin-bottom: 16px;">
                                <i class="fa-solid fa-circle-info" style="color: var(--admin-primary);"></i> 
                                Các thông tin sau khi lưu sẽ đồng bộ ngay lập tức sang Header, Footer, Trang Giới Thiệu, Trang Liên Hệ và Hóa Đơn Xuất Kho.
                            </p>
                            <button type="submit" class="admin-btn admin-btn-primary" style="width: 100%; justify-content: center; padding: 12px; font-size: 15px;">
                                <i class="fa-solid fa-floppy-disk"></i> LƯU THAY ĐỔI
                            </button>
                        </div>
                    </div>

                </div>
            </div>
        </form>

    </div>
</main>
</body>
</html>
