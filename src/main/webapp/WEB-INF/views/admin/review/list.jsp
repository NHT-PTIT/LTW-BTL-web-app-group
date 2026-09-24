<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div>
            <div class="admin-topbar-title">QUẢN LÝ ĐÁNH GIÁ & NHẬN XÉT SẢN PHẨM</div>
            <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                Kiểm duyệt nội dung đánh giá 1-5 sao và bình luận của khách hàng trên toàn bộ hệ thống.
            </p>
        </div>
        <c:if test="${pendingReviewCount > 0}">
            <div>
                <span class="admin-badge admin-badge-warning" style="font-size: 13px; padding: 6px 12px;">
                    <i class="fa-solid fa-clock"></i> Có ${pendingReviewCount} đánh giá đang chờ duyệt
                </span>
            </div>
        </c:if>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <!-- Thông Báo -->
        <c:if test="${param.msg == 'toggled'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-circle-check"></i> Đã cập nhật trạng thái hiển thị của đánh giá!
            </div>
        </c:if>
        <c:if test="${param.msg == 'deleted'}">
            <div class="admin-alert admin-alert-success">
                <i class="fa-solid fa-trash-can"></i> Đã xóa đánh giá thành công!
            </div>
        </c:if>

        <div class="admin-card">
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th style="width: 50px;">ID</th>
                            <th style="width: 200px;">Sản Phẩm</th>
                            <th style="width: 160px;">Khách Hàng</th>
                            <th style="width: 120px;">Đánh Giá</th>
                            <th>Nội Dung Nhận Xét</th>
                            <th style="width: 130px;">Thời Gian</th>
                            <th style="text-align: center; width: 130px;">Trạng Thái</th>
                            <th style="text-align: right; width: 80px;">Xóa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${reviews}">
                            <tr>
                                <td><span style="color: var(--admin-muted); font-size: 12px;">#${r.id}</span></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${r.productId}" target="_blank" 
                                       style="color: var(--admin-primary); font-weight: 600; text-decoration: none; display: block; max-width: 200px;">
                                        <c:out value="${not empty r.productName ? r.productName : ('Sản phẩm #' += r.productId)}" />
                                        <i class="fa-solid fa-arrow-up-right-from-square" style="font-size: 11px; margin-left: 3px;"></i>
                                    </a>
                                </td>
                                <td>
                                    <div style="font-weight: 600; color: #1e293b;">
                                        <i class="fa-solid fa-user" style="color: #64748b; font-size: 12px; margin-right: 4px;"></i> 
                                        <c:out value="${r.customerName}" />
                                    </div>
                                    <c:if test="${not empty r.customerEmail}">
                                        <small style="color: var(--admin-muted); display: block;"><c:out value="${r.customerEmail}" /></small>
                                    </c:if>
                                </td>
                                <td>
                                    <div style="color: #f59e0b; font-size: 13px;">
                                        <c:forEach begin="1" end="${r.rating}">
                                            <i class="fa-solid fa-star"></i>
                                        </c:forEach>
                                        <c:forEach begin="${r.rating + 1}" end="5">
                                            <i class="fa-regular fa-star" style="color: #cbd5e1;"></i>
                                        </c:forEach>
                                    </div>
                                    <small style="font-weight: 700; color: #475569;">${r.rating} / 5 sao</small>
                                </td>
                                <td>
                                    <div style="color: #334155; font-size: 13px; line-height: 1.5; max-width: 380px;">
                                        <c:out value="${r.comment}" />
                                    </div>
                                </td>
                                <td>
                                    <span style="font-size: 12px; color: var(--admin-muted);">${r.formattedCreatedAt}</span>
                                </td>
                                <td style="text-align: center;">
                                    <a href="${pageContext.request.contextPath}/admin/reviews?action=toggle&id=${r.id}" 
                                       title="Bấm để Đổi trạng thái Hiển thị / Ẩn" style="text-decoration: none;">
                                        <c:choose>
                                            <c:when test="${r.approved}">
                                                <span class="admin-badge admin-badge-success" style="cursor: pointer;">
                                                    <i class="fa-solid fa-circle-check"></i> Hiển thị
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="admin-badge admin-badge-danger" style="cursor: pointer;">
                                                    <i class="fa-solid fa-eye-slash"></i> Đang ẩn
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </td>
                                <td style="text-align: right;">
                                    <a href="${pageContext.request.contextPath}/admin/reviews?action=delete&id=${r.id}" 
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa vĩnh viễn đánh giá này không?');" 
                                       class="admin-btn admin-btn-sm admin-btn-danger" title="Xóa đánh giá">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty reviews}">
                            <tr>
                                <td colspan="8" style="text-align: center; color: var(--admin-muted); padding: 40px;">
                                    Chưa có đánh giá nào từ khách hàng.
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
