<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Thanh toán & Đặt hàng - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="shop" />
</jsp:include>
    
    <!-- Breadcrumb Area Start -->
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
                                <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                <li><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                <li>Thanh toán</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Area End -->
    
    <!-- Checkout Area Start -->
    <section class="bleezy-checkout-area section_100">
        <div class="container">
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible" role="alert" style="margin-bottom: 25px;">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <i class="fa fa-exclamation-circle"></i> <c:out value="${errorMessage}"/>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/checkout" method="post">
                <div class="row">
                    <!-- Billing Address Form -->
                    <div class="col-md-6">
                        <div class="bleezy-checkout-form checkout-form-right" style="background: #fff; padding: 30px; border: 1px solid #eee; border-radius: 6px;">
                            <h3 style="font-size: 20px; font-weight: bold; border-bottom: 2px solid #e85b24; padding-bottom: 12px; margin-bottom: 20px;">
                                <i class="fa fa-user-circle-o" style="color: #e85b24;"></i> Thông tin nhận hàng (Khách hàng)
                            </h3>

                            <c:choose>
                                <c:when test="${not empty sessionScope.currentUser}">
                                    <div style="background: #eff6ff; border-left: 4px solid #3b82f6; padding: 12px 15px; border-radius: 4px; margin-bottom: 20px; font-size: 13.5px; color: #1e40af;">
                                        <i class="fa fa-check-circle" style="color: #3b82f6; margin-right: 6px;"></i>
                                        Bạn đang đặt hàng với tài khoản <strong><c:out value="${sessionScope.currentUser.fullName}"/></strong>. Đơn hàng sẽ được liên kết trực tiếp vào <strong>Lịch sử đơn hàng</strong> của bạn.
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div style="background: #fffbeb; border-left: 4px solid #f59e0b; padding: 12px 15px; border-radius: 4px; margin-bottom: 20px; font-size: 13.5px; color: #92400e;">
                                        <i class="fa fa-info-circle" style="color: #f59e0b; margin-right: 6px;"></i>
                                        Bạn đang mua hàng với tư cách khách vãng lai. 
                                        <a href="${pageContext.request.contextPath}/login?redirect=checkout" style="color: #d97706; font-weight: bold; text-decoration: underline;">Đăng nhập ngay</a> 
                                        để tự động điền thông tin và theo dõi đơn hàng!
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="row checkout-form">
                                <div class="col-md-12">
                                    <label for="fullname">Họ và tên người nhận <span style="color: red;">*</span></label>
                                    <input type="text" name="customerName" id="fullname" 
                                           value="<c:out value="${not empty customerName ? customerName : ''}"/>" 
                                           placeholder="Ví dụ: Nguyễn Văn An" required>
                                </div>
                            </div>
                            <div class="row checkout-form">
                                <div class="col-md-6">
                                    <label for="phone">Số điện thoại liên hệ <span style="color: red;">*</span></label>
                                    <input type="tel" name="customerPhone" id="phone" 
                                           value="<c:out value="${not empty customerPhone ? customerPhone : ''}"/>" 
                                           placeholder="Ví dụ: 0988123456" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="email">Địa chỉ Email</label>
                                    <input type="email" name="customerEmail" id="email" 
                                           value="<c:out value="${not empty customerEmail ? customerEmail : ''}"/>" 
                                           placeholder="Để nhận thông báo đơn hàng">
                                </div>
                            </div>
                            <div class="row checkout-form">
                                <div class="col-md-12">
                                    <label for="city">Tỉnh / Thành phố <span style="color: red;">*</span></label>
                                    <input type="text" name="city" id="city" 
                                           value="<c:out value="${not empty city ? city : 'Hà Nội'}"/>" 
                                           placeholder="Ví dụ: Hà Nội, TP. Hồ Chí Minh, Đà Nẵng..." required>
                                </div>
                            </div>
                            <div class="row checkout-form">
                                <div class="col-md-12">
                                    <label for="address">Địa chỉ chi tiết (Số nhà, Tên đường, Phường/Xã) <span style="color: red;">*</span></label>
                                    <input type="text" name="shippingAddress" id="address" 
                                           value="<c:out value="${not empty shippingAddress ? shippingAddress : ''}"/>" 
                                           placeholder="Ví dụ: Số 96A Trần Phú, Phường Mộ Lao, Quận Hà Đông" required>
                                </div>
                            </div>
                            <div class="row checkout-form">
                                <div class="col-md-12">
                                    <label for="ordernote">Ghi chú giao hàng & Yêu cầu kỹ thuật</label>
                                    <textarea name="note" id="ordernote" placeholder="Ví dụ: Giao hàng vào giờ hành chính, cần kỹ sư gọi điện hướng dẫn cài đặt tham số..."><c:out value="${note}"/></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order Summary & Payment -->
                    <div class="col-md-6">
                        <div class="calculate-shipping-bottom checkout-shiping-bottom margin-top" style="background: #fff; padding: 30px; border: 1px solid #eee; border-radius: 6px;">
                            <h3 style="font-size: 20px; font-weight: bold; border-bottom: 2px solid #e85b24; padding-bottom: 12px; margin-bottom: 20px;">
                                <i class="fa fa-shopping-basket" style="color: #e85b24;"></i> Tóm tắt đơn hàng (${sessionScope.cart.totalQuantity} món)
                            </h3>
                            <table class="table">
                                <thead>
                                    <tr style="border-bottom: 2px solid #eee;">
                                        <th style="padding: 10px 0; color: #555;">Sản phẩm</th>
                                        <th style="padding: 10px 0; text-align: right; color: #555;">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${sessionScope.cart.items}" var="ci">
                                        <tr>
                                            <td style="padding: 12px 0;">
                                                <strong style="color: #222;"><c:out value="${ci.product.name}"/></strong>
                                                <span style="color: #e85b24; font-weight: 600;"> × ${ci.quantity}</span>
                                                <c:if test="${not empty ci.product.sku}">
                                                    <br><small style="color: #888;">SKU: <c:out value="${ci.product.sku}"/></small>
                                                </c:if>
                                            </td>
                                            <td style="padding: 12px 0; text-align: right; font-weight: 600; color: #333;">
                                                ${ci.formattedSubtotal}
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr style="border-top: 1px solid #eee;">
                                        <td style="padding: 10px 0; color: #666;">Tạm tính đơn hàng:</td>
                                        <td style="padding: 10px 0; text-align: right; color: #333; font-weight: 600;">
                                            ${sessionScope.cart.formattedTotalAmount}
                                        </td>
                                    </tr>
                                    <c:if test="${not empty sessionScope.cart.appliedCoupon}">
                                        <tr style="background: #f0fdf4;">
                                            <td style="padding: 10px 0; color: #166534; font-weight: 600;">
                                                <i class="fa fa-ticket"></i> Mã giảm giá (${sessionScope.cart.appliedCoupon.code}):
                                            </td>
                                            <td style="padding: 10px 0; text-align: right; color: #16a34a; font-weight: bold;">
                                                ${sessionScope.cart.formattedDiscountAmount}
                                            </td>
                                        </tr>
                                    </c:if>
                                    <tr>
                                        <td style="padding: 10px 0; color: #666;">Phí vận chuyển & Bảo hiểm hàng:</td>
                                        <td style="padding: 10px 0; text-align: right; color: #16a34a; font-weight: bold;">
                                            <i class="fa fa-check"></i> Miễn phí giao hàng
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 10px 0; color: #666;">Hóa đơn tài chính:</td>
                                        <td style="padding: 10px 0; text-align: right; color: #666;">Đã bao gồm thuế GTGT (VAT)</td>
                                    </tr>
                                    <tr style="border-top: 2px solid #ddd; background: #fafafa;">
                                        <td style="padding: 15px 10px;"><strong style="font-size: 16px; color: #111;">Tổng thanh toán:</strong></td>
                                        <td style="padding: 15px 10px; text-align: right;">
                                            <strong style="color: #e85b24; font-size: 22px;">${sessionScope.cart.formattedFinalTotal}</strong>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                            <div class="bleezy-payment" style="margin-top: 30px;">
                                <h3 style="font-size: 18px; font-weight: bold; margin-bottom: 15px; color: #222;">
                                    Phương thức thanh toán
                                </h3>
                                <div class="payment" style="border: 1px solid #ddd; padding: 15px; border-radius: 6px; margin-bottom: 12px; background: #fafafa;">
                                    <label style="display: flex; align-items: center; gap: 10px; cursor: pointer; margin-bottom: 0;">
                                        <input type="radio" name="paymentMethod" value="COD" checked style="width: 18px; height: 18px;">
                                        <h4 style="margin: 0; font-size: 15px; font-weight: 600; color: #222;">Thanh toán khi nhận hàng (COD)</h4>
                                    </label>
                                    <p style="margin: 8px 0 0 28px; color: #666; font-size: 13px;">
                                        Nhận hàng, kiểm tra sản phẩm chính hãng nguyên tem bảo hành trước khi thanh toán tiền mặt cho nhân viên giao hàng.
                                    </p>
                                </div>
                                <div class="payment" style="border: 1px solid #c7d2fe; padding: 15px; border-radius: 6px; margin-bottom: 12px; background: #f8faff;">
                                    <label style="display: flex; align-items: center; gap: 10px; cursor: pointer; margin-bottom: 0;">
                                        <input type="radio" name="paymentMethod" value="BANK_TRANSFER" style="width: 18px; height: 18px;">
                                        <h4 style="margin: 0; font-size: 15px; font-weight: 600; color: #4338ca;">
                                            <i class="fa fa-qrcode"></i> Chuyển khoản ngân hàng (Quét mã VietQR tự động)
                                        </h4>
                                    </label>
                                    <div style="margin: 8px 0 0 28px; color: #475569; font-size: 13px;">
                                        Ngân hàng: <strong style="color: #4338ca;">${companyInfo.bankName}</strong> | 
                                        Số TK: <strong style="font-family: monospace; font-size: 14px;">${companyInfo.bankAccountNo}</strong> | 
                                        Chủ TK: <strong>${companyInfo.bankAccountName}</strong>
                                        <div style="margin-top: 6px; color: #059669; font-size: 12px; font-weight: 600;">
                                            <i class="fa fa-bolt"></i> Mã VietQR chuẩn Napas 24/7 tự động điền số tiền sẽ được hiển thị ngay khi bạn nhấn "Hoàn tất đặt hàng".
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="proceed-checkout" style="margin-top: 25px;">
                                <button type="submit" class="bleezy-btn" 
                                        style="width: 100%; border: none; cursor: pointer; font-size: 17px; padding: 16px 0; border-radius: 4px; box-shadow: 0 4px 12px rgba(232,91,36,0.35);">
                                    <i class="fa fa-shield"></i> Xác nhận & Hoàn tất đặt hàng
                                </button>
                                <p style="text-align: center; color: #888; font-size: 12px; margin-top: 10px;">
                                    <i class="fa fa-lock"></i> Thông tin đặt hàng của bạn được bảo mật tuyệt đối 100%
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </section>
    <!-- Checkout Area End -->
    
<jsp:include page="/common/footer.jsp" />
