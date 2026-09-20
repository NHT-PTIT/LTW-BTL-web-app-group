<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Liên hệ & Hỗ trợ kỹ thuật - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="contact" />
</jsp:include>

    
    <!-- Breadcromb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Liên hệ & Tư vấn kỹ thuật</h2>
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
                                <li>Liên hệ</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcromb Area End -->
    
    <!-- Contact Page Area Start -->
    <section class="bleezy-contact-page-area section_t_100 section_b_70">
        <div class="container">
            <div class="row">
                <!-- Branch 1 -->
                <div class="col-md-4 col-sm-4">
                    <div class="single-contact-address">
                        <h3>Trụ sở Hà Nội</h3>
                        <ul>
                            <li>
                                <i class="fa fa-map-marker"></i>
                                <p>Số 96A Trần Phú, Phường Mộ Lao, Quận Hà Đông, Hà Nội</p>
                            </li>
                            <li>
                                <i class="fa fa-phone"></i>
                                <p>(+84) 828-376-0532</p>
                            </li>
                            <li>
                                <i class="fa fa-envelope-o"></i>
                                <p>hanoi@bleezy-solar.vn</p>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- Branch 2 -->
                <div class="col-md-4 col-sm-4">
                    <div class="single-contact-address">
                        <h3>Chi nhánh Đà Nẵng</h3>
                        <ul>
                            <li>
                                <i class="fa fa-map-marker"></i>
                                <p>Số 123 Đường Nguyễn Văn Linh, Quận Hải Châu, Đà Nẵng</p>
                            </li>
                            <li>
                                <i class="fa fa-phone"></i>
                                <p>(+84) 236-376-0532</p>
                            </li>
                            <li>
                                <i class="fa fa-envelope-o"></i>
                                <p>danang@bleezy-solar.vn</p>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- Branch 3 -->
                <div class="col-md-4 col-sm-4">
                    <div class="single-contact-address">
                        <h3>Chi nhánh TP. Hồ Chí Minh</h3>
                        <ul>
                            <li>
                                <i class="fa fa-map-marker"></i>
                                <p>Số 456 Đường Lê Văn Việt, Phường Tăng Nhơn Phú A, TP. Thủ Đức</p>
                            </li>
                            <li>
                                <i class="fa fa-phone"></i>
                                <p>(+84) 28-376-0532</p>
                            </li>
                            <li>
                                <i class="fa fa-envelope-o"></i>
                                <p>hcm@bleezy-solar.vn</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Contact Page Area End -->
    
    <!-- Contact Form Area Start -->
    <section class="bleezy-contact-form-area section_b_100">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="contact-form">
                        <div class="contact-heading">
                            <h3>Gửi yêu cầu khảo sát & Tư vấn báo giá</h3>
                            <p>Đội ngũ kỹ sư năng lượng Bleezy sẽ phản hồi và liên hệ lại quý khách trong vòng 30 phút.</p>
                        </div>
                        <form onsubmit="alert('Cảm ơn bạn đã gửi yêu cầu tư vấn! Chúng tôi sẽ liên hệ trong thời gian sớm nhất.'); return false;">
                            <div class="row">
                                <div class="col-md-4 col-sm-4">
                                    <p>
                                        <input type="text" name="name" placeholder="Họ và tên của bạn *" required>
                                    </p>
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <p>
                                        <input type="email" name="email" placeholder="Địa chỉ Email *" required>
                                    </p>
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <p>
                                        <input type="tel" name="phone" placeholder="Số điện thoại liên hệ *" required>
                                    </p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <p>
                                        <textarea name="Message" placeholder="Nội dung cần tư vấn (Nhu cầu công suất Inverter, vị trí lắp mái, hệ thống hòa lưới hay lưu trữ Hybrid)..." required></textarea>
                                    </p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="contact-form-button">
                                        <button type="submit" name="submit">Gửi thông điệp ngay</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Contact Form Area End -->
    
    <jsp:include page="/common/footer.jsp" />

