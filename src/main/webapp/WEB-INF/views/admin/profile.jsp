<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div>
            <div class="admin-topbar-title">HỒ SƠ CÁ NHÂN & BẢO MẬT ADMIN</div>
            <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                Quản lý thông tin tài khoản đăng nhập quản trị và cập nhật mật khẩu định kỳ để bảo đảm an toàn hệ thống.
            </p>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <!-- Thông báo Profile -->
        <c:if test="${param.msg == 'profile_updated'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Thông tin hồ sơ quản trị viên đã được cập nhật thành công!
            </div>
        </c:if>
        <c:if test="${param.err == 'update_failed'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-circle-exclamation"></i> Có lỗi xảy ra khi cập nhật hồ sơ. Vui lòng thử lại.
            </div>
        </c:if>
        <c:if test="${param.err == 'name_required'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-circle-exclamation"></i> Vui lòng nhập họ và tên của quản trị viên.
            </div>
        </c:if>

        <!-- Thông báo Đổi Mật Khẩu -->
        <c:if test="${param.msg == 'password_changed'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Đổi mật khẩu thành công! Mật khẩu mới đã được mã hóa an toàn bằng BCrypt.
            </div>
        </c:if>
        <c:if test="${param.err == 'wrong_old_password'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-triangle-exclamation"></i> Mật khẩu hiện tại không chính xác. Vui lòng kiểm tra lại.
            </div>
        </c:if>
        <c:if test="${param.err == 'password_mismatch'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-triangle-exclamation"></i> Mật khẩu mới và xác nhận mật khẩu không khớp nhau!
            </div>
        </c:if>
        <c:if test="${param.err == 'password_too_short'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-triangle-exclamation"></i> Mật khẩu mới phải có ít nhất 6 ký tự.
            </div>
        </c:if>

        <div class="form-grid-2">
            
            <!-- Cột 1: Thông Tin Hồ Sơ -->
            <div>
                <div class="admin-card">
                    <div class="admin-card-header">
                        <div class="admin-card-title">
                            <i class="fa-solid fa-user-gear" style="color: var(--admin-primary);"></i> THÔNG TIN QUẢN TRỊ VIÊN
                        </div>
                    </div>
                    <div class="admin-card-body">
                        
                        <div style="display: flex; align-items: center; gap: 16px; margin-bottom: 24px; padding-bottom: 20px; border-bottom: 1px solid var(--admin-border);">
                            <div style="width: 64px; height: 64px; border-radius: 50%; background: linear-gradient(135deg, #0f172a, #1e293b); color: #f26723; display: flex; align-items: center; justify-content: center; font-size: 28px; border: 2px solid #f26723;">
                                <i class="fa-solid fa-user-shield"></i>
                            </div>
                            <div>
                                <h3 style="font-size: 18px; font-weight: 700; color: #0f172a; margin-bottom: 4px;">
                                    <c:out value="${admin.fullName}" />
                                </h3>
                                <div style="display: flex; gap: 8px; align-items: center;">
                                    <span class="status-badge status-completed" style="font-size: 11px;">
                                        <i class="fa-solid fa-shield"></i> <c:out value="${admin.role}" />
                                    </span>
                                    <span style="font-size: 12px; color: var(--admin-muted);">
                                        Tài khoản: <strong>@<c:out value="${admin.username}" /></strong>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <form action="${pageContext.request.contextPath}/admin/profile" method="post">
                            <input type="hidden" name="action" value="update-profile">

                            <div class="admin-form-group">
                                <label class="admin-form-label">TÊN ĐĂNG NHẬP (Cố định)</label>
                                <input type="text" value="<c:out value='${admin.username}' />" class="admin-input" disabled style="background: #f1f5f9; cursor: not-allowed;">
                            </div>

                            <div class="admin-form-group">
                                <label class="admin-form-label">HỌ VÀ TÊN <span class="required">*</span></label>
                                <input type="text" name="fullName" value="<c:out value='${admin.fullName}' />" class="admin-input" required>
                            </div>

                            <div class="admin-form-group">
                                <label class="admin-form-label">EMAIL CÔNG VIỆC</label>
                                <input type="email" name="email" value="<c:out value='${admin.email}' />" class="admin-input" placeholder="admin@bleezysolar.vn">
                            </div>

                            <div class="admin-form-group">
                                <label class="admin-form-label">SỐ ĐIỆN THOẠI</label>
                                <input type="text" name="phone" value="<c:out value='${admin.phone}' />" class="admin-input" placeholder="0988xxxxxx">
                            </div>

                            <div style="font-size: 12px; color: var(--admin-muted); margin-bottom: 20px;">
                                <p style="margin-bottom: 4px;">
                                    <i class="fa-regular fa-clock"></i> Đăng nhập gần nhất: 
                                    <strong><fmt:formatDate value="${admin.lastLogin}" pattern="dd/MM/yyyy HH:mm" /></strong>
                                </p>
                                <p>
                                    <i class="fa-regular fa-calendar-check"></i> Ngày khởi tạo tài khoản: 
                                    <strong><fmt:formatDate value="${admin.createdAt}" pattern="dd/MM/yyyy" /></strong>
                                </p>
                            </div>

                            <button type="submit" class="admin-btn admin-btn-primary" style="padding: 10px 20px;">
                                <i class="fa-solid fa-floppy-disk"></i> Lưu Thay Đổi Hồ Sơ
                            </button>
                        </form>

                    </div>
                </div>
            </div>

            <!-- Cột 2: Đổi Mật Khẩu -->
            <div id="password-section">
                <div class="admin-card">
                    <div class="admin-card-header">
                        <div class="admin-card-title">
                            <i class="fa-solid fa-key" style="color: var(--admin-primary);"></i> ĐỔI MẬT KHẨU ĐĂNG NHẬP
                        </div>
                    </div>
                    <div class="admin-card-body">
                        
                        <p style="font-size: 13px; color: var(--admin-muted); margin-bottom: 20px;">
                            Để bảo vệ an toàn cho cơ sở dữ liệu và hệ thống đơn hàng, vui lòng sử dụng mật khẩu mạnh kết hợp chữ, số và ký tự đặc biệt.
                        </p>

                        <form action="${pageContext.request.contextPath}/admin/profile" method="post">
                            <input type="hidden" name="action" value="change-password">

                            <div class="admin-form-group">
                                <label class="admin-form-label">MẬT KHẨU HIỆN TẠI <span class="required">*</span></label>
                                <input type="password" name="oldPassword" class="admin-input" placeholder="Nhập mật khẩu đang sử dụng" required>
                            </div>

                            <div class="admin-form-group">
                                <label class="admin-form-label">MẬT KHẨU MỚI <span class="required">*</span></label>
                                <input type="password" name="newPassword" class="admin-input" placeholder="Tối thiểu 6 ký tự" minlength="6" required>
                            </div>

                            <div class="admin-form-group">
                                <label class="admin-form-label">XÁC NHẬN MẬT KHẨU MỚI <span class="required">*</span></label>
                                <input type="password" name="confirmPassword" class="admin-input" placeholder="Nhập lại chính xác mật khẩu mới" minlength="6" required>
                            </div>

                            <div style="background: #f8fafc; border: 1px solid var(--admin-border); border-radius: 6px; padding: 12px 16px; margin-bottom: 20px; font-size: 12px; color: var(--admin-muted);">
                                <ul style="margin: 0; padding-left: 18px; line-height: 1.8;">
                                    <li>Mật khẩu mới không được trùng với mật khẩu cũ.</li>
                                    <li>Hệ thống tự động băm mật khẩu với chuẩn BCrypt 12 rounds.</li>
                                    <li>Sau khi đổi thành công, phiên đăng nhập hiện tại vẫn được duy trì an toàn.</li>
                                </ul>
                            </div>

                            <button type="submit" class="admin-btn admin-btn-primary" style="padding: 10px 20px;">
                                <i class="fa-solid fa-lock"></i> Cập Nhật Mật Khẩu
                            </button>
                        </form>

                    </div>
                </div>
            </div>

        </div>

    </div>
</main>
</body>
</html>
