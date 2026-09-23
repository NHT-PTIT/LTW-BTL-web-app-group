<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="admin-sidebar">
    <!-- Brand Logo Area -->
    <div class="admin-brand">
        <a href="${pageContext.request.contextPath}/admin/dashboard" style="display: flex; align-items: center; gap: 10px; text-decoration: none;">
            <img src="${pageContext.request.contextPath}/assets/img/site-logo.png" alt="Bleezy Logo" class="admin-brand-logo" 
                 onerror="this.style.display='none'; document.getElementById('brand-fallback').style.display='inline-flex';">
            <span id="brand-fallback" style="display:none; color: #f26723; font-size: 22px; font-weight: 800;"><i class="fa-solid fa-solar-panel"></i></span>
            <div>
                <div class="admin-brand-title">BLEEZY SOLAR</div>
                <span class="admin-brand-badge">ADMIN PORTAL</span>
            </div>
        </a>
    </div>

    <!-- Navigation Links -->
    <ul class="admin-nav">
        <li class="admin-nav-item">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-nav-link ${activeMenu == 'dashboard' ? 'active' : ''}">
                <div class="admin-nav-link-content">
                    <i class="fa-solid fa-gauge-high"></i>
                    <span>Bảng điều khiển</span>
                </div>
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="${pageContext.request.contextPath}/admin/orders" class="admin-nav-link ${activeMenu == 'orders' ? 'active' : ''}">
                <div class="admin-nav-link-content">
                    <i class="fa-solid fa-receipt"></i>
                    <span>Quản lý Đơn hàng</span>
                </div>
                <c:if test="${not empty pendingOrderCount && pendingOrderCount > 0}">
                    <span class="nav-badge nav-badge-pending">${pendingOrderCount}</span>
                </c:if>
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="${pageContext.request.contextPath}/admin/users" class="admin-nav-link ${activeMenu == 'users' ? 'active' : ''}">
                <div class="admin-nav-link-content">
                    <i class="fa-solid fa-users"></i>
                    <span>Quản lý Khách hàng</span>
                </div>
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="${pageContext.request.contextPath}/admin/products" class="admin-nav-link ${activeMenu == 'products' ? 'active' : ''}">
                <div class="admin-nav-link-content">
                    <i class="fa-solid fa-boxes-stacked"></i>
                    <span>Quản lý Sản phẩm</span>
                </div>
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="${pageContext.request.contextPath}/admin/categories" class="admin-nav-link ${activeMenu == 'categories' ? 'active' : ''}">
                <div class="admin-nav-link-content">
                    <i class="fa-solid fa-folder-tree"></i>
                    <span>Quản lý Danh mục</span>
                </div>
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="${pageContext.request.contextPath}/admin/contacts" class="admin-nav-link ${activeMenu == 'contacts' ? 'active' : ''}">
                <div class="admin-nav-link-content">
                    <i class="fa-solid fa-envelope-open-text"></i>
                    <span>Yêu cầu Tư vấn & LH</span>
                </div>
                <c:if test="${not empty newInquiryCount && newInquiryCount > 0}">
                    <span class="nav-badge nav-badge-info">${newInquiryCount}</span>
                </c:if>
            </a>
        </li>
    </ul>

    <!-- Footer Profile & Logout -->
    <div class="admin-sidebar-footer">
        <div class="admin-user-info">
            <div class="admin-user-avatar">
                <i class="fa-solid fa-user-shield"></i>
            </div>
            <div style="flex: 1; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                <div style="font-weight: 600; color: #fff; font-size: 13px;">${sessionScope.currentAdmin.fullName}</div>
                <div style="font-size: 11px; color: #94a3b8;">${sessionScope.currentAdmin.role}</div>
            </div>
        </div>
        <div style="display: flex; align-items: center; justify-content: space-between; margin-top: 10px; padding-top: 10px; border-top: 1px solid rgba(255,255,255,0.06);">
            <a href="${pageContext.request.contextPath}/" target="_blank" style="color: #94a3b8; font-size: 12px; text-decoration: none;" title="Xem website người dùng">
                <i class="fa-solid fa-arrow-up-right-from-square me-1"></i> Trang chủ
            </a>
            <a href="${pageContext.request.contextPath}/admin/logout" class="admin-logout-btn">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </div>
    </div>
</aside>
