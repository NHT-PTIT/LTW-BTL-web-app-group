<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Đơn hàng của tôi - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="pages" />
</jsp:include>

    <!-- Breadcrumb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Đơn hàng của tôi</h2>
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
                                <li><a href="${pageContext.request.contextPath}/account/profile">Tài khoản</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                <li>Lịch sử đơn mua</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Area End -->

    <!-- Account Orders Area Start -->
    <section class="section_100" style="background: #f8fafc;">
        <div class="container">
            <div class="row">
                <!-- Sidebar Tài khoản -->
                <div class="col-md-3 col-sm-4">
                    <div style="background: #fff; border-radius: 8px; border: 1px solid #e2e8f0; padding: 24px; margin-bottom: 30px; text-align: center;">
                        <div style="width: 80px; height: 80px; border-radius: 50%; background: #f26723; color: #fff; font-size: 32px; font-weight: 700; display: inline-flex; align-items: center; justify-content: center; margin-bottom: 14px; box-shadow: 0 4px 10px rgba(242, 103, 35, 0.25);">
                            ${sessionScope.currentUser.avatarInitial}
                        </div>
                        <h4 style="font-weight: 700; color: #1e293b; margin-bottom: 4px; font-size: 17px;">
                            ${sessionScope.currentUser.fullName}
                        </h4>
                        <p style="color: #64748b; font-size: 13px; margin-bottom: 20px;">
                            @${sessionScope.currentUser.username}
                        </p>

                        <ul style="list-style: none; padding: 0; margin: 0; text-align: left; border-top: 1px solid #e2e8f0; padding-top: 15px;">
                            <li style="margin-bottom: 8px;">
                                <a href="${pageContext.request.contextPath}/account/profile" 
                                   style="display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 6px; font-weight: 500; text-decoration: none; color: #475569; transition: all 0.2s;">
                                    <i class="fa fa-user-circle" style="width: 18px;"></i> Hồ sơ cá nhân
                                </a>
                            </li>
                            <li style="margin-bottom: 8px;">
                                <a href="${pageContext.request.contextPath}/account/orders" 
                                   style="display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 6px; font-weight: 600; text-decoration: none; background: rgba(242, 103, 35, 0.1); color: #f26723;">
                                    <i class="fa fa-shopping-basket" style="width: 18px;"></i> Đơn hàng của tôi
                                </a>
                            </li>
                            <li style="margin-bottom: 8px;">
                                <a href="${pageContext.request.contextPath}/account/wishlist" 
                                   style="display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 6px; font-weight: 500; text-decoration: none; color: #475569; transition: all 0.2s;">
                                    <i class="fa fa-heart" style="width: 18px;"></i> Sản phẩm yêu thích
                                </a>
                            </li>
                            <li style="margin-bottom: 8px;">
                                <a href="${pageContext.request.contextPath}/cart" 
                                   style="display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 6px; font-weight: 500; text-decoration: none; color: #475569; transition: all 0.2s;">
                                    <i class="fa fa-shopping-cart" style="width: 18px;"></i> Giỏ hàng hiện tại
                                </a>
                            </li>
                            <li style="border-top: 1px solid #e2e8f0; margin-top: 12px; padding-top: 12px;">
                                <a href="${pageContext.request.contextPath}/logout" 
                                   style="display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 6px; font-weight: 600; text-decoration: none; color: #dc2626; transition: all 0.2s;">
                                    <i class="fa fa-sign-out" style="width: 18px;"></i> Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Nội dung chính -->
                <div class="col-md-9 col-sm-8">

                    <!-- TRƯỜNG HỢP 1: XEM CHI TIẾT ĐƠN HÀNG (orderDetail) -->
                    <c:if test="${not empty orderDetail}">
                        <!-- Thông báo khi hủy đơn -->
                        <c:if test="${param.msg == 'cancel_success'}">
                            <div class="alert alert-success" style="padding: 14px; margin-bottom: 20px; border-radius: 6px; background: #ecfdf5; border: 1px solid #6ee7b7; color: #065f46; font-size: 14px;">
                                <i class="fa fa-check-circle" style="margin-right: 6px;"></i> Đơn hàng #${orderDetail.orderCode} đã được hủy thành công. Số lượng sản phẩm đã được tự động hoàn trả lại kho hàng!
                            </div>
                        </c:if>
                        <c:if test="${param.err == 'cancel_failed'}">
                            <div class="alert alert-danger" style="padding: 14px; margin-bottom: 20px; border-radius: 6px; background: #fef2f2; border: 1px solid #fca5a5; color: #991b1b; font-size: 14px;">
                                <i class="fa fa-exclamation-triangle" style="margin-right: 6px;"></i> Không thể hủy đơn hàng này do đơn đã được chuyển sang khâu vận chuyển hoặc đã kết thúc.
                            </div>
                        </c:if>

                        <div style="background: #fff; border-radius: 8px; border: 1px solid #e2e8f0; padding: 28px; margin-bottom: 24px;">
                            <div style="display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid #e2e8f0; padding-bottom: 16px; margin-bottom: 20px; flex-wrap: wrap; gap: 10px;">
                                <div>
                                    <a href="${pageContext.request.contextPath}/account/orders" style="color: #64748b; font-size: 13px; text-decoration: none; font-weight: 600;">
                                        <i class="fa fa-arrow-left"></i> Quay lại danh sách đơn hàng
                                    </a>
                                    <h3 style="font-size: 20px; font-weight: 700; color: #0f172a; margin: 6px 0 0 0;">
                                        CHI TIẾT ĐƠN HÀNG #${orderDetail.orderCode}
                                    </h3>
                                    <span style="font-size: 12px; color: #64748b;">
                                        Đặt ngày: <fmt:formatDate value="${orderDetail.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                    </span>
                                </div>
                                <div style="display: flex; align-items: center; gap: 10px; flex-wrap: wrap;">
                                    <c:choose>
                                        <c:when test="${orderDetail.status == 'COMPLETED'}">
                                            <span style="display: inline-block; background: #dcfce7; color: #15803d; padding: 6px 14px; border-radius: 20px; font-weight: 600; font-size: 13px;">
                                                <i class="fa fa-check-circle"></i> Đã hoàn tất
                                            </span>
                                        </c:when>
                                        <c:when test="${orderDetail.status == 'SHIPPING'}">
                                            <span style="display: inline-block; background: #e0f2fe; color: #0369a1; padding: 6px 14px; border-radius: 20px; font-weight: 600; font-size: 13px;">
                                                <i class="fa fa-truck"></i> Đang giao hàng
                                            </span>
                                        </c:when>
                                        <c:when test="${orderDetail.status == 'CANCELLED'}">
                                            <span style="display: inline-block; background: #fee2e2; color: #b91c1c; padding: 6px 14px; border-radius: 20px; font-weight: 600; font-size: 13px;">
                                                <i class="fa fa-times-circle"></i> Đã hủy
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="display: inline-block; background: #fef3c7; color: #b45309; padding: 6px 14px; border-radius: 20px; font-weight: 600; font-size: 13px;">
                                                <i class="fa fa-clock-o"></i> Chờ duyệt đơn
                                            </span>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- Nút In hóa đơn bán lẻ -->
                                    <a href="${pageContext.request.contextPath}/invoice?id=${orderDetail.id}" target="_blank"
                                       style="display: inline-flex; align-items: center; gap: 5px; background: #fff; border: 1px solid #0284c7; color: #0284c7; padding: 6px 14px; border-radius: 20px; font-size: 13px; font-weight: 600; text-decoration: none; transition: all 0.2s;"
                                       onmouseover="this.style.background='#0284c7'; this.style.color='#fff';"
                                       onmouseout="this.style.background='#fff'; this.style.color='#0284c7';">
                                        <i class="fa fa-print"></i> In hóa đơn
                                    </a>

                                    <!-- Nút Hủy đơn hàng cho Khách nếu đơn còn PENDING -->
                                    <c:if test="${orderDetail.status == 'PENDING'}">
                                        <form action="${pageContext.request.contextPath}/account/orders" method="post" style="display: inline-block; margin: 0;"
                                              onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${orderDetail.orderCode} không?\nSố lượng sản phẩm sẽ được tự động hoàn lại kho hàng.');">
                                            <input type="hidden" name="action" value="cancel-order">
                                            <input type="hidden" name="orderId" value="${orderDetail.id}">
                                            <button type="submit" style="background: #fff; border: 1px solid #ef4444; color: #ef4444; padding: 6px 14px; border-radius: 20px; font-size: 13px; font-weight: 600; cursor: pointer; transition: all 0.2s;"
                                                    onmouseover="this.style.background='#ef4444'; this.style.color='#fff';"
                                                    onmouseout="this.style.background='#fff'; this.style.color='#ef4444';">
                                                <i class="fa fa-trash-o" style="margin-right: 4px;"></i> Hủy đơn hàng
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Bảng các mặt hàng trong đơn -->
                            <div class="table-responsive" style="margin-bottom: 24px;">
                                <table class="table" style="border: 1px solid #e2e8f0; margin-bottom: 0;">
                                    <thead style="background: #f8fafc;">
                                        <tr>
                                            <th style="border-top: none; font-size: 12px; color: #64748b; text-transform: uppercase;">Ảnh</th>
                                            <th style="border-top: none; font-size: 12px; color: #64748b; text-transform: uppercase;">Thiết bị</th>
                                            <th style="border-top: none; font-size: 12px; color: #64748b; text-transform: uppercase;">Mã SKU</th>
                                            <th style="border-top: none; font-size: 12px; color: #64748b; text-transform: uppercase;">Đơn giá</th>
                                            <th style="border-top: none; font-size: 12px; color: #64748b; text-transform: uppercase;">Số lượng</th>
                                            <th style="border-top: none; font-size: 12px; color: #64748b; text-transform: uppercase; text-align: right;">Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${orderDetail.items}">
                                            <tr>
                                                <td style="vertical-align: middle; width: 60px;">
                                                    <c:set var="fallbackImg" value="${pageContext.request.contextPath}/assets/img/product-1.jpg" />
                                                    <c:set var="displayImg" value="${fallbackImg}" />
                                                    <c:if test="${not empty item.productImage}">
                                                        <c:choose>
                                                            <c:when test="${item.productImage.startsWith('http://') || item.productImage.startsWith('https://')}">
                                                                <c:set var="displayImg" value="${item.productImage}" />
                                                            </c:when>
                                                            <c:when test="${item.productImage.startsWith('/')}">
                                                                <c:set var="displayImg" value="${pageContext.request.contextPath}${item.productImage}" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set var="displayImg" value="${pageContext.request.contextPath}/${item.productImage}" />
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                    <img src="${displayImg}" alt="<c:out value='${item.productName}' />" 
                                                         style="width: 48px; height: 48px; object-fit: cover; border-radius: 4px; border: 1px solid #e2e8f0;"
                                                         onerror="this.onerror=null; this.src='${fallbackImg}';">
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <strong style="color: #1e293b;">${item.productName}</strong>
                                                </td>
                                                <td style="vertical-align: middle; font-size: 12px; color: #64748b;">${item.productSku}</td>
                                                <td style="vertical-align: middle; font-size: 13px;">${item.formattedUnitPrice}</td>
                                                <td style="vertical-align: middle; font-weight: 600;">x ${item.quantity}</td>
                                                <td style="vertical-align: middle; text-align: right; font-weight: 700; color: #f26723;">
                                                    ${item.formattedSubtotal}
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                    <tfoot>
                                        <c:if test="${not empty orderDetail.couponCode}">
                                            <tr style="background: #f0fdf4; font-size: 13.5px;">
                                                <td colspan="5" style="text-align: right; color: #166534; font-weight: 600;">
                                                    <i class="fa fa-ticket"></i> Mã giảm giá (${orderDetail.couponCode}):
                                                </td>
                                                <td style="text-align: right; font-weight: 700; color: #16a34a;">
                                                    ${orderDetail.formattedDiscountAmount}
                                                </td>
                                            </tr>
                                        </c:if>
                                        <tr style="background: #f8fafc; font-size: 15px;">
                                            <td colspan="5" style="text-align: right; font-weight: 700; text-transform: uppercase;">Tổng giá trị đơn hàng:</td>
                                            <td style="text-align: right; font-weight: 700; color: #f26723; font-size: 18px;">
                                                ${orderDetail.formattedTotalAmount}
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>

                            <!-- Thông tin người nhận & Địa chỉ -->
                            <div class="row">
                                <div class="col-sm-6">
                                    <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 18px; margin-bottom: 15px;">
                                        <h4 style="font-size: 14px; font-weight: 700; color: #1e293b; margin: 0 0 10px 0; border-bottom: 1px solid #e2e8f0; padding-bottom: 6px;">
                                            <i class="fa fa-user" style="color: #f26723; margin-right: 6px;"></i> THÔNG TIN NGƯỜI NHẬN
                                        </h4>
                                        <p style="margin: 0 0 4px 0; font-size: 13px; color: #334155;"><strong>Họ tên:</strong> ${orderDetail.customerName}</p>
                                        <p style="margin: 0 0 4px 0; font-size: 13px; color: #334155;"><strong>SĐT:</strong> ${orderDetail.customerPhone}</p>
                                        <p style="margin: 0; font-size: 13px; color: #334155;"><strong>Email:</strong> ${not empty orderDetail.customerEmail ? orderDetail.customerEmail : 'Không có'}</p>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 18px; margin-bottom: 15px;">
                                        <h4 style="font-size: 14px; font-weight: 700; color: #1e293b; margin: 0 0 10px 0; border-bottom: 1px solid #e2e8f0; padding-bottom: 6px;">
                                            <i class="fa fa-map-marker" style="color: #f26723; margin-right: 6px;"></i> GIAO HÀNG & THANH TOÁN
                                        </h4>
                                        <p style="margin: 0 0 4px 0; font-size: 13px; color: #334155;"><strong>Địa chỉ:</strong> ${orderDetail.shippingAddress}</p>
                                        <p style="margin: 0 0 4px 0; font-size: 13px; color: #334155;">
                                            <strong>Hình thức:</strong> ${orderDetail.paymentMethod == 'BANK_TRANSFER' ? 'Chuyển khoản ngân hàng' : 'Tiền mặt khi nhận hàng (COD)'}
                                        </p>
                                        <c:if test="${not empty orderDetail.note}">
                                            <p style="margin: 0; font-size: 12px; color: #b45309; font-style: italic;">
                                                <strong>Ghi chú:</strong> "${orderDetail.note}"
                                            </p>
                                        </c:if>
                                    </div>
                            </div>

                            <!-- VietQR Payment for Pending Bank Transfer Orders -->
                            <c:if test="${orderDetail.paymentMethod == 'BANK_TRANSFER' && orderDetail.status == 'PENDING'}">
                                <div style="background: linear-gradient(135deg, #eff6ff 0%, #e0e7ff 100%); border: 2px solid #6366f1; border-radius: 8px; padding: 20px; margin-top: 15px;">
                                    <div class="row" style="align-items: center;">
                                        <div class="col-sm-4 text-center" style="margin-bottom: 12px;">
                                            <img src="https://img.vietqr.io/image/${companyInfo.bankName}-${companyInfo.bankAccountNo}-compact2.png?amount=${orderDetail.totalAmount}&addInfo=${orderDetail.orderCode}&accountName=${companyInfo.bankAccountName}" 
                                                 alt="VietQR #${orderDetail.orderCode}" 
                                                 style="max-width: 170px; border-radius: 6px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); background: #fff; padding: 4px;" />
                                            <div style="font-size: 11px; color: #4b5563; margin-top: 6px; font-weight: 600;">
                                                <i class="fa fa-qrcode"></i> Quét mã VietQR chuyển khoản
                                            </div>
                                        </div>
                                        <div class="col-sm-8">
                                            <h5 style="color: #3730a3; font-weight: 700; margin-top: 0; font-size: 15px;">
                                                <i class="fa fa-university"></i> THÔNG TIN CHUYỂN KHOẢN ĐƠN HÀNG #${orderDetail.orderCode}
                                            </h5>
                                            <p style="margin: 0 0 6px 0; font-size: 13px;"><strong>Ngân hàng thụ hưởng:</strong> <span style="color: #4338ca; font-weight: 700;">${companyInfo.bankName}</span></p>
                                            <p style="margin: 0 0 6px 0; font-size: 13px;">
                                                <strong>Số tài khoản:</strong> <span style="font-family: monospace; font-weight: 700; font-size: 14px;">${companyInfo.bankAccountNo}</span>
                                            </p>
                                            <p style="margin: 0 0 6px 0; font-size: 13px;"><strong>Chủ tài khoản:</strong> ${companyInfo.bankAccountName}</p>
                                            <p style="margin: 0 0 6px 0; font-size: 13px;">
                                                <strong>Số tiền cần thanh toán:</strong> <strong style="color: #e85b24; font-size: 15px;">${orderDetail.formattedTotalAmount}</strong>
                                            </p>
                                            <p style="margin: 0; font-size: 13px;">
                                                <strong>Cú pháp chuyển khoản:</strong> <span style="font-family: monospace; font-weight: 700; color: #b91c1c; background: #fff; padding: 2px 6px; border-radius: 3px; border: 1px dashed #fca5a5;">${orderDetail.orderCode}</span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </c:if>

                    <!-- TRƯỜNG HỢP 2: DANH SÁCH ĐƠN HÀNG (orders) -->
                    <c:if test="${empty orderDetail}">
                        <div style="background: #fff; border-radius: 8px; border: 1px solid #e2e8f0; padding: 28px;">
                            <div style="border-bottom: 1px solid #e2e8f0; padding-bottom: 12px; margin-bottom: 20px;">
                                <h3 style="font-size: 18px; font-weight: 700; color: #0f172a; margin: 0;">
                                    <i class="fa fa-shopping-basket" style="color: #f26723; margin-right: 8px;"></i> LỊCH SỬ ĐƠN HÀNG CỦA BẠN
                                </h3>
                                <p style="color: #64748b; font-size: 13px; margin: 4px 0 0 0;">
                                    Theo dõi tình trạng vận chuyển và xem lại hóa đơn của các thiết bị đã mua.
                                </p>
                            </div>

                            <c:choose>
                                <c:when test="${empty orders}">
                                    <div style="text-align: center; padding: 50px 20px; color: #64748b;">
                                        <i class="fa fa-shopping-bag" style="font-size: 48px; color: #cbd5e1; margin-bottom: 16px; display: block;"></i>
                                        <h4 style="font-size: 16px; font-weight: 600; color: #334155; margin-bottom: 8px;">Bạn chưa có đơn hàng nào!</h4>
                                        <p style="font-size: 13px; margin-bottom: 20px;">Hãy khám phá các thiết bị biến tần và giải pháp điện mặt trời chính hãng của chúng tôi.</p>
                                        <a href="${pageContext.request.contextPath}/shop" 
                                           style="display: inline-block; background: #f26723; color: #fff; font-family: 'Oswald', sans-serif; font-size: 14px; font-weight: 600; padding: 10px 22px; border-radius: 4px; text-decoration: none; text-transform: uppercase;">
                                            <i class="fa fa-shopping-cart" style="margin-right: 6px;"></i> Mua sắm ngay
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table" style="border: 1px solid #e2e8f0; margin-bottom: 0;">
                                            <thead style="background: #f8fafc;">
                                                <tr>
                                                    <th style="border-top: none; font-size: 12px; color: #64748b; text-transform: uppercase;">Mã đơn</th>
                                                    <th style="border-top: none; font-size: 12px; color: #64748b; text-transform: uppercase;">Ngày đặt</th>
                                                    <th style="border-top: none; font-size: 12px; color: #64748b; text-transform: uppercase;">Số mặt hàng</th>
                                                    <th style="border-top: none; font-size: 12px; color: #64748b; text-transform: uppercase;">Tổng tiền</th>
                                                    <th style="border-top: none; font-size: 12px; color: #64748b; text-transform: uppercase;">Trạng thái</th>
                                                    <th style="border-top: none; font-size: 12px; color: #64748b; text-transform: uppercase; text-align: right;">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="ord" items="${orders}">
                                                    <tr>
                                                        <td style="vertical-align: middle;">
                                                            <a href="${pageContext.request.contextPath}/account/orders?action=detail&id=${ord.id}" style="font-weight: 700; color: #0f172a; text-decoration: none;">
                                                                ${ord.orderCode}
                                                            </a>
                                                        </td>
                                                        <td style="vertical-align: middle; font-size: 13px; color: #64748b;">
                                                            <fmt:formatDate value="${ord.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                                        </td>
                                                        <td style="vertical-align: middle; font-size: 13px;">
                                                            ${ord.items.size()} sản phẩm
                                                        </td>
                                                        <td style="vertical-align: middle; font-weight: 700; color: #f26723;">
                                                            ${ord.formattedTotalAmount}
                                                        </td>
                                                        <td style="vertical-align: middle;">
                                                            <c:choose>
                                                                <c:when test="${ord.status == 'COMPLETED'}">
                                                                    <span style="display: inline-block; background: #dcfce7; color: #15803d; padding: 4px 10px; border-radius: 12px; font-weight: 600; font-size: 11px;">
                                                                        <i class="fa fa-check"></i> Đã hoàn tất
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${ord.status == 'SHIPPING'}">
                                                                    <span style="display: inline-block; background: #e0f2fe; color: #0369a1; padding: 4px 10px; border-radius: 12px; font-weight: 600; font-size: 11px;">
                                                                        <i class="fa fa-truck"></i> Đang giao
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${ord.status == 'CANCELLED'}">
                                                                    <span style="display: inline-block; background: #fee2e2; color: #b91c1c; padding: 4px 10px; border-radius: 12px; font-weight: 600; font-size: 11px;">
                                                                        <i class="fa fa-ban"></i> Đã hủy
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span style="display: inline-block; background: #fef3c7; color: #b45309; padding: 4px 10px; border-radius: 12px; font-weight: 600; font-size: 11px;">
                                                                        <i class="fa fa-clock-o"></i> Chờ duyệt
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td style="vertical-align: middle; text-align: right; white-space: nowrap;">
                                                            <a href="${pageContext.request.contextPath}/account/orders?action=detail&id=${ord.id}" 
                                                               style="display: inline-block; background: #f1f5f9; color: #334155; padding: 6px 12px; border-radius: 4px; font-size: 12px; font-weight: 600; text-decoration: none; border: 1px solid #cbd5e1;">
                                                                <i class="fa fa-eye"></i> Xem chi tiết
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/invoice?id=${ord.id}" target="_blank" title="In hóa đơn A4"
                                                               style="display: inline-block; background: #f0f9ff; color: #0284c7; padding: 6px 10px; border-radius: 4px; font-size: 12px; font-weight: 600; text-decoration: none; border: 1px solid #bae6fd; margin-left: 4px;">
                                                                <i class="fa fa-print"></i>
                                                            </a>
                                                            <c:if test="${ord.status == 'PENDING'}">
                                                                <form action="${pageContext.request.contextPath}/account/orders" method="post" style="display: inline-block; margin: 0 0 0 4px;"
                                                                      onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${ord.orderCode}?\nSản phẩm sẽ được hoàn lại kho hàng.');">
                                                                    <input type="hidden" name="action" value="cancel-order">
                                                                    <input type="hidden" name="orderId" value="${ord.id}">
                                                                    <button type="submit" style="background: #fff; border: 1px solid #ef4444; color: #ef4444; padding: 5px 10px; border-radius: 4px; font-size: 12px; font-weight: 600; cursor: pointer;">
                                                                        Hủy đơn
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>
    </section>
    <!-- Account Orders Area End -->

<jsp:include page="/common/footer.jsp" />
