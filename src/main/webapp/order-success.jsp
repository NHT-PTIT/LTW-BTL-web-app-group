<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Đặt hàng thành công - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="shop" />
</jsp:include>

    
    <!-- Breadcromb Area Start -->
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
                                <li><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                <li><a href="${pageContext.request.contextPath}/shop.jsp">Cửa hàng</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                <li>Đặt hàng thành công</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcromb Area End -->
    
    <!-- Order Success Area Start -->
    <section class="section_100" style="background: #f8f9fa;">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div style="background: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); text-align: center;">
                        <div style="margin-bottom: 20px;">
                            <i class="fa fa-check-circle" style="font-size: 70px; color: #28a745;"></i>
                        </div>
                        <h2 style="font-size: 28px; color: #222; margin-bottom: 10px; font-weight: bold;">ĐẶT HÀNG THÀNH CÔNG!</h2>
                        <p style="color: #666; font-size: 16px; margin-bottom: 25px;">
                            Cảm ơn quý khách đã tin tưởng đặt hàng tại <strong>Bleezy Inverter & Solar Power</strong>.<br>
                            Bộ phận kỹ thuật & giao nhận sẽ liên hệ xác nhận đơn hàng qua điện thoại trong vòng 15-30 phút.
                        </p>
                        
                        <div style="background: #fafafa; border: 1px dashed #ddd; border-radius: 6px; padding: 25px; text-align: left; margin-bottom: 30px;">
                            <div class="row">
                                <div class="col-sm-6">
                                    <p><strong>Mã đơn hàng:</strong> <span style="color: #e85b24; font-weight: bold;">#ORD-20260921-8899</span></p>
                                    <p><strong>Ngày đặt hàng:</strong> 21/09/2026</p>
                                    <p><strong>Phương thức:</strong> Thanh toán khi nhận hàng (COD)</p>
                                    <p><strong>Trạng thái:</strong> <span class="label label-warning" style="font-size: 13px;">Chờ xác nhận xuất kho</span></p>
                                </div>
                                <div class="col-sm-6">
                                    <p><strong>Người nhận:</strong> Nguyễn Văn An (0988123456)</p>
                                    <p><strong>Địa chỉ:</strong> Số 96A Trần Phú, Phường Mộ Lao, Quận Hà Đông, Hà Nội</p>
                                    <p><strong>Tổng thanh toán:</strong> <strong style="color: #e85b24; font-size: 18px;">27.400.000₫</strong></p>
                                    <p><strong>Phí vận chuyển:</strong> Miễn phí</p>
                                </div>
                            </div>
                        </div>
                        
                        <div style="display: flex; justify-content: center; gap: 15px; flex-wrap: wrap;">
                            <a href="${pageContext.request.contextPath}/shop.jsp" class="bleezy-btn"><i class="fa fa-shopping-bag"></i> Tiếp tục mua hàng</a>
                            <a href="${pageContext.request.contextPath}/index.jsp" class="bleezy-btn" style="background: #333; border-color: #333;"><i class="fa fa-home"></i> Về trang chủ</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Order Success Area End -->
    
    <jsp:include page="/common/footer.jsp" />

