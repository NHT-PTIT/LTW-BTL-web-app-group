<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div>
            <div class="admin-topbar-title">BẢNG ĐIỀU KHIỂN TỔNG QUAN</div>
            <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                Xin chào, <strong>${sessionScope.currentAdmin.fullName}</strong>. Dưới đây là tình hình hoạt động kinh doanh hôm nay.
            </p>
        </div>
        <div style="display: flex; align-items: center; gap: 12px;">
            <a href="${pageContext.request.contextPath}/admin/products?action=add" class="admin-btn admin-btn-primary">
                <i class="fa-solid fa-plus"></i> Thêm Sản Phẩm Mới
            </a>
            <a href="${pageContext.request.contextPath}/" target="_blank" class="admin-btn admin-btn-secondary" title="Xem cửa hàng khách hàng">
                <i class="fa-solid fa-arrow-up-right-from-square"></i> Xem Live Store
            </a>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">
        <!-- 4 Thẻ Thống Kê KPI -->
        <div class="stats-grid">
            <!-- Card 1: Đơn Hàng & Chờ Xử Lý -->
            <div class="stat-card" style="border-left: 4px solid var(--admin-primary);">
                <div class="stat-icon" style="background: #fff7ed; color: #f26723;">
                    <i class="fa-solid fa-receipt"></i>
                </div>
                <div style="flex: 1;">
                    <div class="stat-label">Tổng Đơn Hàng</div>
                    <div class="stat-val">${orderStats['TOTAL']}</div>
                    <div style="font-size: 12px; color: #b45309; margin-top: 4px; font-weight: 600;">
                        <i class="fa-solid fa-clock me-1"></i> ${pendingOrderCount} đơn chờ duyệt
                    </div>
                </div>
            </div>

            <!-- Card 2: Doanh Thu Hoàn Tất -->
            <div class="stat-card" style="border-left: 4px solid #16a34a;">
                <div class="stat-icon" style="background: #f0fdf4; color: #16a34a;">
                    <i class="fa-solid fa-sack-dollar"></i>
                </div>
                <div style="flex: 1;">
                    <div class="stat-label">Doanh Thu Đã Thu</div>
                    <div class="stat-val" style="color: #16a34a;">${formattedRevenue}</div>
                    <div style="font-size: 12px; color: var(--admin-muted); margin-top: 4px;">
                        Từ ${orderStats['COMPLETED']} đơn thành công
                    </div>
                </div>
            </div>

            <!-- Card 3: Sản Phẩm Kho Hàng -->
            <div class="stat-card" style="border-left: 4px solid #0284c7;">
                <div class="stat-icon" style="background: #f0f9ff; color: #0284c7;">
                    <i class="fa-solid fa-boxes-stacked"></i>
                </div>
                <div style="flex: 1;">
                    <div class="stat-label">Sản Phẩm Trong Kho</div>
                    <div class="stat-val">${totalProducts}</div>
                    <div style="font-size: 12px; margin-top: 4px;">
                        <c:choose>
                            <c:when test="${lowStockCount > 0}">
                                <span style="color: #dc2626; font-weight: 600;">
                                    <i class="fa-solid fa-triangle-exclamation me-1"></i> ${lowStockCount} SP sắp hết hàng
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: #16a34a;">Kho hàng ổn định</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Card 4: Yêu Cầu Tư Vấn Khách Hàng -->
            <div class="stat-card" style="border-left: 4px solid #8b5cf6;">
                <div class="stat-icon" style="background: #f5f3ff; color: #8b5cf6;">
                    <i class="fa-solid fa-headset"></i>
                </div>
                <div style="flex: 1;">
                    <div class="stat-label">Tư Vấn & Liên Hệ</div>
                    <div class="stat-val">${totalInquiries}</div>
                    <div style="font-size: 12px; color: #7c3aed; margin-top: 4px; font-weight: 600;">
                        <i class="fa-solid fa-bell me-1"></i> ${newInquiryCount} yêu cầu mới
                    </div>
                </div>
            </div>

            <!-- Card 5: Khách Hàng Thành Viên -->
            <div class="stat-card" style="border-left: 4px solid #06b6d4;">
                <div class="stat-icon" style="background: #ecfeff; color: #0891b2;">
                    <i class="fa-solid fa-users"></i>
                </div>
                <div style="flex: 1;">
                    <div class="stat-label">Khách Hàng Thành Viên</div>
                    <div class="stat-val">${totalUsers}</div>
                    <div style="font-size: 12px; color: #0891b2; margin-top: 4px; font-weight: 600;">
                        <a href="${pageContext.request.contextPath}/admin/users" style="color: inherit; text-decoration: none;">
                            Quản lý tài khoản &rarr;
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Cảnh Báo Tồn Kho Sắp Hết (Nếu Có) -->
        <c:if test="${not empty lowStockProducts}">
            <div class="admin-card" style="border-left: 4px solid #ef4444; margin-bottom: 24px;">
                <div class="admin-card-header" style="background: #fef2f2;">
                    <div class="admin-card-title" style="color: #b91c1c;">
                        <i class="fa-solid fa-triangle-exclamation"></i> CẢNH BÁO TỒN KHO THẤP (DƯỚI 5 CHIẾC)
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/products" class="admin-btn admin-btn-sm admin-btn-secondary">
                        Quản lý tồn kho &rarr;
                    </a>
                </div>
                <div class="table-responsive">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Ảnh</th>
                                <th>Mã SKU</th>
                                <th>Tên Sản Phẩm</th>
                                <th>Danh Mục</th>
                                <th>Tồn Kho</th>
                                <th>Giá Bán</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="lp" items="${lowStockProducts}">
                                <tr>
                                    <td>
                                        <c:set var="lpImgIdx" value="${lp.id > 0 ? ((lp.id - 1) % 7 + 1) : 1}" />
                                        <c:set var="fallbackLpImg" value="${pageContext.request.contextPath}/assets/img/product-${lpImgIdx}.jpg" />
                                        <img src="${not empty lp.mainImageUrl ? lp.mainImageUrl : fallbackLpImg}" alt="${lp.name}" class="admin-table-thumb"
                                             onerror="this.onerror=null; this.src='${fallbackLpImg}';">
                                    </td>
                                    <td><strong>${lp.sku}</strong></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${lp.id}" style="color: var(--admin-text); font-weight: 600; text-decoration: none;">
                                            ${lp.name}
                                        </a>
                                    </td>
                                    <td><span style="font-size: 12px; color: var(--admin-muted);">${lp.categoryName}</span></td>
                                    <td>
                                        <span class="stock-badge-low">Chỉ còn ${lp.stockQuantity} chiếc</span>
                                    </td>
                                    <td><span class="price-accent">${lp.getFormattedEffectivePrice()}</span></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${lp.id}" class="admin-btn admin-btn-sm admin-btn-secondary">
                                            <i class="fa-solid fa-pen-to-square"></i> Cập nhật kho
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>

        <!-- Bảng 5 Đơn Hàng Mới Nhất -->
        <div class="admin-card">
            <div class="admin-card-header">
                <div class="admin-card-title">
                    <i class="fa-solid fa-list-check" style="color: var(--admin-primary);"></i> ĐƠN HÀNG MỚI ĐẶT GẦN ĐÂY
                </div>
                <a href="${pageContext.request.contextPath}/admin/orders" class="admin-btn admin-btn-secondary admin-btn-sm">
                    Xem tất cả đơn hàng &rarr;
                </a>
            </div>
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Mã Đơn Hàng</th>
                            <th>Khách Hàng</th>
                            <th>Số Điện Thoại</th>
                            <th>Thời Gian Đặt</th>
                            <th>Tổng Tiền</th>
                            <th>Thanh Toán</th>
                            <th>Trạng Thái</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ord" items="${recentOrders}">
                            <tr>
                                <td>
                                    <strong style="color: #0f172a; letter-spacing: 0.5px;">${ord.orderCode}</strong>
                                </td>
                                <td><strong>${ord.customerName}</strong></td>
                                <td>${ord.customerPhone}</td>
                                <td><span style="color: var(--admin-muted); font-size: 12px;"><fmt:formatDate value="${ord.createdAt}" pattern="dd/MM/yyyy HH:mm" /></span></td>
                                <td><span class="price-accent">${ord.formattedTotalAmount}</span></td>
                                <td>
                                    <span style="font-size: 12px; font-weight: 600; color: #475569;">
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
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${ord.id}" class="admin-btn admin-btn-sm admin-btn-secondary">
                                        <i class="fa-solid fa-eye"></i> Chi tiết
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty recentOrders}">
                            <tr>
                                <td colspan="8" style="text-align: center; color: var(--admin-muted); padding: 36px;">
                                    <i class="fa-regular fa-folder-open" style="font-size: 32px; margin-bottom: 8px; display: block; opacity: 0.5;"></i>
                                    Chưa có đơn hàng nào trong hệ thống.
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
