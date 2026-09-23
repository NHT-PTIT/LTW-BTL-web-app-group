<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div>
            <div class="admin-topbar-title">YÊU CẦU TƯ VẤN & LIÊN HỆ</div>
            <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                Danh sách khách hàng gửi yêu cầu tư vấn kỹ thuật điện mặt trời từ trang chủ và liên hệ.
            </p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/contact" target="_blank" class="admin-btn admin-btn-secondary" title="Xem biểu mẫu liên hệ ngoài trang chủ">
                <i class="fa-solid fa-arrow-up-right-from-square"></i> Xem Trang Liên Hệ
            </a>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <!-- Thông Báo -->
        <c:if test="${param.msg == 'status_updated'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Đã cập nhật trạng thái và ghi chú tư vấn thành công!
            </div>
        </c:if>

        <!-- Tabs Trạng Thái -->
        <div class="admin-filters-bar">
            <div class="admin-tab-group">
                <a href="${pageContext.request.contextPath}/admin/contacts?status=ALL" class="admin-tab ${currentStatus == 'ALL' ? 'active' : ''}">
                    Tất cả <span style="font-size: 11px; opacity: 0.8;">(${totalAll})</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/contacts?status=NEW" class="admin-tab ${currentStatus == 'NEW' ? 'active' : ''}">
                    Mới nhận <span class="nav-badge nav-badge-pending" style="font-size: 10px; padding: 1px 6px;">${countNew}</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/contacts?status=PROCESSING" class="admin-tab ${currentStatus == 'PROCESSING' ? 'active' : ''}">
                    Đang tư vấn <span style="font-size: 11px; opacity: 0.8;">(${countProcessing})</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/contacts?status=RESOLVED" class="admin-tab ${currentStatus == 'RESOLVED' ? 'active' : ''}">
                    Đã giải quyết <span style="font-size: 11px; opacity: 0.8;">(${countResolved})</span>
                </a>
            </div>
        </div>

        <!-- Bảng Dữ Liệu Liên Hệ -->
        <div class="admin-card">
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th style="width: 50px;">ID</th>
                            <th>Khách Hàng</th>
                            <th>Tiêu Đề & Nội Dung Yêu Cầu</th>
                            <th>Thời Gian</th>
                            <th>Trạng Thái</th>
                            <th>Cập Nhật & Ghi Chú</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${inquiries}">
                            <tr>
                                <td><span style="color: var(--admin-muted); font-size: 12px;">#${c.id}</span></td>
                                <td style="min-width: 180px;">
                                    <div style="font-weight: 700; color: #0f172a;">${c.fullName}</div>
                                    <div style="margin-top: 2px;">
                                        <a href="tel:${c.phone}" style="color: #0284c7; text-decoration: none; font-size: 13px; font-weight: 500;">
                                            <i class="fa-solid fa-phone me-1" style="font-size: 11px;"></i>${c.phone}
                                        </a>
                                    </div>
                                    <c:if test="${not empty c.email}">
                                        <div style="font-size: 12px; color: var(--admin-muted); margin-top: 2px;">
                                            <a href="mailto:${c.email}" style="color: inherit; text-decoration: none;">
                                                <i class="fa-solid fa-envelope me-1" style="font-size: 10px;"></i>${c.email}
                                            </a>
                                        </div>
                                    </c:if>
                                </td>
                                <td style="max-width: 320px;">
                                    <div style="font-weight: 600; color: #1e293b; margin-bottom: 4px;">
                                        ${not empty c.subject ? c.subject : 'Tư vấn biến tần & hệ thống điện mặt trời'}
                                    </div>
                                    <div style="font-size: 13px; color: #475569; background: #f8fafc; padding: 8px 12px; border-radius: 6px; border: 1px solid #e2e8f0; line-height: 1.4;">
                                        "${c.message}"
                                    </div>
                                </td>
                                <td>
                                    <span style="font-size: 12px; color: var(--admin-muted);">${c.getFormattedCreatedAt()}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.status == 'RESOLVED'}">
                                            <span class="status-badge status-resolved"><i class="fa-solid fa-circle-check"></i> Đã giải quyết</span>
                                        </c:when>
                                        <c:when test="${c.status == 'PROCESSING'}">
                                            <span class="status-badge status-processing"><i class="fa-solid fa-headset"></i> Đang tư vấn</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-new"><i class="fa-solid fa-bell"></i> Yêu cầu mới</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="min-width: 240px;">
                                    <!-- Form Cập Nhật Trực Tiếp -->
                                    <form action="${pageContext.request.contextPath}/admin/contacts" method="post" style="display: flex; flex-direction: column; gap: 6px;">
                                        <input type="hidden" name="id" value="${c.id}">
                                        <div style="display: flex; gap: 6px;">
                                            <select name="status" class="admin-select" style="font-size: 12px; padding: 4px 8px; flex: 1;">
                                                <option value="NEW" ${c.status == 'NEW' ? 'selected' : ''}>Mới (NEW)</option>
                                                <option value="PROCESSING" ${c.status == 'PROCESSING' ? 'selected' : ''}>Đang tư vấn</option>
                                                <option value="RESOLVED" ${c.status == 'RESOLVED' ? 'selected' : ''}>Đã xong</option>
                                            </select>
                                            <button type="submit" class="admin-btn admin-btn-sm admin-btn-primary" title="Lưu ghi chú & trạng thái">
                                                <i class="fa-solid fa-check"></i>
                                            </button>
                                        </div>
                                        <input type="text" name="adminNotes" value="${c.adminNotes}" placeholder="Ghi chú tư vấn (đã gọi, hẹn khảo sát...)" 
                                               class="admin-input" style="font-size: 12px; padding: 4px 8px;">
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty inquiries}">
                            <tr>
                                <td colspan="6" style="text-align: center; color: var(--admin-muted); padding: 40px;">
                                    <i class="fa-regular fa-folder-open" style="font-size: 32px; margin-bottom: 8px; display: block; opacity: 0.5;"></i>
                                    Chưa có yêu cầu tư vấn nào thuộc danh mục này.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <!-- Phân Trang -->
            <c:if test="${totalPages > 1}">
                <div class="admin-pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/admin/contacts?status=${currentStatus}&page=${currentPage - 1}" class="page-item">
                            <i class="fa-solid fa-chevron-left"></i>
                        </a>
                    </c:if>
                    <c:forEach var="p" begin="1" end="${totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/contacts?status=${currentStatus}&page=${p}" 
                           class="page-item ${p == currentPage ? 'active' : ''}">${p}</a>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/contacts?status=${currentStatus}&page=${currentPage + 1}" class="page-item">
                            <i class="fa-solid fa-chevron-right"></i>
                        </a>
                    </c:if>
                </div>
            </c:if>
        </div>

    </div>
</main>
</body>
</html>
