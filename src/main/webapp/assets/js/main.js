/**
 * PTIT TECH - CLIENT FRONTEND LOGIC
 * Quản lý giỏ hàng, thông báo Toast, bộ lọc và các tương tác phía người dùng
 */

document.addEventListener('DOMContentLoaded', function () {
    console.log("PTIT Tech Client JS Loaded!");

    // 1. Khởi tạo bắt sự kiện Thêm vào giỏ hàng bằng Ajax (trên các nút .btn-add-to-cart)
    const addToCartButtons = document.querySelectorAll('.btn-add-to-cart');
    addToCartButtons.forEach(button => {
        button.addEventListener('click', function (e) {
            e.preventDefault();
            const productId = this.getAttribute('data-product-id');
            const quantity = this.getAttribute('data-quantity') || 1;
            addToCartAjax(productId, quantity);
        });
    });
});

/**
 * Gửi yêu cầu thêm sản phẩm vào giỏ hàng bằng Ajax
 */
function addToCartAjax(productId, quantity) {
    const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 2));
    const url = (contextPath ? contextPath : '') + '/cart?action=add&productId=' + productId + '&quantity=' + quantity;

    fetch(url, {
        method: 'POST',
        headers: {
            'X-Requested-With': 'XMLHttpRequest'
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Cập nhật số lượng hiển thị trên icon giỏ hàng
            const badge = document.querySelector('.cart-badge');
            if (badge) {
                badge.textContent = data.totalCartItems;
            }
            showToast("Đã thêm sản phẩm vào giỏ hàng thành công!", "success");
        } else {
            showToast(data.message || "Không thể thêm vào giỏ hàng", "error");
        }
    })
    .catch(err => {
        console.error("Lỗi khi thêm giỏ hàng:", err);
        // Fallback: Nếu không dùng Ajax thì submit thông thường
        window.location.href = (contextPath ? contextPath : '') + '/cart?action=add&productId=' + productId;
    });
}

/**
 * Hiển thị thông báo Toast nhanh gọn không cần reload trang
 */
function showToast(message, type = "info") {
    let toast = document.querySelector('.toast-msg');
    if (!toast) {
        toast = document.createElement('div');
        toast.className = 'toast-msg';
        document.body.appendChild(toast);
    }
    toast.textContent = message;
    toast.classList.add('show');

    setTimeout(() => {
        toast.classList.remove('show');
    }, 3000);
}
