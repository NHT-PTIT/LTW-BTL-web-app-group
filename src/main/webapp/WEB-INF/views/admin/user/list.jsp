<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div>
            <div class="admin-topbar-title">QUẢN LÝ KHÁCH HÀNG</div>
            <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                Quản lý danh sách tài khoản thành viên, lịch sử mua sắm và quyền truy cập cổng Portal.
            </p>
        </div>
        <div style="display: flex; gap: 10px;">
            <a href="${pageContext.request.contextPath}/admin/orders" class="admin-btn admin-btn-secondary">
                <i class="fa-solid fa-receipt"></i> Xem Đơn Hàng
            </a>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <!-- Thông Báo -->
        <c:if test="${param.msg == 'status_updated'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Cập nhật trạng thái kích hoạt tài khoản thành công!
            </div>
        </c:if>
        <c:if test="${param.err == 'update_failed'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-circle-exclamation"></i> Có lỗi xảy ra trong quá trình cập nhật trạng thái tài khoản.
            </div>
        </c:if>
        <c:if test="${param.err == 'not_found'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-circle-exclamation"></i> Không tìm thấy thông tin khách hàng yêu cầu!
            </div>
        </c:if>

        <!-- KPI Cards Thống Kê Nhanh -->
        <div class="row g-3 mb-4" style="display: flex; gap: 15px; margin-bottom: 20px;">
            <div style="flex: 1; background: #fff; border-radius: 8px; border: 1px solid #e2e8f0; padding: 18px 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); display: flex; align-items: center; justify-content: space-between;">
                <div>
                    <div style="font-size: 12px; font-weight: 700; text-transform: uppercase; color: #64748b; letter-spacing: 0.5px;">Tổng Khách Hàng</div>
                    <div style="font-size: 26px; font-weight: 800; color: #0f172a; margin-top: 4px; font-family: 'Oswald', sans-serif;">
                        ${userStats['TOTAL']}
                    </div>
                </div>
                <div style="width: 44px; height: 44px; border-radius: 8px; background: #eff6ff; color: #3b82f6; display: flex; align-items: center; justify-content: center; font-size: 20px;">
                    <i class="fa-solid fa-users"></i>
                </div>
            </div>

            <div style="flex: 1; background: #fff; border-radius: 8px; border: 1px solid #e2e8f0; padding: 18px 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); display: flex; align-items: center; justify-content: space-between;">
                <div>
                    <div style="font-size: 12px; font-weight: 700; text-transform: uppercase; color: #64748b; letter-spacing: 0.5px;">Đang Hoạt Động</div>
                    <div style="font-size: 26px; font-weight: 800; color: #16a34a; margin-top: 4px; font-family: 'Oswald', sans-serif;">
                        ${userStats['ACTIVE']}
                    </div>
                </div>
                <div style="width: 44px; height: 44px; border-radius: 8px; background: #f0fdf4; color: #16a34a; display: flex; align-items: center; justify-content: center; font-size: 20px;">
                    <i class="fa-solid fa-user-check"></i>
                </div>
            </div>

            <div style="flex: 1; background: #fff; border-radius: 8px; border: 1px solid #e2e8f0; padding: 18px 20px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); display: flex; align-items: center; justify-content: space-between;">
                <div>
                    <div style="font-size: 12px; font-weight: 700; text-transform: uppercase; color: #64748b; letter-spacing: 0.5px;">Tài Khoản Bị Khóa</div>
                    <div style="font-size: 26px; font-weight: 800; color: #dc2626; margin-top: 4px; font-family: 'Oswald', sans-serif;">
                        ${userStats['LOCKED']}
                    </div>
                </div>
                <div style="width: 44px; height: 44px; border-radius: 8px; background: #fef2f2; color: #dc2626; display: flex; align-items: center; justify-content: center; font-size: 20px;">
                    <i class="fa-solid fa-user-slash"></i>
                </div>
            </div>
        </div>

        <!-- Thanh Lọc & Tìm Kiếm -->
        <div class="admin-filters-bar">
            <!-- Tabs Trạng Thái -->
            <div class="admin-tab-group">
                <a href="${pageContext.request.contextPath}/admin/users?status=ALL<c:if test="${not empty keyword}">&keyword=<c:out value="${keyword}"/></c:if>" 
                   class="admin-tab ${currentStatus == 'ALL' ? 'active' : ''}">
                    Tất cả <span style="font-size: 11px; opacity: 0.8;">(${userStats['TOTAL']})</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/users?status=ACTIVE<c:if test="${not empty keyword}">&keyword=<c:out value="${keyword}"/></c:if>" 
                   class="admin-tab ${currentStatus == 'ACTIVE' ? 'active' : ''}">
                    Hoạt động <span style="font-size: 11px; opacity: 0.8;">(${userStats['ACTIVE']})</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/users?status=LOCKED<c:if test="${not empty keyword}">&keyword=<c:out value="${keyword}"/></c:if>" 
                   class="admin-tab ${currentStatus == 'LOCKED' ? 'active' : ''}">
                    Bị khóa <span style="font-size: 11px; opacity: 0.8;">(${userStats['LOCKED']})</span>
                </a>
            </div>

            <!-- Form Tìm Kiếm -->
            <form action="${pageContext.request.contextPath}/admin/users" method="get" class="admin-search-form">
                <input type="hidden" name="status" value="${currentStatus}">
                <input type="text" name="keyword" value="${keyword}" placeholder="Tên, username, email, SĐT..." class="admin-search-input">
                <button type="submit" class="admin-btn admin-btn-secondary">
                    <i class="fa-solid fa-magnifying-glass"></i> Tìm
                </button>
                <c:if test="${not empty keyword}">
                    <a href="${pageContext.request.contextPath}/admin/users?status=${currentStatus}" class="admin-btn admin-btn-secondary" title="Hủy tìm kiếm">
                        <i class="fa-solid fa-xmark"></i>
                    </a>
                </c:if>
            </form>
        </div>

        <!-- Bảng Dữ Liệu Khách Hàng -->
        <div class="admin-card">
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th style="width: 50px;">#ID</th>
                            <th>Khách Hàng</th>
                            <th>Thông Tin Liên Hệ</th>
                            <th>Địa Chỉ Mặc Định</th>
                            <th style="text-align: center;">Đơn Hàng</th>
                            <th style="text-align: right;">Tổng Chi Tiêu</th>
                            <th>Trạng Thái</th>
                            <th style="text-align: right;">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td>
                                    <span style="font-weight: 600; color: #64748b;">#${u.id}</span>
                                </td>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 12px;">
                                        <div style="width: 38px; height: 38px; border-radius: 50%; background: #0f172a; color: #f26723; font-weight: 700; display: flex; align-items: center; justify-content: center; font-size: 15px; border: 2px solid #e2e8f0;">
                                            ${u.avatarInitial}
                                        </div>
                                        <div>
                                            <a href="${pageContext.request.contextPath}/admin/users?action=detail&id=${u.id}" 
                                               style="font-weight: 700; color: #0f172a; text-decoration: none; font-size: 14px;">
                                                <c:out value="${u.fullName}"/>
                                            </a>
                                            <div style="font-size: 12px; color: var(--admin-muted);">
                                                @<c:out value="${u.username}"/>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div style="font-size: 13px; color: #334155;">
                                        <i class="fa-solid fa-envelope" style="width: 16px; color: #94a3b8; font-size: 12px;"></i>
                                        <c:out value="${u.email}"/>
                                    </div>
                                    <div style="font-size: 13px; color: #334155; margin-top: 3px;">
                                        <i class="fa-solid fa-phone" style="width: 16px; color: #94a3b8; font-size: 12px;"></i>
                                        <c:out value="${not empty u.phone ? u.phone : 'Chưa cập nhật'}"/>
                                    </div>
                                </td>
                                <td>
                                    <span style="font-size: 13px; color: #475569; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; max-width: 250px;">
                                        <c:out value="${not empty u.address ? u.address : 'Chưa có địa chỉ'}"/>
                                    </span>
                                </td>
                                <td style="text-align: center;">
                                    <span class="nav-badge" style="background: #e2e8f0; color: #0f172a; font-weight: 700; font-size: 12px;">
                                        ${u.totalOrders} đơn
                                    </span>
                                </td>
                                <td style="text-align: right;">
                                    <strong style="color: #f26723; font-family: 'Oswald', sans-serif; font-size: 15px;">
                                        ${u.formattedTotalSpent}
                                    </strong>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.active}">
                                            <span class="admin-badge admin-badge-completed" style="display: inline-flex; align-items: center; gap: 5px;">
                                                <i class="fa-solid fa-check"></i> Hoạt động
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="admin-badge admin-badge-cancelled" style="display: inline-flex; align-items: center; gap: 5px;">
                                                <i class="fa-solid fa-ban"></i> Đã khóa
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align: right; white-space: nowrap;">
                                    <div style="display: inline-flex; gap: 6px;">
                                        <!-- Xem Chi Tiết & Đơn Hàng -->
                                        <a href="${pageContext.request.contextPath}/admin/users?action=detail&id=${u.id}" 
                                           class="admin-btn admin-btn-secondary" style="padding: 6px 12px; font-size: 12px;" title="Xem hồ sơ & đơn hàng">
                                            <i class="fa-solid fa-id-card"></i> Hồ sơ
                                        </a>

                                        <!-- Khóa / Mở Khóa Tài Khoản -->
                                        <form action="${pageContext.request.contextPath}/admin/users" method="post" style="display: inline;" 
                                              onsubmit="return confirm('${u.active ? 'Bạn có chắc chắn muốn TẠM KHÓA tài khoản này không? Khách hàng sẽ không thể đăng nhập.' : 'Bạn có chắc chắn muốn MỞ KHÓA cho tài khoản này không?'}');">
                                            <input type="hidden" name="action" value="toggle-status">
                                            <input type="hidden" name="userId" value="${u.id}">
                                            <input type="hidden" name="redirectUrl" value="${pageContext.request.contextPath}/admin/users?status=${currentStatus}&keyword=${keyword}&page=${currentPage}">
                                            
                                            <c:choose>
                                                <c:when test="${u.active}">
                                                    <button type="submit" class="admin-btn" style="padding: 6px 10px; font-size: 12px; background: #fff1f2; color: #e11d48; border: 1px solid #fecdd3;" title="Khóa tài khoản">
                                                        <i class="fa-solid fa-lock"></i>
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="submit" class="admin-btn" style="padding: 6px 10px; font-size: 12px; background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0;" title="Mở khóa tài khoản">
                                                        <i class="fa-solid fa-lock-open"></i>
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty users}">
                            <tr>
                                <td colspan="8" style="text-align: center; padding: 40px; color: var(--admin-muted);">
                                    <i class="fa-solid fa-user-xmark" style="font-size: 32px; margin-bottom: 10px; opacity: 0.5;"></i>
                                    <div>Không tìm thấy khách hàng nào phù hợp với bộ lọc hiện tại.</div>
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
                        <a href="${pageContext.request.contextPath}/admin/users?status=${currentStatus}&keyword=${keyword}&page=${currentPage - 1}" class="admin-page-link">
                            <i class="fa-solid fa-chevron-left"></i>
                        </a>
                    </c:if>
                    
                    <c:forEach begin="1" end="${totalPages}" var="p">
                        <a href="${pageContext.request.contextPath}/admin/users?status=${currentStatus}&keyword=${keyword}&page=${p}" 
                           class="admin-page-link ${p == currentPage ? 'active' : ''}">
                            ${p}
                        </a>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/users?status=${currentStatus}&keyword=${keyword}&page=${currentPage + 1}" class="admin-page-link">
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
