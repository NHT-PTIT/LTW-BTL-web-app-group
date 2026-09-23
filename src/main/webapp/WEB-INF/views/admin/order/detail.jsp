<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div style="display: flex; align-items: center; gap: 14px;">
            <a href="${pageContext.request.contextPath}/admin/orders" class="admin-btn admin-btn-secondary admin-btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Quay Lại
            </a>
            <div>
                <div class="admin-topbar-title">CHI TIẾT ĐƠN HÀNG #${order.orderCode}</div>
                <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                    Đặt lúc: <strong><fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm" /></strong>
                </p>
            </div>
        </div>
        <div style="display: flex; align-items: center; gap: 10px;">
            <button onclick="window.print()" class="admin-btn admin-btn-secondary">
                <i class="fa-solid fa-print"></i> In Hóa Đơn
            </button>
            <a href="${pageContext.request.contextPath}/track-order?keyword=${order.orderCode}" target="_blank" class="admin-btn admin-btn-secondary">
                <i class="fa-solid fa-arrow-up-right-from-square"></i> Xem Trang Khách
            </a>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <!-- Thông báo kết quả -->
        <c:if test="${param.msg == 'status_updated'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Trạng thái đơn hàng đã được cập nhật thành công!
            </div>
        </c:if>
        <c:if test="${param.err == 'update_failed'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-circle-exclamation"></i> Có lỗi xảy ra khi cập nhật trạng thái đơn hàng. Vui lòng thử lại.
            </div>
        </c:if>

        <div class="form-grid-3">
            <!-- Cột Trái: Danh Sách Thiết Bị & Khách Hàng -->
            <div>
                <!-- Card 1: Danh sách thiết bị đã mua -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <div class="admin-card-title">
                            <i class="fa-solid fa-boxes-stacked" style="color: var(--admin-primary);"></i> CÁC MẶT HÀNG ĐÃ ĐẶT (${order.items.size()} mặt hàng)
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>Ảnh</th>
                                    <th>Thiết Bị</th>
                                    <th>Mã SKU</th>
                                    <th>Đơn Giá</th>
                                    <th>Số Lượng</th>
                                    <th style="text-align: right;">Thành Tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${order.items}">
                                    <tr>
                                        <td>
                                            <c:set var="itemImgIdx" value="${item.productId > 0 ? ((item.productId - 1) mod 7 + 1) : 1}" />
                                            <c:set var="fallbackItemImg" value="${pageContext.request.contextPath}/assets/img/product-${itemImgIdx}.jpg" />
                                            <c:set var="itemImgSrc" value="${fallbackItemImg}" />
                                            <c:if test="${not empty item.productImage}">
                                                <c:choose>
                                                    <c:when test="${item.productImage.startsWith('http://') || item.productImage.startsWith('https://')}">
                                                        <c:set var="itemImgSrc" value="${item.productImage}" />
                                                    </c:when>
                                                    <c:when test="${item.productImage.startsWith('/')}">
                                                        <c:set var="itemImgSrc" value="${pageContext.request.contextPath}${item.productImage}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="itemImgSrc" value="${pageContext.request.contextPath}/${item.productImage}" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                            <img src="${itemImgSrc}" alt="<c:out value='${item.productName}' />" class="admin-table-thumb"
                                                 onerror="this.onerror=null; this.src='${fallbackItemImg}';">
                                        </td>
                                        <td>
                                            <strong>${item.productName}</strong>
                                        </td>
                                        <td><span style="font-size: 12px; color: var(--admin-muted);">${item.productSku}</span></td>
                                        <td>${item.formattedUnitPrice}</td>
                                        <td><strong>x ${item.quantity}</strong></td>
                                        <td style="text-align: right;"><span class="price-accent">${item.formattedSubtotal}</span></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="5" style="text-align: right; font-weight: 700; font-size: 15px; text-transform: uppercase;">
                                        Tổng Giá Trị Đơn Hàng:
                                    </td>
                                    <td style="text-align: right;">
                                        <span class="price-accent" style="font-size: 18px; font-weight: 700;">
                                            ${order.formattedTotalAmount}
                                        </span>
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                <!-- Card 2: Thông tin khách hàng & Giao nhận -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <div class="admin-card-title">
                            <i class="fa-solid fa-address-card" style="color: var(--admin-primary);"></i> THÔNG TIN KHÁCH HÀNG & GIAO HÀNG
                        </div>
                    </div>
                    <div class="admin-card-body">
                        <div class="form-grid-2">
                            <div>
                                <div style="font-size: 12px; color: var(--admin-muted); margin-bottom: 2px;">HỌ TÊN NGƯỜI NHẬN</div>
                                <div style="font-size: 15px; font-weight: 700; color: #0f172a;">${order.customerName}</div>
                            </div>
                            <div>
                                <div style="font-size: 12px; color: var(--admin-muted); margin-bottom: 2px;">SỐ ĐIỆN THOẠI LIÊN HỆ</div>
                                <div style="font-size: 15px; font-weight: 700;">
                                    <a href="tel:${order.customerPhone}" style="color: #0284c7; text-decoration: none;">
                                        <i class="fa-solid fa-phone me-1"></i> ${order.customerPhone}
                                    </a>
                                </div>
                            </div>
                            <div>
                                <div style="font-size: 12px; color: var(--admin-muted); margin-bottom: 2px;">ĐỊA CHỈ EMAIL</div>
                                <div style="font-size: 14px; font-weight: 500;">${not empty order.customerEmail ? order.customerEmail : 'Không cung cấp'}</div>
                            </div>
                            <div>
                                <div style="font-size: 12px; color: var(--admin-muted); margin-bottom: 2px;">PHƯƠNG THỨC THANH TOÁN</div>
                                <div style="font-size: 14px; font-weight: 600; color: #334155;">
                                    ${order.paymentMethod == 'BANK_TRANSFER' ? 'Chuyển khoản qua ngân hàng (Vietcombank)' : 'Thanh toán tiền mặt khi nhận hàng (COD)'}
                                </div>
                            </div>
                        </div>

                        <div style="margin-top: 18px; padding-top: 14px; border-top: 1px solid var(--admin-border);">
                            <div style="font-size: 12px; color: var(--admin-muted); margin-bottom: 4px;">ĐỊA CHỈ GIAO HÀNG CHI TIẾT</div>
                            <div style="font-size: 14px; color: #1e293b; background: #f8fafc; padding: 12px; border-radius: 6px; border: 1px solid #e2e8f0;">
                                <i class="fa-solid fa-location-dot me-2" style="color: var(--admin-primary);"></i>
                                ${order.shippingAddress}
                            </div>
                        </div>

                        <c:if test="${not empty order.note}">
                            <div style="margin-top: 14px;">
                                <div style="font-size: 12px; color: var(--admin-muted); margin-bottom: 4px;">GHI CHÚ CỦA KHÁCH HÀNG</div>
                                <div style="font-size: 13px; font-style: italic; color: #475569; background: #fffbeb; padding: 10px 14px; border-radius: 6px; border-left: 3px solid #f59e0b;">
                                    "${order.note}"
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Cột Phải: Duyệt & Đổi Trạng Thái Đơn Hàng -->
            <div>
                <div class="admin-card">
                    <div class="admin-card-header">
                        <div class="admin-card-title">
                            <i class="fa-solid fa-sliders" style="color: var(--admin-primary);"></i> DUYỆT TRẠNG THÁI
                        </div>
                    </div>
                    <div class="admin-card-body">
                        <div style="margin-bottom: 18px; text-align: center; padding: 14px; background: #f8fafc; border-radius: 8px; border: 1px solid var(--admin-border);">
                            <div style="font-size: 12px; color: var(--admin-muted); margin-bottom: 6px;">TRẠNG THÁI HIỆN TẠI</div>
                            <c:choose>
                                <c:when test="${order.status == 'COMPLETED'}">
                                    <span class="status-badge status-completed" style="font-size: 14px; padding: 6px 14px;">
                                        <i class="fa-solid fa-check-circle"></i> ĐÃ HOÀN TẤT
                                    </span>
                                </c:when>
                                <c:when test="${order.status == 'SHIPPING'}">
                                    <span class="status-badge status-shipping" style="font-size: 14px; padding: 6px 14px;">
                                        <i class="fa-solid fa-truck-fast"></i> ĐANG GIAO HÀNG
                                    </span>
                                </c:when>
                                <c:when test="${order.status == 'CANCELLED'}">
                                    <span class="status-badge status-cancelled" style="font-size: 14px; padding: 6px 14px;">
                                        <i class="fa-solid fa-ban"></i> ĐÃ HỦY ĐƠN
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-pending" style="font-size: 14px; padding: 6px 14px;">
                                        <i class="fa-solid fa-hourglass-half"></i> CHỜ DUYỆT ĐƠN
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Form Cập Nhật Trạng Thái -->
                        <form action="${pageContext.request.contextPath}/admin/orders" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn thay đổi trạng thái đơn hàng này?');">
                            <input type="hidden" name="action" value="update-status">
                            <input type="hidden" name="orderId" value="${order.id}">

                            <div class="admin-form-group">
                                <label class="admin-form-label">CHUYỂN SANG TRẠNG THÁI MỚI:</label>
                                <select name="status" class="admin-select" style="font-weight: 600;">
                                    <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>⏳ Chờ xử lý (PENDING)</option>
                                    <option value="SHIPPING" ${order.status == 'SHIPPING' ? 'selected' : ''}>🚚 Đang vận chuyển (SHIPPING)</option>
                                    <option value="COMPLETED" ${order.status == 'COMPLETED' ? 'selected' : ''}>✅ Đã giao thành công (COMPLETED)</option>
                                    <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>❌ Hủy đơn hàng (CANCELLED)</option>
                                </select>
                            </div>

                            <button type="submit" class="admin-btn admin-btn-primary" style="width: 100%; justify-content: center; padding: 11px;">
                                <i class="fa-solid fa-floppy-disk"></i> LƯU TRẠNG THÁI
                            </button>
                        </form>

                        <div style="font-size: 12px; color: var(--admin-muted); margin-top: 14px; line-height: 1.4;">
                            <i class="fa-solid fa-circle-info me-1"></i> Khi bạn cập nhật trạng thái tại đây, khách hàng có thể tra cứu mã <strong>${order.orderCode}</strong> trên trang chủ và nhận được thông tin tức thời.
                        </div>
                    </div>
                </div>

                <!-- Thao Tác Nhanh -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <div class="admin-card-title">
                            <i class="fa-solid fa-phone" style="color: var(--admin-primary);"></i> LIÊN HỆ KHÁCH
                        </div>
                    </div>
                    <div class="admin-card-body" style="display: flex; flex-direction: column; gap: 8px;">
                        <a href="tel:${order.customerPhone}" class="admin-btn admin-btn-secondary" style="justify-content: center;">
                            <i class="fa-solid fa-phone"></i> Gọi Điện Cho Khách
                        </a>
                        <c:if test="${not empty order.customerEmail}">
                            <a href="mailto:${order.customerEmail}?subject=Xác nhận đơn hàng ${order.orderCode} từ Bleezy Solar" class="admin-btn admin-btn-secondary" style="justify-content: center;">
                                <i class="fa-solid fa-envelope"></i> Gửi Email Thông Báo
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>
</body>
</html>
