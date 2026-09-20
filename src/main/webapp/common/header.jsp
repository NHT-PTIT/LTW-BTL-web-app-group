<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                        <p><i class="fa fa-user"></i><a href="${pageContext.request.contextPath}/register.jsp">Register</a> or <a href="${pageContext.request.contextPath}/login.jsp">Login</a></p>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-6">
                        <div class="cart-top-menu">
                            <div class="login dropdown">
                                <a href="#" class="dropdown-toggle cart-icon" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                   <i class="fa fa-shopping-bag"></i> Cart(02)
                                </a>
                                <div class="dropdown-menu cart-dropdown" aria-labelledby="dropdownMenu2">
                                    <h3>Recently added item(s)</h3>
                                    <ul>
                                        <li>
                                            <div class="cart-btn-product">
                                                <a class="product-remove" href="#">
                                                    <i class="fa fa-trash-o"></i>
                                                </a>
                                                <div class="cart-btn-pro-img">
                                                    <a href="${pageContext.request.contextPath}/product-detail.jsp">
                                                        <img src="${pageContext.request.contextPath}/assets/img/product-1.jpg" alt="product" />
                                                    </a>
                                                </div>
                                                <div class="cart-btn-pro-cont">
                                                    <h4><a href="${pageContext.request.contextPath}/product-detail.jsp">Inverter Deye 5kW Hybrid</a></h4>
                                                    <span class="item-cat">1 x 22.500.000₫</span>
                                                    <span class="price">22.500.000₫</span>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                    <div class="cart-btn">
                                        <a href="${pageContext.request.contextPath}/cart.jsp" class="cart-btn-1">View Cart</a>
                                        <a href="${pageContext.request.contextPath}/checkout.jsp" class="cart-btn-2">Checkout</a>
                                    </div>
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
                            <img src="${pageContext.request.contextPath}/assets/img/site-logo.png" alt="site logo" />
                        </a>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="header-right">
                        <div class="header-right-top">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="single-top-right">
                                        <p>Call Us: <a href="tel:08283760532">(+84) 828-376-0532</a></p>
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
                                        <p><i class="fa fa-user"></i> <a href="${pageContext.request.contextPath}/register.jsp">Register</a> or <a href="${pageContext.request.contextPath}/login.jsp">Login</a></p>
                                        <div class="cart-top-menu">
                                            <div class="login dropdown">
                                                <a href="#" class="dropdown-toggle cart-icon" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                   <i class="fa fa-shopping-bag"></i> Cart(02)
                                                </a>
                                                <div class="dropdown-menu cart-dropdown" aria-labelledby="dropdownMenu1">
                                                    <h3>Recently added item(s)</h3>
                                                    <ul>
                                                        <li>
                                                            <div class="cart-btn-product">
                                                                <a class="product-remove" href="#">
                                                                    <i class="fa fa-trash-o"></i>
                                                                </a>
                                                                <div class="cart-btn-pro-img">
                                                                    <a href="${pageContext.request.contextPath}/product-detail.jsp">
                                                                        <img src="${pageContext.request.contextPath}/assets/img/product-1.jpg" alt="product" />
                                                                    </a>
                                                                </div>
                                                                <div class="cart-btn-pro-cont">
                                                                    <h4><a href="${pageContext.request.contextPath}/product-detail.jsp">Inverter Deye 5kW Hybrid</a></h4>
                                                                    <span class="item-cat">1 x 22.500.000₫</span>
                                                                    <span class="price">22.500.000₫</span>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ul>
                                                    <div class="cart-btn">
                                                        <a href="${pageContext.request.contextPath}/cart.jsp" class="cart-btn-1">View Cart</a>
                                                        <a href="${pageContext.request.contextPath}/checkout.jsp" class="cart-btn-2">Checkout</a>
                                                    </div>
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
                                                <li class="${param.activeMenu == 'home' ? 'current-page-item' : ''}"><a href="${pageContext.request.contextPath}/home">home</a></li>
                                                <li class="${param.activeMenu == 'about' ? 'current-page-item' : ''}"><a href="${pageContext.request.contextPath}/about.jsp">about us</a></li>
                                                <li class="${param.activeMenu == 'pages' ? 'current-page-item' : ''}">
                                                    <a href="#">pages</a>
                                                    <ul>
                                                        <li><a href="${pageContext.request.contextPath}/team.jsp">Team member</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/404.jsp">404 page</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/login.jsp">login</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/register.jsp">register</a></li>
                                                    </ul>
                                                </li>
                                                <li class="${param.activeMenu == 'shop' ? 'current-page-item' : ''}">
                                                    <a href="${pageContext.request.contextPath}/shop">shop</a>
                                                    <ul>
                                                        <li><a href="${pageContext.request.contextPath}/shop">shop</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/product-detail">single shop</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/cart.jsp">cart</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/checkout.jsp">checkout</a></li>
                                                    </ul>
                                                </li>
                                                <li class="${param.activeMenu == 'contact' ? 'current-page-item' : ''}"><a href="${pageContext.request.contextPath}/contact.jsp">contact</a></li>
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
                                                <input type="search" name="keyword" placeholder="Search..." >
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
