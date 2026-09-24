<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div style="display: flex; align-items: center; gap: 14px;">
            <a href="${pageContext.request.contextPath}/admin/team" class="admin-btn admin-btn-secondary admin-btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Quay Lại
            </a>
            <div>
                <div class="admin-topbar-title">${isEdit ? 'CẬP NHẬT THÔNG TIN NHÂN SỰ' : 'THÊM THÀNH VIÊN MỚI'}</div>
                <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                    <c:choose>
                        <c:when test="${isEdit}">Chỉnh sửa hồ sơ chuyên gia: <c:out value="${member.fullName}" /></c:when>
                        <c:otherwise>Nhập thông tin chuyên gia, kỹ sư để hiển thị trên trang Đội ngũ.</c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <form action="${pageContext.request.contextPath}/admin/team" method="post">
            <c:if test="${isEdit}">
                <input type="hidden" name="id" value="${member.id}">
            </c:if>

            <div class="form-grid-3">
                <!-- Cột Trái & Giữa -->
                <div style="grid-column: span 2;">
                    <div class="admin-card">
                        <div class="admin-card-header">
                            <div class="admin-card-title">
                                <i class="fa-solid fa-id-card" style="color: var(--admin-primary);"></i> HỒ SƠ CHUYÊN GIA
                            </div>
                        </div>
                        <div class="admin-card-body">
                            <div class="form-grid-2">
                                <div class="admin-form-group">
                                    <label class="admin-form-label">HỌ VÀ TÊN <span class="required">*</span></label>
                                    <input type="text" name="fullName" value="<c:out value='${member.fullName}' />" class="admin-input" 
                                           placeholder="Ví dụ: KS. Nguyễn Văn An" required>
                                </div>
                                <div class="admin-form-group">
                                    <label class="admin-form-label">VỊ TRÍ / CHỨC DANH <span class="required">*</span></label>
                                    <input type="text" name="position" value="<c:out value='${member.position}' />" class="admin-input" 
                                           placeholder="Ví dụ: Giám đốc Kỹ thuật / Kỹ sư Điện mặt trời" required>
                                </div>
                            </div>

                            <div class="form-grid-2">
                                <div class="admin-form-group">
                                    <label class="admin-form-label">EMAIL LIÊN HỆ</label>
                                    <input type="email" name="email" value="<c:out value='${member.email}' />" class="admin-input" 
                                           placeholder="engineer@bleezysolar.vn">
                                </div>
                                <div class="admin-form-group">
                                    <label class="admin-form-label">THỨ TỰ HIỂN THỊ (Ưu tiên nhỏ hơn đứng trước)</label>
                                    <input type="number" name="sortOrder" value="${member.sortOrder != null ? member.sortOrder : 1}" 
                                           class="admin-input" min="0">
                                </div>
                            </div>

                            <div class="admin-form-group" style="margin-bottom: 0;">
                                <label class="admin-form-label">TIỂU SỬ / BẰNG CẤP CHUYÊN MÔN</label>
                                <textarea name="bio" class="admin-textarea" rows="4" 
                                          placeholder="Tóm tắt kinh nghiệm: 10 năm kinh nghiệm thiết kế trạm biến áp, chứng chỉ hòa lưới quốc tế...">${member.bio}</textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Cột Phải: Ảnh đại diện & Trạng thái -->
                <div>
                    <div class="admin-card">
                        <div class="admin-card-header">
                            <div class="admin-card-title">
                                <i class="fa-solid fa-image" style="color: var(--admin-primary);"></i> ẢNH ĐẠI DIỆN
                            </div>
                        </div>
                        <div class="admin-card-body">
                            <div class="admin-form-group">
                                <label class="admin-form-label">ĐƯỜNG DẪN ẢNH (URL)</label>
                                <input type="text" name="avatarUrl" id="avatarUrlInput" value="<c:out value='${member.avatarUrl}' />" 
                                       class="admin-input" placeholder="assets/img/team-1.jpg hoặc https://..." 
                                       oninput="updateAvatarPreview(this.value)">
                            </div>

                            <div style="text-align: center; padding: 15px; background: #f8fafc; border-radius: 8px; border: 1px dashed var(--admin-border); margin-bottom: 16px;">
                                <c:set var="prevAv" value="${member.avatarUrl}" />
                                <c:if test="${empty prevAv}">
                                    <c:set var="prevAv" value="${pageContext.request.contextPath}/assets/img/team-1.jpg" />
                                </c:if>
                                <c:if test="${!prevAv.startsWith('http://') && !prevAv.startsWith('https://') && !prevAv.startsWith('/')}">
                                    <c:set var="prevAv" value="${pageContext.request.contextPath}/${prevAv}" />
                                </c:if>
                                <img src="${prevAv}" id="avatarPreview" alt="Xem trước avatar" 
                                     style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover; border: 3px solid #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.1);"
                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/team-1.jpg';">
                                <div style="font-size: 11px; color: var(--admin-muted); margin-top: 8px;">Xem trước ảnh đại diện</div>
                            </div>

                            <div class="admin-form-group" style="margin-bottom: 0;">
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="isActive" value="true" ${member.id == 0 || member.active ? 'checked' : ''}>
                                    <span>Cho phép <strong>Hiển thị công khai</strong> trên website</span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Thao tác Lưu -->
                    <div style="display: flex; flex-direction: column; gap: 10px;">
                        <button type="submit" class="admin-btn admin-btn-primary" style="justify-content: center; padding: 12px; font-size: 15px;">
                            <i class="fa-solid fa-floppy-disk"></i> LƯU NHÂN SỰ
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/team" class="admin-btn admin-btn-secondary" style="justify-content: center;">
                            Hủy bỏ
                        </a>
                    </div>
                </div>
            </div>
        </form>

    </div>
</main>

<script>
function updateAvatarPreview(url) {
    var img = document.getElementById('avatarPreview');
    if (url && url.trim().length > 0) {
        var cleanUrl = url.trim();
        if (!cleanUrl.startsWith('http://') && !cleanUrl.startsWith('https://') && !cleanUrl.startsWith('/')) {
            cleanUrl = '${pageContext.request.contextPath}/' + cleanUrl;
        }
        img.src = cleanUrl;
    }
}
</script>
</body>
</html>
