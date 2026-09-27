<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Đặt hàng thành công - Bleezy Security" />
    <jsp:param name="activeMenu" value="shop" />
</jsp:include>
    
    <!-- Breadcrumb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Xác nhận đặt hàng</h2>
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
                                <li><a href="${pageContext.request.contextPath}/shop">Cửa hàng</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                <li>Đặt hàng thành công</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Area End -->
    
    <!-- Order Success Area Start -->
    <section class="section_100" style="background: #f8f9fa;">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div style="background: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 5px 20px rgba(0,0,0,0.06); text-align: center;">
                        <div style="margin-bottom: 20px;">
                            <i class="fa fa-check-circle" style="font-size: 70px; color: #16a34a;"></i>
                        </div>
                        <h2 style="font-size: 28px; color: #111; margin-bottom: 10px; font-weight: bold;">
                            ĐẶT HÀNG THÀNH CÔNG!
                        </h2>
                        <p style="color: #555; font-size: 15px; margin-bottom: 25px; line-height: 24px;">
                            Cảm ơn quý khách đã tin tưởng đặt mua thiết bị tại <strong>Bleezy Security</strong>.<br>
                            Bộ phận điều phối kỹ thuật sẽ liên hệ qua số điện thoại để xác nhận lịch giao hàng trong vòng 15-30 phút.
                        </p>
                        
                        <!-- Order Details Card -->
                        <c:choose>
                            <c:when test="${not empty order}">
                                <div style="background: #fafafa; border: 1px dashed #d1d5db; border-radius: 8px; padding: 25px; text-align: left; margin-bottom: 30px;">
                                    <div class="row" style="font-size: 14px;">
                                        <div class="col-sm-6" style="margin-bottom: 15px;">
                                            <p style="margin-bottom: 8px;"><strong>Mã đơn hàng:</strong> <span style="color: #e85b24; font-weight: bold; font-size: 16px;">#${order.orderCode}</span></p>
                                            <p style="margin-bottom: 8px;"><strong>Ngày đặt hàng:</strong> <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/></p>
                                            <p style="margin-bottom: 8px;"><strong>Phương thức:</strong> ${order.paymentMethod == 'COD' ? 'Thanh toán khi nhận hàng (COD)' : 'Chuyển khoản ngân hàng'}</p>
                                            <p style="margin-bottom: 8px;"><strong>Trạng thái đơn:</strong> 
                                                <span class="label label-${order.statusBadgeClass}" style="font-size: 13px; padding: 4px 10px;">
                                                    ${order.statusDisplayName}
                                                </span>
                                            </p>
                                        </div>
                                        <div class="col-sm-6" style="margin-bottom: 15px;">
                                            <p style="margin-bottom: 8px;"><strong>Người nhận:</strong> <c:out value="${order.customerName}"/> (<c:out value="${order.customerPhone}"/>)</p>
                                            <p style="margin-bottom: 8px;"><strong>Địa chỉ:</strong> <c:out value="${order.shippingAddress}"/></p>
                                            <c:if test="${not empty order.note}">
                                                <p style="margin-bottom: 8px;"><strong>Ghi chú:</strong> <c:out value="${order.note}"/></p>
                                            </c:if>
                                            <p style="margin-bottom: 8px;"><strong>Phí vận chuyển:</strong> <span style="color: #16a34a; font-weight: bold;">Miễn phí</span></p>
                                            <c:if test="${not empty order.couponCode}">
                                                <p style="margin-bottom: 8px;"><strong>Mã giảm giá áp dụng:</strong> <span class="label label-success" style="font-size: 12px;"><i class="fa fa-tag"></i> <c:out value="${order.couponCode}"/></span> (<span style="color: #16a34a; font-weight: bold;">${order.formattedDiscountAmount}</span>)</p>
                                            </c:if>
                                            <p style="margin-bottom: 8px;"><strong>Tổng thanh toán:</strong> <strong style="color: #e85b24; font-size: 20px;">${order.formattedTotalAmount}</strong></p>
                                        </div>
                                    </div>

                                    <!-- VietQR Payment Block for BANK_TRANSFER -->
                                    <c:if test="${order.paymentMethod == 'BANK_TRANSFER'}">
                                        <div style="background: linear-gradient(135deg, #eff6ff 0%, #e0e7ff 100%); border: 2px solid #6366f1; border-radius: 12px; padding: 25px; margin: 25px 0; text-align: left; box-shadow: 0 4px 15px rgba(99, 102, 241, 0.1);">
                                            <div class="row" style="align-items: center;">
                                                <div class="col-sm-5 text-center" style="margin-bottom: 15px;">
                                                    <h5 style="color: #4338ca; font-weight: 700; margin-bottom: 12px; font-size: 15px;">
                                                        <i class="fa fa-qrcode"></i> QUÉT MÃ VIETQR QUA APP NGÂN HÀNG
                                                    </h5>
                                                    <div style="background: #fff; padding: 12px; display: inline-block; border-radius: 10px; box-shadow: 0 2px 8px rgba(0,0,0,0.08);">
                                                        <img src="https://img.vietqr.io/image/${companyInfo.bankName}-${companyInfo.bankAccountNo}-compact2.png?amount=${order.totalAmount}&addInfo=${order.orderCode}&accountName=${companyInfo.bankAccountName}" 
                                                             alt="Mã VietQR thanh toán ${order.orderCode}" 
                                                             style="max-width: 100%; width: 230px; height: auto; border-radius: 6px; display: block;" />
                                                    </div>
                                                    <p style="font-size: 12px; color: #6b7280; margin-top: 8px; margin-bottom: 0;">
                                                        Mã QR tự động điền đúng Số tài khoản, Số tiền và Nội dung
                                                    </p>
                                                </div>
                                                <div class="col-sm-7">
                                                    <div style="background: #fff; padding: 18px 20px; border-radius: 10px; border: 1px solid #cbd5e1;">
                                                        <h5 style="color: #1e293b; font-weight: 700; margin-top: 0; margin-bottom: 15px; font-size: 16px; border-bottom: 2px solid #6366f1; padding-bottom: 8px;">
                                                            <i class="fa fa-university"></i> THÔNG TIN CHUYỂN KHOẢN THỦ CÔNG
                                                        </h5>
                                                        <p style="margin-bottom: 10px; font-size: 14px;">
                                                            <strong>Ngân hàng thụ hưởng:</strong> 
                                                            <span style="color: #4338ca; font-weight: 700; text-transform: uppercase;">${companyInfo.bankName}</span>
                                                        </p>
                                                        <p style="margin-bottom: 10px; font-size: 14px;">
                                                            <strong>Số tài khoản:</strong> 
                                                            <span style="font-size: 17px; font-weight: 800; color: #1e293b; font-family: monospace; letter-spacing: 1px;">${companyInfo.bankAccountNo}</span>
                                                            <button type="button" class="btn btn-default btn-xs" onclick="navigator.clipboard.writeText('${companyInfo.bankAccountNo}'); alert('Đã sao chép số tài khoản!');" style="margin-left: 8px; padding: 2px 8px; font-size: 11px;">
                                                                <i class="fa fa-copy"></i> Sao chép
                                                            </button>
                                                        </p>
                                                        <p style="margin-bottom: 10px; font-size: 14px;">
                                                            <strong>Chủ tài khoản:</strong> 
                                                            <span style="font-weight: 700; color: #334155; text-transform: uppercase;">${companyInfo.bankAccountName}</span>
                                                        </p>
                                                        <p style="margin-bottom: 10px; font-size: 14px;">
                                                            <strong>Số tiền thanh toán:</strong> 
                                                            <span style="font-size: 18px; font-weight: 800; color: #e85b24;">${order.formattedTotalAmount}</span>
                                                        </p>
                                                        <p style="margin-bottom: 5px; font-size: 14px;">
                                                            <strong>Nội dung chuyển khoản (bắt buộc):</strong> 
                                                            <span style="font-size: 16px; font-weight: 800; color: #b91c1c; font-family: monospace; background: #fef2f2; padding: 2px 6px; border-radius: 4px; border: 1px dashed #f87171;">${order.orderCode}</span>
                                                            <button type="button" class="btn btn-default btn-xs" onclick="navigator.clipboard.writeText('${order.orderCode}'); alert('Đã sao chép mã đơn hàng!');" style="margin-left: 8px; padding: 2px 8px; font-size: 11px;">
                                                                <i class="fa fa-copy"></i> Sao chép
                                                            </button>
                                                        </p>
                                                        <div style="margin-top: 12px; padding: 8px 12px; background: #fffbeb; border-radius: 6px; border-left: 3px solid #f59e0b; font-size: 12px; color: #92400e;">
                                                            <i class="fa fa-info-circle"></i> Đơn hàng sẽ tự động chuyển sang trạng thái <strong>Đang chuẩn bị hàng</strong> ngay khi bộ phận kế toán xác nhận số dư tài khoản.
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- Order Items List -->
                                    <c:if test="${not empty order.items}">
                                        <div style="margin-top: 15px; border-top: 1px solid #e5e7eb; padding-top: 15px;">
                                            <h4 style="font-size: 15px; font-weight: bold; margin-bottom: 10px; color: #333;">Chi tiết các mặt hàng đã đặt:</h4>
                                            <table class="table table-bordered" style="background: #fff; font-size: 13px; margin-bottom: 0;">
                                                <thead style="background: #f3f4f6;">
                                                    <tr>
                                                        <th>Tên sản phẩm</th>
                                                        <th style="text-align: center; width: 80px;">Số lượng</th>
                                                        <th style="text-align: right; width: 130px;">Đơn giá</th>
                                                        <th style="text-align: right; width: 140px;">Thành tiền</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${order.items}" var="it">
                                                        <tr>
                                                            <td>
                                                                <strong style="color: #222;"><c:out value="${it.productName}"/></strong>
                                                                <c:if test="${not empty it.productSku}">
                                                                    <br><small style="color: #888;">SKU: <c:out value="${it.productSku}"/></small>
                                                                </c:if>
                                                            </td>
                                                            <td style="text-align: center; font-weight: bold;">${it.quantity}</td>
                                                            <td style="text-align: right;">${it.formattedUnitPrice}</td>
                                                            <td style="text-align: right; font-weight: 600; color: #e85b24;">${it.formattedSubtotal}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:if>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div style="background: #fafafa; border: 1px dashed #ddd; border-radius: 6px; padding: 25px; text-align: center; margin-bottom: 30px;">
                                    <p style="color: #666; font-size: 15px;">
                                        Đơn hàng của bạn đã được ghi nhận trên hệ thống và đang trong quá trình chuẩn bị xuất kho.
                                    </p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        
                        <div style="display: flex; justify-content: center; gap: 15px; flex-wrap: wrap;">
                            <a href="${pageContext.request.contextPath}/shop" class="bleezy-btn">
                                <i class="fa fa-shopping-bag"></i> Tiếp tục mua sắm
                            </a>
                            <c:if test="${not empty order}">
                                <a href="${pageContext.request.contextPath}/invoice?code=${order.orderCode}" target="_blank" class="bleezy-btn" style="background: #e85b24; border-color: #e85b24;">
                                    <i class="fa fa-print"></i> In hóa đơn / Phiếu xuất
                                </a>
                                <a href="${pageContext.request.contextPath}/track-order?q=${order.orderCode}" class="bleezy-btn" style="background: #0284c7; border-color: #0284c7;">
                                    <i class="fa fa-truck"></i> Theo dõi đơn hàng
                                </a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/home" class="bleezy-btn" style="background: #374151; border-color: #374151;">
                                <i class="fa fa-home"></i> Về trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Order Success Area End -->
    
<jsp:include page="/common/footer.jsp" />
