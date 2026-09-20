<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Giỏ hàng - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="shop" />
</jsp:include>

    
    <!-- Breadcromb Area Start -->
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
                                <li><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                <li><a href="${pageContext.request.contextPath}/shop.jsp">Cửa hàng</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                <li>Giỏ hàng</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcromb Area End -->
    
    <!-- Cart Page Area Start -->
    <section class="bleezy-cart-area section_100">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <div class="cart-table">
                        <table class="table table-striped table-responsive">
                            <thead>
                                <tr>
                                    <th>Hình ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Đơn giá</th>
                                    <th>Số lượng</th>
                                    <th>Thành tiền</th>
                                    <th>Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="shop-cart-item">
                                    <td class="bleezy-cart-preview">
                                        <a href="${pageContext.request.contextPath}/product-detail.jsp">
                                            <img src="${pageContext.request.contextPath}/assets/img/product-1.jpg" alt="Inverter Deye 5kW Hybrid" style="width: 70px; height: 70px; object-fit: cover;" />
                                        </a>
                                    </td>
                                    <td class="bleezy-cart-product">
                                        <a href="${pageContext.request.contextPath}/product-detail.jsp">
                                            <p><strong>Biến Tần Inverter Deye 5kW Hybrid</strong></p>
                                            <small style="color: #888;">Bảo hành 5 năm</small>
                                        </a>
                                    </td>
                                    <td class="bleezy-cart-price">
                                        <p>22.500.000₫</p>
                                    </td>
                                    <td class="bleezy-cart-quantity">
                                        <input type="number" value="1" min="1" max="99" style="width: 60px; text-align: center; border: 1px solid #ddd; padding: 5px;">
                                    </td>
                                    <td class="bleezy-cart-total">
                                        <p><strong>22.500.000₫</strong></p>
                                    </td>
                                    <td class="bleezy-cart-close">
                                        <a href="#" title="Xóa mặt hàng này"><i class="fa fa-trash"></i></a>
                                    </td>
                                </tr>
                                <tr class="shop-cart-item">
                                    <td class="bleezy-cart-preview">
                                        <a href="${pageContext.request.contextPath}/product-detail.jsp">
                                            <img src="${pageContext.request.contextPath}/assets/img/product-3.jpg" alt="Tấm Pin Longi 450W" style="width: 70px; height: 70px; object-fit: cover;" />
                                        </a>
                                    </td>
                                    <td class="bleezy-cart-product">
                                        <a href="${pageContext.request.contextPath}/product-detail.jsp">
                                            <p><strong>Tấm Pin Năng Lượng Mặt Trời Longi 450W</strong></p>
                                            <small style="color: #888;">Bảo hành 12 năm</small>
                                        </a>
                                    </td>
                                    <td class="bleezy-cart-price">
                                        <p>2.450.000₫</p>
                                    </td>
                                    <td class="bleezy-cart-quantity">
                                        <input type="number" value="2" min="1" max="99" style="width: 60px; text-align: center; border: 1px solid #ddd; padding: 5px;">
                                    </td>
                                    <td class="bleezy-cart-total">
                                        <p><strong>4.900.000₫</strong></p>
                                    </td>
                                    <td class="bleezy-cart-close">
                                        <a href="#" title="Xóa mặt hàng này"><i class="fa fa-trash"></i></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="bleezy-update-cart clearfix">
                            <div class="col-md-6 col-sm-6">
                                <div class="coupon-cart-left">
                                    <form>
                                        <input type="text" placeholder="Nhập mã ưu đãi / giảm giá..." >
                                        <button type="submit">Áp dụng</button>
                                    </form>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6">
                                <div class="coupon-cart-right" style="display: flex; justify-content: flex-end; gap: 10px;">
                                    <a href="${pageContext.request.contextPath}/shop.jsp" class="bleezy-btn" style="background: #6c757d; border-color: #6c757d;">Tiếp tục mua hàng</a>
                                    <a href="#" class="bleezy-btn">Cập nhật giỏ</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="calculate-shipping-bottom margin-top">
                        <h3>Cộng giỏ hàng</h3>
                        <table>
                            <tbody>
                                <tr>
                                    <td>Tạm tính:</td>
                                    <td><strong>27.400.000₫</strong></td>
                                </tr>
                                <tr>
                                    <td>Vận chuyển:</td>
                                    <td><span style="color: #28a745; font-weight: bold;">Miễn phí giao hàng</span></td>
                                </tr>
                                <tr>
                                    <td>Thuế VAT (8%):</td>
                                    <td>Đã bao gồm VAT</td>
                                </tr>
                                <tr>
                                    <td><strong>Tổng thanh toán:</strong></td>
                                    <td><strong style="color: #e85b24; font-size: 20px;">27.400.000₫</strong></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="proceed-checkout" style="margin-top: 25px;">
                        <a href="${pageContext.request.contextPath}/checkout.jsp" class="bleezy-btn" style="display: block; text-align: center; width: 100%; font-size: 16px; padding: 14px 0;">Tiến hành thanh toán <i class="fa fa-arrow-right"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Cart Page Area End -->
    
    <jsp:include page="/common/footer.jsp" />

