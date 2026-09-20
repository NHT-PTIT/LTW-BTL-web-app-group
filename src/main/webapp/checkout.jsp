<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Thanh toán & Đặt hàng - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="shop" />
</jsp:include>

    
    <!-- Breadcromb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Thanh toán đơn hàng</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="breadcromb-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-bottom-text">
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                <li><a href="${pageContext.request.contextPath}/shop.jsp">Cửa hàng</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                <li>Thanh toán</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcromb Area End -->
    
    <!-- Checkout Area Start -->
    <section class="bleezy-checkout-area section_100">
        <div class="container">
            <form action="${pageContext.request.contextPath}/order-success.jsp" method="get">
                <div class="row">
                    <!-- Billing Address Form -->
                    <div class="col-md-6">
                        <div class="bleezy-checkout-form checkout-form-right">
                            <h3>Thông tin giao hàng (Khách hàng)</h3>
                            <div class="row checkout-form">
                                <div class="col-md-12">
                                    <label for="fullname">Họ và tên người nhận *</label>
                                    <input type="text" name="customerName" id="fullname" value="Nguyễn Văn An" required>
                                </div>
                            </div>
                            <div class="row checkout-form">
                                <div class="col-md-6">
                                    <label for="phone">Số điện thoại liên hệ *</label>
                                    <input type="tel" name="customerPhone" id="phone" value="0988123456" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="email">Địa chỉ Email</label>
                                    <input type="email" name="customerEmail" id="email" value="nguyenvanan@gmail.com">
                                </div>
                            </div>
                            <div class="row checkout-form">
                                <div class="col-md-12">
                                    <label for="city">Tỉnh / Thành phố *</label>
                                    <input type="text" name="city" id="city" value="Hà Nội" required>
                                </div>
                            </div>
                            <div class="row checkout-form">
                                <div class="col-md-12">
                                    <label for="address">Địa chỉ chi tiết (Số nhà, Tên đường, Phường/Xã) *</label>
                                    <input type="text" name="shippingAddress" id="address" value="Số 96A Trần Phú, Phường Mộ Lao, Quận Hà Đông" required>
                                </div>
                            </div>
                            <div class="row checkout-form">
                                <div class="col-md-12">
                                    <label for="ordernote">Ghi chú giao hàng & Yêu cầu lắp đặt</label>
                                    <textarea name="note" id="ordernote" placeholder="Ví dụ: Giao hàng vào giờ hành chính, gọi trước khi giao 30 phút..."></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Order Summary & Payment -->
                    <div class="col-md-6">
                        <div class="calculate-shipping-bottom checkout-shiping-bottom margin-top">
                            <h3>Tóm tắt đơn hàng</h3>
                            <table>
                                <thead>
                                    <tr style="border-bottom: 2px solid #eee;">
                                        <th style="padding: 10px 0;">Sản phẩm</th>
                                        <th style="padding: 10px 0; text-align: right;">Tạm tính</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Inverter Deye 5kW Hybrid × 1</td>
                                        <td style="text-align: right;">22.500.000₫</td>
                                    </tr>
                                    <tr>
                                        <td>Tấm Pin Longi 450W × 2</td>
                                        <td style="text-align: right;">4.900.000₫</td>
                                    </tr>
                                    <tr>
                                        <td>Phí vận chuyển & Đóng gói:</td>
                                        <td style="text-align: right; color: #28a745; font-weight: bold;">Miễn phí</td>
                                    </tr>
                                    <tr style="border-top: 2px solid #eee;">
                                        <td><strong style="font-size: 16px;">Tổng thanh toán:</strong></td>
                                        <td style="text-align: right;"><strong style="color: #e85b24; font-size: 20px;">27.400.000₫</strong></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="bleezy-payment" style="margin-top: 25px;">
                            <h3 style="font-size: 18px; margin-bottom: 15px;">Phương thức thanh toán</h3>
                            <div class="payment" style="border: 1px solid #eee; padding: 15px; border-radius: 4px; margin-bottom: 10px;">
                                <label style="display: flex; align-items: center; gap: 10px; cursor: pointer; margin-bottom: 0;">
                                    <input type="radio" name="paymentMethod" value="COD" checked>
                                    <h4 style="margin: 0; font-size: 15px;">Thanh toán khi nhận hàng (COD)</h4>
                                </label>
                                <p style="margin: 8px 0 0 25px; color: #666; font-size: 13px;">Khách hàng được quyền đồng kiểm sản phẩm nguyên đai nguyên kiện trước khi thanh toán tiền mặt cho nhân viên giao hàng.</p>
                            </div>
                            <div class="payment" style="border: 1px solid #eee; padding: 15px; border-radius: 4px; margin-bottom: 10px;">
                                <label style="display: flex; align-items: center; gap: 10px; cursor: pointer; margin-bottom: 0;">
                                    <input type="radio" name="paymentMethod" value="BANK">
                                    <h4 style="margin: 0; font-size: 15px;">Chuyển khoản ngân hàng (Quét mã QR / VietQR)</h4>
                                </label>
                                <p style="margin: 8px 0 0 25px; color: #666; font-size: 13px;">Chuyển khoản trực tiếp tới STK công ty: Vietcombank - 0011001234567 (Chi nhánh Hà Nội). Nội dung: [Mã Đơn Hàng] - [Số điện thoại].</p>
                            </div>
                        </div>
                        <div class="proceed-checkout" style="margin-top: 20px;">
                            <button type="submit" class="bleezy-btn" style="width: 100%; border: none; cursor: pointer; font-size: 16px; padding: 15px 0;">
                                <i class="fa fa-check-circle"></i> Xác nhận đặt hàng
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>
    <!-- Checkout Area End -->
    
    <jsp:include page="/common/footer.jsp" />

