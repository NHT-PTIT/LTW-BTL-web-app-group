/**
 * PTIT TECH - ADMIN FRONTEND LOGIC
 * Quản lý xem trước ảnh tải lên, xác nhận xóa dữ liệu và thao tác bảng điều khiển
 */

document.addEventListener('DOMContentLoaded', function () {
    console.log("PTIT Tech Admin JS Loaded!");

    // 1. Xác nhận trước khi xóa (Áp dụng cho mọi nút/link có class .btn-delete-confirm)
    const deleteButtons = document.querySelectorAll('.btn-delete-confirm');
    deleteButtons.forEach(btn => {
        btn.addEventListener('click', function (e) {
            const confirmMsg = this.getAttribute('data-confirm') || "Bạn có chắc chắn muốn xóa bản ghi này không?";
            if (!confirm(confirmMsg)) {
                e.preventDefault();
            }
        });
    });

    // 2. Xem trước ảnh khi chọn file upload
    const imageInputs = document.querySelectorAll('input[type="file"].preview-image-input');
    imageInputs.forEach(input => {
        input.addEventListener('change', function () {
            const targetPreviewId = this.getAttribute('data-preview-target');
            const previewImg = document.getElementById(targetPreviewId);
            if (previewImg && this.files && this.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    previewImg.src = e.target.result;
                    previewImg.style.display = 'block';
                };
                reader.readAsDataURL(this.files[0]);
            }
        });
    });
});
