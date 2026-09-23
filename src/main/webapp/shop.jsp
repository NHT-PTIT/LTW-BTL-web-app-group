<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Fallback nạp dữ liệu động nếu trang được gọi trực tiếp mà không qua ShopServlet
    if (request.getAttribute("productList") == null) {
        com.myptitgroup.web_app_group.dao.ProductDAO pDao = new com.myptitgroup.web_app_group.dao.ProductDAO();
        com.myptitgroup.web_app_group.dao.CategoryDAO cDao = new com.myptitgroup.web_app_group.dao.CategoryDAO();

        String catParam = request.getParameter("categoryId");
        if (catParam == null || catParam.isEmpty()) catParam = request.getParameter("cid");
        Integer categoryId = null;
        if (catParam != null && !catParam.trim().isEmpty()) {
            try { categoryId = Integer.parseInt(catParam.trim()); } catch (Exception ignored) {}
        }

        String brand = request.getParameter("brand");
        if (brand != null && brand.trim().isEmpty()) brand = null;

        String keyword = request.getParameter("keyword");
        if (keyword == null || keyword.trim().isEmpty()) keyword = request.getParameter("q");
        if (keyword != null) { keyword = keyword.trim(); if (keyword.isEmpty()) keyword = null; }

        String sort = request.getParameter("sort");
        if (sort == null || sort.trim().isEmpty()) sort = "newest";

        int pageNum = 1;
        try { pageNum = Integer.parseInt(request.getParameter("page")); } catch (Exception ignored) {}
        int pageSize = 9;

        java.util.List<com.myptitgroup.web_app_group.model.Product> list = pDao.filterProducts(
            categoryId, brand, null, null, null, null, keyword, sort, pageNum, pageSize
        );
        int total = pDao.countFilteredProducts(categoryId, brand, null, null, null, null, keyword);
        int totalPages = (int) Math.ceil((double) total / pageSize);
        if (totalPages < 1) totalPages = 1;

        request.setAttribute("productList", list);
        request.setAttribute("totalCount", total);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", pageNum);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("categories", cDao.getAllActive());
        request.setAttribute("brands", pDao.getAllBrands());
        request.setAttribute("featuredSidebar", pDao.getFeaturedProducts(3));
        request.setAttribute("selectedCategoryId", categoryId);
        request.setAttribute("selectedBrand", brand);
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedSort", sort);

        if (categoryId != null) {
            request.setAttribute("currentCategory", cDao.getById(categoryId));
        }
    }
%>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="${not empty pageTitle ? pageTitle : 'Cửa hàng - Bleezy Inverter & Solar Power'}" />
    <jsp:param name="activeMenu" value="shop" />
</jsp:include>
    
    <!-- Breadcromb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>
                                <c:choose>
                                    <c:when test="${not empty currentCategory}">${currentCategory.name}</c:when>
                                    <c:when test="${not empty keyword}">Tìm kiếm: "${keyword}"</c:when>
                                    <c:when test="${not empty selectedBrand}">Thương hiệu: ${selectedBrand}</c:when>
                                    <c:otherwise>Cửa hàng sản phẩm</c:otherwise>
                                </c:choose>
                            </h2>
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
                                <li><a href="${pageContext.request.contextPath}/shop">Cửa hàng</a></li>
                                <c:if test="${not empty currentCategory}">
                                    <li><a href="#"><i class="fa fa-long-arrow-right"></i></a></li>
                                    <li>${currentCategory.name}</li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcromb Area End -->
    
    <!-- Shop Page Area Start -->
    <section class="bleezy-shop-page-area section_100">
        <div class="container">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3">
                    <div class="shop-left-sidebar">
                        <!-- Search Widget -->
                        <div class="shop-sidebar-widget">
                            <form action="${pageContext.request.contextPath}/shop" method="get">
                                <input type="search" name="keyword" value="${keyword}" placeholder="Tìm kiếm sản phẩm..." >
                                <c:if test="${not empty selectedCategoryId}">
                                    <input type="hidden" name="categoryId" value="${selectedCategoryId}">
                                </c:if>
                                <c:if test="${not empty selectedBrand}">
                                    <input type="hidden" name="brand" value="${selectedBrand}">
                                </c:if>
                                <button type="submit"><i class="fa fa-search"></i></button>
                            </form>
                        </div>

                        <!-- Categories Widget -->
                        <div class="shop-sidebar-widget widget_product_categories">
                            <h3>Danh mục sản phẩm</h3>
                            <ul class="product-categories">
                                <li class="${empty selectedCategoryId ? 'current-cat' : ''}">
                                    <a href="${pageContext.request.contextPath}/shop${not empty selectedBrand ? '?brand='.concat(selectedBrand) : ''}">
                                        <strong>Tất cả danh mục</strong>
                                    </a>
                                </li>
                                <c:forEach items="${categories}" var="cat">
                                    <li class="${selectedCategoryId == cat.id ? 'current-cat' : ''}">
                                        <a href="${pageContext.request.contextPath}/shop?categoryId=${cat.id}${not empty selectedBrand ? '&brand='.concat(selectedBrand) : ''}">
                                            <c:out value="${cat.name}"/>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>

                        <!-- Brand Filter Widget -->
                        <div class="shop-sidebar-widget widget_product_categories" style="margin-top: 30px;">
                            <h3>Thương hiệu</h3>
                            <ul class="product-categories">
                                <li class="${empty selectedBrand ? 'current-cat' : ''}">
                                    <a href="${pageContext.request.contextPath}/shop${not empty selectedCategoryId ? '?categoryId='.concat(selectedCategoryId) : ''}">
                                        <strong>Tất cả thương hiệu</strong>
                                    </a>
                                </li>
                                <c:forEach items="${brands}" var="b">
                                    <li class="${selectedBrand == b ? 'current-cat' : ''}">
                                        <a href="${pageContext.request.contextPath}/shop?brand=${b}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}">
                                            <c:out value="${b}"/>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>

                        <!-- Featured Products Widget -->
                        <div class="shop-sidebar-widget" style="margin-top: 30px;">
                            <h3>Sản phẩm bán chạy</h3>
                            <ul class="featured-list">
                                <c:forEach items="${featuredSidebar}" var="fp">
                                    <c:set var="fpImgIdx" value="${fp.id > 0 ? ((fp.id - 1) % 7 + 1) : 1}" />
                                    <li class="sidebr-pro-widget">
                                        <div class="product-thumb-info">
                                            <div class="product-thumb-info-image">
                                                <a href="${pageContext.request.contextPath}/product-detail?id=${fp.id}">
                                                    <img src="${pageContext.request.contextPath}/assets/img/product-${fpImgIdx}.jpg" alt="${fp.name}" />
                                                </a>
                                            </div>
                                            <div class="product-thumb-info-content">
                                                <h4><a href="${pageContext.request.contextPath}/product-detail?id=${fp.id}"><c:out value="${fp.name}"/></a></h4>
                                                <span class="item-cat">
                                                    <a href="${pageContext.request.contextPath}/shop?categoryId=${fp.categoryId}">${not empty fp.categoryName ? fp.categoryName : fp.brand}</a>
                                                </span>
                                                <span class="price">
                                                    ${fp.formattedEffectivePrice}
                                                </span>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- Main Products Grid -->
                <div class="col-md-9">
                    <div class="bleezy-shop-left margin-top">
                        <!-- Shorting Bar -->
                        <div class="shorting">
                            <div class="row">
                                <div class="col-sm-6">
                                    <p>
                                        <c:choose>
                                            <c:when test="${totalCount > 0}">
                                                Hiển thị ${(currentPage - 1) * pageSize + 1}–${(currentPage * pageSize) > totalCount ? totalCount : (currentPage * pageSize)} trên ${totalCount} sản phẩm
                                            </c:when>
                                            <c:otherwise>
                                                Không có sản phẩm nào
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                <div class="col-sm-6">
                                    <form method="get" action="${pageContext.request.contextPath}/shop">
                                        <c:if test="${not empty selectedCategoryId}">
                                            <input type="hidden" name="categoryId" value="${selectedCategoryId}">
                                        </c:if>
                                        <c:if test="${not empty selectedBrand}">
                                            <input type="hidden" name="brand" value="${selectedBrand}">
                                        </c:if>
                                        <c:if test="${not empty keyword}">
                                            <input type="hidden" name="keyword" value="${keyword}">
                                        </c:if>
                                        <label>
                                            <select name="sort" onchange="this.form.submit()">
                                                <option value="newest" ${selectedSort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                                                <option value="price_asc" ${selectedSort == 'price_asc' ? 'selected' : ''}>Giá: Từ thấp đến cao</option>
                                                <option value="price_desc" ${selectedSort == 'price_desc' ? 'selected' : ''}>Giá: Từ cao đến thấp</option>
                                                <option value="name_asc" ${selectedSort == 'name_asc' ? 'selected' : ''}>Tên: A đến Z</option>
                                            </select>
                                        </label>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Product List Grid -->
                        <c:choose>
                            <c:when test="${not empty productList}">
                                <div class="row">
                                    <c:forEach items="${productList}" var="p" varStatus="loop">
                                        <c:set var="pImgIdx" value="${p.id > 0 ? ((p.id - 1) % 7 + 1) : 1}" />
                                        <div class="col-md-4 col-sm-4" style="margin-bottom: 30px;">
                                            <div class="single-shop-product" style="position: relative; height: 100%;">
                                                <c:if test="${p.hasDiscount()}">
                                                    <span style="position: absolute; top: 10px; left: 10px; background: #e74c3c; color: #fff; padding: 3px 8px; border-radius: 3px; font-size: 11px; font-weight: bold; z-index: 2;">
                                                        -${p.discountPercent}%
                                                    </span>
                                                </c:if>
                                                <div class="single-product-image">
                                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                                        <img src="${pageContext.request.contextPath}/assets/img/product-${pImgIdx}.jpg" alt="${p.name}" style="height: 220px; object-fit: contain; width: 100%; padding: 10px; background: #fff;" />
                                                    </a>
                                                </div>
                                                <div class="single-product-text">
                                                    <c:if test="${not empty p.brand}">
                                                        <span style="font-size: 11px; text-transform: uppercase; color: #888; letter-spacing: 0.5px;">
                                                            ${p.brand} <c:if test="${not empty p.powerStr}">| ${p.powerStr}</c:if>
                                                        </span>
                                                    </c:if>
                                                    <h3 style="height: 44px; overflow: hidden; margin-top: 5px; font-size: 15px; line-height: 22px;">
                                                        <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" title="${p.name}">
                                                            <c:out value="${p.name}"/>
                                                        </a>
                                                    </h3>
                                                    <div class="product-price">
                                                        <h3>${p.formattedEffectivePrice}</h3>
                                                        <c:if test="${p.hasDiscount()}">
                                                            <del style="color: #999; font-size: 12px; margin-left: 5px;">${p.formattedPrice}</del>
                                                        </c:if>
                                                    </div>
                                                    <div class="product-button">
                                                        <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">Chi tiết</a>
                                                        <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}" title="Xem chi tiết"><i class="fa fa-eye"></i></a>
                                                        <a href="${pageContext.request.contextPath}/cart-action?action=add&productId=${p.id}&quantity=1" title="Thêm vào giỏ hàng"><i class="fa fa-shopping-cart"></i></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <c:if test="${loop.count % 3 == 0}">
                                            <div class="clearfix visible-md-block visible-lg-block"></div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info text-center" style="margin: 50px 0; padding: 40px;">
                                    <i class="fa fa-search fa-3x" style="color: #3498db; margin-bottom: 15px;"></i>
                                    <h3>Không tìm thấy sản phẩm phù hợp</h3>
                                    <p style="margin-top: 10px; color: #666;">Rất tiếc, không có sản phẩm nào khớp với tiêu chí tìm kiếm hoặc bộ lọc của bạn.</p>
                                    <a href="${pageContext.request.contextPath}/shop" class="bleezy-btn" style="margin-top: 20px;">Xem tất cả sản phẩm</a>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="pagination-box">
                                    <ul class="pagination">
                                        <!-- Previous Page Link -->
                                        <c:if test="${currentPage > 1}">
                                            <li>
                                                <a href="${pageContext.request.contextPath}/shop?page=${currentPage - 1}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}${not empty selectedBrand ? '&brand='.concat(selectedBrand) : ''}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty selectedSort ? '&sort='.concat(selectedSort) : ''}">
                                                    <i class="fa fa-angle-double-left"></i>
                                                </a>
                                            </li>
                                        </c:if>

                                        <!-- Page Numbers -->
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="${currentPage == i ? 'active' : ''}">
                                                <a href="${pageContext.request.contextPath}/shop?page=${i}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}${not empty selectedBrand ? '&brand='.concat(selectedBrand) : ''}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty selectedSort ? '&sort='.concat(selectedSort) : ''}">
                                                    ${i}
                                                </a>
                                            </li>
                                        </c:forEach>

                                        <!-- Next Page Link -->
                                        <c:if test="${currentPage < totalPages}">
                                            <li>
                                                <a href="${pageContext.request.contextPath}/shop?page=${currentPage + 1}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}${not empty selectedBrand ? '&brand='.concat(selectedBrand) : ''}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty selectedSort ? '&sort='.concat(selectedSort) : ''}">
                                                    <i class="fa fa-angle-double-right"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>
    </section>
    <!-- Shop Page Area End -->
    
    <jsp:include page="/common/footer.jsp" />
