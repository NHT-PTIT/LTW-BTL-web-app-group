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
    <jsp:param name="pageTitle" value="Bleezy - Thiết bị Điện Mặt Trời & Biến Tần Inverter" />
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
                                        <h2>the most successfull security <span>agency</span></h2>
                                        <p>Nunc accumsan metus quis metus. Sed luctus. Mauris eu enim quisque dignissim nequesudm consectetuer dapibus wn eu leo integer varius erat.</p>
                                        <a href="#" class="bleezy-btn">start a project</a>
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
                                        <h2>Premium Security Services Trusted <span> by Millions</span></h2>
                                        <p>Nunc accumsan metus quis metus. Sed luctus. Mauris eu enim quisque dignissim nequesudm consectetuer dapibus wn eu leo integer varius erat.</p>
                                        <a href="#" class="bleezy-btn">learn more</a>
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
                                        <h2>Premium Security Services Trusted<span> by Millions</span></h2>
                                        <p>Nunc accumsan metus quis metus. Sed luctus. Mauris eu enim quisque dignissim nequesudm consectetuer dapibus wn eu leo integer varius erat.</p>
                                        <a href="#" class="bleezy-btn">learn more</a>
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
                        <h2>We always try to Provide Cost Effective <span>Security Solutions</span></h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="single-promo">
                        <div class="promo-image">
                            <a href="#">
                                <img src="${pageContext.request.contextPath}/assets/img/promo-1.jpg" alt="promo" />
                            </a>
                        </div>
                        <div class="promo-text">
                            <h2><a href="#">Our Experience</a></h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-promo">
                        <div class="promo-image">
                            <a href="#">
                                <img src="${pageContext.request.contextPath}/assets/img/promo-2.jpg" alt="promo" />
                            </a>
                        </div>
                        <div class="promo-text">
                            <h2><a href="#">bleezy History</a></h2>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-promo">
                        <div class="promo-image">
                            <a href="#">
                                <img src="${pageContext.request.contextPath}/assets/img/promo-4.jpg" alt="promo" />
                            </a>
                        </div>
                        <div class="promo-text">
                            <h2><a href="#">Our Mission</a></h2>
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
                        <h3>What We Offer</h3>
                        <h2>our services</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="single-service">
                        <div class="service-icon">
                            <i class="flaticon-house-security"></i>
                        </div>
                        <h3><a href="#">Home Secutity</a></h3>
                        <p>Enim ad minim veniam quis nostrud exercitation ullamco laboris aliquip dolor in velit esse cillum.</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-service">
                        <div class="service-icon">
                            <i class="flaticon-security-camera"></i>
                        </div>
                        <h3><a href="#">cctv system</a></h3>
                        <p>Enim ad minim veniam quis nostrud exercitation ullamco laboris aliquip dolor in velit esse cillum.</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-service">
                        <div class="service-icon">
                            <i class="flaticon-locked-internet-security-padlock"></i>
                        </div>
                        <h3><a href="#">cloud Security</a></h3>
                        <p>Enim ad minim veniam quis nostrud exercitation ullamco laboris aliquip dolor in velit esse cillum.</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="single-service">
                        <div class="service-icon">
                            <i class="flaticon-computer"></i>
                        </div>
                        <h3><a href="#">computer Secutity</a></h3>
                        <p>Enim ad minim veniam quis nostrud exercitation ullamco laboris aliquip dolor in velit esse cillum.</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-service">
                        <div class="service-icon">
                            <i class="flaticon-policeman"></i>
                        </div>
                        <h3><a href="#">Bodyguard</a></h3>
                        <p>Enim ad minim veniam quis nostrud exercitation ullamco laboris aliquip dolor in velit esse cillum.</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-service">
                        <div class="service-icon">
                            <i class="flaticon-fingerprint"></i>
                        </div>
                        <h3><a href="#">Biometric</a></h3>
                        <p>Enim ad minim veniam quis nostrud exercitation ullamco laboris aliquip dolor in velit esse cillum.</p>
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
                        <h3>Giải Pháp Tối Ưu Năng Lượng</h3>
                        <h2>Sản Phẩm Nổi Bật</h2>
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
                        <h3>We are ready to provide security in resonable price and guarantee your safety in any situation in your life </h3>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 col-sm-3">
                    <div class="count-box">
                        <h3 class="counter">2800</h3>
                        <h4>Project <span>Done</span></h4>
                    </div>
                </div>
                <div class="col-md-3 col-sm-3">
                    <div class="count-box">
                        <h3 class="counter">1200</h3>
                        <h4>Qualified <span>Employee</span></h4>
                    </div>
                </div>
                <div class="col-md-3 col-sm-3">
                    <div class="count-box">
                        <h3 class="counter">3100</h3>
                        <h4>Deal <span>Assigned</span></h4>
                    </div>
                </div>
                <div class="col-md-3 col-sm-3">
                    <div class="count-box">
                        <h3 class="counter">2700</h3>
                        <h4>Satisfied <span>Clients</span></h4>
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
                        <h3>See Our Experience</h3>
                        <h2>Photo Gallery</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="single-gallery-img">
                        <img src="${pageContext.request.contextPath}/assets/img/gallery-1.jpg" alt="ignition" />
                        <div class="gallery-caption">
                            <p>
                                <a href="${pageContext.request.contextPath}/assets/img/gallery-1.jpg" class="more gallery2">
                                    <i class="fa fa-fw fa-search-plus"></i>
                                </a>
                                <a href="#">
                                    <i class="fa fa-fw fa-link"></i>
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-gallery-img">
                        <img src="${pageContext.request.contextPath}/assets/img/gallery-2.jpg" alt="ignition" />
                        <div class="gallery-caption">
                            <p>
                                <a href="${pageContext.request.contextPath}/assets/img/gallery-2.jpg" class="more gallery2">
                                    <i class="fa fa-fw fa-search-plus"></i>
                                </a>
                                <a href="#">
                                    <i class="fa fa-fw fa-link"></i>
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-gallery-img">
                        <img src="${pageContext.request.contextPath}/assets/img/gallery-3.jpg" alt="ignition" />
                        <div class="gallery-caption">
                            <p>
                                <a href="${pageContext.request.contextPath}/assets/img/gallery-3.jpg" class="more gallery2">
                                    <i class="fa fa-fw fa-search-plus"></i>
                                </a>
                                <a href="#">
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
                        <img src="${pageContext.request.contextPath}/assets/img/gallery-4.jpg" alt="ignition" />
                        <div class="gallery-caption">
                            <p>
                                <a href="${pageContext.request.contextPath}/assets/img/gallery-4.jpg" class="more gallery2">
                                    <i class="fa fa-fw fa-search-plus"></i>
                                </a>
                                <a href="#">
                                    <i class="fa fa-fw fa-link"></i>
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-gallery-img">
                        <img src="${pageContext.request.contextPath}/assets/img/gallery-6.jpg" alt="ignition" />
                        <div class="gallery-caption">
                            <p>
                                <a href="${pageContext.request.contextPath}/assets/img/gallery-6.jpg" class="more gallery2">
                                    <i class="fa fa-fw fa-search-plus"></i>
                                </a>
                                <a href="#">
                                    <i class="fa fa-fw fa-link"></i>
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-gallery-img">
                        <img src="${pageContext.request.contextPath}/assets/img/gallery-5.jpg" alt="ignition" />
                        <div class="gallery-caption">
                            <p>
                                <a href="${pageContext.request.contextPath}/assets/img/gallery-5.jpg" class="more gallery2">
                                    <i class="fa fa-fw fa-search-plus"></i>
                                </a>
                                <a href="#">
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
                        <h3>What They Say</h3>
                        <h2>Testimonials</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="testimonial-slide">
                        <div class="single-testimonial">
                            <div class="testimonial-text">
                                <p>Esse cillum fugiat nulla pariatur excepteur ipsum dolor sit amconsectetur adipisicing elit sedaup eiusmod tempor incididunt labore et dolore magna aliqua lorem ipsum dolor sit ametes etur adipisicing elit usmod tempor incididunt eiusmod tempor incididunt ut labore.</p>
                            </div>
                            <div class="testimonial-info">
                                <div class="info-img">
                                    <img src="${pageContext.request.contextPath}/assets/img/client1.jpg" alt="client" />
                                </div>
                                <div class="info-name">
                                    <h4>Mike Hussy</h4>
                                    <p>Business Owner, Spain</p>
                                </div>
                            </div>
                        </div>
                        <div class="single-testimonial">
                            <div class="testimonial-text">
                                <p>Esse cillum fugiat nulla pariatur excepteur ipsum dolor sit amconsectetur adipisicing elit sedaup eiusmod tempor incididunt labore et dolore magna aliqua lorem ipsum dolor sit ametes etur adipisicing elit usmod tempor incididunt eiusmod tempor incididunt ut labore.</p>
                            </div>
                            <div class="testimonial-info">
                                <div class="info-img">
                                    <img src="${pageContext.request.contextPath}/assets/img/client2.jpg" alt="client" />
                                </div>
                                <div class="info-name">
                                    <h4>Zenifar Lopez</h4>
                                    <p>Business Owner, Spain</p>
                                </div>
                            </div>
                        </div>
                        <div class="single-testimonial">
                            <div class="testimonial-text">
                                <p>Esse cillum fugiat nulla pariatur excepteur ipsum dolor sit amconsectetur adipisicing elit sedaup eiusmod tempor incididunt labore et dolore magna aliqua lorem ipsum dolor sit ametes etur adipisicing elit usmod tempor incididunt eiusmod tempor incididunt ut labore.</p>
                            </div>
                            <div class="testimonial-info">
                                <div class="info-img">
                                    <img src="${pageContext.request.contextPath}/assets/img/client2.jpg" alt="client" />
                                </div>
                                <div class="info-name">
                                    <h4>Zenifar Lopez</h4>
                                    <p>Business Owner, Spain</p>
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
                        <h3>security Information</h3>
                        <h2>Our Latest News</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="single-blog">
                        <div class="blog-image">
                            <a href="#">
                                <img src="${pageContext.request.contextPath}/assets/img/blog-1.jpg" alt="blog" />
                            </a>
                        </div>
                        <div class="blog-text">
                            <h2><a href="#">Security System Of Any Building</a></h2>
                            <div class="blog-meta">
                                <p>-: Jan 20, 2018   /   Admin   /   6 Likes</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-blog">
                        <div class="blog-image">
                            <a href="#">
                                <img src="${pageContext.request.contextPath}/assets/img/blog-2.jpg" alt="blog" />
                            </a>
                        </div>
                        <div class="blog-text">
                            <h2><a href="#">Don’t Worry Your Data is Safe</a></h2>
                            <div class="blog-meta">
                                <p>-: Jan 20, 2018   /   Admin   /   6 Likes</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="single-blog">
                        <div class="blog-image">
                            <a href="#">
                                <img src="${pageContext.request.contextPath}/assets/img/blog-3.jpg" alt="blog" />
                            </a>
                        </div>
                        <div class="blog-text">
                            <h2><a href="#">Go next we are always with you</a></h2>
                            <div class="blog-meta">
                                <p>-: Jan 20, 2018   /   Admin   /   6 Likes</p>
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
                        <h3>Download our corporate brochure</h3>
                    </div>
                </div>
                <div class="col-md-3 col-sm-4">
                    <div class="broucher-right">
                        <div class="download-btn">
                            <a href="#">Download.Pdf <span class="fa fa-arrow-circle-o-down"></span></a>
                            <i class="fa fa-file-pdf-o"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Broucher Area End -->
    
<jsp:include page="/common/footer.jsp" />
