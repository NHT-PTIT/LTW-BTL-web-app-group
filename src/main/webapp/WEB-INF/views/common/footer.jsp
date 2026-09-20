<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Main Footer -->
<footer style="background: #0b1120; color: #94a3b8; padding: 50px 0 20px 0; margin-top: 60px; border-top: 1px solid rgba(255,255,255,0.05);">
    <div class="container">
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 30px; margin-bottom: 40px;">
            <!-- Cột 1: Thông tin công ty -->
            <div>
                <h3 style="color: #fff; font-size: 18px; margin-bottom: 16px; font-weight: 700;">
                    <i class="fa-solid fa-bolt" style="color: #3b82f6;"></i> PTIT TECH
                </h3>
                <p style="font-size: 14px; line-height: 1.7; margin-bottom: 14px;">
                    ${companyInfo != null ? companyInfo.aboutSummary : 'Đơn vị tiên phong phân phối biến tần, thiết bị truyền động và tự động hóa công nghiệp chính hãng tại Việt Nam.'}
                </p>
                <div style="font-size: 13px; line-height: 1.8;">
                    <p><i class="fa-solid fa-location-dot me-2" style="color: #3b82f6;"></i> ${companyInfo != null ? companyInfo.address : 'Km10 Nguyễn Trãi, Hà Đông, Hà Nội'}</p>
                    <p><i class="fa-solid fa-phone me-2" style="color: #3b82f6;"></i> Hotline: ${companyInfo != null ? companyInfo.hotline : '1900 6868'}</p>
                    <p><i class="fa-solid fa-envelope me-2" style="color: #3b82f6;"></i> ${companyInfo != null ? companyInfo.email : 'contact@ptittech.vn'}</p>
                </div>
            </div>

            <!-- Cột 2: Danh mục sản phẩm -->
            <div>
                <h4 style="color: #fff; font-size: 16px; margin-bottom: 16px; font-weight: 600;">Danh Mục Thiết Bị</h4>
                <ul style="list-style: none; font-size: 14px; line-height: 2.2;">
                    <li><a href="${pageContext.request.contextPath}/products?category=1">Biến tần hạ thế (0.4kW - 15kW)</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=2">Biến tần công nghiệp nặng (>15kW)</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=3">Khí cụ đóng cắt Aptomat MCCB</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=4">Contactor & Khởi động từ</a></li>
                </ul>
            </div>

            <!-- Cột 3: Hỗ trợ khách hàng -->
            <div>
                <h4 style="color: #fff; font-size: 16px; margin-bottom: 16px; font-weight: 600;">Hỗ Trợ Khách Hàng</h4>
                <ul style="list-style: none; font-size: 14px; line-height: 2.2;">
                    <li><a href="${pageContext.request.contextPath}/about">Về chúng tôi & Đội ngũ nhân sự</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Yêu cầu báo giá dự án</a></li>
                    <li><a href="#">Chính sách bảo hành 12-24 tháng</a></li>
                    <li><a href="#">Tài liệu hướng dẫn cài đặt tham số</a></li>
                </ul>
            </div>

            <!-- Cột 4: Kết nối & Cam kết -->
            <div>
                <h4 style="color: #fff; font-size: 16px; margin-bottom: 16px; font-weight: 600;">Cam Kết Chất Lượng</h4>
                <p style="font-size: 14px; margin-bottom: 16px;">100% sản phẩm CO/CQ chính hãng Schneider, Mitsubishi, ABB. Hỗ trợ kỹ thuật lắp đặt 24/7.</p>
                <div style="display: flex; gap: 12px; font-size: 18px;">
                    <a href="#" style="color: #cbd5e1;"><i class="fa-brands fa-facebook"></i></a>
                    <a href="#" style="color: #cbd5e1;"><i class="fa-brands fa-youtube"></i></a>
                    <a href="#" style="color: #cbd5e1;"><i class="fa-brands fa-linkedin"></i></a>
                </div>
            </div>
        </div>

        <div style="border-top: 1px solid rgba(255,255,255,0.08); padding-top: 20px; text-align: center; font-size: 13px;">
            &copy; 2026 PTIT Tech - Nhóm Bài Tập Lập Trình Web (INT1434). Bản quyền thuộc về Nhóm tác giả.
        </div>
    </div>
</footer>

<!-- Toast Message Container -->
<div class="toast-msg"></div>

<!-- Custom Frontend Logic Scripts -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
