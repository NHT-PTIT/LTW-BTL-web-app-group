<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hóa Đơn Bán Hàng #${order.orderCode} - ${companyInfo.companyName}</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Space+Grotesk:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background-color: #f1f5f9;
            color: #1e293b;
            font-size: 13px;
            line-height: 1.5;
            -webkit-print-color-adjust: exact !important;
            print-color-adjust: exact !important;
        }

        /* Top Action Bar (Chỉ hiển thị trên màn hình) */
        .no-print-bar {
            background: #0f172a;
            color: #fff;
            padding: 12px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 999;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .bar-title {
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 600;
            font-size: 14px;
        }
        .bar-title span {
            background: #e85b24;
            padding: 2px 8px;
            border-radius: 4px;
            font-family: 'Space Grotesk', monospace;
            font-size: 13px;
        }
        .bar-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .btn-action {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            border: none;
            transition: all 0.2s;
        }
        .btn-print {
            background: #e85b24;
            color: #ffffff;
        }
        .btn-print:hover {
            background: #cf4914;
        }
        .btn-close {
            background: #334155;
            color: #f8fafc;
        }
        .btn-close:hover {
            background: #475569;
        }
        .print-tip {
            font-size: 12px;
            color: #94a3b8;
            margin-right: 15px;
        }

        /* Khung trang A4 */
        .page-container {
            max-width: 820px;
            margin: 28px auto;
            background: #ffffff;
            padding: 38px 45px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            border-radius: 8px;
            position: relative;
        }

        /* Header hóa đơn */
        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 20px;
            margin-bottom: 24px;
        }
        .company-brand {
            max-width: 60%;
        }
        .brand-logo-text {
            font-size: 22px;
            font-weight: 800;
            color: #0f172a;
            letter-spacing: -0.5px;
            margin-bottom: 4px;
        }
        .brand-logo-text span {
            color: #e85b24;
        }
        .company-meta {
            font-size: 12px;
            color: #475569;
            line-height: 1.6;
        }
        .invoice-title-block {
            text-align: right;
        }
        .invoice-title {
            font-size: 20px;
            font-weight: 800;
            color: #e85b24;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }
        .invoice-subtitle {
            font-size: 11px;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 8px;
        }
        .order-code-badge {
            display: inline-block;
            background: #f8fafc;
            border: 1px solid #cbd5e1;
            padding: 4px 10px;
            border-radius: 6px;
            font-family: 'Space Grotesk', monospace;
            font-weight: 700;
            font-size: 15px;
            color: #0f172a;
        }

        /* Khối thông tin 2 cột (Khách hàng & Đơn hàng) */
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            margin-bottom: 26px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 16px 20px;
        }
        .info-col-title {
            font-size: 12px;
            font-weight: 700;
            color: #475569;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
            border-bottom: 1px solid #e2e8f0;
            padding-bottom: 4px;
        }
        .info-row {
            display: flex;
            margin-bottom: 6px;
            font-size: 12.5px;
        }
        .info-label {
            width: 120px;
            color: #64748b;
            font-weight: 500;
            flex-shrink: 0;
        }
        .info-val {
            color: #0f172a;
            font-weight: 600;
            flex-grow: 1;
            word-break: break-word;
        }

        /* Bảng danh sách hàng hóa */
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .items-table th {
            background-color: #0f172a;
            color: #ffffff;
            font-weight: 600;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 10px 12px;
            text-align: left;
            border: 1px solid #0f172a;
        }
        .items-table td {
            padding: 10px 12px;
            font-size: 12.5px;
            border: 1px solid #e2e8f0;
            vertical-align: middle;
        }
        .items-table tbody tr:nth-child(even) {
            background-color: #f8fafc;
        }
        .col-center {
            text-align: center;
        }
        .col-right {
            text-align: right;
        }
        .sku-tag {
            font-family: 'Space Grotesk', monospace;
            font-size: 11px;
            color: #64748b;
            display: block;
            margin-top: 2px;
        }

        /* Tổng kết tài chính & VietQR */
        .summary-wrapper {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 25px;
            gap: 20px;
        }
        .vietqr-invoice-box {
            display: flex;
            align-items: center;
            gap: 14px;
            border: 1px dashed #cbd5e1;
            padding: 10px 14px;
            border-radius: 8px;
            background: #f8fafc;
            max-width: 400px;
        }
        .vietqr-invoice-box img {
            width: 90px;
            height: 90px;
            border-radius: 4px;
            border: 1px solid #e2e8f0;
            background: #fff;
            padding: 2px;
        }
        .vietqr-invoice-text {
            font-size: 11.5px;
            line-height: 1.55;
            color: #334155;
        }
        .summary-box {
            width: 340px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            overflow: hidden;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 14px;
            font-size: 12.5px;
            border-bottom: 1px solid #f1f5f9;
        }
        .summary-row.total {
            background-color: #fff7ed;
            border-top: 2px solid #e85b24;
            padding: 12px 14px;
            font-size: 14px;
            font-weight: 700;
            color: #e85b24;
        }

        /* Chữ ký 4 bên */
        .signatures-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
            text-align: center;
            margin-top: 20px;
            padding-top: 15px;
        }
        .sig-title {
            font-weight: 700;
            font-size: 12.5px;
            color: #0f172a;
            margin-bottom: 4px;
        }
        .sig-sub {
            font-size: 11px;
            color: #64748b;
            font-style: italic;
            margin-bottom: 65px;
        }
        .sig-name {
            font-weight: 600;
            font-size: 12px;
            color: #334155;
            border-top: 1px dashed #cbd5e1;
            padding-top: 6px;
            margin: 0 10px;
        }

        /* Footer ghi chú */
        .invoice-footer-note {
            margin-top: 35px;
            border-top: 1px solid #e2e8f0;
            padding-top: 12px;
            text-align: center;
            font-size: 11px;
            color: #64748b;
            line-height: 1.6;
        }

        /* In ấn chuẩn A4 */
        @media print {
            body {
                background: #ffffff;
                color: #000000;
                font-size: 12px;
            }
            .no-print-bar {
                display: none !important;
            }
            .page-container {
                max-width: 100%;
                margin: 0;
                padding: 0;
                box-shadow: none;
                border-radius: 0;
            }
            .info-grid {
                background: #ffffff !important;
                border: 1px solid #000000 !important;
            }
            .info-col-title {
                border-bottom: 1px solid #000000 !important;
                color: #000000 !important;
            }
            .items-table th {
                background-color: #f1f5f9 !important;
                color: #000000 !important;
                border: 1px solid #000000 !important;
            }
            .items-table td {
                border: 1px solid #000000 !important;
            }
            .items-table tbody tr:nth-child(even) {
                background-color: #ffffff !important;
            }
            .summary-box {
                border: 1px solid #000000 !important;
            }
            .summary-row.total {
                background-color: #ffffff !important;
                border-top: 2px solid #000000 !important;
                color: #000000 !important;
            }
            .sig-name {
                border-top: 1px dashed #000000 !important;
            }
            @page {
                size: A4 portrait;
                margin: 12mm 15mm;
            }
        }
    </style>
</head>
<body>

    <!-- Thanh công cụ in ấn (Chỉ hiển thị trên web, ẩn khi in) -->
    <div class="no-print-bar">
        <div class="bar-title">
            <i class="fa-solid fa-file-invoice" style="color: #e85b24;"></i>
            HÓA ĐƠN BÁN HÀNG <span>#${order.orderCode}</span>
        </div>
        <div class="bar-actions">
            <span class="print-tip"><i class="fa-solid fa-circle-info"></i> Khuyến nghị: Chọn khổ A4, tỉ lệ 100% trong hộp thoại in</span>
            <button onclick="window.print()" class="btn-action btn-print">
                <i class="fa-solid fa-print"></i> In Hóa Đơn / Xuất PDF
            </button>
            <button onclick="window.close()" class="btn-action btn-close">
                <i class="fa-solid fa-xmark"></i> Đóng
            </button>
        </div>
    </div>

    <!-- Khung Nội Dung A4 -->
    <div class="page-container">
        
        <!-- Header -->
        <div class="invoice-header">
            <div class="company-brand">
                <div class="brand-logo-text">
                    ${companyInfo.companyName != null ? companyInfo.companyName : 'BLEEZY'} <span>SECURITY</span>
                </div>
                <div class="company-meta">
                    <p><strong>Địa chỉ:</strong> ${companyInfo.address}</p>
                    <p><strong>Hotline:</strong> ${companyInfo.hotline} | <strong>Email:</strong> ${companyInfo.email}</p>
                    <c:if test="${not empty companyInfo.slogan}">
                        <p style="font-style: italic; color: #64748b;">"${companyInfo.slogan}"</p>
                    </c:if>
                </div>
            </div>
            <div class="invoice-title-block">
                <div class="invoice-title">HÓA ĐƠN BÁN HÀNG</div>
                <div class="invoice-subtitle">KIÊM PHIẾU XUẤT KHO THIẾT BỊ</div>
                <div class="order-code-badge">
                    MÃ: #${order.orderCode}
                </div>
            </div>
        </div>

        <!-- 2 Cột Thông Tin Đơn Hàng & Khách Hàng -->
        <div class="info-grid">
            <!-- Bên Mua (Khách hàng) -->
            <div>
                <div class="info-col-title"><i class="fa-solid fa-user"></i> THÔNG TIN KHÁCH HÀNG</div>
                <div class="info-row">
                    <span class="info-label">Người nhận hàng:</span>
                    <span class="info-val"><c:out value="${order.customerName}" /></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Số điện thoại:</span>
                    <span class="info-val"><c:out value="${order.customerPhone}" /></span>
                </div>
                <c:if test="${not empty order.customerEmail}">
                    <div class="info-row">
                        <span class="info-label">Email:</span>
                        <span class="info-val"><c:out value="${order.customerEmail}" /></span>
                    </div>
                </c:if>
                <div class="info-row">
                    <span class="info-label">Địa chỉ giao:</span>
                    <span class="info-val"><c:out value="${order.shippingAddress}" /></span>
                </div>
                <c:if test="${not empty order.note}">
                    <div class="info-row">
                        <span class="info-label">Ghi chú giao:</span>
                        <span class="info-val" style="font-weight: 500; font-style: italic;"><c:out value="${order.note}" /></span>
                    </div>
                </c:if>
            </div>

            <!-- Thông tin đơn hàng -->
            <div>
                <div class="info-col-title"><i class="fa-solid fa-file-lines"></i> THÔNG TIN CHỨNG TỪ</div>
                <div class="info-row">
                    <span class="info-label">Mã chứng từ:</span>
                    <span class="info-val">INV-${order.orderCode}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Ngày tạo đơn:</span>
                    <span class="info-val"><fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm" /></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Hình thức TT:</span>
                    <span class="info-val">
                        ${order.paymentMethod == 'COD' ? 'Thanh toán tiền mặt khi nhận hàng (COD)' : 'Chuyển khoản ngân hàng'}
                    </span>
                </div>
                <div class="info-row">
                    <span class="info-label">Trạng thái đơn:</span>
                    <span class="info-val" style="color: #e85b24;">
                        ${order.statusDisplayName}
                    </span>
                </div>
                <div class="info-row">
                    <span class="info-label">Xuất kho tại:</span>
                    <span class="info-val">Tổng kho Bleezy Hà Nội</span>
                </div>
            </div>
        </div>

        <!-- Bảng Sản Phẩm -->
        <table class="items-table">
            <thead>
                <tr>
                    <th style="width: 40px;" class="col-center">STT</th>
                    <th>Tên Thiết Bị / Sản Phẩm An Ninh & CCTV</th>
                    <th style="width: 80px;" class="col-center">ĐVT</th>
                    <th style="width: 70px;" class="col-center">Số lượng</th>
                    <th style="width: 120px;" class="col-right">Đơn giá</th>
                    <th style="width: 130px;" class="col-right">Thành tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${order.items}" varStatus="st">
                    <tr>
                        <td class="col-center">${st.index + 1}</td>
                        <td>
                            <strong><c:out value="${item.productName}" /></strong>
                            <c:if test="${not empty item.productSku}">
                                <span class="sku-tag">Mã SKU: <c:out value="${item.productSku}" /></span>
                            </c:if>
                        </td>
                        <td class="col-center">Bộ / Chiếc</td>
                        <td class="col-center"><strong>${item.quantity}</strong></td>
                        <td class="col-right">${item.formattedUnitPrice}</td>
                        <td class="col-right"><strong>${item.formattedSubtotal}</strong></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Khối Tổng Hợp Tiền & VietQR -->
        <div class="summary-wrapper">
            <c:choose>
                <c:when test="${not empty companyInfo.bankAccountNo}">
                    <div class="vietqr-invoice-box">
                        <img src="https://img.vietqr.io/image/${companyInfo.bankName}-${companyInfo.bankAccountNo}-compact2.png?amount=${order.totalAmount}&addInfo=${order.orderCode}&accountName=${companyInfo.bankAccountName}" 
                             alt="VietQR Invoice ${order.orderCode}" />
                        <div class="vietqr-invoice-text">
                            <strong style="color: #4338ca; text-transform: uppercase;"><i class="fa-solid fa-qrcode"></i> THANH TOÁN VIETQR</strong><br>
                            Ngân hàng: <strong>${companyInfo.bankName}</strong><br>
                            Số TK: <strong style="font-family: monospace; font-size: 12.5px;">${companyInfo.bankAccountNo}</strong><br>
                            Chủ TK: <strong>${companyInfo.bankAccountName}</strong><br>
                            Nội dung: <strong style="color: #b91c1c; font-family: monospace;">${order.orderCode}</strong>
                        </div>
                    </div>
                </c:when>
                <c:otherwise><div></div></c:otherwise>
            </c:choose>

            <div class="summary-box">
                <div class="summary-row">
                    <span>Tổng tiền hàng:</span>
                    <strong>${order.formattedTotalAmount}</strong>
                </div>
                <div class="summary-row">
                    <span>Cước phí vận chuyển:</span>
                    <span style="color: #16a34a; font-weight: 600;">Miễn phí (0 đ)</span>
                </div>
                <c:if test="${not empty order.couponCode}">
                    <div class="summary-row" style="color: #16a34a;">
                        <span>Mã giảm giá (${order.couponCode}):</span>
                        <strong>${order.formattedDiscountAmount}</strong>
                    </div>
                </c:if>
                <div class="summary-row total">
                    <span>TỔNG THANH TOÁN:</span>
                    <span>${order.formattedTotalAmount}</span>
                </div>
            </div>
        </div>

        <!-- Chữ ký các bên -->
        <div class="signatures-grid">
            <div>
                <div class="sig-title">Người Lập Hóa Đơn</div>
                <div class="sig-sub">(Ký, ghi rõ họ tên)</div>
                <div class="sig-name">Bộ phận Kế toán</div>
            </div>
            <div>
                <div class="sig-title">Thủ Kho Xuất Hàng</div>
                <div class="sig-sub">(Ký, ghi rõ họ tên)</div>
                <div class="sig-name">Quản lý kho Bleezy</div>
            </div>
            <div>
                <div class="sig-title">Nhân Viên Giao Hàng</div>
                <div class="sig-sub">(Ký, ghi rõ họ tên)</div>
                <div class="sig-name">Đơn vị vận chuyển</div>
            </div>
            <div>
                <div class="sig-title">Khách Hàng Nhận Hàng</div>
                <div class="sig-sub">(Ký, ghi rõ họ tên)</div>
                <div class="sig-name"><c:out value="${order.customerName}" /></div>
            </div>
        </div>

        <!-- Lưu ý cuối trang -->
        <div class="invoice-footer-note">
            <p>Quý khách vui lòng kiểm tra kỹ số lượng, tem niêm phong và ngoại quan thiết bị trước khi ký nhận hàng.</p>
            <p>Hóa đơn kiêm phiếu xuất kho có giá trị bảo hành chính hãng theo thời hạn quy định trên phiếu bảo hành kèm theo.</p>
            <p>Hotline Hỗ Trợ Kỹ Thuật 24/7: <strong>${companyInfo.hotline}</strong> | Website: <strong>bleezysecurity.vn</strong></p>
        </div>

    </div>

</body>
</html>
