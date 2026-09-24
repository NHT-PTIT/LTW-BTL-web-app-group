<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div>
            <div class="admin-topbar-title">
                ${isEdit ? 'CHỈNH SỬA MÃ GIẢM GIÁ' : 'TẠO MÃ GIẢM GIÁ MỚI'}
            </div>
            <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                ${isEdit ? 'Cập nhật tham số khuyến mãi cho mã #' : 'Thiết lập mã coupon giảm giá mới cho hệ thống.'}${coupon.code}
            </p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/coupons" class="admin-btn admin-btn-secondary">
                <i class="fa-solid fa-arrow-left"></i> Quay lại Danh sách
            </a>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <c:if test="${not empty errorMessage}">
            <div class="admin-alert admin-alert-danger">
                <i class="fa-solid fa-circle-exclamation"></i> <c:out value="${errorMessage}"/>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/coupons" method="post">
            <input type="hidden" name="id" value="${coupon.id}">

            <div class="row" style="display: flex; gap: 24px; flex-wrap: wrap;">
                <!-- Cột chính -->
                <div style="flex: 2; min-width: 320px;">
                    <div class="admin-card" style="margin-bottom: 24px;">
                        <h4 style="font-size: 15px; font-weight: 700; color: #0f172a; margin-bottom: 18px; border-bottom: 1px solid #f1f5f9; padding-bottom: 10px;">
                            <i class="fa-solid fa-ticket" style="color: #e85b24;"></i> Thông Tin Mã Giảm Giá
                        </h4>

                        <div class="admin-form-group" style="margin-bottom: 16px;">
                            <label class="admin-form-label" for="code">
                                Mã Code Voucher <span style="color: #ef4444;">*</span>
                            </label>
                            <input type="text" id="code" name="code" class="admin-form-control" 
                                   value="<c:out value="${coupon.code}"/>" 
                                   placeholder="Ví dụ: SOLAR2026, GIAM500K..." required 
                                   style="text-transform: uppercase; font-family: monospace; font-size: 16px; font-weight: 700; letter-spacing: 1px;">
                            <small style="color: var(--admin-muted); font-size: 12px; margin-top: 4px; display: block;">
                                Mã không dấu, viết hoa, không chứa khoảng trắng. Khách hàng sẽ nhập mã này tại giỏ hàng.
                            </small>
                        </div>

                        <div class="admin-form-group" style="margin-bottom: 16px;">
                            <label class="admin-form-label" for="description">Mô Tả Chương Trình</label>
                            <textarea id="description" name="description" class="admin-form-control" rows="3" 
                                      placeholder="Ví dụ: Giảm 10% tối đa 1.000.000 đ cho đơn hàng từ 5.000.000 đ mừng khai trương đại lý..."><c:out value="${coupon.description}"/></textarea>
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;">
                            <div class="admin-form-group">
                                <label class="admin-form-label" for="discountType">
                                    Loại Giảm Giá <span style="color: #ef4444;">*</span>
                                </label>
                                <select id="discountType" name="discountType" class="admin-form-control" onchange="toggleDiscountType(this.value)">
                                    <option value="PERCENT" ${coupon.discountType == 'PERCENT' ? 'selected' : ''}>Theo Phần Trăm (%)</option>
                                    <option value="FIXED" ${coupon.discountType == 'FIXED' ? 'selected' : ''}>Số Tiền Cố Định (VNĐ)</option>
                                </select>
                            </div>
                            <div class="admin-form-group">
                                <label class="admin-form-label" for="discountValue">
                                    Mức Giảm <span style="color: #ef4444;">*</span>
                                </label>
                                <input type="number" id="discountValue" name="discountValue" class="admin-form-control" 
                                       value="${coupon.discountValue}" step="any" min="0" required 
                                       placeholder="Ví dụ: 10 (nếu là %) hoặc 500000 (nếu là VNĐ)">
                            </div>
                        </div>

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;">
                            <div class="admin-form-group" id="maxDiscountGroup">
                                <label class="admin-form-label" for="maxDiscountAmount">Giảm Tối Đa (VNĐ)</label>
                                <input type="number" id="maxDiscountAmount" name="maxDiscountAmount" class="admin-form-control" 
                                       value="${coupon.maxDiscountAmount}" step="any" min="0" 
                                       placeholder="Để trống nếu không giới hạn">
                                <small style="color: var(--admin-muted); font-size: 11px;">Chỉ áp dụng khi chọn giảm theo %</small>
                            </div>
                            <div class="admin-form-group">
                                <label class="admin-form-label" for="minOrderAmount">Giá Trị Đơn Tối Thiểu (VNĐ)</label>
                                <input type="number" id="minOrderAmount" name="minOrderAmount" class="admin-form-control" 
                                       value="${coupon.minOrderAmount}" step="any" min="0" 
                                       placeholder="Ví dụ: 2000000">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Cột phụ: Giới hạn & Trạng thái -->
                <div style="flex: 1; min-width: 280px;">
                    <div class="admin-card" style="margin-bottom: 24px;">
                        <h4 style="font-size: 15px; font-weight: 700; color: #0f172a; margin-bottom: 18px; border-bottom: 1px solid #f1f5f9; padding-bottom: 10px;">
                            <i class="fa-solid fa-clock-rotate-left" style="color: #0284c7;"></i> Giới Hạn & Thời Gian
                        </h4>

                        <div class="admin-form-group" style="margin-bottom: 16px;">
                            <label class="admin-form-label" for="usageLimit">Số Lượng Lượt Dùng Tối Đa</label>
                            <input type="number" id="usageLimit" name="usageLimit" class="admin-form-control" 
                                   value="${coupon.usageLimit}" min="0" 
                                   placeholder="0 = Không giới hạn lượt">
                            <c:if test="${isEdit}">
                                <small style="color: #059669; font-weight: 600; display: block; margin-top: 4px;">
                                    Đã có ${coupon.usedCount} khách hàng áp dụng mã này.
                                </small>
                            </c:if>
                        </div>

                        <div class="admin-form-group" style="margin-bottom: 16px;">
                            <label class="admin-form-label" for="startDate">Ngày Bắt Đầu Áp Dụng</label>
                            <input type="date" id="startDate" name="startDate" class="admin-form-control" 
                                   value="<fmt:formatDate value="${coupon.startDate}" pattern="yyyy-MM-dd"/>">
                        </div>

                        <div class="admin-form-group" style="margin-bottom: 16px;">
                            <label class="admin-form-label" for="endDate">Ngày Hết Hạn</label>
                            <input type="date" id="endDate" name="endDate" class="admin-form-control" 
                                   value="<fmt:formatDate value="${coupon.endDate}" pattern="yyyy-MM-dd"/>">
                        </div>

                        <div class="admin-form-group" style="margin-bottom: 20px;">
                            <label class="admin-form-label">Trạng Thái Kích Hoạt</label>
                            <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; margin-top: 6px;">
                                <input type="checkbox" name="isActive" value="true" ${coupon.active ? 'checked' : ''} 
                                       style="width: 18px; height: 18px;">
                                <span style="font-weight: 600; color: #1e293b;">Bật cho phép áp dụng voucher</span>
                            </label>
                        </div>

                        <div style="border-top: 1px solid #f1f5f9; padding-top: 16px;">
                            <button type="submit" class="admin-btn admin-btn-primary" style="width: 100%; justify-content: center; padding: 12px 0; font-size: 15px;">
                                <i class="fa-solid fa-floppy-disk"></i> Lưu Mã Giảm Giá
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

    </div>
</main>

<script>
function toggleDiscountType(type) {
    var maxGroup = document.getElementById('maxDiscountGroup');
    if (type === 'PERCENT') {
        maxGroup.style.display = 'block';
    } else {
        maxGroup.style.display = 'none';
    }
}
// Init
toggleDiscountType(document.getElementById('discountType').value);
</script>

</body>
</html>
