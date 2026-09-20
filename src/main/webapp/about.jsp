<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Về chúng tôi - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="about" />
</jsp:include>

    
    <!-- Breadcromb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Về chúng tôi</h2>
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
                                <li>Về chúng tôi</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcromb Area End -->
    
    <!-- About Page Start -->
    <section class="bleezy-about-page section_100">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="about-left">
                        <h2>Bleezy Inverter & Solar Power</h2>
                        <p>Chào mừng bạn đến với Bleezy — đơn vị tiên phong trong lĩnh vực cung cấp giải pháp biến tần Inverter, điện mặt trời hòa lưới và lưu trữ năng lượng sạch tại Việt Nam. Với hơn 8 năm hoạt động, chúng tôi luôn cam kết đem lại các sản phẩm đạt tiêu chuẩn chất lượng châu Âu, an toàn và tối ưu chi phí đầu tư.</p>
                        <p>Hệ thống sản phẩm của chúng tôi được nhập khẩu chính hãng từ các thương hiệu hàng đầu thế giới như Deye, Huawei, Growatt, Longi, Canadian Solar,... kèm theo chính sách bảo hành chính hãng từ 5 đến 10 năm và dịch vụ hỗ trợ kỹ thuật 24/7.</p>
                        <a href="${pageContext.request.contextPath}/shop.jsp" class="bleezy-btn">Khám phá sản phẩm</a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="about-right">
                        <img src="${pageContext.request.contextPath}/assets/img/abt-img.jpg" alt="about image" />
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- About Page End -->
    
    <!-- Statement Area Start -->
    <section class="bleezy-statement-area section_b_100">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <div class="statement-left">
                        <h2>Sứ mệnh của chúng tôi</h2>
                        <p>Mang năng lượng xanh, bền vững và tiết kiệm đến từng hộ gia đình và doanh nghiệp trên cả nước. Thúc đẩy chuyển đổi số và công nghệ năng lượng thông minh, góp phần bảo vệ môi trường và kiến tạo tương lai phát triển bền vững.</p>
                    </div>
                </div>
                <div class="col-md-6 col-sm-6">
                    <div class="statement-right">
                        <h2>Tầm nhìn chiến lược</h2>
                        <p>Trở thành tập đoàn phân phối thiết bị năng lượng mặt trời và biến tần Inverter uy tín số 1 khu vực Đông Nam Á, xây dựng hệ sinh thái khép kín từ cung ứng vật tư, tư vấn thiết kế kỹ thuật đến dịch vụ bảo hành bảo trì trọn đời.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Statement Area End -->
    
    <!-- Team Member Area Start -->
    <section class="bleezy-team-member-area section_100">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="site-heading">
                        <h3>Kinh nghiệm chuyên môn</h3>
                        <h2>Đội ngũ chuyên gia kỹ thuật</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="team-slider">
                        <div class="single-team-slide">
                            <div class="team-img">
                                <a href="${pageContext.request.contextPath}/team.jsp">
                                    <img src="${pageContext.request.contextPath}/assets/img/team-1.jpg" alt="team img" />
                                </a>
                                <div class="team-social-box">
                                    <div class="team-social">
                                        <a href="#"><i class="fa fa-facebook"></i></a>
                                        <a href="#"><i class="fa fa-twitter"></i></a>
                                        <a href="#"><i class="fa fa-linkedin"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="team-text">
                                <h4><a href="${pageContext.request.contextPath}/team.jsp">Nguyễn Tiến Đạt</a></h4>
                                <p>Kỹ sư trưởng Hệ thống Inverter</p>
                            </div>
                        </div>
                        <div class="single-team-slide">
                            <div class="team-img">
                                <a href="${pageContext.request.contextPath}/team.jsp">
                                    <img src="${pageContext.request.contextPath}/assets/img/team-2.jpg" alt="team img" />
                                </a>
                                <div class="team-social-box">
                                    <div class="team-social">
                                        <a href="#"><i class="fa fa-facebook"></i></a>
                                        <a href="#"><i class="fa fa-twitter"></i></a>
                                        <a href="#"><i class="fa fa-linkedin"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="team-text">
                                <h4><a href="${pageContext.request.contextPath}/team.jsp">Trần Thu Trang</a></h4>
                                <p>Trưởng phòng Quản lý chất lượng</p>
                            </div>
                        </div>
                        <div class="single-team-slide">
                            <div class="team-img">
                                <a href="${pageContext.request.contextPath}/team.jsp">
                                    <img src="${pageContext.request.contextPath}/assets/img/team-3.jpg" alt="team img" />
                                </a>
                                <div class="team-social-box">
                                    <div class="team-social">
                                        <a href="#"><i class="fa fa-facebook"></i></a>
                                        <a href="#"><i class="fa fa-twitter"></i></a>
                                        <a href="#"><i class="fa fa-linkedin"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="team-text">
                                <h4><a href="${pageContext.request.contextPath}/team.jsp">Lê Hoàng Nam</a></h4>
                                <p>Chuyên gia giải pháp Lưu trữ Hybrid</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Team Member Area End -->
    
    <jsp:include page="/common/footer.jsp" />

