<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                                <li><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
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
                    <div class="login-page-box">
                        <div class="login-page-heading">
                            <i class="fa fa-user-plus"></i>
                            <h3>Tạo tài khoản mới</h3>
                        </div>
                        <form onsubmit="alert('Đăng ký tài khoản thành công! Mời bạn đăng nhập.'); window.location.href='${pageContext.request.contextPath}/login.jsp'; return false;">
                            <div class="account-form-group">
                                <input type="text" placeholder="Tên đăng nhập (Username) *" name="username" required>
                                <i class="fa fa-user"></i>
                            </div>
                            <div class="account-form-group">
                                <input type="email" placeholder="Địa chỉ Email *" name="email" required>
                                <i class="fa fa-envelope-o"></i>
                            </div>
                            <div class="account-form-group">
                                <input type="password" placeholder="Mật khẩu *" name="password" required>
                                <i class="fa fa-lock"></i>
                            </div>
                            <div class="account-form-group">
                                <input type="password" placeholder="Nhập lại mật khẩu *" name="confirmPassword" required>
                                <i class="fa fa-lock"></i>
                            </div>
                            <div class="remember">
                                <label>
                                    <input name="agree" type="checkbox" required checked>
                                    Tôi đồng ý với <a href="#" style="color: #e85b24;">Điều khoản sử dụng & Chính sách bảo mật</a>
                                </label>
                            </div>
                            <div class="submit-login">
                                <button type="submit">Đăng ký ngay</button>
                            </div>
                        </form>
                        <div class="login-sign-up">
                            <a href="${pageContext.request.contextPath}/login.jsp">Bạn đã có tài khoản? Đăng nhập ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Register Area End -->
    
    <jsp:include page="/common/footer.jsp" />

