<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="admin-sidebar">
    <div class="admin-brand">
        <i class="fa-solid fa-gauge-high" style="color: #3b82f6;"></i>
        <span>PTIT Admin</span>
    </div>

    <ul class="admin-nav">
        <li class="admin-nav-item">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-nav-link ${activeMenu == 'dashboard' ? 'active' : ''}">
                <i class="fa-solid fa-chart-line"></i>
                <span>Bảng điều khiển</span>
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="${pageContext.request.contextPath}/admin/products" class="admin-nav-link ${activeMenu == 'products' ? 'active' : ''}">
                <i class="fa-solid fa-boxes-stacked"></i>
                <span>Quản lý Sản phẩm</span>
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="${pageContext.request.contextPath}/admin/categories" class="admin-nav-link ${activeMenu == 'categories' ? 'active' : ''}">
                <i class="fa-solid fa-folder-tree"></i>
                <span>Quản lý Danh mục</span>
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="${pageContext.request.contextPath}/admin/orders" class="admin-nav-link ${activeMenu == 'orders' ? 'active' : ''}">
                <i class="fa-solid fa-receipt"></i>
                <span>Quản lý Đơn hàng</span>
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="${pageContext.request.contextPath}/admin/contacts" class="admin-nav-link ${activeMenu == 'contacts' ? 'active' : ''}">
                <i class="fa-solid fa-envelope-open-text"></i>
                <span>Yêu cầu Tư vấn & LH</span>
            </a>
        </li>
        <li class="admin-nav-item">
            <a href="${pageContext.request.contextPath}/admin/cms" class="admin-nav-link ${activeMenu == 'cms' ? 'active' : ''}">
                <i class="fa-solid fa-pen-to-square"></i>
                <span>Nội dung & Nhân sự</span>
            </a>
        </li>
    </ul>

    <div style="padding: 16px 20px; border-top: 1px solid rgba(255,255,255,0.08);">
        <div style="font-size: 13px; color: #94a3b8; margin-bottom: 8px;">
            <i class="fa-solid fa-user-shield me-1"></i> ${sessionScope.currentAdmin.fullName}
        </div>
        <a href="${pageContext.request.contextPath}/admin/logout" style="color: #ef4444; font-size: 13px; font-weight: 600; display: flex; align-items: center; gap: 6px;">
            <i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất
        </a>
    </div>
</aside>
