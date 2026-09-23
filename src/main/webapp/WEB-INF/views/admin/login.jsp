<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Quản Trị - Bleezy Solar Admin Portal</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Oswald:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: 'Inter', -apple-system, sans-serif;
            background: #111827;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background-image: radial-gradient(circle at 50% 20%, rgba(242, 103, 35, 0.12) 0%, transparent 60%);
        }
        .login-box {
            background: #ffffff;
            width: 100%;
            max-width: 420px;
            padding: 40px 34px;
            border-radius: 10px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            border-top: 4px solid #f26723;
        }
        .brand-header {
            text-align: center;
            margin-bottom: 28px;
        }
        .brand-logo {
            height: 44px;
            width: auto;
            margin-bottom: 12px;
            object-fit: contain;
        }
        .brand-header h2 {
            font-family: 'Oswald', sans-serif;
            font-size: 24px;
            font-weight: 700;
            color: #111827;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }
        .brand-header p {
            font-size: 13px;
            color: #64748b;
            margin-top: 4px;
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
            padding: 11px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 6px;
            outline: none;
            font-size: 14px;
            transition: all 0.2s;
        }
        .form-group input:focus {
            border-color: #f26723;
            box-shadow: 0 0 0 3px rgba(242, 103, 35, 0.15);
        }
        .btn-login {
            width: 100%;
            background: #f26723;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-family: 'Oswald', sans-serif;
            font-weight: 600;
            font-size: 16px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            cursor: pointer;
            transition: background 0.2s, box-shadow 0.2s;
            box-shadow: 0 4px 6px rgba(242, 103, 35, 0.25);
        }
        .btn-login:hover {
            background: #212121;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }
        .alert-error {
            background: #fef2f2;
            color: #b91c1c;
            padding: 11px 14px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 18px;
            border: 1px solid #fecaca;
            display: flex;
            align-items: center;
            gap: 8px;
        }
    </style>
</head>
<body>

<div class="login-box">
    <div class="brand-header">
        <img src="${pageContext.request.contextPath}/assets/img/site-logo.png" alt="Bleezy Logo" class="brand-logo"
             onerror="this.style.display='none'; document.getElementById('login-fallback-icon').style.display='block';">
        <i id="login-fallback-icon" class="fa-solid fa-solar-panel" style="display:none; font-size: 36px; color: #f26723; margin-bottom: 8px;"></i>
        <h2>BLEEZY SOLAR ADMIN</h2>
        <p>Hệ thống Quản trị Biến tần & Năng lượng Mặt trời</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert-error">
            <i class="fa-solid fa-circle-exclamation"></i> ${errorMessage}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/login" method="POST">
        <div class="form-group">
            <label for="username">TÊN ĐĂNG NHẬP</label>
            <input type="text" id="username" name="username" value="${param.username != null ? param.username : 'admin'}" required autofocus>
        </div>

        <div class="form-group">
            <label for="password">MẬT KHẨU</label>
            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu..." required>
        </div>

        <button type="submit" class="btn-login">
            <i class="fa-solid fa-right-to-bracket me-1"></i> ĐĂNG NHẬP HỆ THỐNG
        </button>
    </form>

    <div style="margin-top: 22px; text-align: center; border-top: 1px solid #f1f5f9; padding-top: 16px;">
        <a href="${pageContext.request.contextPath}/" style="font-size: 13px; color: #64748b; text-decoration: none;">
            <i class="fa-solid fa-arrow-left me-1"></i> Quay về Trang chủ Khách hàng
        </a>
    </div>
</div>

</body>
</html>
