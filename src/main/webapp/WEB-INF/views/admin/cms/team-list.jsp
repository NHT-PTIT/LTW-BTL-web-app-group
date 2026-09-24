<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div>
            <div class="admin-topbar-title">QUẢN LÝ ĐỘI NGŨ NHÂN SỰ & CHUYÊN GIA</div>
            <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                Danh sách cán bộ quản lý, kỹ sư trưởng và chuyên gia kỹ thuật hiển thị trên trang Đội ngũ (/team).
            </p>
        </div>
        <div style="display: flex; align-items: center; gap: 10px;">
            <a href="${pageContext.request.contextPath}/team" target="_blank" class="admin-btn admin-btn-secondary">
                <i class="fa-solid fa-arrow-up-right-from-square"></i> Xem Trang Team
            </a>
            <a href="${pageContext.request.contextPath}/admin/team?action=add" class="admin-btn admin-btn-primary">
                <i class="fa-solid fa-user-plus"></i> Thêm Nhân Sự Mới
            </a>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <!-- Thông báo kết quả -->
        <c:if test="${param.msg == 'saved'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Thông tin thành viên đã được lưu thành công!
            </div>
        </c:if>
        <c:if test="${param.msg == 'deleted'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Đã xóa thành viên khỏi danh sách thành công!
            </div>
        </c:if>
        <c:if test="${param.err == 'delete_failed'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-circle-exclamation"></i> Không thể xóa thành viên. Vui lòng thử lại.
            </div>
        </c:if>

        <div class="admin-card">
            <div class="admin-card-header">
                <div class="admin-card-title">
                    <i class="fa-solid fa-users-gear" style="color: var(--admin-primary);"></i> DANH SÁCH THÀNH VIÊN (${members.size()} nhân sự)
                </div>
            </div>
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th style="width: 70px;">Ảnh</th>
                            <th>Họ và Tên</th>
                            <th>Chức Vụ / Vị Trí</th>
                            <th>Email Liên Hệ</th>
                            <th style="width: 90px; text-align: center;">Thứ Tự</th>
                            <th style="width: 120px;">Trạng Thái</th>
                            <th style="text-align: right; width: 150px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="m" items="${members}" varStatus="st">
                            <tr>
                                <td>
                                    <c:set var="avatarSrc" value="${m.avatarUrl}" />
                                    <c:if test="${empty avatarSrc}">
                                        <c:set var="avatarSrc" value="${pageContext.request.contextPath}/assets/img/team-${(st.index % 4) + 1}.jpg" />
                                    </c:if>
                                    <c:if test="${!avatarSrc.startsWith('http://') && !avatarSrc.startsWith('https://') && !avatarSrc.startsWith('/')}">
                                        <c:set var="avatarSrc" value="${pageContext.request.contextPath}/${avatarSrc}" />
                                    </c:if>
                                    <img src="${avatarSrc}" alt="<c:out value='${m.fullName}' />" 
                                         style="width: 44px; height: 44px; border-radius: 50%; object-fit: cover; border: 1px solid var(--admin-border);"
                                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/team-1.jpg';">
                                </td>
                                <td>
                                    <strong style="color: #0f172a; font-size: 14px;"><c:out value="${m.fullName}" /></strong>
                                    <c:if test="${not empty m.bio}">
                                        <div style="font-size: 12px; color: var(--admin-muted); max-width: 320px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                            <c:out value="${m.bio}" />
                                        </div>
                                    </c:if>
                                </td>
                                <td>
                                    <span style="font-weight: 500; color: #0284c7;"><c:out value="${m.position}" /></span>
                                </td>
                                <td>
                                    <span style="font-size: 13px; color: var(--admin-muted);"><c:out value="${m.email}" /></span>
                                </td>
                                <td style="text-align: center;">
                                    <strong>${m.sortOrder}</strong>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${m.active}">
                                            <span class="status-badge status-completed"><i class="fa-solid fa-check"></i> Hiển thị</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-cancelled"><i class="fa-solid fa-eye-slash"></i> Tạm ẩn</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align: right; white-space: nowrap;">
                                    <a href="${pageContext.request.contextPath}/admin/team?action=edit&id=${m.id}" class="admin-btn admin-btn-sm admin-btn-secondary" title="Chỉnh sửa">
                                        <i class="fa-solid fa-pen-to-square"></i> Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/team?action=delete&id=${m.id}" class="admin-btn admin-btn-sm admin-btn-danger" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa thành viên <c:out value="${m.fullName}"/>?');" title="Xóa nhân sự">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty members}">
                            <tr>
                                <td colspan="7" style="text-align: center; color: var(--admin-muted); padding: 40px;">
                                    <i class="fa-solid fa-users" style="font-size: 32px; margin-bottom: 8px; display: block; opacity: 0.5;"></i>
                                    Chưa có thành viên nào trong danh sách. Hãy thêm nhân sự đầu tiên!
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</main>
</body>
</html>
