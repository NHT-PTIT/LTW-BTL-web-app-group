<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Fallback nạp dữ liệu nếu truy cập trực tiếp contact.jsp không qua ContactServlet
    if (request.getAttribute("companyInfo") == null) {
        com.myptitgroup.web_app_group.dao.CompanyInfoDAO cDao = new com.myptitgroup.web_app_group.dao.CompanyInfoDAO();
        request.setAttribute("companyInfo", cDao.getCompanyInfo());
    }
%>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Liên hệ & Hỗ trợ kỹ thuật - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="contact" />
</jsp:include>
    
    <!-- Breadcrumb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Liên hệ & Tư vấn kỹ thuật</h2>
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
                                <li>Liên hệ</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Area End -->
    
    <!-- Contact Page Area Start -->
    <section class="bleezy-contact-page-area section_t_100 section_b_70">
        <div class="container">
            <div class="row">
                <!-- Branch 1 (Trụ sở chính) -->
                <div class="col-md-4 col-sm-4">
                    <div class="single-contact-address">
                        <h3>Trụ sở chính</h3>
                        <ul>
                            <li>
                                <i class="fa fa-map-marker"></i>
                                <p>${not empty companyInfo.address ? companyInfo.address : 'Km10 Đường Nguyễn Trãi, Q. Hà Đông, Hà Nội'}</p>
                            </li>
                            <li>
                                <i class="fa fa-phone"></i>
                                <p>${not empty companyInfo.hotline ? companyInfo.hotline : '1900 6868 - 0988 123 456'}</p>
                            </li>
                            <li>
                                <i class="fa fa-envelope-o"></i>
                                <p>${not empty companyInfo.email ? companyInfo.email : 'contact@ptittech.vn'}</p>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- Branch 2 -->
                <div class="col-md-4 col-sm-4">
                    <div class="single-contact-address">
                        <h3>Chi nhánh Đà Nẵng</h3>
                        <ul>
                            <li>
                                <i class="fa fa-map-marker"></i>
                                <p>Số 123 Đường Nguyễn Văn Linh, Quận Hải Châu, TP. Đà Nẵng</p>
                            </li>
                            <li>
                                <i class="fa fa-phone"></i>
                                <p>(+84) 236-376-0532</p>
                            </li>
                            <li>
                                <i class="fa fa-envelope-o"></i>
                                <p>danang@ptittech.vn</p>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- Branch 3 -->
                <div class="col-md-4 col-sm-4">
                    <div class="single-contact-address">
                        <h3>Chi nhánh TP. Hồ Chí Minh</h3>
                        <ul>
                            <li>
                                <i class="fa fa-map-marker"></i>
                                <p>Số 456 Đường Lê Văn Việt, Phường Tăng Nhơn Phú A, TP. Thủ Đức</p>
                            </li>
                            <li>
                                <i class="fa fa-phone"></i>
                                <p>(+84) 28-376-0532</p>
                            </li>
                            <li>
                                <i class="fa fa-envelope-o"></i>
                                <p>hcm@ptittech.vn</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Contact Page Area End -->
    
    <!-- Contact Form Area Start -->
    <section class="bleezy-contact-form-area section_b_100">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="contact-form">
                        <div class="contact-heading">
                            <h3>Gửi yêu cầu khảo sát & Tư vấn báo giá</h3>
                            <p>Đội ngũ kỹ sư năng lượng và tự động hóa Bleezy sẽ phản hồi và liên hệ lại quý khách trong vòng 30 phút.</p>
                        </div>

                        <!-- Thông báo thành công -->
                        <c:if test="${param.msg == 'sent_success'}">
                            <div class="alert alert-success" role="alert" style="padding: 16px; margin-bottom: 24px; border-radius: 6px; font-size: 15px; background: #ecfdf5; border: 1px solid #6ee7b7; color: #065f46;">
                                <i class="fa fa-check-circle" style="font-size: 18px; margin-right: 8px;"></i>
                                <strong>Cảm ơn quý khách!</strong> Yêu cầu tư vấn của quý khách đã được tiếp nhận thành công. Kỹ sư chuyên môn sẽ liên hệ lại qua số điện thoại hoặc email sớm nhất.
                            </div>
                        </c:if>

                        <!-- Thông báo lỗi -->
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert" style="padding: 16px; margin-bottom: 24px; border-radius: 6px; font-size: 14px; background: #fef2f2; border: 1px solid #fca5a5; color: #991b1b;">
                                <i class="fa fa-exclamation-triangle" style="font-size: 16px; margin-right: 8px;"></i>
                                <c:out value="${errorMessage}" />
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/contact" method="post">
                            <div class="row">
                                <div class="col-md-4 col-sm-4">
                                    <p>
                                        <input type="text" name="fullName" placeholder="Họ và tên của bạn *" value="<c:out value='${not empty formFullName ? formFullName : (not empty sessionScope.currentUser ? sessionScope.currentUser.fullName : "")}' />" required>
                                    </p>
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <p>
                                        <input type="email" name="email" placeholder="Địa chỉ Email *" value="<c:out value='${not empty formEmail ? formEmail : (not empty sessionScope.currentUser ? sessionScope.currentUser.email : "")}' />" required>
                                    </p>
                                </div>
                                <div class="col-md-4 col-sm-4">
                                    <p>
                                        <input type="tel" name="phone" placeholder="Số điện thoại liên hệ *" value="<c:out value='${not empty formPhone ? formPhone : (not empty sessionScope.currentUser ? sessionScope.currentUser.phone : "")}' />" required>
                                    </p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <p>
                                        <input type="text" name="subject" placeholder="Chủ đề yêu cầu (Ví dụ: Báo giá biến tần Schneider 22kW, Tư vấn điện mặt trời áp mái...)" value="<c:out value='${not empty formSubject ? formSubject : ""}' />">
                                    </p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <p>
                                        <textarea name="message" placeholder="Nội dung cần tư vấn (Nhu cầu công suất Inverter, vị trí lắp mái, hệ thống hòa lưới hay lưu trữ Hybrid)..." required><c:out value='${not empty formMessage ? formMessage : ""}' /></textarea>
                                    </p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="contact-form-button">
                                        <button type="submit">Gửi thông điệp ngay</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Contact Form Area End -->
    
    <jsp:include page="/common/footer.jsp" />
