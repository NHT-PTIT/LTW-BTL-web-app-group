<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${not empty param.pageTitle ? param.pageTitle : 'Bleezy - Inverter & Solar Power'}</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/assets/img/site-logo.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <!-- Font awesome CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css">
    <!-- Animate CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.min.css">
    <!-- OwlCarousel CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/owl.carousel.css">
    <!-- Flaticon CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/flaticon/flaticon.css">
    <!-- SlickNav CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/slicknav.min.css">
    <!-- Featherlight CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/featherlight.css">
    <!-- Featherlight Gallery CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/featherlight.gallery.css">
    <!-- Main CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <!-- Responsive CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css">
</head>
<body>
    
    <!-- Header Area Start -->
    <header class="bleezy-header-area">
        <div class="header-right-overlay"></div>
        <div class="mobile-top-menu">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser}">
                                <p><i class="fa fa-user"></i> <a href="${pageContext.request.contextPath}/account/profile">${sessionScope.currentUser.fullName}</a> | <a href="${pageContext.request.contextPath}/logout" style="color: #dc2626;">Đăng xuất</a></p>
                            </c:when>
                            <c:otherwise>
                                <p><i class="fa fa-user"></i> <a href="${pageContext.request.contextPath}/register">Đăng ký</a> hoặc <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <div class="cart-top-menu">
                            <div class="login dropdown">
                                <a href="${pageContext.request.contextPath}/cart" class="dropdown-toggle cart-icon" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                   <i class="fa fa-shopping-bag"></i> Giỏ hàng (${empty sessionScope.cart ? 0 : sessionScope.cart.totalQuantity})
                                </a>
                                <div class="dropdown-menu cart-dropdown" aria-labelledby="dropdownMenu2">
                                    <c:choose>
                                        <c:when test="${empty sessionScope.cart or empty sessionScope.cart.items}">
                                            <p style="padding: 15px; color: #888; text-align: center; margin: 0;">Giỏ hàng của bạn đang trống.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <h3>Sản phẩm trong giỏ (${sessionScope.cart.totalQuantity})</h3>
                                            <ul style="max-height: 240px; overflow-y: auto;">
                                                <c:forEach items="${sessionScope.cart.items}" var="cItem">
                                                    <li>
                                                        <div class="cart-btn-product">
                                                            <a class="product-remove" href="${pageContext.request.contextPath}/cart-action?action=remove&productId=${cItem.product.id}" title="Xóa">
                                                                <i class="fa fa-trash-o"></i>
                                                            </a>
                                                            <div class="cart-btn-pro-img">
                                                                <a href="${pageContext.request.contextPath}/product-detail?id=${cItem.product.id}">
                                                                    <img src="${pageContext.request.contextPath}/assets/img/product-1.jpg" alt="product" />
                                                                </a>
                                                            </div>
                                                            <div class="cart-btn-pro-cont">
                                                                <h4><a href="${pageContext.request.contextPath}/product-detail?id=${cItem.product.id}"><c:out value="${cItem.product.name}"/></a></h4>
                                                                <span class="item-cat">${cItem.quantity} &times; ${cItem.product.formattedEffectivePrice}</span>
                                                                <span class="price">${cItem.formattedSubtotal}</span>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                            <div style="padding: 10px 15px; font-weight: bold; border-top: 1px solid #eee; text-align: right; color: #e85b24;">
                                                Tổng: ${sessionScope.cart.formattedTotalAmount}
                                            </div>
                                            <div class="cart-btn">
                                                <a href="${pageContext.request.contextPath}/cart" class="cart-btn-1">Xem giỏ hàng</a>
                                                <a href="${pageContext.request.contextPath}/checkout" class="cart-btn-2">Thanh toán</a>
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
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="site-logo">
                        <a href="${pageContext.request.contextPath}/home">
                            <img src="${pageContext.request.contextPath}/assets/img/site-logo.png" alt="PTIT Tech Logo" />
                        </a>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="header-right">
                        <div class="header-right-top">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="single-top-right">
                                        <p>Hotline: <a href="tel:19006868">1900 6868 - 0988 123 456</a></p>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="single-top-right">
                                        <ul>
                                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                            <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                                            <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                            <li><a href="#"><i class="fa fa-skype"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="single-top-right">
                                        <p>
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.currentUser}">
                                                    <span class="dropdown" style="display: inline-block;">
                                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: #0f172a; font-weight: 600;">
                                                            <i class="fa fa-user-circle" style="color: #f26723;"></i> Xin chào, <strong>${sessionScope.currentUser.fullName}</strong> <i class="fa fa-angle-down"></i>
                                                        </a>
                                                        <ul class="dropdown-menu" style="left: auto; right: 0; min-width: 180px; padding: 6px 0; border-radius: 6px; box-shadow: 0 10px 25px rgba(0,0,0,0.15);">
                                                            <li><a href="${pageContext.request.contextPath}/account/profile" style="padding: 8px 16px; font-size: 13px;"><i class="fa fa-id-card-o" style="margin-right: 8px; color: #f26723;"></i> Hồ sơ cá nhân</a></li>
                                                            <li><a href="${pageContext.request.contextPath}/account/orders" style="padding: 8px 16px; font-size: 13px;"><i class="fa fa-shopping-basket" style="margin-right: 8px; color: #f26723;"></i> Đơn hàng của tôi</a></li>
                                                            <li class="divider" style="margin: 4px 0;"></li>
                                                            <li><a href="${pageContext.request.contextPath}/logout" style="padding: 8px 16px; font-size: 13px; color: #dc2626;"><i class="fa fa-sign-out" style="margin-right: 8px;"></i> Đăng xuất</a></li>
                                                        </ul>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fa fa-user"></i> <a href="${pageContext.request.contextPath}/register">Đăng ký</a> | <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                                                </c:otherwise>
                                            </c:choose>
                                            <a href="${pageContext.request.contextPath}/admin/dashboard" title="Trang Quản Trị Hệ Thống" style="margin-left: 8px; color: #f26723; font-weight: bold;">
                                                <i class="fa fa-lock"></i> Admin
                                            </a>
                                        </p>
                                        <div class="cart-top-menu">
                                            <div class="login dropdown">
                                                <a href="${pageContext.request.contextPath}/cart" class="dropdown-toggle cart-icon" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                   <i class="fa fa-shopping-bag"></i> Giỏ hàng (${empty sessionScope.cart ? 0 : sessionScope.cart.totalQuantity})
                                                </a>
                                                <div class="dropdown-menu cart-dropdown" aria-labelledby="dropdownMenu1">
                                                    <c:choose>
                                                        <c:when test="${empty sessionScope.cart or empty sessionScope.cart.items}">
                                                            <p style="padding: 20px; color: #888; text-align: center; margin: 0;">Giỏ hàng của bạn đang trống.</p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <h3>Sản phẩm trong giỏ (${sessionScope.cart.totalQuantity})</h3>
                                                            <ul style="max-height: 250px; overflow-y: auto;">
                                                                <c:forEach items="${sessionScope.cart.items}" var="cItem">
                                                                    <li>
                                                                        <div class="cart-btn-product">
                                                                            <a class="product-remove" href="${pageContext.request.contextPath}/cart-action?action=remove&productId=${cItem.product.id}" title="Xóa món này">
                                                                                <i class="fa fa-trash-o"></i>
                                                                            </a>
                                                                            <div class="cart-btn-pro-img">
                                                                                <a href="${pageContext.request.contextPath}/product-detail?id=${cItem.product.id}">
                                                                                    <img src="${pageContext.request.contextPath}/assets/img/product-1.jpg" alt="product" />
                                                                                </a>
                                                                            </div>
                                                                            <div class="cart-btn-pro-cont">
                                                                                <h4><a href="${pageContext.request.contextPath}/product-detail?id=${cItem.product.id}"><c:out value="${cItem.product.name}"/></a></h4>
                                                                                <span class="item-cat">${cItem.quantity} &times; ${cItem.product.formattedEffectivePrice}</span>
                                                                                <span class="price">${cItem.formattedSubtotal}</span>
                                                                            </div>
                                                                        </div>
                                                                    </li>
                                                                </c:forEach>
                                                            </ul>
                                                            <div style="padding: 10px 15px; font-weight: bold; border-top: 1px solid #eee; text-align: right; color: #e85b24; font-size: 15px;">
                                                                Tổng cộng: ${sessionScope.cart.formattedTotalAmount}
                                                            </div>
                                                            <div class="cart-btn">
                                                                <a href="${pageContext.request.contextPath}/cart" class="cart-btn-1">Xem giỏ hàng</a>
                                                                <a href="${pageContext.request.contextPath}/checkout" class="cart-btn-2">Thanh toán ngay</a>
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
                        <div class="menu-container">
                            <div class="row">
                                <div class="col-md-11 col-sm-11">
                                    <!-- Responsive Menu -->
                                    <div class="bleezy-responsive-menu"></div>
                                    <!-- Responsive Menu -->
                                    <div class="mainmenu">
                                        <nav>
                                            <ul id="bleezy_navigation">
                                                <li class="${param.activeMenu == 'home' ? 'current-page-item' : ''}"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                                                <li class="${param.activeMenu == 'about' ? 'current-page-item' : ''}"><a href="${pageContext.request.contextPath}/about.jsp">Giới thiệu</a></li>
                                                <li class="${param.activeMenu == 'shop' ? 'current-page-item' : ''}">
                                                    <a href="${pageContext.request.contextPath}/shop">Cửa hàng</a>
                                                    <ul>
                                                        <li><a href="${pageContext.request.contextPath}/shop">Danh mục sản phẩm</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/cart">Giỏ hàng (${empty sessionScope.cart ? 0 : sessionScope.cart.totalQuantity})</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/checkout">Thanh toán đơn hàng</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/track-order">Tra cứu tiến độ đơn hàng</a></li>
                                                    </ul>
                                                </li>
                                                <li class="${param.activeMenu == 'pages' ? 'current-page-item' : ''}">
                                                    <a href="#">Tiện ích</a>
                                                    <ul>
                                                        <li><a href="${pageContext.request.contextPath}/track-order">Tra cứu đơn hàng</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/team.jsp">Đội ngũ chuyên gia</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/404.jsp">Trang lỗi 404</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập tài khoản</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/register.jsp">Đăng ký thành viên</a></li>
                                                    </ul>
                                                </li>
                                                <li class="${param.activeMenu == 'contact' ? 'current-page-item' : ''}"><a href="${pageContext.request.contextPath}/contact.jsp">Liên hệ & Tư vấn</a></li>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                                <div class="col-md-1 col-sm-1">
                                    <div class="header-search">
                                        <div class="search-icon">
                                            <i class="fa fa-search"></i>
                                        </div>
                                        <div class="search-form">
                                            <form action="${pageContext.request.contextPath}/shop" method="get">
                                                <input type="search" name="keyword" placeholder="Tìm kiếm thiết bị..." >
                                                <button type="submit"><i class="fa fa-search"></i></button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- Header Area End -->
