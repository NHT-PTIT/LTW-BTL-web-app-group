<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Giỏ hàng - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="shop" />
</jsp:include>
    
    <!-- Breadcrumb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Giỏ hàng của bạn</h2>
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
                                <li>Giỏ hàng</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Area End -->
    
    <!-- Cart Page Area Start -->
    <section class="bleezy-cart-area section_100">
        <div class="container">
            <!-- Notifications if present -->
            <c:if test="${not empty alertSuccess}">
                <div class="alert alert-success alert-dismissible" role="alert" style="margin-bottom: 25px;">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <i class="fa fa-check-circle"></i> <c:out value="${alertSuccess}"/>
                </div>
            </c:if>
            <c:if test="${not empty alertInfo}">
                <div class="alert alert-info alert-dismissible" role="alert" style="margin-bottom: 25px;">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <i class="fa fa-info-circle"></i> <c:out value="${alertInfo}"/>
                </div>
            </c:if>
            <c:if test="${not empty alertWarning}">
                <div class="alert alert-warning alert-dismissible" role="alert" style="margin-bottom: 25px;">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <i class="fa fa-exclamation-triangle"></i> <c:out value="${alertWarning}"/>
                </div>
            </c:if>

            <c:choose>
                <%-- Trạng thái 1: Giỏ hàng trống --%>
                <c:when test="${empty sessionScope.cart or empty sessionScope.cart.items}">
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2 text-center" style="padding: 60px 20px; background: #fff; border-radius: 8px; border: 1px dashed #ddd;">
                            <div style="font-size: 70px; color: #d1d5db; margin-bottom: 20px;">
                                <i class="fa fa-shopping-cart"></i>
                            </div>
                            <h3 style="font-size: 24px; font-weight: bold; color: #333; margin-bottom: 12px;">
                                Giỏ hàng của bạn đang trống!
                            </h3>
                            <p style="color: #666; font-size: 15px; margin-bottom: 30px;">
                                Hãy khám phá danh mục thiết bị điện công nghiệp, biến tần và giải pháp năng lượng mặt trời chính hãng tại Bleezy.
                            </p>
                            <a href="${pageContext.request.contextPath}/shop" class="bleezy-btn" style="padding: 12px 30px; font-size: 15px;">
                                <i class="fa fa-shopping-bag"></i> Tiếp tục mua sắm ngay
                            </a>
                        </div>
                    </div>
                </c:when>

                <%-- Trạng thái 2: Giỏ hàng có sản phẩm --%>
                <c:otherwise>
                    <div class="row">
                        <div class="col-md-8">
                            <div class="cart-table">
                                <table class="table table-striped table-responsive">
                                    <thead>
                                        <tr>
                                            <th>Hình ảnh</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Đơn giá</th>
                                            <th style="text-align: center;">Số lượng</th>
                                            <th>Thành tiền</th>
                                            <th style="text-align: center;">Xóa</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${sessionScope.cart.items}" var="item">
                                            <c:set var="cartImgIdx" value="${item.product.id > 0 ? ((item.product.id - 1) % 7 + 1) : 1}" />
                                            <tr class="shop-cart-item">
                                                <td class="bleezy-cart-preview">
                                                    <a href="${pageContext.request.contextPath}/product-detail?id=${item.product.id}">
                                                        <img src="${pageContext.request.contextPath}/assets/img/product-${cartImgIdx}.jpg" 
                                                             alt="<c:out value="${item.product.name}"/>" 
                                                             style="width: 70px; height: 70px; object-fit: contain; background: #fff; border: 1px solid #eee; padding: 4px;" />
                                                    </a>
                                                </td>
                                                <td class="bleezy-cart-product">
                                                    <a href="${pageContext.request.contextPath}/product-detail?id=${item.product.id}">
                                                        <p style="font-weight: 600; color: #222; margin-bottom: 4px;">
                                                            <c:out value="${item.product.name}"/>
                                                        </p>
                                                    </a>
                                                    <small style="color: #888;">Mã SKU: <c:out value="${item.product.sku}"/></small>
                                                    <c:if test="${not empty item.product.brand}">
                                                        <small style="color: #0284c7; display: block;">Hãng: <c:out value="${item.product.brand}"/></small>
                                                    </c:if>
                                                </td>
                                                <td class="bleezy-cart-price">
                                                    <p style="font-weight: 500;">${item.product.formattedEffectivePrice}</p>
                                                </td>
                                                <td class="bleezy-cart-quantity" style="text-align: center;">
                                                    <form action="${pageContext.request.contextPath}/cart-action" method="post" style="display: inline-flex; align-items: center; gap: 4px;">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="productId" value="${item.product.id}">
                                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.stockQuantity > 0 ? item.product.stockQuantity : 99}" 
                                                               style="width: 55px; text-align: center; border: 1px solid #ccc; padding: 6px 2px; border-radius: 4px; font-weight: 600;">
                                                        <button type="submit" class="btn btn-default btn-sm" title="Cập nhật số lượng" style="padding: 6px 8px; border-color: #ddd;">
                                                            <i class="fa fa-refresh"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                                <td class="bleezy-cart-total">
                                                    <p style="color: #e85b24; font-weight: bold;">${item.formattedSubtotal}</p>
                                                </td>
                                                <td class="bleezy-cart-close" style="text-align: center;">
                                                    <a href="${pageContext.request.contextPath}/cart-action?action=remove&productId=${item.product.id}" 
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ?');" 
                                                       title="Xóa mặt hàng này"
                                                       style="color: #ef4444; font-size: 16px;">
                                                        <i class="fa fa-trash-o"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="row">
                                <div class="bleezy-update-cart clearfix" style="margin-top: 15px;">
                                    <div class="col-md-6 col-sm-6">
                                        <a href="${pageContext.request.contextPath}/shop" class="bleezy-btn" style="background: #4b5563; border-color: #4b5563;">
                                            <i class="fa fa-arrow-left"></i> Tiếp tục chọn sản phẩm
                                        </a>
                                    </div>
                                    <div class="col-md-6 col-sm-6 text-right">
                                        <a href="${pageContext.request.contextPath}/cart-action?action=clear" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa toàn bộ giỏ hàng?');" 
                                           class="bleezy-btn" style="background: #dc2626; border-color: #dc2626;">
                                            <i class="fa fa-trash"></i> Xóa toàn bộ giỏ
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Cart Summary Column -->
                        <div class="col-md-4">
                            <div class="calculate-shipping-bottom margin-top" style="background: #fff; border: 1px solid #eee; border-radius: 6px; padding: 25px;">
                                <h3 style="font-size: 20px; font-weight: bold; border-bottom: 2px solid #e85b24; padding-bottom: 12px; margin-bottom: 15px;">
                                    Cộng giỏ hàng
                                </h3>

                                <!-- Voucher Input Form -->
                                <div style="margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px dashed #e5e7eb;">
                                    <label style="font-size: 13px; font-weight: 600; color: #374151; margin-bottom: 6px; display: block;">
                                        <i class="fa fa-ticket" style="color: #e85b24;"></i> Mã giảm giá / Voucher:
                                    </label>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.cart.appliedCoupon}">
                                            <div style="background: #f0fdf4; border: 1px solid #86efac; border-radius: 6px; padding: 10px 12px; display: flex; justify-content: space-between; align-items: center;">
                                                <div>
                                                    <span style="font-weight: 700; color: #166534; font-family: monospace; font-size: 14px;">
                                                        <i class="fa fa-check-circle"></i> ${sessionScope.cart.appliedCoupon.code}
                                                    </span>
                                                    <small style="display: block; color: #15803d; font-size: 11.5px;">${sessionScope.cart.appliedCoupon.description}</small>
                                                </div>
                                                <a href="${pageContext.request.contextPath}/cart-action?action=remove-coupon" 
                                                   class="btn btn-default btn-xs" style="color: #dc2626; border-color: #fca5a5;" title="Hủy mã này">
                                                    <i class="fa fa-times"></i> Hủy
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/cart-action" method="post" style="display: flex; gap: 6px;">
                                                <input type="hidden" name="action" value="apply-coupon">
                                                <input type="text" name="couponCode" placeholder="Nhập mã (vd: SOLAR2026)" required 
                                                       style="text-transform: uppercase; flex: 1; padding: 7px 10px; border: 1px solid #cbd5e1; border-radius: 4px; font-size: 13px;">
                                                <button type="submit" class="btn btn-primary" style="background: #e85b24; border-color: #e85b24; padding: 7px 14px; font-weight: 600; font-size: 13px;">
                                                    Áp dụng
                                                </button>
                                            </form>
                                            <small style="color: #64748b; font-size: 11.5px; display: block; margin-top: 5px;">
                                                Gợi ý: <span style="font-family: monospace; font-weight: 600; color: #e85b24;">SOLAR2026</span> (giảm 10%), <span style="font-family: monospace; font-weight: 600; color: #e85b24;">GIAM500K</span>
                                            </small>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <table class="table" style="margin-bottom: 20px;">
                                    <tbody>
                                        <tr>
                                            <td style="border-top: none; color: #666;">Số lượng mặt hàng:</td>
                                            <td style="border-top: none; text-align: right; font-weight: 600;">${sessionScope.cart.totalQuantity} chiếc</td>
                                        </tr>
                                        <tr>
                                            <td style="color: #666;">Tạm tính ban đầu:</td>
                                            <td style="text-align: right; font-weight: bold; color: #222;">${sessionScope.cart.formattedTotalAmount}</td>
                                        </tr>
                                        <c:if test="${not empty sessionScope.cart.appliedCoupon}">
                                            <tr style="background: #f0fdf4;">
                                                <td style="color: #15803d; font-weight: 600;">
                                                    <i class="fa fa-tag"></i> Giảm giá (${sessionScope.cart.appliedCoupon.code}):
                                                </td>
                                                <td style="text-align: right; font-weight: bold; color: #16a34a;">
                                                    ${sessionScope.cart.formattedDiscountAmount}
                                                </td>
                                            </tr>
                                        </c:if>
                                        <tr>
                                            <td style="color: #666;">Vận chuyển:</td>
                                            <td style="text-align: right;"><span style="color: #16a34a; font-weight: bold;"><i class="fa fa-truck"></i> Miễn phí toàn quốc</span></td>
                                        </tr>
                                        <tr>
                                            <td style="color: #666;">Hóa đơn VAT:</td>
                                            <td style="text-align: right; color: #666;">Đã bao gồm VAT</td>
                                        </tr>
                                        <tr style="border-top: 2px solid #eee;">
                                            <td style="font-size: 16px; font-weight: bold; color: #111;">Tổng thanh toán:</td>
                                            <td style="text-align: right;"><strong style="color: #e85b24; font-size: 22px;">${sessionScope.cart.formattedFinalTotal}</strong></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="proceed-checkout">
                                    <a href="${pageContext.request.contextPath}/checkout" class="bleezy-btn" 
                                       style="display: block; text-align: center; width: 100%; font-size: 16px; padding: 14px 0; border-radius: 4px; box-shadow: 0 4px 10px rgba(232,91,36,0.3);">
                                        Tiến hành đặt hàng <i class="fa fa-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
    <!-- Cart Page Area End -->
    
<jsp:include page="/common/footer.jsp" />
