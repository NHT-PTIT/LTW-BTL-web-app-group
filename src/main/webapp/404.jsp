<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="404 - Không tìm thấy trang - Bleezy Security" />
    <jsp:param name="activeMenu" value="pages" />
</jsp:include>
    
    <!-- Breadcromb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>404 - Không tìm thấy trang</h2>
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
                                <li>Lỗi 404</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcromb Area End -->
    
    <!-- Not Found Area Start -->
    <section class="bleezy-notfound-area section_t_70 section_b_100">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="notfound">
                        <img src="${pageContext.request.contextPath}/assets/img/va.png" alt="404 image" />
                        <h2>404</h2>
                        <h3>Rất tiếc! Trang bạn đang tìm kiếm không tồn tại hoặc đã bị di chuyển.</h3>
                        <form action="${pageContext.request.contextPath}/shop.jsp" method="get">
                            <input type="search" name="keyword" placeholder="Tìm kiếm sản phẩm hoặc dịch vụ..." >
                            <button type="submit">
                                <i class="fa fa-search" aria-hidden="true"></i>
                            </button>
                        </form>
                        <a href="${pageContext.request.contextPath}/index.jsp" class="bleezy-btn">Quay về trang chủ</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Not Found Area End -->
    
    <jsp:include page="/common/footer.jsp" />

