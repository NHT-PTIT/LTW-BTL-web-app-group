<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Đăng ký tài khoản - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="pages" />
</jsp:include>
    
    <!-- Breadcromb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Đăng ký tài khoản</h2>
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
                                <li>Đăng ký thành viên</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcromb Area End -->
    
    <!-- Register Area Start -->
    <section class="bleezy-login-page-area section_100">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="login-page-box" style="max-width: 580px; margin: 0 auto;">
                        <div class="login-page-heading">
                            <i class="fa fa-user-plus"></i>
                            <h3>Tạo tài khoản mới</h3>
                        </div>

                        <!-- Thông báo lỗi nếu có -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" style="margin-bottom: 20px; font-weight: 500;">
                                <i class="fa fa-exclamation-triangle"></i> ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/register" method="post">
                            <div class="account-form-group">
                                <input type="text" placeholder="Họ và tên của bạn *" name="fullName" value="${fullName}" required>
                                <i class="fa fa-id-card-o"></i>
                            </div>

                            <div class="account-form-group">
                                <input type="text" placeholder="Tên đăng nhập (Username) *" name="username" value="${username}" required>
                                <i class="fa fa-user"></i>
                            </div>

                            <div class="account-form-group">
                                <input type="email" placeholder="Địa chỉ Email *" name="email" value="${email}" required>
                                <i class="fa fa-envelope-o"></i>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="account-form-group">
                                        <input type="tel" placeholder="Số điện thoại liên hệ" name="phone" value="${phone}">
                                        <i class="fa fa-phone"></i>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="account-form-group">
                                        <input type="text" placeholder="Địa chỉ nhận hàng (Tùy chọn)" name="address" value="${address}">
                                        <i class="fa fa-map-marker"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="account-form-group">
                                        <input type="password" placeholder="Mật khẩu (tối thiểu 6 ký tự) *" name="password" required>
                                        <i class="fa fa-lock"></i>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="account-form-group">
                                        <input type="password" placeholder="Nhập lại mật khẩu *" name="confirmPassword" required>
                                        <i class="fa fa-lock"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="remember">
                                <label>
                                    <input name="agree" type="checkbox" required checked>
                                    Tôi đồng ý với <a href="#" style="color: #e85b24;">Điều khoản dịch vụ & Chính sách bảo mật Bleezy</a>
                                </label>
                            </div>
                            <div class="submit-login">
                                <button type="submit">Đăng ký ngay</button>
                            </div>
                        </form>
                        <div class="login-sign-up">
                            <a href="${pageContext.request.contextPath}/login">Bạn đã có tài khoản? Đăng nhập ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Register Area End -->
    
    <jsp:include page="/common/footer.jsp" />
