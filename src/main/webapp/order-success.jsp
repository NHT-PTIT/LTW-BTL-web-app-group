<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Đặt hàng thành công - Bleezy Inverter & Solar Power" />
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
                            Cảm ơn quý khách đã tin tưởng đặt mua thiết bị tại <strong>Bleezy Inverter & Solar Power</strong>.<br>
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
                                            <p style="margin-bottom: 8px;"><strong>Tổng thanh toán:</strong> <strong style="color: #e85b24; font-size: 20px;">${order.formattedTotalAmount}</strong></p>
                                        </div>
                                    </div>

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
