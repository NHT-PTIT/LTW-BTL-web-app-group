<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // Fallback nạp dữ liệu nếu truy cập trực tiếp product-detail.jsp không qua ProductDetailServlet
    if (request.getAttribute("product") == null) {
        com.myptitgroup.web_app_group.dao.ProductDAO pDao = new com.myptitgroup.web_app_group.dao.ProductDAO();
        com.myptitgroup.web_app_group.dao.CategoryDAO cDao = new com.myptitgroup.web_app_group.dao.CategoryDAO();
        com.myptitgroup.web_app_group.dao.ProductReviewDAO rDao = new com.myptitgroup.web_app_group.dao.ProductReviewDAO();

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
            request.setAttribute("reviews", rDao.getApprovedReviewsByProductId(p.getId()));
            request.setAttribute("reviewStats", rDao.getReviewStats(p.getId()));
            request.setAttribute("pageTitle", p.getName() + " - Bleezy Security");
        }
    }
%>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="${not empty pageTitle ? pageTitle : 'Chi tiết sản phẩm - Bleezy Security'}" />
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

            <c:if test="${param.reviewMsg == 'success'}">
                <div class="alert alert-success alert-dismissible" role="alert" style="margin-bottom: 25px;">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <i class="fa fa-check-circle"></i> Cảm ơn bạn! Đánh giá và nhận xét của bạn về sản phẩm đã được ghi nhận thành công.
                </div>
            </c:if>
            <c:if test="${param.reviewMsg == 'empty_comment'}">
                <div class="alert alert-warning alert-dismissible" role="alert" style="margin-bottom: 25px;">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <i class="fa fa-exclamation-triangle"></i> Vui lòng nhập nội dung đánh giá của bạn trước khi gửi!
                </div>
            </c:if>

            <div class="row">
                <c:set var="detailImgIdx" value="${product.id > 0 ? ((product.id - 1) % 7 + 1) : 1}" />
                <c:set var="fallbackDetailImg" value="${pageContext.request.contextPath}/assets/img/product-${detailImgIdx}.jpg" />
                <c:set var="mainImgSrc" value="${fallbackDetailImg}" />
                <c:if test="${not empty product.mainImageUrl}">
                    <c:choose>
                        <c:when test="${product.mainImageUrl.startsWith('http://') || product.mainImageUrl.startsWith('https://')}">
                            <c:set var="mainImgSrc" value="${product.mainImageUrl}" />
                        </c:when>
                        <c:when test="${product.mainImageUrl.startsWith('/')}">
                            <c:set var="mainImgSrc" value="${pageContext.request.contextPath}${product.mainImageUrl}" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="mainImgSrc" value="${pageContext.request.contextPath}/${product.mainImageUrl}" />
                        </c:otherwise>
                    </c:choose>
                </c:if>
                <div class="col-md-6 col-sm-6">
                    <div class="single-pro-page-img" style="background: #fff; padding: 20px; border: 1px solid #eee; text-align: center; border-radius: 8px;">
                        <img id="mainProductImage" src="${mainImgSrc}" alt="<c:out value='${product.name}'/>" 
                             onerror="this.onerror=null; this.src='${fallbackDetailImg}';"
                             style="max-height: 400px; width: auto; max-width: 100%; object-fit: contain; border-radius: 4px;" />
                        
                        <!-- Image Gallery Thumbnails if present -->
                        <c:if test="${not empty product.gallery}">
                            <div class="gallery-thumbs" style="display: flex; gap: 10px; margin-top: 15px; justify-content: center; flex-wrap: wrap;">
                                <!-- Thumbnail ảnh chính -->
                                <img src="${mainImgSrc}" 
                                     alt="Ảnh chính" 
                                     style="width: 70px; height: 70px; object-fit: cover; border: 2px solid #e85b24; cursor: pointer; border-radius: 6px; padding: 2px;"
                                     onclick="document.getElementById('mainProductImage').src = this.src;" />
                                <!-- Các ảnh phụ trong gallery -->
                                <c:forEach items="${product.gallery}" var="gImg" varStatus="loop">
                                    <c:set var="thumbSrc" value="${gImg.imageUrl}" />
                                    <c:if test="${!thumbSrc.startsWith('http://') && !thumbSrc.startsWith('https://') && !thumbSrc.startsWith('/')}">
                                        <c:set var="thumbSrc" value="${pageContext.request.contextPath}/${thumbSrc}" />
                                    </c:if>
                                    <img src="${thumbSrc}" 
                                         alt="Gallery ${loop.index + 1}" 
                                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/product-${(product.id + loop.index) % 7 + 1}.jpg';"
                                         style="width: 70px; height: 70px; object-fit: cover; border: 1px solid #ddd; cursor: pointer; border-radius: 6px; padding: 2px; transition: border-color 0.2s;"
                                         onmouseover="this.style.borderColor='#e85b24';"
                                         onmouseout="this.style.borderColor='#ddd';"
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
                        
                        <!-- Dynamic Star Rating Header -->
                        <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 15px; flex-wrap: wrap;">
                            <ul class="product-rating" style="margin: 0; padding: 0; list-style: none; display: flex; color: #f59e0b; font-size: 15px; gap: 2px;">
                                <c:forEach begin="1" end="5" var="i">
                                    <li><i class="fa ${i <= reviewStats.averageRating ? 'fa-star' : (i - reviewStats.averageRating < 0.8 ? 'fa-star-half-o' : 'fa-star-o')}"></i></li>
                                </c:forEach>
                            </ul>
                            <strong style="color: #1e293b; font-size: 14px;">${reviewStats.averageRating} / 5</strong>
                            <a href="#reviews" onclick="$('a[href=\'#tab-customer-reviews\']').tab('show'); document.getElementById('tab-customer-reviews').scrollIntoView({behavior: 'smooth'});" 
                               style="color: #64748b; font-size: 13px; text-decoration: underline;">
                                (${reviewStats.totalReviews} đánh giá từ khách hàng)
                            </a>
                        </div>
                        
                        <div class="single-pro-page-para">
                            <p style="color: #555; line-height: 24px;">
                                <c:out value="${product.shortDescription}"/>
                            </p>
                            <p style="margin-top: 10px; font-size: 14px;">
                                <strong>Mã SKU:</strong> <code><c:out value="${product.sku}"/></code> 
                                <c:if test="${not empty product.powerStr}">
                                    | <strong>Thông số / Độ phân giải:</strong> <span class="badge" style="background: #27ae60;">${product.powerStr}</span>
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

                        <c:choose>
                            <c:when test="${product.stockQuantity > 0}">
                                <form action="${pageContext.request.contextPath}/cart-action" method="post" style="margin-top: 25px;">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <div class="single-shop-price" style="margin-bottom: 15px;">
                                        <p class="qnt" style="display: flex; align-items: center; gap: 10px;">
                                            <span style="font-weight: 600; color: #444;">Số lượng:</span>
                                            <input value="1" min="1" max="${product.stockQuantity}" name="quantity" type="number" 
                                                   style="width: 80px; padding: 8px; border: 1px solid #ccc; border-radius: 4px; text-align: center; font-weight: bold;">
                                            <span style="color: #666; font-size: 13px;">(Còn ${product.stockQuantity} sản phẩm trong kho)</span>
                                        </p>
                                    </div>
                                    <div class="single-shop-page-btn" style="display: flex; gap: 12px; margin-top: 20px; flex-wrap: wrap; align-items: center;">
                                        <button type="submit" class="bleezy-btn" style="cursor: pointer; padding: 12px 24px;">
                                            <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                        </button>
                                        <button type="submit" name="buyNow" value="1" class="bleezy-btn" 
                                                style="background: #16a34a; border-color: #16a34a; cursor: pointer; padding: 12px 24px;">
                                            <i class="fa fa-bolt"></i> Mua ngay
                                        </button>
                                        <a href="${pageContext.request.contextPath}/wishlist-action?action=toggle&productId=${product.id}&redirect=detail" 
                                           class="btn btn-default" 
                                           style="padding: 11px 18px; border-radius: 4px; border: 1px solid #e11d48; color: #e11d48; font-weight: 600; text-decoration: none;"
                                           title="Thêm hoặc xóa khỏi danh sách yêu thích">
                                            <i class="fa fa-heart"></i> Yêu thích
                                        </a>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div style="margin-top: 25px; padding: 15px; background: #fee2e2; border: 1px solid #fca5a5; border-radius: 6px; color: #b91c1c;">
                                    <i class="fa fa-exclamation-triangle"></i> <strong>Sản phẩm hiện đang tạm hết hàng.</strong> Quý khách vui lòng liên hệ hotline để đặt hàng trước.
                                </div>
                            </c:otherwise>
                        </c:choose>

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
            <div class="row" style="margin-top: 60px;" id="reviews">
                <div class="col-md-12">
                    <div class="service-details-tab">
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active"><a href="#tab-spec" aria-controls="tab-spec" role="tab" data-toggle="tab">Thông số kỹ thuật</a></li>
                            <li role="presentation"><a href="#tab-desc" aria-controls="tab-desc" role="tab" data-toggle="tab">Mô tả chi tiết</a></li>
                            <li role="presentation"><a href="#tab-review" aria-controls="tab-review" role="tab" data-toggle="tab">Cam kết & Bảo hành</a></li>
                            <li role="presentation"><a href="#tab-customer-reviews" aria-controls="tab-customer-reviews" role="tab" data-toggle="tab">
                                <i class="fa fa-star text-warning" style="color: #f59e0b;"></i> Đánh giá khách hàng (${reviewStats.totalReviews})
                            </a></li>
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
                                        <tr><th>Thông số nổi bật / Độ phân giải</th><td><c:out value="${product.powerStr}"/></td></tr>
                                        <tr><th>Danh mục phân loại</th><td>${not empty category ? category.name : 'Thiết bị an ninh & CCTV'}</td></tr>
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
                                                <tr><th>Nguồn điện hoạt động</th><td>12V DC / PoE (Power over Ethernet) tiêu chuẩn 802.3af</td></tr>
                                                <tr><th>Cảm biến hình ảnh</th><td>CMOS quét lũy tiến, chuẩn nén H.265+ tiết kiệm băng thông</td></tr>
                                                <tr><th>Tầm xa hồng ngoại</th><td>Smart IR 30m - 50m (Tự động chuyển chế độ ngày/đêm ICR)</td></tr>
                                                <tr><th>Cấp độ bảo vệ</th><td>IP67 / IK10 (Chống nước bụi ngoài trời và chống va đập)</td></tr>
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
                                            <p>Thiết bị được phân phối chính hãng bởi <strong>Bleezy Security Solutions</strong>, đầy đủ chứng nhận xuất xứ CO, chứng nhận chất lượng CQ và catalog kỹ thuật đi kèm.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Tab Commit & Warranty -->
                            <div role="tabpanel" class="tab-pane" id="tab-review">
                                <h4>Cam kết chất lượng & Chính sách bảo hành</h4>
                                <div class="review-list" style="margin-top: 15px;">
                                    <div style="border-bottom: 1px solid #eee; padding-bottom: 15px; margin-bottom: 15px;">
                                        <strong><i class="fa fa-shield" style="color: #27ae60;"></i> Bảo hành chính hãng:</strong>
                                        <p style="margin-top: 5px;">Tất cả thiết bị an ninh, camera giám sát CCTV và khóa thông minh đều được cam kết bảo hành tiêu chuẩn 24 tháng theo đúng quy định của nhà sản xuất (${product.brand}).</p>
                                    </div>
                                    <div style="border-bottom: 1px solid #eee; padding-bottom: 15px; margin-bottom: 15px;">
                                        <strong><i class="fa fa-wrench" style="color: #2980b9;"></i> Hỗ trợ kỹ thuật 24/7:</strong>
                                        <p style="margin-top: 5px;">Đội ngũ kỹ sư an ninh Bleezy Security trực tiếp tư vấn giải pháp, hỗ trợ cài đặt cấu hình qua hotline <strong>1900 6868</strong> hoặc Zalo kỹ thuật.</p>
                                    </div>
                                    <div>
                                        <strong><i class="fa fa-truck" style="color: #e67e22;"></i> Giao hàng & Lắp đặt:</strong>
                                        <p style="margin-top: 5px;">Hỗ trợ giao hàng toàn quốc, kiểm tra hàng trước khi thanh toán, kèm tài liệu hướng dẫn đấu nối chi tiết bằng tiếng Việt.</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Tab Customer Reviews -->
                            <div role="tabpanel" class="tab-pane" id="tab-customer-reviews">
                                <div class="row">
                                    <!-- Cột Tổng quan điểm sao -->
                                    <div class="col-sm-5" style="border-right: 1px solid #eee; padding-right: 25px;">
                                        <div style="background: #fff; border: 1px solid #e2e8f0; border-radius: 8px; padding: 25px; text-align: center; margin-bottom: 25px;">
                                            <div style="font-size: 48px; font-weight: 800; color: #1e293b; line-height: 1;">
                                                ${reviewStats.averageRating}
                                            </div>
                                            <div style="color: #f59e0b; font-size: 20px; margin: 10px 0;">
                                                <c:forEach begin="1" end="5" var="i">
                                                    <i class="fa ${i <= reviewStats.averageRating ? 'fa-star' : (i - reviewStats.averageRating < 0.8 ? 'fa-star-half-o' : 'fa-star-o')}"></i>
                                                </c:forEach>
                                            </div>
                                            <p style="color: #64748b; font-size: 13px; margin: 0;">Dựa trên ${reviewStats.totalReviews} đánh giá thực tế</p>
                                        </div>

                                        <!-- Form gửi đánh giá -->
                                        <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 8px; padding: 20px;">
                                            <h4 style="font-size: 16px; font-weight: 700; color: #1e293b; margin-top: 0; margin-bottom: 15px;">
                                                <i class="fa fa-pencil"></i> Gửi đánh giá của bạn
                                            </h4>
                                            <form action="${pageContext.request.contextPath}/product-review" method="post">
                                                <input type="hidden" name="productId" value="${product.id}">
                                                
                                                <div class="form-group" style="margin-bottom: 12px;">
                                                    <label style="font-size: 13px; font-weight: 600; color: #334155; display: block; margin-bottom: 5px;">Mức độ hài lòng:</label>
                                                    <select name="rating" class="form-control" style="font-size: 13px; border-radius: 4px;">
                                                        <option value="5" selected>⭐⭐⭐⭐⭐ Tuyệt vời (5/5 sao)</option>
                                                        <option value="4">⭐⭐⭐⭐ Rất tốt (4/5 sao)</option>
                                                        <option value="3">⭐⭐⭐ Bình thường (3/5 sao)</option>
                                                        <option value="2">⭐⭐ Kém (2/5 sao)</option>
                                                        <option value="1">⭐ Rất tệ (1/5 sao)</option>
                                                    </select>
                                                </div>

                                                <c:if test="${empty sessionScope.currentUser or not empty sessionScope.currentAdmin}">
                                                    <div class="form-group" style="margin-bottom: 12px;">
                                                        <label style="font-size: 13px; font-weight: 600; color: #334155; margin-bottom: 4px;">Họ tên của bạn *</label>
                                                        <input type="text" name="customerName" class="form-control" placeholder="Ví dụ: Kỹ sư Hoàng Nam" required style="font-size: 13px;">
                                                    </div>
                                                    <div class="form-group" style="margin-bottom: 12px;">
                                                        <label style="font-size: 13px; font-weight: 600; color: #334155; margin-bottom: 4px;">Email (không bắt buộc)</label>
                                                        <input type="email" name="customerEmail" class="form-control" placeholder="Để nhận phản hồi từ kỹ thuật" style="font-size: 13px;">
                                                    </div>
                                                </c:if>

                                                <div class="form-group" style="margin-bottom: 15px;">
                                                    <label style="font-size: 13px; font-weight: 600; color: #334155; margin-bottom: 4px;">Nhận xét chi tiết *</label>
                                                    <textarea name="comment" rows="4" class="form-control" placeholder="Chia sẻ cảm nhận về độ nét, độ ổn định, tính năng thông minh và hỗ trợ kỹ thuật..." required style="font-size: 13px;"></textarea>
                                                </div>

                                                <button type="submit" class="btn btn-primary" style="width: 100%; background: #e85b24; border-color: #e85b24; font-weight: 600; padding: 10px 0;">
                                                    <i class="fa fa-paper-plane"></i> Gửi Đánh Giá Ngay
                                                </button>
                                            </form>
                                        </div>
                                    </div>

                                    <!-- Cột Danh sách nhận xét -->
                                    <div class="col-sm-7" style="padding-left: 25px;">
                                        <h4 style="font-size: 16px; font-weight: 700; color: #1e293b; margin-top: 0; margin-bottom: 20px;">
                                            Khách hàng nói gì về thiết bị này (${reviewStats.totalReviews})
                                        </h4>

                                        <c:choose>
                                            <c:when test="${not empty reviews}">
                                                <div class="reviews-container">
                                                    <c:forEach var="rev" items="${reviews}">
                                                        <div style="background: #fff; border: 1px solid #e2e8f0; border-radius: 8px; padding: 18px 20px; margin-bottom: 15px; box-shadow: 0 1px 3px rgba(0,0,0,0.04);">
                                                            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 8px;">
                                                                <div>
                                                                    <strong style="color: #0f172a; font-size: 14px;">
                                                                        <i class="fa fa-user-circle" style="color: #64748b; margin-right: 4px;"></i> <c:out value="${rev.customerName}"/>
                                                                    </strong>
                                                                    <span class="label label-success" style="font-size: 11px; margin-left: 6px; background-color: #10b981;">
                                                                        <i class="fa fa-check"></i> Đã mua hàng
                                                                    </span>
                                                                </div>
                                                                <span style="font-size: 12px; color: #94a3b8;">${rev.formattedCreatedAt}</span>
                                                            </div>
                                                            <div style="color: #f59e0b; font-size: 13px; margin-bottom: 10px;">
                                                                <c:forEach begin="1" end="${rev.rating}">
                                                                    <i class="fa fa-star"></i>
                                                                </c:forEach>
                                                                <c:forEach begin="${rev.rating + 1}" end="5">
                                                                    <i class="fa fa-star-o" style="color: #cbd5e1;"></i>
                                                                </c:forEach>
                                                            </div>
                                                            <p style="color: #334155; font-size: 13.5px; line-height: 1.6; margin: 0;">
                                                                <c:out value="${rev.comment}"/>
                                                            </p>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div style="text-align: center; padding: 40px 20px; background: #fff; border: 1px dashed #cbd5e1; border-radius: 8px;">
                                                    <i class="fa fa-comments-o" style="font-size: 40px; color: #94a3b8; margin-bottom: 10px; display: block;"></i>
                                                    <p style="color: #64748b; font-size: 14px; margin: 0;">Chưa có đánh giá nào cho sản phẩm này. Hãy là người đầu tiên chia sẻ cảm nhận của bạn!</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
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
                                        <a href="${pageContext.request.contextPath}/wishlist-action?action=toggle&productId=${rp.id}&redirect=shop" title="Yêu thích"><i class="fa fa-heart"></i></a>
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
