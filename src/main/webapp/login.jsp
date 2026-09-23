<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Đăng nhập - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="pages" />
</jsp:include>
    
    <!-- Breadcromb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Đăng nhập tài khoản</h2>
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
                                <li>Đăng nhập</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcromb Area End -->
    
    <!-- Login Area Start -->
    <section class="bleezy-login-page-area section_100">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="login-page-box" style="max-width: 500px; margin: 0 auto;">
                        <div class="login-page-heading">
                            <i class="fa fa-key"></i>
                            <h3>Đăng nhập</h3>
                        </div>

                        <!-- Thông báo đăng ký thành công -->
                        <c:if test="${param.msg == 'reg_success'}">
                            <div class="alert alert-success" style="margin-bottom: 20px; font-weight: 500;">
                                <i class="fa fa-check-circle"></i> Đăng ký tài khoản thành công! Vui lòng đăng nhập để tiếp tục.
                            </div>
                        </c:if>

                        <!-- Thông báo đăng xuất -->
                        <c:if test="${param.msg == 'logged_out'}">
                            <div class="alert alert-info" style="margin-bottom: 20px; font-weight: 500;">
                                <i class="fa fa-info-circle"></i> Bạn đã đăng xuất thành công!
                            </div>
                        </c:if>

                        <!-- Thông báo lỗi nếu có -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" style="margin-bottom: 20px; font-weight: 500;">
                                <i class="fa fa-exclamation-triangle"></i> ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <c:if test="${not empty param.redirect}">
                                <input type="hidden" name="redirect" value="${param.redirect}">
                            </c:if>

                            <div class="account-form-group">
                                <input type="text" placeholder="Tên đăng nhập hoặc Email *" name="username" value="${username}" required autofocus>
                                <i class="fa fa-user"></i>
                            </div>
                            <div class="account-form-group">
                                <input type="password" placeholder="Mật khẩu *" name="password" required>
                                <i class="fa fa-lock"></i>
                            </div>
                            <p class="forgot">
                                <a href="tel:19006868" title="Liên hệ tổng đài để cấp lại mật khẩu">Quên mật khẩu? (Hotline: 1900 6868)</a>
                            </p>
                            <p>
                                <label>
                                    <input name="remember" type="checkbox" checked>
                                    Ghi nhớ đăng nhập trên thiết bị này
                                </label>
                            </p>
                            <p>
                                <button type="submit">Đăng nhập ngay</button>
                            </p>
                        </form>
                        <div class="login-sign-up">
                            <a href="${pageContext.request.contextPath}/register">Bạn chưa có tài khoản? Đăng ký ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Login Area End -->
    
    <jsp:include page="/common/footer.jsp" />
