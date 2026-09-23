<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div>
            <div class="admin-topbar-title">QUẢN LÝ SẢN PHẨM</div>
            <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                Tổng số <strong>${totalProducts}</strong> sản phẩm trong danh mục hàng hóa.
            </p>
        </div>
        <div style="display: flex; align-items: center; gap: 10px;">
            <a href="${pageContext.request.contextPath}/admin/products?action=add" class="admin-btn admin-btn-primary">
                <i class="fa-solid fa-plus"></i> Thêm Sản Phẩm Mới
            </a>
            <a href="${pageContext.request.contextPath}/shop" target="_blank" class="admin-btn admin-btn-secondary" title="Xem gian hàng của khách">
                <i class="fa-solid fa-arrow-up-right-from-square"></i> Xem Gian Hàng
            </a>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <!-- Thông Báo -->
        <c:if test="${param.msg == 'saved'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Lưu thông tin sản phẩm thành công!
            </div>
        </c:if>
        <c:if test="${param.msg == 'deleted'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-trash-can"></i> Đã xóa sản phẩm khỏi hệ thống thành công!
            </div>
        </c:if>
        <c:if test="${param.err == 'delete_failed'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-triangle-exclamation"></i> Không thể xóa sản phẩm do đang có đơn hàng liên kết.
            </div>
        </c:if>

        <!-- Thanh Lọc Danh Mục & Tìm Kiếm -->
        <div class="admin-filters-bar">
            <form action="${pageContext.request.contextPath}/admin/products" method="get" style="display: flex; gap: 10px; align-items: center; flex-wrap: wrap;">
                <!-- Dropdown Danh mục -->
                <select name="categoryId" class="admin-select" style="width: 220px;" onchange="this.form.submit()">
                    <option value="ALL">-- Tất cả danh mục --</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}" ${selectedCategoryId == cat.id ? 'selected' : ''}>
                            ${cat.name}
                        </option>
                    </c:forEach>
                </select>

                <!-- Tìm kiếm theo Tên hoặc SKU -->
                <input type="text" name="keyword" value="${keyword}" placeholder="Nhập tên sản phẩm hoặc SKU..." class="admin-search-input" style="width: 260px;">
                <button type="submit" class="admin-btn admin-btn-secondary">
                    <i class="fa-solid fa-magnifying-glass"></i> Tìm Kiếm
                </button>
                <c:if test="${not empty keyword || not empty selectedCategoryId}">
                    <a href="${pageContext.request.contextPath}/admin/products" class="admin-btn admin-btn-secondary" title="Đặt lại bộ lọc">
                        <i class="fa-solid fa-rotate-left"></i> Đặt lại
                    </a>
                </c:if>
            </form>
        </div>

        <!-- Bảng Dữ Liệu Sản Phẩm -->
        <div class="admin-card">
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Ảnh</th>
                            <th>Mã SKU</th>
                            <th>Tên Thiết Bị</th>
                            <th>Danh Mục</th>
                            <th>Hãng SX</th>
                            <th>Công Suất</th>
                            <th>Giá Niêm Yết</th>
                            <th>Giá Bán</th>
                            <th>Tồn Kho</th>
                            <th style="text-align: right;">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td>
                                    <c:set var="pImgIdx" value="${p.id > 0 ? ((p.id - 1) mod 7 + 1) : 1}" />
                                    <c:set var="fallbackImg" value="${pageContext.request.contextPath}/assets/img/product-${pImgIdx}.jpg" />
                                    <c:set var="productImgSrc" value="${fallbackImg}" />
                                    <c:if test="${not empty p.mainImageUrl}">
                                        <c:choose>
                                            <c:when test="${p.mainImageUrl.startsWith('http://') || p.mainImageUrl.startsWith('https://')}">
                                                <c:set var="productImgSrc" value="${p.mainImageUrl}" />
                                            </c:when>
                                            <c:when test="${p.mainImageUrl.startsWith('/')}">
                                                <c:set var="productImgSrc" value="${pageContext.request.contextPath}${p.mainImageUrl}" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="productImgSrc" value="${pageContext.request.contextPath}/${p.mainImageUrl}" />
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                    <img src="${productImgSrc}" alt="<c:out value='${p.name}' />" class="admin-table-thumb"
                                         onerror="this.onerror=null; this.src='${fallbackImg}';">
                                </td>
                                <td><strong style="color: #0f172a;">${p.sku}</strong></td>
                                <td>
                                    <div style="font-weight: 600; color: #1e293b; max-width: 260px; line-height: 1.4;">
                                        <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.id}" style="color: inherit; text-decoration: none;">
                                            ${p.name}
                                        </a>
                                    </div>
                                    <c:if test="${p.featured}">
                                        <span style="font-size: 11px; color: #eab308; font-weight: 600;">
                                            <i class="fa-solid fa-star"></i> Nổi bật
                                        </span>
                                    </c:if>
                                </td>
                                <td><span style="font-size: 12px; color: var(--admin-muted);">${p.categoryName}</span></td>
                                <td><span style="font-weight: 500;">${p.brand}</span></td>
                                <td><span style="font-size: 12px; color: #475569;">${p.powerStr}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty p.salePrice}">
                                            <span style="text-decoration: line-through; color: var(--admin-muted); font-size: 12px;">
                                                ${p.formattedPrice}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="font-size: 13px; color: #475569;">${p.formattedPrice}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><span class="price-accent">${p.formattedEffectivePrice}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.stockQuantity <= 5}">
                                            <span class="stock-badge-low">Chỉ còn ${p.stockQuantity} chiếc</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="font-weight: 600; color: #16a34a;">${p.stockQuantity} chiếc</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align: right; white-space: nowrap;">
                                    <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.id}" class="admin-btn admin-btn-sm admin-btn-secondary" title="Sửa thông tin">
                                        <i class="fa-solid fa-pen-to-square"></i> Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${p.id}" 
                                       class="admin-btn admin-btn-sm admin-btn-danger" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');"
                                       title="Xóa sản phẩm">
                                        <i class="fa-solid fa-trash-can"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty products}">
                            <tr>
                                <td colspan="10" style="text-align: center; color: var(--admin-muted); padding: 40px;">
                                    <i class="fa-regular fa-folder-open" style="font-size: 32px; margin-bottom: 8px; display: block; opacity: 0.5;"></i>
                                    Không tìm thấy sản phẩm nào phù hợp với điều kiện tìm kiếm.
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
                        <a href="${pageContext.request.contextPath}/admin/products?categoryId=${selectedCategoryId}&keyword=${keyword}&page=${currentPage - 1}" class="page-item">
                            <i class="fa-solid fa-chevron-left"></i>
                        </a>
                    </c:if>
                    <c:forEach var="p" begin="1" end="${totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/products?categoryId=${selectedCategoryId}&keyword=${keyword}&page=${p}" 
                           class="page-item ${p == currentPage ? 'active' : ''}">${p}</a>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/products?categoryId=${selectedCategoryId}&keyword=${keyword}&page=${currentPage + 1}" class="page-item">
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
