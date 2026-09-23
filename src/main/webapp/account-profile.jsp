<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Hồ sơ tài khoản - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="pages" />
</jsp:include>

    <!-- Breadcrumb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Tài khoản thành viên</h2>
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
                                <li>Hồ sơ cá nhân</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Area End -->

    <!-- Account Area Start -->
    <section class="section_100" style="background: #f8fafc;">
        <div class="container">
            <div class="row">
                <!-- Sidebar Tài khoản -->
                <div class="col-md-3 col-sm-4">
                    <div style="background: #fff; border-radius: 8px; border: 1px solid #e2e8f0; padding: 24px; margin-bottom: 30px; text-align: center;">
                        <div style="width: 80px; height: 80px; border-radius: 50%; background: #f26723; color: #fff; font-size: 32px; font-weight: 700; display: inline-flex; align-items: center; justify-content: center; margin-bottom: 14px; box-shadow: 0 4px 10px rgba(242, 103, 35, 0.25);">
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
                                   style="display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 6px; font-weight: 600; text-decoration: none; background: rgba(242, 103, 35, 0.1); color: #f26723;">
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

                <!-- Nội dung chính -->
                <div class="col-md-9 col-sm-8">
                    <!-- Thông báo Thành công / Lỗi -->
                    <c:if test="${param.msg == 'profile_updated'}">
                        <div class="alert alert-success" style="font-weight: 500;">
                            <i class="fa fa-check-circle"></i> Cập nhật hồ sơ cá nhân thành công!
                        </div>
                    </c:if>
                    <c:if test="${param.msg == 'pwd_updated'}">
                        <div class="alert alert-success" style="font-weight: 500;">
                            <i class="fa fa-check-circle"></i> Đổi mật khẩu thành công! Hãy ghi nhớ mật khẩu mới của bạn.
                        </div>
                    </c:if>
                    <c:if test="${param.err == 'pwd_incorrect'}">
                        <div class="alert alert-danger" style="font-weight: 500;">
                            <i class="fa fa-exclamation-triangle"></i> Mật khẩu hiện tại không chính xác!
                        </div>
                    </c:if>
                    <c:if test="${param.err == 'pwd_mismatch'}">
                        <div class="alert alert-danger" style="font-weight: 500;">
                            <i class="fa fa-exclamation-triangle"></i> Mật khẩu mới và mật khẩu xác nhận không khớp!
                        </div>
                    </c:if>
                    <c:if test="${param.err == 'pwd_short'}">
                        <div class="alert alert-danger" style="font-weight: 500;">
                            <i class="fa fa-exclamation-triangle"></i> Mật khẩu mới phải có tối thiểu 6 ký tự!
                        </div>
                    </c:if>

                    <!-- Card 1: Thông tin cá nhân -->
                    <div style="background: #fff; border-radius: 8px; border: 1px solid #e2e8f0; padding: 28px; margin-bottom: 24px;">
                        <div style="border-bottom: 1px solid #e2e8f0; padding-bottom: 12px; margin-bottom: 20px;">
                            <h3 style="font-size: 18px; font-weight: 700; color: #0f172a; margin: 0;">
                                <i class="fa fa-id-card" style="color: #f26723; margin-right: 8px;"></i> THÔNG TIN TÀI KHOẢN
                            </h3>
                            <p style="color: #64748b; font-size: 13px; margin: 4px 0 0 0;">
                                Quản lý thông tin cá nhân và địa chỉ mặc định để tự động điền khi thanh toán.
                            </p>
                        </div>

                        <form action="${pageContext.request.contextPath}/account/profile" method="post">
                            <input type="hidden" name="action" value="update-profile">

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group" style="margin-bottom: 18px;">
                                        <label style="font-weight: 600; font-size: 13px; color: #334155; margin-bottom: 6px;">Tên đăng nhập (Username)</label>
                                        <input type="text" class="form-control" value="${sessionScope.currentUser.username}" readonly style="background: #f1f5f9; cursor: not-allowed;">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group" style="margin-bottom: 18px;">
                                        <label style="font-weight: 600; font-size: 13px; color: #334155; margin-bottom: 6px;">Địa chỉ Email</label>
                                        <input type="email" class="form-control" value="${sessionScope.currentUser.email}" readonly style="background: #f1f5f9; cursor: not-allowed;">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group" style="margin-bottom: 18px;">
                                        <label style="font-weight: 600; font-size: 13px; color: #334155; margin-bottom: 6px;">Họ và tên của bạn <span style="color: #dc2626;">*</span></label>
                                        <input type="text" name="fullName" class="form-control" value="${sessionScope.currentUser.fullName}" required>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group" style="margin-bottom: 18px;">
                                        <label style="font-weight: 600; font-size: 13px; color: #334155; margin-bottom: 6px;">Số điện thoại nhận hàng</label>
                                        <input type="tel" name="phone" class="form-control" value="${sessionScope.currentUser.phone}" placeholder="Ví dụ: 0912345678">
                                    </div>
                                </div>
                            </div>

                            <div class="form-group" style="margin-bottom: 22px;">
                                <label style="font-weight: 600; font-size: 13px; color: #334155; margin-bottom: 6px;">Địa chỉ giao hàng mặc định</label>
                                <textarea name="address" class="form-control" rows="2" placeholder="Ví dụ: Số 45 Lê Văn Lương, Trung Hòa, Cầu Giấy, Hà Nội">${sessionScope.currentUser.address}</textarea>
                            </div>

                            <button type="submit" style="background: #f26723; color: #fff; font-family: 'Oswald', sans-serif; font-size: 15px; font-weight: 600; border: none; padding: 10px 24px; border-radius: 4px; text-transform: uppercase; cursor: pointer; transition: all 0.2s;">
                                <i class="fa fa-floppy-o" style="margin-right: 6px;"></i> Lưu thay đổi
                            </button>
                        </form>
                    </div>

                    <!-- Card 2: Đổi mật khẩu -->
                    <div id="pwdSection" style="background: #fff; border-radius: 8px; border: 1px solid #e2e8f0; padding: 28px;">
                        <div style="border-bottom: 1px solid #e2e8f0; padding-bottom: 12px; margin-bottom: 20px;">
                            <h3 style="font-size: 18px; font-weight: 700; color: #0f172a; margin: 0;">
                                <i class="fa fa-lock" style="color: #f26723; margin-right: 8px;"></i> ĐỔI MẬT KHẨU
                            </h3>
                            <p style="color: #64748b; font-size: 13px; margin: 4px 0 0 0;">
                                Để bảo mật tài khoản, vui lòng không chia sẻ mật khẩu của bạn cho người khác.
                            </p>
                        </div>

                        <form action="${pageContext.request.contextPath}/account/profile" method="post">
                            <input type="hidden" name="action" value="change-password">

                            <div class="form-group" style="margin-bottom: 16px; max-width: 450px;">
                                <label style="font-weight: 600; font-size: 13px; color: #334155; margin-bottom: 6px;">Mật khẩu hiện tại <span style="color: #dc2626;">*</span></label>
                                <input type="password" name="currentPassword" class="form-control" required placeholder="Nhập mật khẩu hiện tại">
                            </div>

                            <div class="form-group" style="margin-bottom: 16px; max-width: 450px;">
                                <label style="font-weight: 600; font-size: 13px; color: #334155; margin-bottom: 6px;">Mật khẩu mới (tối thiểu 6 ký tự) <span style="color: #dc2626;">*</span></label>
                                <input type="password" name="newPassword" class="form-control" required placeholder="Nhập mật khẩu mới">
                            </div>

                            <div class="form-group" style="margin-bottom: 22px; max-width: 450px;">
                                <label style="font-weight: 600; font-size: 13px; color: #334155; margin-bottom: 6px;">Xác nhận mật khẩu mới <span style="color: #dc2626;">*</span></label>
                                <input type="password" name="confirmPassword" class="form-control" required placeholder="Nhập lại mật khẩu mới">
                            </div>

                            <button type="submit" style="background: #212121; color: #fff; font-family: 'Oswald', sans-serif; font-size: 15px; font-weight: 600; border: none; padding: 10px 24px; border-radius: 4px; text-transform: uppercase; cursor: pointer; transition: all 0.2s;">
                                <i class="fa fa-key" style="margin-right: 6px;"></i> Cập nhật mật khẩu
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Account Area End -->

<jsp:include page="/common/footer.jsp" />
