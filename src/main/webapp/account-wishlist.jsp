<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Sản phẩm yêu thích - Bleezy Inverter & Solar" />
    <jsp:param name="activeMenu" value="shop" />
</jsp:include>

<!-- Breadcrumb Area Start -->
<section class="bleezy-breadcromb-area">
    <div class="breadcromb-top section_50">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="breadcromb-top-text">
                        <h2>Sản phẩm yêu thích</h2>
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
                            <li><a href="${pageContext.request.contextPath}/account/profile">Tài khoản</a></li>
                            <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                            <li>Yêu thích</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Breadcrumb Area End -->

<!-- Main Account Area Start -->
<section class="section_100" style="background: #f8fafc;">
    <div class="container">
        <div class="row">
            
            <!-- Menu Sidebar Tài khoản -->
            <div class="col-md-3 col-sm-4">
                <div style="background: #fff; border-radius: 8px; border: 1px solid #e2e8f0; padding: 24px; text-align: center; margin-bottom: 24px;">
                    <div style="width: 80px; height: 80px; border-radius: 50%; background: #f26723; color: #fff; font-size: 32px; font-weight: 700; display: flex; align-items: center; justify-content: center; margin: 0 auto 12px auto; box-shadow: 0 4px 12px rgba(242, 103, 35, 0.25);">
                        ${sessionScope.currentUser.avatarInitial}
                    </div>
                    <h4 style="font-weight: 700; color: #1e293b; margin-bottom: 4px; font-size: 17px;">
                        ${sessionScope.currentUser.fullName}
                    </h4>
                    <p style="color: #64748b; font-size: 13px; margin-bottom: 20px;">
                        @${sessionScope.currentUser.username}
                    </p>

                    <ul style="list-style: none; padding: 0; margin: 0; text-align: left; border-top: 1px solid #e2e8f0; padding-top: 15px;">
                        <li style="margin-bottom: 8px;">
                            <a href="${pageContext.request.contextPath}/account/profile" 
                               style="display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 6px; font-weight: 500; text-decoration: none; color: #475569; transition: all 0.2s;">
                                <i class="fa fa-user-circle" style="width: 18px;"></i> Hồ sơ cá nhân
                            </a>
                        </li>
                        <li style="margin-bottom: 8px;">
                            <a href="${pageContext.request.contextPath}/account/orders" 
                               style="display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 6px; font-weight: 500; text-decoration: none; color: #475569; transition: all 0.2s;">
                                <i class="fa fa-shopping-basket" style="width: 18px;"></i> Đơn hàng của tôi
                            </a>
                        </li>
                        <li style="margin-bottom: 8px;">
                            <a href="${pageContext.request.contextPath}/account/wishlist" 
                               style="display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 6px; font-weight: 600; text-decoration: none; background: rgba(225, 29, 72, 0.1); color: #e11d48;">
                                <i class="fa fa-heart" style="width: 18px;"></i> Sản phẩm yêu thích
                            </a>
                        </li>
                        <li style="margin-bottom: 8px;">
                            <a href="${pageContext.request.contextPath}/cart" 
                               style="display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 6px; font-weight: 500; text-decoration: none; color: #475569; transition: all 0.2s;">
                                <i class="fa fa-shopping-cart" style="width: 18px;"></i> Giỏ hàng hiện tại
                            </a>
                        </li>
                        <li style="border-top: 1px solid #e2e8f0; margin-top: 12px; padding-top: 12px;">
                            <a href="${pageContext.request.contextPath}/logout" 
                               style="display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 6px; font-weight: 600; text-decoration: none; color: #dc2626; transition: all 0.2s;">
                                <i class="fa fa-sign-out" style="width: 18px;"></i> Đăng xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Nội dung Danh sách yêu thích -->
            <div class="col-md-9 col-sm-8">
                <div style="background: #fff; border-radius: 8px; border: 1px solid #e2e8f0; padding: 28px;">
                    <div style="border-bottom: 1px solid #e2e8f0; padding-bottom: 12px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap;">
                        <div>
                            <h3 style="font-size: 18px; font-weight: 700; color: #0f172a; margin: 0;">
                                <i class="fa fa-heart" style="color: #e11d48; margin-right: 8px;"></i> DANH SÁCH SẢN PHẨM YÊU THÍCH
                            </h3>
                            <p style="color: #64748b; font-size: 13px; margin: 4px 0 0 0;">
                                Lưu lại các thiết bị bạn quan tâm để dễ dàng so sánh giá và đặt hàng khi cần.
                            </p>
                        </div>
                        <span style="font-size: 13px; font-weight: 600; color: #64748b;">
                            Tổng cộng: <strong style="color: #e11d48;">${wishlistProducts.size()}</strong> sản phẩm
                        </span>
                    </div>

                    <c:choose>
                        <c:when test="${empty wishlistProducts}">
                            <div style="text-align: center; padding: 60px 20px; color: #64748b;">
                                <i class="fa fa-heart-o" style="font-size: 54px; color: #cbd5e1; margin-bottom: 16px; display: block;"></i>
                                <h4 style="font-size: 17px; font-weight: 600; color: #334155; margin-bottom: 8px;">
                                    Danh sách yêu thích của bạn đang trống!
                                </h4>
                                <p style="font-size: 13.5px; margin-bottom: 24px; max-width: 450px; margin-left: auto; margin-right: auto;">
                                    Hãy bấm biểu tượng trái tim <i class="fa fa-heart" style="color: #e11d48;"></i> tại các trang sản phẩm để lưu lại thiết bị bạn quan tâm.
                                </p>
                                <a href="${pageContext.request.contextPath}/shop" 
                                   style="display: inline-block; background: #e85b24; color: #fff; font-family: 'Oswald', sans-serif; font-size: 14px; font-weight: 600; padding: 11px 26px; border-radius: 4px; text-decoration: none; text-transform: uppercase;">
                                    <i class="fa fa-shopping-bag" style="margin-right: 6px;"></i> Khám phá cửa hàng ngay
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table" style="margin-bottom: 0;">
                                    <thead>
                                        <tr style="background: #f8fafc; border-bottom: 2px solid #e2e8f0;">
                                            <th style="width: 80px;">Hình ảnh</th>
                                            <th>Tên Thiết Bị / Linh Kiện</th>
                                            <th style="width: 140px; text-align: right;">Giá bán</th>
                                            <th style="width: 120px; text-align: center;">Tình trạng</th>
                                            <th style="width: 170px; text-align: right;">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="p" items="${wishlistProducts}">
                                            <c:set var="wImgIdx" value="${p.id > 0 ? ((p.id - 1) % 7 + 1) : 1}" />
                                            <c:set var="fallbackImg" value="${pageContext.request.contextPath}/assets/img/product-${wImgIdx}.jpg" />
                                            <c:set var="displayImg" value="${fallbackImg}" />
                                            <c:if test="${not empty p.mainImageUrl}">
                                                <c:choose>
                                                    <c:when test="${p.mainImageUrl.startsWith('http://') || p.mainImageUrl.startsWith('https://')}">
                                                        <c:set var="displayImg" value="${p.mainImageUrl}" />
                                                    </c:when>
                                                    <c:when test="${p.mainImageUrl.startsWith('/')}">
                                                        <c:set var="displayImg" value="${pageContext.request.contextPath}${p.mainImageUrl}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="displayImg" value="${pageContext.request.contextPath}/${p.mainImageUrl}" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>

                                            <tr>
                                                <td style="vertical-align: middle;">
                                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                                        <img src="${displayImg}" alt="<c:out value='${p.name}'/>" 
                                                             onerror="this.onerror=null; this.src='${fallbackImg}';"
                                                             style="width: 64px; height: 64px; object-fit: contain; border-radius: 4px; border: 1px solid #e2e8f0; padding: 2px;" />
                                                    </a>
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <c:if test="${not empty p.brand}">
                                                        <small style="color: #0284c7; text-transform: uppercase; font-weight: 600; font-size: 11px;">
                                                            ${p.brand}
                                                        </small><br>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" style="color: #1e293b; font-weight: 600; text-decoration: none; font-size: 14px;">
                                                        <c:out value="${p.name}"/>
                                                    </a>
                                                    <c:if test="${not empty p.sku}">
                                                        <br><small style="color: #64748b;">SKU: <c:out value="${p.sku}"/></small>
                                                    </c:if>
                                                </td>
                                                <td style="vertical-align: middle; text-align: right;">
                                                    <strong style="color: #e85b24; font-size: 15px;">
                                                        ${p.formattedEffectivePrice}
                                                    </strong>
                                                    <c:if test="${p.hasDiscount()}">
                                                        <br><del style="color: #94a3b8; font-size: 12px;">${p.formattedPrice}</del>
                                                    </c:if>
                                                </td>
                                                <td style="vertical-align: middle; text-align: center;">
                                                    <c:choose>
                                                        <c:when test="${p.stockQuantity > 0}">
                                                            <span class="label label-success" style="font-size: 11px;">Còn hàng</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="label label-danger" style="font-size: 11px;">Tạm hết</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td style="vertical-align: middle; text-align: right;">
                                                    <div style="display: flex; gap: 6px; justify-content: flex-end; align-items: center;">
                                                        <c:if test="${p.stockQuantity > 0}">
                                                            <form action="${pageContext.request.contextPath}/cart-action" method="post" style="display: inline; margin: 0;">
                                                                <input type="hidden" name="action" value="add">
                                                                <input type="hidden" name="productId" value="${p.id}">
                                                                <input type="hidden" name="quantity" value="1">
                                                                <button type="submit" class="btn btn-primary btn-sm" style="background: #e85b24; border-color: #e85b24;" title="Thêm vào giỏ">
                                                                    <i class="fa fa-shopping-cart"></i> Mua
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                        <a href="${pageContext.request.contextPath}/wishlist-action?action=remove&productId=${p.id}&redirect=wishlist" 
                                                           onclick="return confirm('Bạn có chắc muốn bỏ sản phẩm này khỏi yêu thích?');" 
                                                           class="btn btn-default btn-sm" style="color: #dc2626; border-color: #fca5a5;" title="Bỏ yêu thích">
                                                            <i class="fa fa-trash-o"></i>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- Main Account Area End -->

<jsp:include page="/common/footer.jsp" />
