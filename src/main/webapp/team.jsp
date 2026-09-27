<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Fallback nạp dữ liệu nếu truy cập trực tiếp team.jsp không qua TeamServlet
    if (request.getAttribute("teamMembers") == null) {
        com.myptitgroup.web_app_group.dao.CompanyInfoDAO cDao = new com.myptitgroup.web_app_group.dao.CompanyInfoDAO();
        request.setAttribute("teamMembers", cDao.getActiveTeamMembers());
        request.setAttribute("companyInfo", cDao.getCompanyInfo());
    }
%>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Đội ngũ kỹ thuật - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="pages" />
</jsp:include>
    
    <!-- Breadcrumb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Đội ngũ chuyên gia kỹ thuật</h2>
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
                                <li><a href="${pageContext.request.contextPath}/about">Về chúng tôi</a></li>
                                <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                <li>Đội ngũ chuyên gia</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Area End -->
    
    <!-- Team Member Area Start -->
    <section class="bleezy-team-member-area section_t_100 section_b_70">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center" style="margin-bottom: 50px;">
                    <span style="color: #f26723; font-weight: 700; text-transform: uppercase; font-size: 13px; letter-spacing: 1.5px;">Nhân sự nòng cốt</span>
                    <h2 style="font-size: 32px; font-weight: 800; color: #0f172a; margin-top: 8px;">Kỹ sư & Chuyên gia hàng đầu</h2>
                    <p style="color: #64748b; max-width: 650px; margin: 12px auto 0 auto; line-height: 24px;">
                        Đội ngũ kỹ sư năng lượng và tự động hóa giàu kinh nghiệm từ Học viện Công nghệ Bưu chính Viễn thông (PTIT), luôn sẵn sàng tư vấn và hỗ trợ kỹ thuật 24/7.
                    </p>
                </div>
            </div>

            <div class="row">
                <c:choose>
                    <c:when test="${not empty teamMembers}">
                        <c:forEach items="${teamMembers}" var="member">
                            <c:set var="avatarImg" value="${pageContext.request.contextPath}/assets/img/team-1.jpg" />
                            <c:if test="${not empty member.avatarUrl}">
                                <c:choose>
                                    <c:when test="${member.avatarUrl.startsWith('http')}">
                                        <c:set var="avatarImg" value="${member.avatarUrl}" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="avatarImg" value="${pageContext.request.contextPath}/${member.avatarUrl}" />
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <div class="col-md-3 col-sm-6" style="margin-bottom: 35px;">
                                <div class="single-team-slide" style="background: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e2e8f0; box-shadow: 0 4px 14px rgba(0,0,0,0.04); transition: transform 0.2s;" onmouseover="this.style.transform='translateY(-5px)';" onmouseout="this.style.transform='translateY(0)';">
                                    <div class="team-img" style="position: relative;">
                                        <img src="${avatarImg}" alt="${member.fullName}" style="height: 280px; width: 100%; object-fit: cover;" 
                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/team-1.jpg';" />
                                        <div class="team-social-box">
                                            <div class="team-social">
                                                <c:if test="${not empty member.email}">
                                                    <a href="mailto:${member.email}" title="Gửi email cho ${member.fullName}"><i class="fa fa-envelope"></i></a>
                                                </c:if>
                                                <a href="#" title="LinkedIn"><i class="fa fa-linkedin"></i></a>
                                                <a href="#" title="Facebook"><i class="fa fa-facebook"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="team-text" style="padding: 20px; text-align: left;">
                                        <h4 style="margin: 0 0 4px 0; font-size: 17px; font-weight: 700; color: #0f172a;"><c:out value="${member.fullName}"/></h4>
                                        <p style="margin: 0; color: #f26723; font-weight: 600; font-size: 13px;"><c:out value="${member.position}"/></p>
                                        <c:if test="${not empty member.bio}">
                                            <p style="margin-top: 10px; font-size: 12px; color: #64748b; line-height: 20px;"><c:out value="${member.bio}"/></p>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-md-12 text-center" style="padding: 40px; color: #64748b;">
                            <p>Đang cập nhật danh sách chuyên gia kỹ thuật...</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>
    <!-- Team Member Area End -->
    
    <jsp:include page="/common/footer.jsp" />
