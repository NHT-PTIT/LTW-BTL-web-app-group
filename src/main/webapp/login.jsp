<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                                <li><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
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
                    <div class="login-page-box">
                        <div class="login-page-heading">
                            <i class="fa fa-key"></i>
                            <h3>Đăng nhập</h3>
                        </div>
                        <form onsubmit="alert('Đăng nhập thành công (Giao diện tĩnh thử nghiệm)!'); window.location.href='${pageContext.request.contextPath}/index.jsp'; return false;">
                            <div class="account-form-group">
                                <input type="text" placeholder="Tên đăng nhập hoặc Email" name="username" required>
                                <i class="fa fa-user"></i>
                            </div>
                            <div class="account-form-group">
                                <input type="password" placeholder="Mật khẩu" name="password" required>
                                <i class="fa fa-lock"></i>
                            </div>
                            <p class="forgot">
                                <a href="#">Quên mật khẩu?</a>
                            </p>
                            <p>
                                <label>
                                    <input name="remember" type="checkbox" checked>
                                    Ghi nhớ đăng nhập
                                </label>
                            </p>
                            <p>
                                <button type="submit">Đăng nhập ngay</button>
                            </p>
                        </form>
                        <div class="login-sign-up">
                            <a href="${pageContext.request.contextPath}/register.jsp">Bạn chưa có tài khoản? Đăng ký ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Login Area End -->
    
    <jsp:include page="/common/footer.jsp" />

