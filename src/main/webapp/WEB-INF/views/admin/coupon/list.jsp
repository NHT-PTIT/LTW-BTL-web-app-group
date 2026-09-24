<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div>
            <div class="admin-topbar-title">QUẢN LÝ MÃ GIẢM GIÁ (VOUCHER)</div>
            <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                Cấu hình các chương trình khuyến mại, mã voucher giảm giá %, số tiền cố định cho khách hàng.
            </p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/coupons?action=add" class="admin-btn admin-btn-primary">
                <i class="fa-solid fa-plus"></i> Tạo Mã Giảm Giá Mới
            </a>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <!-- Thông Báo -->
        <c:if test="${param.msg == 'saved'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Lưu thông tin mã giảm giá thành công!
            </div>
        </c:if>
        <c:if test="${param.msg == 'deleted'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-trash-can"></i> Đã xóa mã giảm giá thành công!
            </div>
        </c:if>
        <c:if test="${param.msg == 'toggled'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-arrows-rotate"></i> Đã cập nhật trạng thái kích hoạt của mã!
            </div>
        </c:if>

        <div class="admin-card">
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th style="width: 50px;">ID</th>
                            <th>Mã Code</th>
                            <th>Mô Tả / Nội Dung</th>
                            <th>Mức Giảm</th>
                            <th>Đơn Tối Thiểu</th>
                            <th>Lượt Dùng</th>
                            <th>Hạn Áp Dụng</th>
                            <th style="text-align: center;">Trạng Thái</th>
                            <th style="text-align: right; width: 140px;">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${coupons}">
                            <tr>
                                <td><span style="color: var(--admin-muted); font-size: 12px;">#${c.id}</span></td>
                                <td>
                                    <span style="display: inline-block; background: #e0e7ff; color: #3730a3; padding: 4px 10px; border-radius: 6px; font-weight: 800; font-family: monospace; font-size: 14px; letter-spacing: 1px;">
                                        <i class="fa-solid fa-ticket"></i> ${c.code}
                                    </span>
                                </td>
                                <td>
                                    <div style="font-weight: 600; color: #1e293b; max-width: 250px;">
                                        <c:out value="${c.description}" />
                                    </div>
                                    <small style="color: var(--admin-muted);">
                                        Loại: ${c.discountType == 'PERCENT' ? 'Giảm theo phần trăm (%)' : 'Giảm tiền cố định (VNĐ)'}
                                    </small>
                                </td>
                                <td>
                                    <strong style="color: #e85b24; font-size: 14px;">
                                        ${c.formattedDiscountValue}
                                    </strong>
                                    <c:if test="${not empty c.maxDiscountAmount && c.maxDiscountAmount > 0}">
                                        <br><small style="color: var(--admin-muted);">Tối đa: <fmt:formatNumber value="${c.maxDiscountAmount}" pattern="###,###,### đ"/></small>
                                    </c:if>
                                </td>
                                <td>
                                    <span style="font-weight: 500;">${c.formattedMinOrderAmount}</span>
                                </td>
                                <td>
                                    <span style="font-weight: 700; color: ${c.usageLimit > 0 && c.usedCount >= c.usageLimit ? '#dc2626' : '#059669'};">
                                        ${c.usedCount}
                                    </span>
                                    <span style="color: var(--admin-muted); font-size: 12px;">
                                        / ${c.usageLimit > 0 ? c.usageLimit : 'Không giới hạn'}
                                    </span>
                                </td>
                                <td>
                                    <div style="font-size: 12px; color: #475569;">
                                        <c:choose>
                                            <c:when test="${not empty c.endDate}">
                                                <fmt:formatDate value="${c.startDate}" pattern="dd/MM/yyyy" /> &rarr; 
                                                <strong style="color: #b91c1c;"><fmt:formatDate value="${c.endDate}" pattern="dd/MM/yyyy" /></strong>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #059669; font-weight: 600;">Vô thời hạn</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td style="text-align: center;">
                                    <a href="${pageContext.request.contextPath}/admin/coupons?action=toggle&id=${c.id}" 
                                       title="Bấm để bật/tắt kích hoạt" style="text-decoration: none;">
                                        <c:choose>
                                            <c:when test="${c.active}">
                                                <span class="admin-badge admin-badge-success" style="cursor: pointer;">
                                                    <i class="fa-solid fa-check"></i> Đang bật
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="admin-badge admin-badge-danger" style="cursor: pointer;">
                                                    <i class="fa-solid fa-ban"></i> Đã tắt
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </td>
                                <td style="text-align: right;">
                                    <a href="${pageContext.request.contextPath}/admin/coupons?action=edit&id=${c.id}" 
                                       class="admin-btn admin-btn-sm admin-btn-secondary" title="Chỉnh sửa mã">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/coupons?action=delete&id=${c.id}" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa mã giảm giá [${c.code}] không?');" 
                                       class="admin-btn admin-btn-sm admin-btn-danger" title="Xóa mã" style="margin-left: 4px;">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty coupons}">
                            <tr>
                                <td colspan="9" style="text-align: center; color: var(--admin-muted); padding: 40px;">
                                    Chưa có mã giảm giá nào. Hãy bấm "+ Tạo Mã Giảm Giá Mới" để bắt đầu!
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
