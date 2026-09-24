<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div>
            <div class="admin-topbar-title">QUẢN LÝ ĐƠN HÀNG</div>
            <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                Tổng số <strong>${totalOrders}</strong> đơn hàng trong cơ sở dữ liệu.
            </p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/track-order" target="_blank" class="admin-btn admin-btn-secondary" title="Tra cứu mã đơn như khách hàng">
                <i class="fa-solid fa-magnifying-glass-location"></i> Tra Cứu Khách Hàng
            </a>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <!-- Thông Báo -->
        <c:if test="${param.msg == 'status_updated'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Cập nhật trạng thái đơn hàng thành công!
            </div>
        </c:if>

        <!-- Thanh Lọc Trạng Thái & Tìm Kiếm -->
        <div class="admin-filters-bar">
            <!-- Tabs Trạng Thái -->
            <div class="admin-tab-group">
                <a href="${pageContext.request.contextPath}/admin/orders?status=ALL${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="admin-tab ${currentStatus == 'ALL' ? 'active' : ''}">
                    Tất cả <span style="font-size: 11px; opacity: 0.8;">(${orderStats['TOTAL']})</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/orders?status=PENDING${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="admin-tab ${currentStatus == 'PENDING' ? 'active' : ''}">
                    Chờ xử lý <span class="nav-badge nav-badge-pending" style="font-size: 10px; padding: 1px 6px;">${orderStats['PENDING']}</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/orders?status=SHIPPING${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="admin-tab ${currentStatus == 'SHIPPING' ? 'active' : ''}">
                    Đang giao <span style="font-size: 11px; opacity: 0.8;">(${orderStats['SHIPPING']})</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/orders?status=COMPLETED${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="admin-tab ${currentStatus == 'COMPLETED' ? 'active' : ''}">
                    Hoàn tất <span style="font-size: 11px; opacity: 0.8;">(${orderStats['COMPLETED']})</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/orders?status=CANCELLED${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="admin-tab ${currentStatus == 'CANCELLED' ? 'active' : ''}">
                    Đã hủy <span style="font-size: 11px; opacity: 0.8;">(${orderStats['CANCELLED']})</span>
                </a>
            </div>

            <!-- Form Tìm Kiếm -->
            <form action="${pageContext.request.contextPath}/admin/orders" method="get" class="admin-search-form">
                <input type="hidden" name="status" value="${currentStatus}">
                <input type="text" name="keyword" value="${keyword}" placeholder="Mã đơn, tên khách, SĐT..." class="admin-search-input">
                <button type="submit" class="admin-btn admin-btn-secondary">
                    <i class="fa-solid fa-magnifying-glass"></i> Tìm
                </button>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/admin/orders?status=${currentStatus}" class="admin-btn admin-btn-secondary" title="Hủy tìm kiếm">
                        <i class="fa-solid fa-xmark"></i>
                    </a>
                </c:if>
            </form>
        </div>

        <!-- Bảng Dữ Liệu Đơn Hàng -->
        <div class="admin-card">
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Mã Đơn</th>
                            <th>Khách Hàng</th>
                            <th>Số Điện Thoại</th>
                            <th>Ngày Đặt</th>
                            <th>Tổng Tiền</th>
                            <th>Thanh Toán</th>
                            <th>Trạng Thái</th>
                            <th style="text-align: right;">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ord" items="${orders}">
                            <tr>
                                <td>
                                    <strong style="color: #0f172a; letter-spacing: 0.5px;">${ord.orderCode}</strong>
                                </td>
                                <td>
                                    <div style="font-weight: 600;">${ord.customerName}</div>
                                    <div style="font-size: 11px; color: var(--admin-muted);">${ord.customerEmail}</div>
                                </td>
                                <td>
                                    <a href="tel:${ord.customerPhone}" style="color: #0284c7; text-decoration: none; font-weight: 500;">
                                        <i class="fa-solid fa-phone me-1" style="font-size: 11px;"></i>${ord.customerPhone}
                                    </a>
                                </td>
                                <td><span style="font-size: 12px; color: var(--admin-muted);"><fmt:formatDate value="${ord.createdAt}" pattern="dd/MM/yyyy HH:mm" /></span></td>
                                <td><span class="price-accent">${ord.formattedTotalAmount}</span></td>
                                <td>
                                    <span style="font-size: 12px; color: #475569; font-weight: 500;">
                                        ${ord.paymentMethod == 'BANK_TRANSFER' ? 'Chuyển khoản' : 'COD (Tiền mặt)'}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${ord.status == 'COMPLETED'}">
                                            <span class="status-badge status-completed"><i class="fa-solid fa-check"></i> Đã giao</span>
                                        </c:when>
                                        <c:when test="${ord.status == 'SHIPPING'}">
                                            <span class="status-badge status-shipping"><i class="fa-solid fa-truck-fast"></i> Đang giao</span>
                                        </c:when>
                                        <c:when test="${ord.status == 'CANCELLED'}">
                                            <span class="status-badge status-cancelled"><i class="fa-solid fa-xmark"></i> Đã hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-pending"><i class="fa-solid fa-hourglass-half"></i> Chờ duyệt</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align: right; white-space: nowrap;">
                                    <a href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${ord.id}" class="admin-btn admin-btn-sm admin-btn-primary">
                                        <i class="fa-solid fa-eye"></i> Chi Tiết
                                    </a>
                                    <a href="${pageContext.request.contextPath}/invoice?id=${ord.id}" target="_blank" class="admin-btn admin-btn-sm admin-btn-secondary" title="In Hóa Đơn / Xuất Kho">
                                        <i class="fa-solid fa-print"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty orders}">
                            <tr>
                                <td colspan="8" style="text-align: center; color: var(--admin-muted); padding: 40px;">
                                    <i class="fa-regular fa-folder-open" style="font-size: 32px; margin-bottom: 8px; display: block; opacity: 0.5;"></i>
                                    Không tìm thấy đơn hàng nào phù hợp với điều kiện lọc.
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
                        <a href="${pageContext.request.contextPath}/admin/orders?status=${currentStatus}&keyword=${keyword}&page=${currentPage - 1}" class="page-item">
                            <i class="fa-solid fa-chevron-left"></i>
                        </a>
                    </c:if>
                    <c:forEach var="p" begin="1" end="${totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/orders?status=${currentStatus}&keyword=${keyword}&page=${p}" 
                           class="page-item ${p == currentPage ? 'active' : ''}">${p}</a>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/orders?status=${currentStatus}&keyword=${keyword}&page=${currentPage + 1}" class="page-item">
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
