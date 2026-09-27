<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Fallback nạp dữ liệu nếu truy cập trực tiếp index.jsp không qua HomeServlet
    if (request.getAttribute("featuredProducts") == null) {
        com.myptitgroup.web_app_group.dao.ProductDAO pDao = new com.myptitgroup.web_app_group.dao.ProductDAO();
        com.myptitgroup.web_app_group.dao.CategoryDAO cDao = new com.myptitgroup.web_app_group.dao.CategoryDAO();
        request.setAttribute("featuredProducts", pDao.getFeaturedProducts(8));
        request.setAttribute("latestProducts", pDao.getLatestProducts(6));
        request.setAttribute("categoryTree", cDao.getCategoryTree());
    }
%>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Bleezy Security - Thiết bị An Ninh & Camera Giám Sát Thông Minh" />
    <jsp:param name="activeMenu" value="home" />
</jsp:include>
    
    <!-- Slider Area Start -->
    <section class="bleezy-slider-area">
        <div class="bleezy-slide">
            <div class="bleezy-main-slide slide-item-1">
                <div class="bleezy-main-caption">
                    <div class="bleezy-caption-cell">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="slider-text">
                                        <h2>Giải Pháp An Ninh <span>Toàn Diện & Tin Cậy</span></h2>
                                        <p>Cung cấp và lắp đặt hệ thống Camera giám sát CCTV, Khóa cửa thông minh Face ID, Thiết bị kiểm soát ra vào và Báo động chống trộm chính hãng.</p>
                                        <a href="${pageContext.request.contextPath}/shop" class="bleezy-btn">Khám phá sản phẩm</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bleezy-main-slide slide-item-2">
                <div class="bleezy-main-caption">
                    <div class="bleezy-caption-cell">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="slider-text">
                                        <h2>Camera AI Thông Minh <span>Giám Sát 24/7</span></h2>
                                        <p>Công nghệ nhận diện khuôn mặt, cảnh báo xâm nhập thời gian thực và đàm thoại hai chiều từ xa qua điện thoại với chất lượng hình ảnh sắc nét Ultra HD.</p>
                                        <a href="${pageContext.request.contextPath}/shop?categoryId=1" class="bleezy-btn">Xem Camera Giám Sát</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bleezy-main-slide slide-item-3">
                <div class="bleezy-main-caption">
                    <div class="bleezy-caption-cell">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="slider-text">
                                        <h2>Khóa Cửa Điện Tử <span>Bảo Mật Cao Cấp</span></h2>
                                        <p>Mở khóa Face ID 3D không chạm, vân tay sinh trắc học chuẩn FPC Thụy Điển kết hợp chuông hình màn hình IPS hiện đại cho ngôi nhà của bạn.</p>
                                        <a href="${pageContext.request.contextPath}/shop?categoryId=2" class="bleezy-btn">Xem Khóa Thông Minh</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Slider Area End -->
    
    <!-- Promo Area Start -->
    <section class="bleezy-promo-area section_100">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="promo-heading">
                        <h2>Cam Kết Cung Cấp <span>Giải Pháp An Ninh Hiệu Quả & Tối Ưu Chi Phí</span></h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="single-promo">
                        <div class="promo-image">
                            <a href="${pageContext.request.contextPath}/about">
                                <img src="${pageContext.request.contextPath}/assets/img/promo-1.jpg" alt="Kinh nghiệm triển khai" />
                            </a>
                        </div>
                        <div class="promo-text">
                            <h2><a href="${pageContext.request.contextPath}/about">Kinh Nghiệm Chuyên Sâu</a></h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-promo">
                        <div class="promo-image">
                            <a href="${pageContext.request.contextPath}/about">
                                <img src="${pageContext.request.contextPath}/assets/img/promo-2.jpg" alt="Lịch sử phát triển" />
                            </a>
                        </div>
                        <div class="promo-text">
                            <h2><a href="${pageContext.request.contextPath}/about">Hành Trình Bleezy</a></h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-promo">
                        <div class="promo-image">
                            <a href="${pageContext.request.contextPath}/about">
                                <img src="${pageContext.request.contextPath}/assets/img/promo-4.jpg" alt="Sứ mệnh an toàn" />
                            </a>
                        </div>
                        <div class="promo-text">
                            <h2><a href="${pageContext.request.contextPath}/about">Sứ Mệnh Bảo Vệ</a></h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Promo Area End -->
    
    <!-- Services Area Start -->
    <section class="bleezy-service-area section_t_100 section_b_70">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="site-heading">
                        <h3>Dịch Vụ Của Chúng Tôi</h3>
                        <h2>Giải Pháp An Ninh Nổi Bật</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="single-service">
                        <div class="service-icon">
                            <i class="flaticon-house-security"></i>
                        </div>
                        <h3><a href="${pageContext.request.contextPath}/shop">An Ninh Gia Đình</a></h3>
                        <p>Hệ thống cảm biến chống trộm, chuông cửa có hình và khóa thông minh bảo vệ ngôi nhà toàn diện.</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-service">
                        <div class="service-icon">
                            <i class="flaticon-security-camera"></i>
                        </div>
                        <h3><a href="${pageContext.request.contextPath}/shop?categoryId=1">Camera Quan Sát CCTV</a></h3>
                        <p>Camera IP độ nét cao 4K, hồng ngoại ban đêm có màu, lưu trữ đám mây và xem từ xa qua smartphone.</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-service">
                        <div class="service-icon">
                            <i class="flaticon-locked-internet-security-padlock"></i>
                        </div>
                        <h3><a href="${pageContext.request.contextPath}/shop?categoryId=2">Khóa Cửa Thông Minh</a></h3>
                        <p>Khóa vân tay, nhận diện khuôn mặt Face ID 3D, mã số ảo và thẻ từ chuẩn bảo mật quốc tế.</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="single-service">
                        <div class="service-icon">
                            <i class="flaticon-computer"></i>
                        </div>
                        <h3><a href="${pageContext.request.contextPath}/shop">Giám Sát Trung Tâm</a></h3>
                        <p>Hệ thống máy chủ đầu ghi NVR đa kênh quản lý tập trung cho tòa nhà, nhà máy và khu đô thị.</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-service">
                        <div class="service-icon">
                            <i class="flaticon-policeman"></i>
                        </div>
                        <h3><a href="${pageContext.request.contextPath}/contact">Báo Động Khẩn Cấp</a></h3>
                        <p>Còi hú công suất lớn, cảnh báo rò rỉ gas, cảm biến khói báo cháy và tự động quay số khẩn cấp.</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-service">
                        <div class="service-icon">
                            <i class="flaticon-fingerprint"></i>
                        </div>
                        <h3><a href="${pageContext.request.contextPath}/shop?categoryId=3">Kiểm Soát Sinh Trắc Học</a></h3>
                        <p>Máy chấm công vân tay, máy quét khuôn mặt và cổng kiểm soát phân quyền ra vào doanh nghiệp.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Services Area End -->
    
    <!-- Featured Products Area Start -->
    <section class="bleezy-shop-page-area section_100" style="background: #fbfbfb;">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="site-heading">
                        <h3>Giải Pháp An Ninh & Giám Sát Toàn Diện</h3>
                        <h2>Sản Phẩm An Ninh Nổi Bật</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <c:forEach items="${featuredProducts}" var="p" varStatus="loop">
                    <c:set var="pImgIdx" value="${p.id > 0 ? ((p.id - 1) % 7 + 1) : 1}" />
                    <div class="col-md-3 col-sm-6" style="margin-bottom: 30px;">
                        <div class="single-shop-product" style="position: relative; background: #fff; border: 1px solid #eee; height: 100%;">
                            <c:if test="${p.hasDiscount()}">
                                <span style="position: absolute; top: 10px; left: 10px; background: #e74c3c; color: #fff; padding: 3px 8px; border-radius: 3px; font-size: 11px; font-weight: bold; z-index: 2;">
                                    -${p.discountPercent}%
                                </span>
                            </c:if>
                            <div class="single-product-image">
                                <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                    <img src="${pageContext.request.contextPath}/assets/img/product-${pImgIdx}.jpg" alt="${p.name}" style="height: 200px; object-fit: contain; width: 100%; padding: 10px; background: #fff;" />
                                </a>
                            </div>
                            <div class="single-product-text" style="padding: 15px;">
                                <c:if test="${not empty p.brand}">
                                    <span style="font-size: 11px; text-transform: uppercase; color: #888; letter-spacing: 0.5px;">
                                        ${p.brand} <c:if test="${not empty p.powerStr}">| ${p.powerStr}</c:if>
                                    </span>
                                </c:if>
                                <h3 style="height: 42px; overflow: hidden; margin-top: 5px; font-size: 14px; line-height: 20px;">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" title="${p.name}">
                                        <c:out value="${p.name}"/>
                                    </a>
                                </h3>
                                <div class="product-price">
                                    <h3>${p.formattedEffectivePrice}</h3>
                                    <c:if test="${p.hasDiscount()}">
                                        <del style="color: #999; font-size: 12px; margin-left: 5px;">${p.formattedPrice}</del>
                                    </c:if>
                                </div>
                                <div class="product-button">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">Chi tiết</a>
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}"><i class="fa fa-eye"></i></a>
                                    <a href="${pageContext.request.contextPath}/cart.jsp"><i class="fa fa-shopping-cart"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="row" style="margin-top: 30px;">
                <div class="col-md-12 text-center">
                    <a href="${pageContext.request.contextPath}/shop" class="bleezy-btn">Xem tất cả sản phẩm <i class="fa fa-long-arrow-right"></i></a>
                </div>
            </div>
        </div>
    </section>
    <!-- Featured Products Area End -->
    
    <!-- Count Area Start -->
    <section class="bleezy-count-area section_100">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="counts-text">
                        <h3>Bảo vệ an toàn không gian sống và cơ sở sản xuất của bạn với các giải pháp an ninh chất lượng cao nhất</h3>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 col-sm-3">
                    <div class="count-box">
                        <h3 class="counter">2800</h3>
                        <h4>Dự án <span>Hoàn thành</span></h4>
                    </div>
                </div>
                <div class="col-md-3 col-sm-3">
                    <div class="count-box">
                        <h3 class="counter">120</h3>
                        <h4>Kỹ sư <span>Chuyên gia</span></h4>
                    </div>
                </div>
                <div class="col-md-3 col-sm-3">
                    <div class="count-box">
                        <h3 class="counter">3100</h3>
                        <h4>Hệ thống <span>Triển khai</span></h4>
                    </div>
                </div>
                <div class="col-md-3 col-sm-3">
                    <div class="count-box">
                        <h3 class="counter">2700</h3>
                        <h4>Khách hàng <span>Hài lòng</span></h4>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Count Area End -->
    
    <!-- Gallery Area Start -->
    <section class="bleezy-gallery-area section_100">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="site-heading">
                        <h3>Dự Án Đã Thực Hiện</h3>
                        <h2>Hình Ảnh Hoạt Động & Lắp Đặt</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="single-gallery-img">
                        <img src="${pageContext.request.contextPath}/assets/img/gallery-1.jpg" alt="Lắp đặt camera nhà xưởng" />
                        <div class="gallery-caption">
                            <p>
                                <a href="${pageContext.request.contextPath}/assets/img/gallery-1.jpg" class="more gallery2">
                                    <i class="fa fa-fw fa-search-plus"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/shop">
                                    <i class="fa fa-fw fa-link"></i>
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-gallery-img">
                        <img src="${pageContext.request.contextPath}/assets/img/gallery-2.jpg" alt="Hệ thống an ninh tòa nhà" />
                        <div class="gallery-caption">
                            <p>
                                <a href="${pageContext.request.contextPath}/assets/img/gallery-2.jpg" class="more gallery2">
                                    <i class="fa fa-fw fa-search-plus"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/shop">
                                    <i class="fa fa-fw fa-link"></i>
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-gallery-img">
                        <img src="${pageContext.request.contextPath}/assets/img/gallery-3.jpg" alt="Trung tâm điều hành CCTV" />
                        <div class="gallery-caption">
                            <p>
                                <a href="${pageContext.request.contextPath}/assets/img/gallery-3.jpg" class="more gallery2">
                                    <i class="fa fa-fw fa-search-plus"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/shop">
                                    <i class="fa fa-fw fa-link"></i>
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="single-gallery-img">
                        <img src="${pageContext.request.contextPath}/assets/img/gallery-4.jpg" alt="Kiểm soát ra vào vân tay" />
                        <div class="gallery-caption">
                            <p>
                                <a href="${pageContext.request.contextPath}/assets/img/gallery-4.jpg" class="more gallery2">
                                    <i class="fa fa-fw fa-search-plus"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/shop">
                                    <i class="fa fa-fw fa-link"></i>
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-gallery-img">
                        <img src="${pageContext.request.contextPath}/assets/img/gallery-6.jpg" alt="Khóa cửa thông minh biệt thự" />
                        <div class="gallery-caption">
                            <p>
                                <a href="${pageContext.request.contextPath}/assets/img/gallery-6.jpg" class="more gallery2">
                                    <i class="fa fa-fw fa-search-plus"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/shop">
                                    <i class="fa fa-fw fa-link"></i>
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-gallery-img">
                        <img src="${pageContext.request.contextPath}/assets/img/gallery-5.jpg" alt="Báo động chống trộm" />
                        <div class="gallery-caption">
                            <p>
                                <a href="${pageContext.request.contextPath}/assets/img/gallery-5.jpg" class="more gallery2">
                                    <i class="fa fa-fw fa-search-plus"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/shop">
                                    <i class="fa fa-fw fa-link"></i>
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Gallery Area End -->
    
    <!-- Testimonial Area Start -->
    <section class="bleezy-testimonial-area section_100">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="site-heading-black">
                        <h3>Đánh Giá Thực Tế</h3>
                        <h2>Khách Hàng Nói Về Bleezy</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="testimonial-slide">
                        <div class="single-testimonial">
                            <div class="testimonial-text">
                                <p>"Hệ thống 16 Camera Hikvision AcuSense do Bleezy triển khai tại nhà xưởng hoạt động cực kỳ ổn định. Hình ảnh ban đêm rõ nét, tính năng nhận diện người giúp chúng tôi quản lý ra vào rất tiện lợi."</p>
                            </div>
                            <div class="testimonial-info">
                                <div class="info-img">
                                    <img src="${pageContext.request.contextPath}/assets/img/client1.jpg" alt="client" />
                                </div>
                                <div class="info-name">
                                    <h4>Nguyễn Văn Hưng</h4>
                                    <p>Giám đốc điều hành, KCN Tiên Sơn</p>
                                </div>
                            </div>
                        </div>
                        <div class="single-testimonial">
                            <div class="testimonial-text">
                                <p>"Khóa cửa Face ID Philips lắp đặt cho căn hộ tại Times City rất sang trọng và an toàn. Đội ngũ kỹ thuật hỗ trợ lắp đặt nhanh trong 2 giờ, bàn giao hướng dẫn tận tình!"</p>
                            </div>
                            <div class="testimonial-info">
                                <div class="info-img">
                                    <img src="${pageContext.request.contextPath}/assets/img/client2.jpg" alt="client" />
                                </div>
                                <div class="info-name">
                                    <h4>Trần Thu Thảo</h4>
                                    <p>Chủ sở hữu căn hộ, Hà Nội</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Testimonial Area End -->
    
    <!-- Blog Area Start -->
    <section class="bleezy-blog-area section_t_100 section_b_70">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="site-heading">
                        <h3>Cẩm Nang & Kinh Nghiệm</h3>
                        <h2>Tin Tức & Giải Pháp An Ninh</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="single-blog">
                        <div class="blog-image">
                            <a href="${pageContext.request.contextPath}/about">
                                <img src="${pageContext.request.contextPath}/assets/img/blog-1.jpg" alt="blog" />
                            </a>
                        </div>
                        <div class="blog-text">
                            <h2><a href="${pageContext.request.contextPath}/about">Giải Pháp An Ninh Toàn Diện Cho Tòa Nhà & Chung Cư</a></h2>
                            <div class="blog-meta">
                                <p>-: 2026   /   Bleezy Security   /   18 Lượt xem</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-blog">
                        <div class="blog-image">
                            <a href="${pageContext.request.contextPath}/about">
                                <img src="${pageContext.request.contextPath}/assets/img/blog-2.jpg" alt="blog" />
                            </a>
                        </div>
                        <div class="blog-text">
                            <h2><a href="${pageContext.request.contextPath}/about">Bảo Mật Dữ Liệu Camera Giám Sát Chống Hack Từ Xa</a></h2>
                            <div class="blog-meta">
                                <p>-: 2026   /   Bleezy Security   /   25 Lượt xem</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-blog">
                        <div class="blog-image">
                            <a href="${pageContext.request.contextPath}/about">
                                <img src="${pageContext.request.contextPath}/assets/img/blog-3.jpg" alt="blog" />
                            </a>
                        </div>
                        <div class="blog-text">
                            <h2><a href="${pageContext.request.contextPath}/about">Hướng Dẫn Lựa Chọn Khóa Cửa Thông Minh Đúng Nhu Cầu</a></h2>
                            <div class="blog-meta">
                                <p>-: 2026   /   Bleezy Security   /   32 Lượt xem</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Area End -->
    
    <!-- Broucher Area Start -->
    <section class="bleezy-broucher-area">
        <div class="broucher-overlay"></div>
        <div class="container">
            <div class="row">
                <div class="col-md-9 col-sm-8">
                    <div class="broucher-left">
                        <h3>Tải Catalog Sản Phẩm & Bảng Giá Thiết Bị An Ninh Mới Nhất</h3>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4">
                    <div class="broucher-right">
                        <div class="download-btn">
                            <a href="${pageContext.request.contextPath}/contact">Tải Catalog.Pdf <span class="fa fa-arrow-circle-o-down"></span></a>
                            <i class="fa fa-file-pdf-o"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Broucher Area End -->
    
<jsp:include page="/common/footer.jsp" />
