<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Fallback nạp dữ liệu nếu truy cập trực tiếp product-detail.jsp không qua ProductDetailServlet
    if (request.getAttribute("product") == null) {
        com.myptitgroup.web_app_group.dao.ProductDAO pDao = new com.myptitgroup.web_app_group.dao.ProductDAO();
        com.myptitgroup.web_app_group.dao.CategoryDAO cDao = new com.myptitgroup.web_app_group.dao.CategoryDAO();

        String idParam = request.getParameter("id");
        int prodId = 1;
        if (idParam != null && !idParam.trim().isEmpty()) {
            try { prodId = Integer.parseInt(idParam.trim()); } catch (Exception ignored) {}
        }
        com.myptitgroup.web_app_group.model.Product p = pDao.getById(prodId);
        if (p == null) {
            java.util.List<com.myptitgroup.web_app_group.model.Product> defs = pDao.getLatestProducts(1);
            if (!defs.isEmpty()) p = pDao.getById(defs.get(0).getId());
        }
        if (p != null) {
            request.setAttribute("product", p);
            request.setAttribute("category", cDao.getById(p.getCategoryId()));
            request.setAttribute("relatedProducts", pDao.getRelatedProducts(p.getCategoryId(), p.getId(), 4));
            request.setAttribute("pageTitle", p.getName() + " - Bleezy Inverter & Solar Power");
        }
    }
%>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="${not empty pageTitle ? pageTitle : 'Chi tiết sản phẩm - Bleezy'}" />
    <jsp:param name="activeMenu" value="shop" />
</jsp:include>

    <!-- Breadcromb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Chi tiết sản phẩm</h2>
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
                                <c:if test="${not empty category}">
                                    <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/shop?categoryId=${category.id}">${category.name}</a></li>
                                </c:if>
                                <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                <li><c:out value="${product.name}"/></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcromb Area End -->
    
    <!-- Single Product Area Start -->
    <section class="bleezy-shop-page-area section_100">
        <div class="container">
            <div class="row">
                <c:set var="detailImgIdx" value="${product.id > 0 ? ((product.id - 1) % 7 + 1) : 1}" />
                <div class="col-md-6 col-sm-6">
                    <div class="single-pro-page-img" style="background: #fff; padding: 20px; border: 1px solid #eee; text-align: center;">
                        <img id="mainProductImage" src="${pageContext.request.contextPath}/assets/img/product-${detailImgIdx}.jpg" alt="${product.name}" style="max-height: 400px; width: auto; object-fit: contain;" />
                        
                        <!-- Image Gallery Thumbnails if present -->
                        <c:if test="${not empty product.gallery}">
                            <div class="gallery-thumbs" style="display: flex; gap: 10px; margin-top: 15px; justify-content: center;">
                                <c:forEach items="${product.gallery}" var="gImg" varStatus="loop">
                                    <c:set var="thumbIdx" value="${(product.id + loop.index) % 7 + 1}" />
                                    <img src="${pageContext.request.contextPath}/assets/img/product-${thumbIdx}.jpg" 
                                         alt="Gallery" 
                                         style="width: 70px; height: 70px; object-fit: cover; border: 1px solid #ddd; cursor: pointer; border-radius: 4px;"
                                         onclick="document.getElementById('mainProductImage').src = this.src;" />
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="col-md-6 col-sm-6">
                    <div class="single-pro-page-desc">
                        <c:if test="${not empty product.brand}">
                            <span style="display: inline-block; font-size: 12px; text-transform: uppercase; font-weight: bold; color: #2980b9; letter-spacing: 1px; margin-bottom: 5px;">
                                Thương hiệu: ${product.brand}
                            </span>
                        </c:if>
                        <h2 style="font-size: 24px; font-weight: bold; margin-bottom: 10px; color: #333; line-height: 32px;">
                            <c:out value="${product.name}"/>
                        </h2>
                        
                        <ul class="product-rating" style="margin-bottom: 15px;">
                            <li><i class="fa fa-star"></i></li>
                            <li><i class="fa fa-star"></i></li>
                            <li><i class="fa fa-star"></i></li>
                            <li><i class="fa fa-star"></i></li>
                            <li><i class="fa fa-star-half-o"></i></li>
                            <li style="color: #666; font-size: 13px; margin-left: 10px;">(5 sao đánh giá từ kỹ sư lắp đặt)</li>
                        </ul>
                        
                        <div class="single-pro-page-para">
                            <p style="color: #555; line-height: 24px;">
                                <c:out value="${product.shortDescription}"/>
                            </p>
                            <p style="margin-top: 10px; font-size: 14px;">
                                <strong>Mã SKU:</strong> <code><c:out value="${product.sku}"/></code> 
                                <c:if test="${not empty product.powerStr}">
                                    | <strong>Công suất:</strong> <span class="badge" style="background: #27ae60;">${product.powerStr}</span>
                                </c:if>
                                <br>
                                <strong>Tình trạng:</strong> 
                                <c:choose>
                                    <c:when test="${product.stockQuantity > 0}">
                                        <span style="color: #28a745; font-weight: bold;"><i class="fa fa-check-circle"></i> Còn hàng (${product.stockQuantity} sản phẩm sẵn kho)</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #e74c3c; font-weight: bold;"><i class="fa fa-times-circle"></i> Tạm hết hàng</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>

                        <div class="single-shop-price" style="margin-top: 20px;">
                            <p style="font-size: 22px;">
                                Giá bán:
                                <span style="font-size: 26px; color: #e74c3c; font-weight: bold;">
                                    ${product.formattedEffectivePrice}
                                </span>
                                <c:if test="${product.hasDiscount()}">
                                    <del style="color: #999; font-size: 16px; margin-left: 10px;">${product.formattedPrice}</del>
                                    <span style="background: #e74c3c; color: #fff; padding: 2px 8px; border-radius: 3px; font-size: 12px; margin-left: 8px;">
                                        Tiết kiệm ${product.discountPercent}%
                                    </span>
                                </c:if>
                            </p>
                        </div>

                        <form action="${pageContext.request.contextPath}/cart.jsp" method="get" style="margin-top: 25px;">
                            <input type="hidden" name="productId" value="${product.id}">
                            <div class="single-shop-price" style="margin-bottom: 15px;">
                                <p class="qnt" style="display: flex; align-items: center; gap: 10px;">
                                    <span>Số lượng:</span>
                                    <input value="1" min="1" max="${product.stockQuantity > 0 ? product.stockQuantity : 1}" name="quantity" type="number" style="width: 80px; padding: 8px; border: 1px solid #ccc; border-radius: 4px; text-align: center;">
                                </p>
                            </div>
                            <div class="single-shop-page-btn" style="display: flex; gap: 15px; margin-top: 20px;">
                                <button type="submit" class="bleezy-btn" style="cursor: pointer;">
                                    <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                </button>
                                <a href="${pageContext.request.contextPath}/checkout.jsp" class="bleezy-btn" style="background: #28a745; border-color: #28a745;">
                                    Mua ngay
                                </a>
                            </div>
                        </form>

                        <div class="share-product" style="margin-top: 30px;">
                            <h3>Chia sẻ sản phẩm</h3>
                            <ul>
                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Specifications and Reviews Tabs -->
            <div class="row" style="margin-top: 60px;">
                <div class="col-md-12">
                    <div class="service-details-tab">
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active"><a href="#tab-spec" aria-controls="tab-spec" role="tab" data-toggle="tab">Thông số kỹ thuật</a></li>
                            <li role="presentation"><a href="#tab-desc" aria-controls="tab-desc" role="tab" data-toggle="tab">Mô tả chi tiết</a></li>
                            <li role="presentation"><a href="#tab-review" aria-controls="tab-review" role="tab" data-toggle="tab">Đánh giá & Bảo hành</a></li>
                        </ul>
                        <div class="tab-content" style="padding: 30px; background: #fdfdfd; border: 1px solid #eee; border-top: none;">
                            <!-- Tab Spec -->
                            <div role="tabpanel" class="tab-pane active" id="tab-spec">
                                <h4>Bảng thông số kỹ thuật chi tiết</h4>
                                <table class="table table-bordered table-striped" style="margin-top: 15px;">
                                    <tbody>
                                        <tr><th style="width: 30%;">Tên sản phẩm</th><td><c:out value="${product.name}"/></td></tr>
                                        <tr><th>Mã SKU</th><td><c:out value="${product.sku}"/></td></tr>
                                        <tr><th>Thương hiệu sản xuất</th><td><c:out value="${product.brand}"/></td></tr>
                                        <tr><th>Dải công suất định mức</th><td><c:out value="${product.powerStr}"/></td></tr>
                                        <tr><th>Danh mục phân loại</th><td>${not empty category ? category.name : 'Biến tần & Thiết bị điện'}</td></tr>
                                        <c:choose>
                                            <c:when test="${not empty product.specifications}">
                                                <c:forEach items="${product.specifications}" var="s">
                                                    <tr>
                                                        <th><c:out value="${s.specName}"/></th>
                                                        <td><c:out value="${s.specValue}"/></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr><th>Điện áp định mức</th><td>3 Pha 380V - 480V / 50-60Hz</td></tr>
                                                <tr><th>Khả năng quá tải</th><td>150% trong 60 giây, 200% trong 0.5 giây</td></tr>
                                                <tr><th>Cổng giao tiếp</th><td>RS-485 Modbus-RTU, Smart WiFi giám sát từ xa</td></tr>
                                                <tr><th>Cấp bảo vệ</th><td>IP20 / IP65 (Tùy phiên bản lắp đặt trong tủ hoặc ngoài trời)</td></tr>
                                                <tr><th>Chính sách bảo hành</th><td>24 tháng chính hãng (Hỗ trợ 1 đổi 1 trong 30 ngày)</td></tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            <!-- Tab Desc -->
                            <div role="tabpanel" class="tab-pane" id="tab-desc">
                                <h4>Mô tả ứng dụng & tính năng vận hành</h4>
                                <div style="line-height: 28px; color: #444; margin-top: 15px;">
                                    <c:choose>
                                        <c:when test="${not empty product.detailDescription}">
                                            ${product.detailDescription}
                                        </c:when>
                                        <c:otherwise>
                                            <p><c:out value="${product.shortDescription}"/></p>
                                            <p>Thiết bị được phân phối chính hãng bởi <strong>PTIT Tech & Bleezy Solar</strong>, đầy đủ chứng nhận xuất xứ CO, chứng nhận chất lượng CQ và catalog kỹ thuật đi kèm.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <!-- Tab Review -->
                            <div role="tabpanel" class="tab-pane" id="tab-review">
                                <h4>Cam kết chất lượng & Chính sách bảo hành</h4>
                                <div class="review-list" style="margin-top: 15px;">
                                    <div style="border-bottom: 1px solid #eee; padding-bottom: 15px; margin-bottom: 15px;">
                                        <strong><i class="fa fa-shield" style="color: #27ae60;"></i> Bảo hành chính hãng:</strong>
                                        <p style="margin-top: 5px;">Tất cả thiết bị biến tần và giải pháp năng lượng đều được cam kết bảo hành tiêu chuẩn 24 tháng theo đúng quy định của nhà sản xuất (${product.brand}).</p>
                                    </div>
                                    <div style="border-bottom: 1px solid #eee; padding-bottom: 15px; margin-bottom: 15px;">
                                        <strong><i class="fa fa-wrench" style="color: #2980b9;"></i> Hỗ trợ kỹ thuật 24/7:</strong>
                                        <p style="margin-top: 5px;">Đội ngũ kỹ sư cơ điện PTIT Tech trực tiếp tư vấn giải pháp, hỗ trợ cài đặt thông số qua hotline <strong>1900 6868</strong> hoặc Zalo kỹ thuật.</p>
                                    </div>
                                    <div>
                                        <strong><i class="fa fa-truck" style="color: #e67e22;"></i> Giao hàng & Lắp đặt:</strong>
                                        <p style="margin-top: 5px;">Hỗ trợ giao hàng toàn quốc, kiểm tra hàng trước khi thanh toán, kèm tài liệu hướng dẫn đấu nối chi tiết bằng tiếng Việt.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Single Product Area End -->
    
    <!-- Related Product Area Start -->
    <c:if test="${not empty relatedProducts}">
        <section class="related-product-area section_b_100">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="site-heading">
                            <h2>Sản phẩm tương tự</h2>
                            <h3>Có thể bạn quan tâm</h3>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <c:forEach items="${relatedProducts}" var="rp">
                        <c:set var="rpImgIdx" value="${rp.id > 0 ? ((rp.id - 1) % 7 + 1) : 1}" />
                        <div class="col-md-3 col-sm-6">
                            <div class="single-shop-product" style="margin-bottom: 25px;">
                                <div class="single-product-image">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${rp.id}">
                                        <img src="${pageContext.request.contextPath}/assets/img/product-${rpImgIdx}.jpg" alt="${rp.name}" style="height: 180px; object-fit: contain; width: 100%; padding: 10px; background: #fff;" />
                                    </a>
                                </div>
                                <div class="single-product-text">
                                    <c:if test="${not empty rp.brand}">
                                        <span style="font-size: 11px; text-transform: uppercase; color: #888;">${rp.brand}</span>
                                    </c:if>
                                    <h3 style="height: 44px; overflow: hidden; margin-top: 5px; font-size: 14px; line-height: 20px;">
                                        <a href="${pageContext.request.contextPath}/product-detail?id=${rp.id}"><c:out value="${rp.name}"/></a>
                                    </h3>
                                    <div class="product-price">
                                        <h3>${rp.formattedEffectivePrice}</h3>
                                        <c:if test="${rp.hasDiscount()}">
                                            <del style="color: #999; font-size: 12px; margin-left: 5px;">${rp.formattedPrice}</del>
                                        </c:if>
                                    </div>
                                    <div class="product-button">
                                        <a href="${pageContext.request.contextPath}/product-detail?id=${rp.id}">Chi tiết</a>
                                        <a href="${pageContext.request.contextPath}/product-detail?id=${rp.id}"><i class="fa fa-eye"></i></a>
                                        <a href="${pageContext.request.contextPath}/cart.jsp"><i class="fa fa-shopping-cart"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </c:if>
    <!-- Related Product Area End -->
    
    <jsp:include page="/common/footer.jsp" />
