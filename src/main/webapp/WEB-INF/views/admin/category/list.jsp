<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div>
            <div class="admin-topbar-title">QUẢN LÝ DANH MỤC SẢN PHẨM</div>
            <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                Cây danh mục phân cấp đa cấp phục vụ điều hướng và lọc sản phẩm.
            </p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/categories?action=add" class="admin-btn admin-btn-primary">
                <i class="fa-solid fa-plus"></i> Thêm Danh Mục Mới
            </a>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <!-- Thông Báo -->
        <c:if test="${param.msg == 'saved'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Lưu thông tin danh mục thành công!
            </div>
        </c:if>
        <c:if test="${param.msg == 'deleted'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-trash-can"></i> Đã xóa danh mục thành công!
            </div>
        </c:if>
        <c:if test="${param.err == 'delete_failed'}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-triangle-exclamation"></i> Không thể xóa danh mục vì đang chứa sản phẩm hoặc danh mục con.
            </div>
        </c:if>

        <div class="admin-card">
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th style="width: 60px;">ID</th>
                            <th>Tên Danh Mục</th>
                            <th>Đường Dẫn Slug</th>
                            <th>Thứ Tự</th>
                            <th>Trạng Thái</th>
                            <th style="text-align: right;">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="parent" items="${categoryTree}">
                            <!-- Hàng Danh Mục Cha (Cấp 1) -->
                            <tr style="background: #fafafa; font-weight: 600;">
                                <td><span style="color: var(--admin-muted); font-size: 12px;">#${parent.id}</span></td>
                                <td>
                                    <div style="display: flex; align-items: center; gap: 8px;">
                                        <i class="fa-solid fa-folder-open" style="color: var(--admin-primary); font-size: 16px;"></i>
                                        <span style="font-size: 15px; color: #0f172a;">${parent.name}</span>
                                    </div>
                                    <c:if test="${not empty parent.description}">
                                        <div style="font-size: 12px; color: var(--admin-muted); font-weight: normal; margin-left: 24px;">
                                            ${parent.description}
                                        </div>
                                    </c:if>
                                </td>
                                <td><code>/${parent.slug}</code></td>
                                <td>${parent.sortOrder}</td>
                                <td>
                                    <span class="status-badge status-completed" style="font-size: 11px;">Hoạt động</span>
                                </td>
                                <td style="text-align: right; white-space: nowrap;">
                                    <a href="${pageContext.request.contextPath}/admin/categories?action=edit&id=${parent.id}" class="admin-btn admin-btn-sm admin-btn-secondary" title="Sửa">
                                        <i class="fa-solid fa-pen-to-square"></i> Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${parent.id}" 
                                       class="admin-btn admin-btn-sm admin-btn-danger" 
                                       onclick="return confirm('Bạn có chắc muốn xóa danh mục cha [${parent.name}]?');"
                                       title="Xóa">
                                        <i class="fa-solid fa-trash-can"></i> Xóa
                                    </a>
                                </td>
                            </tr>

                            <!-- Các Hàng Danh Mục Con (Cấp 2) -->
                            <c:forEach var="child" items="${parent.subCategories}">
                                <tr>
                                    <td><span style="color: var(--admin-muted); font-size: 12px;">#${child.id}</span></td>
                                    <td style="padding-left: 42px;">
                                        <div style="display: flex; align-items: center; gap: 8px;">
                                            <i class="fa-solid fa-turn-up fa-rotate-90" style="color: #94a3b8; font-size: 13px;"></i>
                                            <i class="fa-regular fa-folder" style="color: #0284c7;"></i>
                                            <span style="font-weight: 500; color: #1e293b;">${child.name}</span>
                                        </div>
                                    </td>
                                    <td><code>/${child.slug}</code></td>
                                    <td>${child.sortOrder}</td>
                                    <td>
                                        <span class="status-badge status-completed" style="font-size: 11px;">Hoạt động</span>
                                    </td>
                                    <td style="text-align: right; white-space: nowrap;">
                                        <a href="${pageContext.request.contextPath}/admin/categories?action=edit&id=${child.id}" class="admin-btn admin-btn-sm admin-btn-secondary">
                                            <i class="fa-solid fa-pen-to-square"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${child.id}" 
                                           class="admin-btn admin-btn-sm admin-btn-danger" 
                                           onclick="return confirm('Bạn có chắc muốn xóa danh mục con [${child.name}]?');">
                                            <i class="fa-solid fa-trash-can"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:forEach>

                        <c:if test="${empty categoryTree}">
                            <tr>
                                <td colspan="6" style="text-align: center; color: var(--admin-muted); padding: 40px;">
                                    Chưa có danh mục nào. Hãy bấm "+ Thêm Danh Mục Mới".
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
