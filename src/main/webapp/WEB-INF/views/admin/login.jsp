<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Quản Trị - PTIT Tech</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .login-box {
            background: #ffffff;
            width: 100%;
            max-width: 400px;
            padding: 36px 32px;
            border-radius: 12px;
            box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.3);
        }
        .brand-header {
            text-align: center;
            margin-bottom: 28px;
        }
        .brand-header h2 {
            font-size: 22px;
            font-weight: 800;
            color: #0f172a;
            margin-top: 8px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 6px;
        }
        .form-group input {
            width: 100%;
            box-sizing: border-box;
            padding: 10px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            outline: none;
            font-size: 14px;
        }
        .form-group input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        .btn-login {
            width: 100%;
            background: #2563eb;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-login:hover {
            background: #1d4ed8;
        }
        .alert-error {
            background: #fef2f2;
            color: #b91c1c;
            padding: 10px 14px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 16px;
            border: 1px solid #fecaca;
        }
    </style>
</head>
<body>

<div class="login-box">
    <div class="brand-header">
        <i class="fa-solid fa-bolt" style="font-size: 32px; color: #2563eb;"></i>
        <h2>PTIT TECH ADMIN</h2>
        <p style="font-size: 13px; color: #64748b; margin: 4px 0 0 0;">Hệ thống Quản trị Nội dung & Đơn hàng</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert-error">
            <i class="fa-solid fa-triangle-exclamation me-1"></i> ${errorMessage}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/login" method="POST">
        <div class="form-group">
            <label for="username">Tên đăng nhập</label>
            <input type="text" id="username" name="username" value="${param.username != null ? param.username : 'admin'}" required autofocus>
        </div>

        <div class="form-group">
            <label for="password">Mật khẩu</label>
            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu..." required>
        </div>

        <button type="submit" class="btn-login">
            <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng Nhập
        </button>
    </form>

    <div style="margin-top: 20px; text-align: center;">
        <a href="${pageContext.request.contextPath}/" style="font-size: 13px; color: #64748b; text-decoration: none;">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay về Trang chủ
        </a>
    </div>
</div>

</body>
</html>
