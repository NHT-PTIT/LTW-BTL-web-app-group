<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div style="display: flex; align-items: center; gap: 14px;">
            <a href="${pageContext.request.contextPath}/admin/users" class="admin-btn admin-btn-secondary admin-btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Danh Sách
            </a>
            <div>
                <div class="admin-topbar-title">HỒ SƠ KHÁCH HÀNG #${customer.id}</div>
                <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                    Thành viên: <strong><c:out value="${customer.fullName}"/></strong> (@<c:out value="${customer.username}"/>)
                </p>
            </div>
        </div>
        <div style="display: flex; align-items: center; gap: 10px;">
            <c:choose>
                <c:when test="${customer.active}">
                    <span class="admin-badge admin-badge-completed" style="font-size: 12px; padding: 6px 12px;">
                        <i class="fa-solid fa-check"></i> Đang hoạt động
                    </span>
                </c:when>
                <c:otherwise>
                    <span class="admin-badge admin-badge-cancelled" style="font-size: 12px; padding: 6px 12px;">
                        <i class="fa-solid fa-lock"></i> Đang bị khóa
                    </span>
                </c:otherwise>
            </c:choose>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <!-- Thông báo -->
        <c:if test="${param.msg == 'status_updated'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Cập nhật trạng thái kích hoạt tài khoản thành công!
            </div>
        </c:if>
        <c:if test="${param.msg == 'pwd_reset_success'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Đặt lại mật khẩu cho khách hàng thành công! Mật khẩu mới đã được cập nhật.
            </div>
        </c:if>
        <c:if test="${param.err == 'update_failed' || param.err == 'pwd_reset_failed'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-circle-exclamation"></i> Có lỗi xảy ra trong quá trình thực hiện tác vụ. Vui lòng thử lại!
            </div>
        </c:if>

        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 24px;">
            
            <!-- Cột Trái: Lịch sử đơn hàng & Tổng hợp mua sắm -->
            <div>
                <!-- Card: Lịch sử đơn hàng của khách -->
                <div class="admin-card mb-4">
                    <div class="admin-card-header" style="display: flex; justify-content: space-between; align-items: center;">
                        <div class="admin-card-title">
                            <i class="fa-solid fa-receipt" style="color: var(--admin-primary);"></i> LỊCH SỬ ĐƠN HÀNG (${customerOrders.size()} đơn)
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>Mã Đơn</th>
                                    <th>Ngày Đặt</th>
                                    <th>Thanh Toán</th>
                                    <th style="text-align: right;">Tổng Tiền</th>
                                    <th>Trạng Thái</th>
                                    <th style="text-align: right;">Chi Tiết</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="ord" items="${customerOrders}">
                                    <tr>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${ord.id}" 
                                               style="font-weight: 700; color: #0f172a; text-decoration: none;">
                                                ${ord.orderCode}
                                            </a>
                                        </td>
                                        <td style="font-size: 13px; color: var(--admin-muted);">
                                            <fmt:formatDate value="${ord.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td>
                                            <span style="font-size: 12px; font-weight: 600; color: #475569; background: #f1f5f9; padding: 2px 8px; border-radius: 4px;">
                                                ${ord.paymentMethod}
                                            </span>
                                        </td>
                                        <td style="text-align: right;">
                                            <strong style="color: #f26723; font-family: 'Oswald', sans-serif;">
                                                ${ord.formattedTotalAmount}
                                            </strong>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${ord.status == 'PENDING'}">
                                                    <span class="admin-badge admin-badge-pending">Chờ xử lý</span>
                                                </c:when>
                                                <c:when test="${ord.status == 'SHIPPING'}">
                                                    <span class="admin-badge admin-badge-shipping">Đang giao</span>
                                                </c:when>
                                                <c:when test="${ord.status == 'COMPLETED'}">
                                                    <span class="admin-badge admin-badge-completed">Hoàn tất</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="admin-badge admin-badge-cancelled">Đã hủy</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="text-align: right;">
                                            <a href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${ord.id}" 
                                               class="admin-btn admin-btn-secondary admin-btn-sm" title="Xem chi tiết đơn này">
                                                <i class="fa-solid fa-arrow-up-right-from-square"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty customerOrders}">
                                    <tr>
                                        <td colspan="6" style="text-align: center; padding: 40px; color: var(--admin-muted);">
                                            <i class="fa-solid fa-box-open" style="font-size: 32px; margin-bottom: 10px; opacity: 0.5;"></i>
                                            <div>Khách hàng này chưa có đơn hàng nào trong hệ thống.</div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Card: Thống Kê Chi Tiêu Của Khách Hàng -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <div class="admin-card-title">
                            <i class="fa-solid fa-chart-pie" style="color: var(--admin-primary);"></i> TỔNG QUAN TÍCH LŨY
                        </div>
                    </div>
                    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px; padding: 20px;">
                        <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 15px; text-align: center;">
                            <div style="font-size: 12px; color: #64748b; font-weight: 600; text-transform: uppercase;">Tổng Số Đơn</div>
                            <div style="font-size: 24px; font-weight: 800; color: #0f172a; margin-top: 5px; font-family: 'Oswald', sans-serif;">
                                ${customer.totalOrders}
                            </div>
                        </div>
                        <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 15px; text-align: center;">
                            <div style="font-size: 12px; color: #64748b; font-weight: 600; text-transform: uppercase;">Tổng Chi Tiêu</div>
                            <div style="font-size: 22px; font-weight: 800; color: #f26723; margin-top: 5px; font-family: 'Oswald', sans-serif;">
                                ${customer.formattedTotalSpent}
                            </div>
                        </div>
                        <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 15px; text-align: center;">
                            <div style="font-size: 12px; color: #64748b; font-weight: 600; text-transform: uppercase;">Trạng Thái Tài Khoản</div>
                            <div style="font-size: 16px; font-weight: 700; margin-top: 8px; color: ${customer.active ? '#16a34a' : '#dc2626'};">
                                ${customer.active ? 'Bình thường' : 'Đang tạm khóa'}
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cột Phải: Thông tin tài khoản & Hành động Admin -->
            <div>
                <!-- Card Thông Tin Khách Hàng -->
                <div class="admin-card mb-4">
                    <div class="admin-card-header">
                        <div class="admin-card-title">
                            <i class="fa-solid fa-address-card" style="color: var(--admin-primary);"></i> HỒ SƠ THÀNH VIÊN
                        </div>
                    </div>
                    <div style="padding: 24px; text-align: center; border-bottom: 1px solid #f1f5f9;">
                        <div style="width: 72px; height: 72px; border-radius: 50%; background: #0f172a; color: #f26723; font-weight: 800; display: inline-flex; align-items: center; justify-content: center; font-size: 28px; border: 3px solid #e2e8f0; margin-bottom: 12px;">
                            ${customer.avatarInitial}
                        </div>
                        <h4 style="margin: 0; font-size: 18px; font-weight: 700; color: #0f172a;"><c:out value="${customer.fullName}"/></h4>
                        <div style="font-size: 13px; color: #64748b; margin-top: 4px;">@<c:out value="${customer.username}"/></div>
                    </div>
                    <div style="padding: 20px;">
                        <div style="margin-bottom: 15px;">
                            <div style="font-size: 11px; font-weight: 700; text-transform: uppercase; color: #64748b;">Địa chỉ Email:</div>
                            <div style="font-size: 14px; font-weight: 600; color: #0f172a; margin-top: 3px;">
                                <i class="fa-solid fa-envelope" style="color: #94a3b8; width: 16px;"></i> <c:out value="${customer.email}"/>
                            </div>
                        </div>
                        <div style="margin-bottom: 15px;">
                            <div style="font-size: 11px; font-weight: 700; text-transform: uppercase; color: #64748b;">Số Điện Thoại:</div>
                            <div style="font-size: 14px; font-weight: 600; color: #0f172a; margin-top: 3px;">
                                <i class="fa-solid fa-phone" style="color: #94a3b8; width: 16px;"></i> <c:out value="${not empty customer.phone ? customer.phone : 'Chưa cập nhật'}"/>
                            </div>
                        </div>
                        <div style="margin-bottom: 15px;">
                            <div style="font-size: 11px; font-weight: 700; text-transform: uppercase; color: #64748b;">Địa Chỉ Mặc Định:</div>
                            <div style="font-size: 13px; color: #334155; margin-top: 3px; line-height: 1.5;">
                                <i class="fa-solid fa-location-dot" style="color: #94a3b8; width: 16px;"></i> <c:out value="${not empty customer.address ? customer.address : 'Chưa thiết lập'}"/>
                            </div>
                        </div>
                        <div style="margin-bottom: 15px;">
                            <div style="font-size: 11px; font-weight: 700; text-transform: uppercase; color: #64748b;">Ngày Đăng Ký:</div>
                            <div style="font-size: 13px; color: #334155; margin-top: 3px;">
                                <i class="fa-solid fa-calendar-days" style="color: #94a3b8; width: 16px;"></i> 
                                <fmt:formatDate value="${customer.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Card Thao Tác Quản Trị -->
                <div class="admin-card">
                    <div class="admin-card-header">
                        <div class="admin-card-title">
                            <i class="fa-solid fa-sliders" style="color: var(--admin-primary);"></i> HÀNH ĐỘNG QUẢN TRỊ
                        </div>
                    </div>
                    <div style="padding: 20px;">
                        <!-- Khóa / Mở Khóa Tài Khoản -->
                        <div style="margin-bottom: 20px; padding-bottom: 20px; border-bottom: 1px solid #f1f5f9;">
                            <div style="font-size: 13px; font-weight: 700; color: #0f172a; margin-bottom: 6px;">Quyền Truy Cập Hệ Thống:</div>
                            <p style="font-size: 12px; color: var(--admin-muted); margin-bottom: 12px;">
                                Khi bị khóa, khách hàng sẽ lập tức bị chặn đăng nhập vào Portal và không thể tiếp tục đặt đơn.
                            </p>
                            <form action="${pageContext.request.contextPath}/admin/users" method="post"
                                  onsubmit="return confirm('${customer.active ? 'Bạn có chắc chắn muốn TẠM KHÓA tài khoản này không?' : 'Bạn có chắc chắn muốn MỞ KHÓA tài khoản này không?'}');">
                                <input type="hidden" name="action" value="toggle-status">
                                <input type="hidden" name="userId" value="${customer.id}">
                                <input type="hidden" name="redirectUrl" value="${pageContext.request.contextPath}/admin/users?action=detail&id=${customer.id}">
                                
                                <c:choose>
                                    <c:when test="${customer.active}">
                                        <button type="submit" class="admin-btn" style="width: 100%; justify-content: center; background: #fff1f2; color: #e11d48; border: 1px solid #fecdd3;">
                                            <i class="fa-solid fa-lock"></i> Tạm Khóa Tài Khoản Này
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="submit" class="admin-btn" style="width: 100%; justify-content: center; background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0;">
                                            <i class="fa-solid fa-lock-open"></i> Mở Khóa Tài Khoản
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </form>
                        </div>

                        <!-- Reset Mật Khẩu Hỗ Trợ Khách Hàng -->
                        <div>
                            <div style="font-size: 13px; font-weight: 700; color: #0f172a; margin-bottom: 6px;">Cấp Lại Mật Khẩu Khách Hàng:</div>
                            <p style="font-size: 12px; color: var(--admin-muted); margin-bottom: 12px;">
                                Hỗ trợ trường hợp khách hàng quên mật khẩu hoặc cần reset bảo mật. Mật khẩu mặc định là <code>Password@123</code>.
                            </p>
                            <form action="${pageContext.request.contextPath}/admin/users" method="post"
                                  onsubmit="return confirm('Bạn có chắc chắn muốn đặt lại mật khẩu cho khách hàng này không?');">
                                <input type="hidden" name="action" value="reset-password">
                                <input type="hidden" name="userId" value="${customer.id}">
                                <div style="display: flex; gap: 8px;">
                                    <input type="text" name="newPassword" value="Password@123" class="admin-search-input" style="flex: 1; font-size: 13px;" required>
                                    <button type="submit" class="admin-btn admin-btn-secondary" style="white-space: nowrap;">
                                        <i class="fa-solid fa-key"></i> Đặt Lại
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
</main>

<jsp:include page="/WEB-INF/views/common/admin-footer.jsp" />
