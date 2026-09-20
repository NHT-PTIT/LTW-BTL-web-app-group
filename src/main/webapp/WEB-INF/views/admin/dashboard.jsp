<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/admin-header.jsp" />
<jsp:include page="../common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div>
            <h2 style="font-size: 20px; font-weight: 700; margin: 0;">Tổng Quan Hoạt Động</h2>
            <p style="font-size: 13px; color: var(--admin-muted); margin: 2px 0 0 0;">Chào mừng trở lại, ${sessionScope.currentAdmin.fullName}!</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/" target="_blank" style="font-size: 13px; color: var(--admin-accent); font-weight: 600; text-decoration: none;">
                <i class="fa-solid fa-arrow-up-right-from-square me-1"></i> Xem Website Client
            </a>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">
        <!-- 4 Thẻ Thống kê -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon" style="background: #eff6ff; color: #3b82f6;">
                    <i class="fa-solid fa-receipt"></i>
                </div>
                <div>
                    <div class="stat-label">Tổng đơn hàng</div>
                    <div class="stat-val">${orderStats['TOTAL']}</div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon" style="background: #fefce8; color: #eab308;">
                    <i class="fa-solid fa-clock"></i>
                </div>
                <div>
                    <div class="stat-label">Đơn chờ xử lý</div>
                    <div class="stat-val">${orderStats['PENDING']}</div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon" style="background: #f0fdf4; color: #16a34a;">
                    <i class="fa-solid fa-boxes-stacked"></i>
                </div>
                <div>
                    <div class="stat-label">Sản phẩm trong kho</div>
                    <div class="stat-val">${totalProducts}</div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon" style="background: #fdf2f8; color: #db2777;">
                    <i class="fa-solid fa-envelope-open-text"></i>
                </div>
                <div>
                    <div class="stat-label">Yêu cầu tư vấn mới</div>
                    <div class="stat-val">${totalInquiries}</div>
                </div>
            </div>
        </div>

        <!-- Bảng 5 Đơn Hàng Mới Nhất -->
        <div class="data-table-card">
            <div class="table-header">
                <h3 style="font-size: 16px; font-weight: 700; margin: 0;">Đơn Hàng Mới Nhất</h3>
                <a href="${pageContext.request.contextPath}/admin/orders" style="font-size: 13px; color: var(--admin-accent); font-weight: 600; text-decoration: none;">
                    Xem tất cả đơn hàng &rarr;
                </a>
            </div>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>Mã Đơn</th>
                        <th>Khách Hàng</th>
                        <th>Số Điện Thoại</th>
                        <th>Tổng Tiền</th>
                        <th>Thanh Toán</th>
                        <th>Trạng Thái</th>
                        <th>Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ord" items="${recentOrders}">
                        <tr>
                            <td><strong>${ord.orderCode}</strong></td>
                            <td>${ord.customerName}</td>
                            <td>${ord.customerPhone}</td>
                            <td><strong style="color: #2563eb;">${ord.getFormattedTotalAmount()}</strong></td>
                            <td><span style="font-size: 12px; font-weight: 600; color: #475569;">${ord.paymentMethod}</span></td>
                            <td>
                                <span style="font-size: 12px; font-weight: 600; padding: 4px 8px; border-radius: 4px; 
                                             background: ${ord.status == 'COMPLETED' ? '#dcfce7; color: #15803d;' : ord.status == 'SHIPPING' ? '#e0f2fe; color: #0369a1;' : '#fef9c3; color: #a16207;'}">
                                    ${ord.getStatusDisplayName()}
                                </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/orders?id=${ord.id}" style="color: var(--admin-accent); font-size: 13px; font-weight: 600; text-decoration: none;">
                                    Chi tiết
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty recentOrders}">
                        <tr>
                            <td colspan="7" style="text-align: center; color: var(--admin-muted); padding: 30px;">
                                Chưa có đơn hàng nào trong hệ thống.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</main>

<script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>
