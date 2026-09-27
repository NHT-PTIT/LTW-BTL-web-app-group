<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/common/admin-header.jsp" />
<jsp:include page="/WEB-INF/views/common/admin-sidebar.jsp" />

<main class="admin-main">
    <!-- Topbar -->
    <header class="admin-topbar">
        <div style="display: flex; align-items: center; gap: 14px;">
            <a href="${pageContext.request.contextPath}/admin/products" class="admin-btn admin-btn-secondary admin-btn-sm">
                <i class="fa-solid fa-arrow-left"></i> Quay Lại
            </a>
            <div>
                <div class="admin-topbar-title">${isEdit ? 'CẬP NHẬT SẢN PHẨM' : 'THÊM SẢN PHẨM MỚI'}</div>
                <p style="font-size: 13px; color: var(--admin-muted); margin-top: 2px;">
                    <c:choose>
                        <c:when test="${isEdit}">Chỉnh sửa thông số kỹ thuật và giá của: <c:out value="${product.name}" /></c:when>
                        <c:otherwise>Điền đầy đủ thông tin để đăng bán sản phẩm mới lên gian hàng.</c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
    </header>

    <!-- Content -->
    <div class="admin-content">

        <form action="${pageContext.request.contextPath}/admin/products" method="post" id="productForm">
            <c:if test="${isEdit}">
                <input type="hidden" name="id" value="${product.id}">
            </c:if>

            <div class="form-grid-3">
                <!-- Cột Trái: Thông Tin Chi Tiết -->
                <div>
                    <!-- Thông Tin Cơ Bản -->
                    <div class="admin-card">
                        <div class="admin-card-header">
                            <div class="admin-card-title">
                                <i class="fa-solid fa-circle-info" style="color: var(--admin-primary);"></i> THÔNG TIN CƠ BẢN
                            </div>
                        </div>
                        <div class="admin-card-body">
                            <div class="admin-form-group">
                                <label class="admin-form-label">TÊN THIẾT BỊ / SẢN PHẨM <span class="required">*</span></label>
                                <input type="text" name="name" value="${product.name}" class="admin-input" 
                                       placeholder="Ví dụ: Camera IP Thân Trụ Hikvision DS-2CD2043G2-I 4MP AcuSense" required>
                            </div>

                            <div class="form-grid-2">
                                <div class="admin-form-group">
                                    <label class="admin-form-label">MÃ SKU SẢN PHẨM <span class="required">*</span></label>
                                    <input type="text" name="sku" value="${product.sku}" class="admin-input" 
                                           placeholder="Ví dụ: CAM-HIK-4MP" required style="text-transform: uppercase;">
                                </div>
                                <div class="admin-form-group">
                                    <label class="admin-form-label">DANH MỤC THIẾT BỊ <span class="required">*</span></label>
                                    <select name="categoryId" class="admin-select" required>
                                        <option value="">-- Chọn danh mục --</option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.id}" ${product.categoryId == cat.id ? 'selected' : ''}>
                                                ${cat.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="form-grid-2">
                                <div class="admin-form-group">
                                    <label class="admin-form-label">THƯƠNG HIỆU / HÃNG SẢN XUẤT</label>
                                    <input type="text" name="brand" value="${product.brand}" class="admin-input" 
                                           placeholder="Hikvision, Dahua, Ezviz, Philips, Kaadas, Ronald Jack...">
                                </div>
                                <div class="admin-form-group">
                                    <label class="admin-form-label">THÔNG SỐ / ĐỘ PHÂN GIẢI NỔI BẬT</label>
                                    <input type="text" name="powerStr" value="${product.powerStr}" class="admin-input" 
                                           placeholder="Ví dụ: 4.0 MP 2K, Zoom 25X, 3D Face ID, 1500 Face...">
                                </div>
                            </div>

                            <div class="admin-form-group">
                                <label class="admin-form-label">THÔNG SỐ ĐỊNH LƯỢNG (Độ phân giải MP / Dung lượng)</label>
                                <input type="number" step="0.1" name="powerVal" value="${product.powerVal}" class="admin-input" 
                                       placeholder="4.0, 8.0, 16.0 (dùng cho bộ lọc thông số)">
                            </div>
                        </div>
                    </div>

                    <!-- Mô Tả Sản Phẩm -->
                    <div class="admin-card">
                        <div class="admin-card-header">
                            <div class="admin-card-title">
                                <i class="fa-solid fa-align-left" style="color: var(--admin-primary);"></i> MÔ TẢ & THÔNG SỐ KỸ THUẬT
                            </div>
                        </div>
                        <div class="admin-card-body">
                            <div class="admin-form-group">
                                <label class="admin-form-label">MÔ TẢ TÓM TẮT (Hiển thị đầu trang chi tiết & thẻ sản phẩm)</label>
                                <textarea name="shortDescription" class="admin-textarea" rows="3" 
                                          placeholder="Tóm tắt tính năng nổi bật: Cảm biến 4MP 2K siêu nét, chuẩn nén H.265+, chống bụi nước IP67, tích hợp AI phát hiện người/xe...">${product.shortDescription}</textarea>
                            </div>

                            <div class="admin-form-group">
                                <label class="admin-form-label">CHI TIẾT KỸ THUẬT & ĐẶC TÍNH (Hỗ trợ HTML)</label>
                                <textarea name="detailDescription" class="admin-textarea" rows="6" 
                                          placeholder="Chi tiết cấu hình, tầm xa hồng ngoại 30m, công nghệ ban đêm có màu, tiêu chuẩn bảo vệ IP67...">${product.detailDescription}</textarea>
                            </div>
                        </div>
                    </div>
                    <!-- Bảng Thông Số Kỹ Thuật (Specs) -->
                    <div class="admin-card">
                        <div class="admin-card-header" style="display: flex; justify-content: space-between; align-items: center;">
                            <div class="admin-card-title">
                                <i class="fa-solid fa-list-check" style="color: var(--admin-primary);"></i> THÔNG SỐ KỸ THUẬT CHI TIẾT
                            </div>
                            <button type="button" class="admin-btn admin-btn-sm admin-btn-secondary" onclick="addSpecRow()">
                                <i class="fa-solid fa-plus"></i> Thêm Thông Số
                            </button>
                        </div>
                        <div class="admin-card-body" style="padding: 0;">
                            <div class="table-responsive">
                                <table class="admin-table" id="specsTable" style="margin-bottom: 0;">
                                    <thead>
                                        <tr>
                                            <th style="width: 40%;">Tên Thông Số</th>
                                            <th>Giá Trị Thông Số</th>
                                            <th style="width: 50px; text-align: center;">Xóa</th>
                                        </tr>
                                    </thead>
                                    <tbody id="specsBody">
                                        <c:choose>
                                            <c:when test="${not empty product.specifications}">
                                                <c:forEach var="spec" items="${product.specifications}">
                                                    <tr>
                                                        <td>
                                                            <input type="text" name="specName" value="<c:out value='${spec.specName}' />" class="admin-input admin-input-sm" placeholder="Ví dụ: Điện áp danh định">
                                                        </td>
                                                        <td>
                                                            <input type="text" name="specValue" value="<c:out value='${spec.specValue}' />" class="admin-input admin-input-sm" placeholder="Ví dụ: 380V / 3 Pha 50-60Hz">
                                                        </td>
                                                        <td style="text-align: center;">
                                                            <button type="button" class="admin-btn admin-btn-sm admin-btn-danger" onclick="removeRow(this)" title="Xóa thông số">
                                                                <i class="fa-solid fa-trash-can"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td>
                                                        <input type="text" name="specName" value="Cảm biến hình ảnh" class="admin-input admin-input-sm" placeholder="Tên thông số">
                                                    </td>
                                                    <td>
                                                        <input type="text" name="specValue" value="1/3 inch Progressive Scan CMOS 4.0 Megapixel" class="admin-input admin-input-sm" placeholder="Giá trị thông số">
                                                    </td>
                                                    <td style="text-align: center;">
                                                        <button type="button" class="admin-btn admin-btn-sm admin-btn-danger" onclick="removeRow(this)" title="Xóa thông số">
                                                            <i class="fa-solid fa-trash-can"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <input type="text" name="specName" value="Cấp độ bảo vệ" class="admin-input admin-input-sm" placeholder="Tên thông số">
                                                    </td>
                                                    <td>
                                                        <input type="text" name="specValue" value="IP67 (Kháng nước & bụi ngoài trời)" class="admin-input admin-input-sm" placeholder="Giá trị thông số">
                                                    </td>
                                                    <td style="text-align: center;">
                                                        <button type="button" class="admin-btn admin-btn-sm admin-btn-danger" onclick="removeRow(this)" title="Xóa thông số">
                                                            <i class="fa-solid fa-trash-can"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Cột Phải: Giá, Tồn Kho & Ảnh -->
                <div>
                    <!-- Giá & Tồn Kho -->
                    <div class="admin-card">
                        <div class="admin-card-header">
                            <div class="admin-card-title">
                                <i class="fa-solid fa-tag" style="color: var(--admin-primary);"></i> GIÁ & KHO HÀNG
                            </div>
                        </div>
                        <div class="admin-card-body">
                            <div class="admin-form-group">
                                <label class="admin-form-label">GIÁ NIÊM YẾT (VNĐ) <span class="required">*</span></label>
                                <input type="text" name="price" value="${product.price}" class="admin-input" 
                                       placeholder="Ví dụ: 18500000" required>
                                <span style="font-size: 11px; color: var(--admin-muted);">Nhập số nguyên, hệ thống tự định dạng.</span>
                            </div>

                            <div class="admin-form-group">
                                <label class="admin-form-label">GIÁ KHUYẾN MÃI (VNĐ - Tùy chọn)</label>
                                <input type="text" name="salePrice" value="${product.salePrice}" class="admin-input" 
                                       placeholder="Để trống nếu không giảm giá">
                            </div>

                            <div class="admin-form-group">
                                <label class="admin-form-label">SỐ LƯỢNG TỒN KHO <span class="required">*</span></label>
                                <input type="number" name="stockQuantity" value="${product.stockQuantity != null ? product.stockQuantity : 10}" 
                                       class="admin-input" required min="0">
                            </div>

                            <hr style="border: 0; border-top: 1px solid var(--admin-border); margin: 16px 0;">

                            <div class="admin-form-group">
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="isFeatured" value="true" ${product.featured ? 'checked' : ''}>
                                    <span>Đánh dấu là <strong>Sản phẩm Nổi bật</strong> trang chủ</span>
                                </label>
                            </div>

                            <div class="admin-form-group" style="margin-bottom: 0;">
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="isActive" value="true" ${product.id == 0 || product.active ? 'checked' : ''}>
                                    <span>Cho phép <strong>Đăng bán công khai</strong></span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Hình Ảnh Đại Diện -->
                    <div class="admin-card">
                        <div class="admin-card-header">
                            <div class="admin-card-title">
                                <i class="fa-solid fa-image" style="color: var(--admin-primary);"></i> HÌNH ẢNH SẢN PHẨM
                            </div>
                        </div>
                        <div class="admin-card-body">
                            <div class="admin-form-group">
                                <label class="admin-form-label">ĐƯỜNG DẪN ẢNH ĐẠI DIỆN (URL)</label>
                                <input type="text" name="mainImageUrl" id="mainImageUrlInput" value="${product.mainImageUrl}" 
                                       class="admin-input" placeholder="https://... hoặc assets/img/product/..." 
                                       oninput="updateImagePreview(this.value)">
                            </div>

                            <!-- Khung Xem Trước Ảnh (Live Preview) -->
                            <div class="image-preview-box" id="previewContainer">
                                <c:choose>
                                    <c:when test="${not empty product.mainImageUrl}">
                                        <c:set var="previewSrc" value="${product.mainImageUrl}" />
                                        <c:if test="${!product.mainImageUrl.startsWith('http://') && !product.mainImageUrl.startsWith('https://') && !product.mainImageUrl.startsWith('/')}">
                                            <c:set var="previewSrc" value="${pageContext.request.contextPath}/${product.mainImageUrl}" />
                                        </c:if>
                                        <img src="${previewSrc}" id="previewImg" alt="Xem trước ảnh" 
                                             onerror="handleImageError()">
                                        <div class="image-preview-placeholder" id="placeholderText" style="display: none;">
                                            <i class="fa-regular fa-image" style="font-size: 32px; margin-bottom: 6px; display: block;"></i>
                                            Dán link ảnh ở trên để xem trước
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="image-preview-placeholder" id="placeholderText">
                                            <i class="fa-regular fa-image" style="font-size: 32px; margin-bottom: 6px; display: block;"></i>
                                            Dán link ảnh ở trên để xem trước
                                        </div>
                                        <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg'/%3E" id="previewImg" alt="Xem trước ảnh" style="display: none;">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Thư Viện Ảnh Chi Tiết (Gallery) -->
                    <div class="admin-card">
                        <div class="admin-card-header" style="display: flex; justify-content: space-between; align-items: center;">
                            <div class="admin-card-title">
                                <i class="fa-solid fa-images" style="color: var(--admin-primary);"></i> THƯ VIỆN ẢNH CHI TIẾT
                            </div>
                            <button type="button" class="admin-btn admin-btn-sm admin-btn-secondary" onclick="addGalleryRow()">
                                <i class="fa-solid fa-plus"></i> Thêm Ảnh
                            </button>
                        </div>
                        <div class="admin-card-body" id="galleryContainer">
                            <c:choose>
                                <c:when test="${not empty product.gallery}">
                                    <c:forEach var="gImg" items="${product.gallery}">
                                        <div class="gallery-item-row" style="display: flex; gap: 8px; margin-bottom: 10px; align-items: center;">
                                            <input type="text" name="galleryImageUrl" value="<c:out value='${gImg.imageUrl}' />" class="admin-input admin-input-sm" placeholder="https://... hoặc assets/img/product/...">
                                            <button type="button" class="admin-btn admin-btn-sm admin-btn-danger" onclick="removeGalleryRow(this)">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </button>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <p class="empty-gallery-tip" style="font-size: 12px; color: var(--admin-muted); margin-bottom: 8px;">Chưa có ảnh phụ nào. Bấm "Thêm Ảnh" để bổ sung ảnh chi tiết các góc chụp.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Nút Thao Tác Lưu -->
                    <div style="display: flex; flex-direction: column; gap: 10px;">
                        <button type="submit" class="admin-btn admin-btn-primary" style="justify-content: center; padding: 12px; font-size: 15px;">
                            <i class="fa-solid fa-floppy-disk"></i> LƯU SẢN PHẨM
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/products" class="admin-btn admin-btn-secondary" style="justify-content: center;">
                            Hủy bỏ
                        </a>
                    </div>
                </div>
            </div>
        </form>

    </div>
</main>

<script>
function addSpecRow() {
    var tbody = document.getElementById('specsBody');
    var tr = document.createElement('tr');
    tr.innerHTML = '<td><input type="text" name="specName" class="admin-input admin-input-sm" placeholder="Tên thông số (VD: Độ phân giải)"></td>' +
                   '<td><input type="text" name="specValue" class="admin-input admin-input-sm" placeholder="Giá trị (VD: 4.0 Megapixel 2K)"></td>' +
                   '<td style="text-align: center;"><button type="button" class="admin-btn admin-btn-sm admin-btn-danger" onclick="removeRow(this)" title="Xóa thông số"><i class="fa-solid fa-trash-can"></i></button></td>';
    tbody.appendChild(tr);
}

function removeRow(btn) {
    var tr = btn.closest('tr');
    if (tr) tr.remove();
}

function addGalleryRow() {
    var container = document.getElementById('galleryContainer');
    var tip = container.querySelector('.empty-gallery-tip');
    if (tip) tip.remove();
    var div = document.createElement('div');
    div.className = 'gallery-item-row';
    div.style = 'display: flex; gap: 8px; margin-bottom: 10px; align-items: center;';
    div.innerHTML = '<input type="text" name="galleryImageUrl" class="admin-input admin-input-sm" placeholder="https://... hoặc assets/img/product/...">' +
                    '<button type="button" class="admin-btn admin-btn-sm admin-btn-danger" onclick="removeGalleryRow(this)"><i class="fa-solid fa-trash-can"></i></button>';
    container.appendChild(div);
}

function removeGalleryRow(btn) {
    var row = btn.closest('.gallery-item-row');
    if (row) row.remove();
}

function updateImagePreview(url) {
    var previewImg = document.getElementById('previewImg');
    var placeholder = document.getElementById('placeholderText');
    if (url && url.trim().length > 0) {
        previewImg.onerror = function() {
            previewImg.onerror = null;
            handleImageError();
        };
        previewImg.src = url.trim();
        previewImg.style.display = 'block';
        if (placeholder) placeholder.style.display = 'none';
    } else {
        previewImg.onerror = null;
        previewImg.style.display = 'none';
        previewImg.src = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg'/%3E";
        if (placeholder) {
            placeholder.style.display = 'block';
            placeholder.innerHTML = '<i class="fa-regular fa-image" style="font-size: 32px; margin-bottom: 6px; display: block;"></i>Dán link ảnh ở trên để xem trước';
        }
    }
}

function handleImageError() {
    var previewImg = document.getElementById('previewImg');
    var placeholder = document.getElementById('placeholderText');
    previewImg.onerror = null;
    previewImg.style.display = 'none';
    if (placeholder) {
        placeholder.style.display = 'block';
        placeholder.innerHTML = '<i class="fa-solid fa-triangle-exclamation" style="font-size: 28px; color: #ef4444; margin-bottom: 6px; display: block;"></i>Không thể tải ảnh từ liên kết này';
    }
}
</script>
</body>
</html>
