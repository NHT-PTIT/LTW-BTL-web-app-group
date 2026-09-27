<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Top Info Bar -->
<div class="top-bar">
    <div class="container" style="display: flex; justify-content: space-between; align-items: center;">
        <div>
            <i class="fa-solid fa-phone me-1"></i> Hotline: <strong>${companyInfo != null ? companyInfo.hotline : '1900 6868'}</strong>
            <span style="margin: 0 10px; opacity: 0.4;">|</span>
            <i class="fa-solid fa-envelope me-1"></i> ${companyInfo != null ? companyInfo.email : 'contact@ptittech.vn'}
        </div>
        <div>
            <!-- Khu vực thông tin liên hệ -->
        </div>
    </div>
</div>

<!-- Main Header -->
<header class="main-header">
    <div class="container">
        <div class="navbar-inner">
            <!-- Brand Logo -->
            <a href="${pageContext.request.contextPath}/" class="logo-brand">
                <i class="fa-solid fa-bolt" style="color: #2563eb;"></i>
                PTIT<span>TECH</span>
            </a>

            <!-- Search Form -->
            <form action="${pageContext.request.contextPath}/products" method="GET" class="search-form">
                <input type="text" name="keyword" value="${param.keyword}" placeholder="Tìm kiếm biến tần, aptomat, thương hiệu, công suất...">
                <button type="submit">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
            </form>

            <!-- Cart Trigger Button -->
            <a href="${pageContext.request.contextPath}/cart" class="cart-trigger">
                <i class="fa-solid fa-cart-shopping" style="color: #2563eb; font-size: 18px;"></i>
                <span>Giỏ hàng</span>
                <span class="cart-badge">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</span>
            </a>
        </div>
    </div>

    <!-- Navigation Menu Bar -->
    <nav style="background: var(--primary);">
        <div class="container">
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/" class="nav-link">
                        <i class="fa-solid fa-house me-1"></i> Trang Chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/products" class="nav-link">
                        <i class="fa-solid fa-boxes-stacked me-1"></i> Tất Cả Sản Phẩm
                    </a>
                </li>

                <!-- Danh mục đa cấp nạp động từ CSDL -->
                <c:forEach var="cat" items="${categoryTree}">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/products?category=${cat.id}" class="nav-link">
                            ${cat.name}
                        </a>
                    </li>
                </c:forEach>

                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/about" class="nav-link">
                        <i class="fa-solid fa-circle-info me-1"></i> Giới Thiệu
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/contact" class="nav-link">
                        <i class="fa-solid fa-headset me-1"></i> Liên Hệ & Tư Vấn
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</header>
