<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div style="display: flex; align-items: center; gap: 14px;">
            <a href="${pageContext.request.contextPath}/admin/categories" class="admin-btn admin-btn-secondary admin-btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Quay Lại
            </a>
            <div>
                <div class="admin-topbar-title">${isEdit ? 'SỬA DANH MỤC' : 'THÊM DANH MỤC MỚI'}</div>
                <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                    <c:choose>
                        <c:when test="${isEdit}">Chỉnh sửa thông tin danh mục: <c:out value="${category.name}"/></c:when>
                        <c:otherwise>Thiết lập danh mục mới để phân loại thiết bị an ninh, camera CCTV & khóa thông minh.</c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content" style="max-width: 800px;">

        <div class="admin-card">
            <div class="admin-card-header">
                <div class="admin-card-title">
                    <i class="fa-solid fa-folder-tree" style="color: var(--admin-primary);"></i> THÔNG TIN DANH MỤC
                </div>
            </div>
            <div class="admin-card-body">
                <form action="${pageContext.request.contextPath}/admin/categories" method="post">
                    <c:if test="${isEdit}">
                        <input type="hidden" name="id" value="${category.id}">
                    </c:if>

                    <div class="admin-form-group">
                        <label class="admin-form-label">TÊN DANH MỤC <span class="required">*</span></label>
                        <input type="text" name="name" value="${category.name}" class="admin-input" 
                               placeholder="Ví dụ: Camera IP Wifi, Khóa cửa Face ID, Máy chấm công..." required>
                    </div>

                    <div class="form-grid-2">
                        <div class="admin-form-group">
                            <label class="admin-form-label">DANH MỤC CHA</label>
                            <select name="parentId" class="admin-select">
                                <option value="NONE">-- Là Danh Mục Cấp 1 (Gốc) --</option>
                                <c:forEach var="rc" items="${rootCategories}">
                                    <!-- Không cho chọn chính mình làm danh mục cha khi sửa -->
                                    <c:if test="${!isEdit || rc.id != category.id}">
                                        <option value="${rc.id}" ${category.parentId == rc.id ? 'selected' : ''}>
                                            📁 ${rc.name}
                                        </option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            <span style="font-size: 11px; color: var(--admin-muted);">Nếu chọn "Là Danh Mục Cấp 1", danh mục này sẽ đứng độc lập ngoài menu.</span>
                        </div>

                        <div class="admin-form-group">
                            <label class="admin-form-label">ĐƯỜNG DẪN URL SLUG (Tùy chọn)</label>
                            <input type="text" name="slug" value="${category.slug}" class="admin-input" 
                                   placeholder="camera-ip-wifi (để trống tự sinh)">
                        </div>
                    </div>

                    <div class="form-grid-2">
                        <div class="admin-form-group">
                            <label class="admin-form-label">THỨ TỰ HIỂN THỊ</label>
                            <input type="number" name="sortOrder" value="${category.sortOrder != null ? category.sortOrder : 1}" class="admin-input" min="0">
                        </div>
                        <div class="admin-form-group">
                            <label class="admin-form-label">TRẠNG THÁI HOẠT ĐỘNG</label>
                            <div style="margin-top: 10px;">
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="isActive" value="true" ${category.id == 0 || category.active ? 'checked' : ''}>
                                    <span>Kích hoạt danh mục</span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="admin-form-group">
                        <label class="admin-form-label">MÔ TẢ NGẮN DANH MỤC</label>
                        <textarea name="description" class="admin-textarea" rows="3" 
                                  placeholder="Mô tả nhóm thiết bị, ứng dụng giải pháp...">${category.description}</textarea>
                    </div>

                    <div style="display: flex; gap: 12px; margin-top: 24px;">
                        <button type="submit" class="admin-btn admin-btn-primary" style="padding: 11px 24px;">
                            <i class="fa-solid fa-floppy-disk"></i> LƯU DANH MỤC
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/categories" class="admin-btn admin-btn-secondary">
                            Hủy Bỏ
                        </a>
                    </div>
                </form>
            </div>
        </div>

    </div>
</main>
</body>
</html>
