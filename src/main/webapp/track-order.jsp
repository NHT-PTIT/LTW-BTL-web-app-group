<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/common/header.jsp">
    <jsp:param name="pageTitle" value="Tra cứu đơn hàng - Bleezy Inverter & Solar Power" />
    <jsp:param name="activeMenu" value="pages" />
</jsp:include>

    <!-- Breadcrumb Area Start -->
    <section class="bleezy-breadcromb-area">
        <div class="breadcromb-top section_50">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="breadcromb-top-text">
                            <h2>Tra cứu tình trạng đơn hàng</h2>
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
                                <li>Tra cứu đơn hàng</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Area End -->

    <!-- Order Tracking Search Area -->
    <section class="section_100" style="background: #fdfdfd;">
        <div class="container">
            <div class="row">
                <div class="col-md-8 col-md-offset-2">
                    <div style="background: #fff; padding: 35px 40px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.06); margin-bottom: 40px;">
                        <h3 style="font-size: 22px; font-weight: bold; margin-bottom: 12px; color: #222; text-align: center;">
                            <i class="fa fa-search" style="color: #e85b24; margin-right: 8px;"></i> Nhập thông tin đơn hàng
                        </h3>
                        <p style="text-align: center; color: #666; font-size: 14px; margin-bottom: 25px;">
                            Nhập <strong>Mã đơn hàng</strong> (Ví dụ: <code>ORD-2026...</code>) hoặc <strong>Số điện thoại</strong> lúc đặt hàng để kiểm tra tiến độ xử lý và giao nhận.
                        </p>

                        <form action="${pageContext.request.contextPath}/track-order" method="get">
                            <div class="input-group" style="display: flex;">
                                <input type="text" name="q" value="<c:out value="${searchedQuery}"/>" 
                                       placeholder="Nhập mã đơn hàng hoặc số điện thoại..." 
                                       required
                                       style="height: 50px; font-size: 16px; border: 2px solid #e85b24; border-radius: 4px 0 0 4px; padding: 0 15px; width: 100%;">
                                <button type="submit" class="bleezy-btn" 
                                        style="height: 50px; border-radius: 0 4px 4px 0; border: none; padding: 0 25px; white-space: nowrap;">
                                    <i class="fa fa-search"></i> Tra cứu
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Search Results -->
                    <c:if test="${hasSearched}">
                        <c:choose>
                            <c:when test="${not empty orders}">
                                <h4 style="font-size: 18px; font-weight: bold; margin-bottom: 20px; color: #333;">
                                    Kết quả tìm kiếm cho: "<c:out value="${searchedQuery}"/>" (${orders.size()} đơn hàng)
                                </h4>

                                <c:forEach items="${orders}" var="ord">
                                    <div style="background: #fff; border: 1px solid #e5e7eb; border-radius: 8px; padding: 25px; margin-bottom: 25px; box-shadow: 0 2px 8px rgba(0,0,0,0.04);">
                                        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; padding-bottom: 15px; margin-bottom: 15px; flex-wrap: wrap; gap: 10px;">
                                            <div>
                                                <span style="font-size: 18px; font-weight: bold; color: #e85b24;">#${ord.orderCode}</span>
                                                <span style="color: #888; font-size: 13px; margin-left: 10px;">
                                                    <i class="fa fa-clock-o"></i> <fmt:formatDate value="${ord.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                </span>
                                            </div>
                                            <div>
                                                <span class="label label-${ord.statusBadgeClass}" style="font-size: 13px; padding: 6px 12px;">
                                                    ${ord.statusDisplayName}
                                                </span>
                                            </div>
                                        </div>

                                        <div class="row" style="font-size: 14px; margin-bottom: 15px;">
                                            <div class="col-sm-6">
                                                <p style="margin-bottom: 6px;"><strong>Người nhận:</strong> <c:out value="${ord.customerName}"/> (<c:out value="${ord.customerPhone}"/>)</p>
                                                <p style="margin-bottom: 6px;"><strong>Địa chỉ:</strong> <c:out value="${ord.shippingAddress}"/></p>
                                            </div>
                                            <div class="col-sm-6">
                                                <p style="margin-bottom: 6px;"><strong>Phương thức:</strong> ${ord.paymentMethod == 'COD' ? 'Thanh toán COD' : 'Chuyển khoản'}</p>
                                                <p style="margin-bottom: 6px;"><strong>Tổng thanh toán:</strong> <strong style="color: #e85b24; font-size: 16px;">${ord.formattedTotalAmount}</strong></p>
                                            </div>
                                        </div>

                                        <!-- Items List -->
                                        <c:if test="${not empty ord.items}">
                                            <div style="background: #fafafa; border-radius: 6px; padding: 15px;">
                                                <table class="table" style="margin-bottom: 0; font-size: 13px;">
                                                    <thead>
                                                        <tr>
                                                            <th>Sản phẩm</th>
                                                            <th style="text-align: center;">SL</th>
                                                            <th style="text-align: right;">Đơn giá</th>
                                                            <th style="text-align: right;">Thành tiền</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${ord.items}" var="it">
                                                            <tr>
                                                                <td>
                                                                    <strong><c:out value="${it.productName}"/></strong>
                                                                    <c:if test="${not empty it.productSku}">
                                                                        <br><small style="color: #888;">SKU: ${it.productSku}</small>
                                                                    </c:if>
                                                                </td>
                                                                <td style="text-align: center;">${it.quantity}</td>
                                                                <td style="text-align: right;">${it.formattedUnitPrice}</td>
                                                                <td style="text-align: right; font-weight: 600;">${it.formattedSubtotal}</td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div style="background: #fff; padding: 40px; border-radius: 8px; text-align: center; border: 1px dashed #ddd;">
                                    <i class="fa fa-info-circle" style="font-size: 45px; color: #999; margin-bottom: 15px;"></i>
                                    <h4 style="font-size: 18px; color: #555; margin-bottom: 10px;">Không tìm thấy đơn hàng nào!</h4>
                                    <p style="color: #777; font-size: 14px;">
                                        Không tìm thấy đơn hàng khớp với từ khóa "<strong><c:out value="${searchedQuery}"/></strong>".<br>
                                        Vui lòng kiểm tra lại Mã đơn hàng hoặc Số điện thoại bạn đã sử dụng khi đặt hàng.
                                    </p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </div>
            </div>
        </div>
    </section>

<jsp:include page="/common/footer.jsp" />
