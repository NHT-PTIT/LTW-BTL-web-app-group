<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Fallback nạp dữ liệu nếu truy cập trực tiếp about.jsp không qua AboutServlet
    if (request.getAttribute("companyInfo") == null) {
        com.myptitgroup.web_app_group.dao.CompanyInfoDAO cDao = new com.myptitgroup.web_app_group.dao.CompanyInfoDAO();
        request.setAttribute("companyInfo", cDao.getCompanyInfo());
        request.setAttribute("teamMembers", cDao.getActiveTeamMembers());
    }
%>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Về chúng tôi - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="about" />
</jsp:include>
    
    <!-- Breadcrumb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Về chúng ta</h2>
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
                                <li>Về chúng tôi</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Area End -->
    
    <!-- About Page Start -->
    <section class="bleezy-about-page section_100">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="about-left">
                        <h2>${not empty companyInfo.companyName ? companyInfo.companyName : 'Bleezy Inverter & Solar Power'}</h2>
                        <c:choose>
                            <c:when test="${not empty companyInfo.aboutDetail}">
                                ${companyInfo.aboutDetail}
                            </c:when>
                            <c:otherwise>
                                <p>Chào mừng bạn đến với Bleezy — đơn vị tiên phong trong lĩnh vực cung cấp giải pháp biến tần Inverter, điện mặt trời hòa lưới và lưu trữ năng lượng sạch tại Việt Nam. Với nhiều năm hoạt động, chúng tôi luôn cam kết đem lại các sản phẩm đạt tiêu chuẩn chất lượng châu Âu, an toàn và tối ưu chi phí đầu tư.</p>
                                <p>Hệ thống sản phẩm của chúng tôi được nhập khẩu chính hãng từ các thương hiệu hàng đầu thế giới như Deye, Huawei, Growatt, Longi, Canadian Solar,... kèm chính sách bảo hành uy tín và dịch vụ hỗ trợ kỹ thuật 24/7.</p>
                            </c:otherwise>
                        </c:choose>
                        <div style="margin-top: 25px;">
                            <a href="${pageContext.request.contextPath}/shop" class="bleezy-btn">Khám phá sản phẩm</a>
                            <a href="${pageContext.request.contextPath}/contact" class="bleezy-btn" style="background: #0f172a; border-color: #0f172a; margin-left: 10px;">Liên hệ tư vấn</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="about-right">
                        <img src="${pageContext.request.contextPath}/assets/img/abt-img.jpg" alt="about image" style="border-radius: 8px; box-shadow: 0 10px 30px rgba(0,0,0,0.08);" />
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- About Page End -->
    
    <!-- Statement Area Start -->
    <section class="bleezy-statement-area section_b_100">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-sm-4">
                    <div class="statement-left" style="background: #fff; padding: 30px; border-radius: 8px; border: 1px solid #e2e8f0; height: 100%;">
                        <div style="font-size: 28px; color: #f26723; margin-bottom: 12px;"><i class="fa fa-bullseye"></i></div>
                        <h3 style="font-size: 20px; font-weight: 700; color: #0f172a; margin-bottom: 12px;">Sứ mệnh của chúng tôi</h3>
                        <p style="color: #64748b; line-height: 24px;">
                            ${not empty companyInfo.mission ? companyInfo.mission : 'Cung cấp thiết bị chất lượng cao, tối ưu hóa năng lượng tiêu thụ cho doanh nghiệp sản xuất và đồng hành cùng tiến trình chuyển đổi số của các nhà máy.'}
                        </p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="statement-right" style="background: #fff; padding: 30px; border-radius: 8px; border: 1px solid #e2e8f0; height: 100%;">
                        <div style="font-size: 28px; color: #f26723; margin-bottom: 12px;"><i class="fa fa-eye"></i></div>
                        <h3 style="font-size: 20px; font-weight: 700; color: #0f172a; margin-bottom: 12px;">Tầm nhìn chiến lược</h3>
                        <p style="color: #64748b; line-height: 24px;">
                            ${not empty companyInfo.vision ? companyInfo.vision : 'Trở thành nhà cung cấp giải pháp tự động hóa công nghiệp và thiết bị điện thông minh uy tín số 1 Việt Nam đến năm 2030.'}
                        </p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4">
                    <div class="statement-right" style="background: #fff; padding: 30px; border-radius: 8px; border: 1px solid #e2e8f0; height: 100%;">
                        <div style="font-size: 28px; color: #f26723; margin-bottom: 12px;"><i class="fa fa-diamond"></i></div>
                        <h3 style="font-size: 20px; font-weight: 700; color: #0f172a; margin-bottom: 12px;">Giá trị cốt lõi</h3>
                        <p style="color: #64748b; line-height: 24px;">
                            ${not empty companyInfo.coreValues ? companyInfo.coreValues : 'Chất lượng chuẩn mực - Tận tâm chuyên nghiệp - Đổi mới sáng tạo - Bền vững cùng khách hàng.'}
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Statement Area End -->
    
    <!-- Team Member Area Start -->
    <section class="bleezy-team-member-area section_100">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="site-heading">
                        <h3>Kinh nghiệm chuyên môn</h3>
                        <h2>Đội ngũ chuyên gia kỹ thuật</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="team-slider">
                        <c:choose>
                            <c:when test="${not empty teamMembers}">
                                <c:forEach items="${teamMembers}" var="m" varStatus="loop">
                                    <c:set var="avatarImg" value="${not empty m.avatarUrl ? (m.avatarUrl.startsWith('http') ? m.avatarUrl : pageContext.request.contextPath.concat('/').concat(m.avatarUrl)) : pageContext.request.contextPath.concat('/assets/img/team-1.jpg')}" />
                                    <div class="single-team-slide">
                                        <div class="team-img">
                                            <a href="${pageContext.request.contextPath}/team">
                                                <img src="${avatarImg}" alt="${m.fullName}" style="height: 320px; width: 100%; object-fit: cover;" 
                                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/team-1.jpg';" />
                                            </a>
                                            <div class="team-social-box">
                                                <div class="team-social">
                                                    <a href="mailto:${m.email}"><i class="fa fa-envelope"></i></a>
                                                    <a href="#"><i class="fa fa-linkedin"></i></a>
                                                    <a href="#"><i class="fa fa-facebook"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="team-text">
                                            <h4><a href="${pageContext.request.contextPath}/team"><c:out value="${m.fullName}"/></a></h4>
                                            <p><c:out value="${m.position}"/></p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="single-team-slide">
                                    <div class="team-img">
                                        <img src="${pageContext.request.contextPath}/assets/img/team-1.jpg" alt="team img" />
                                    </div>
                                    <div class="team-text">
                                        <h4>TS. Nguyễn Văn An</h4>
                                        <p>Tổng Giám Đốc (CEO)</p>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Team Member Area End -->
    
    <jsp:include page="/common/footer.jsp" />
