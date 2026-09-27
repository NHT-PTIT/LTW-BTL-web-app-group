-- ==============================================================================
-- DỰ ÁN BÀI TẬP NHÓM - LẬP TRÌNH WEB (INT1434) - PTIT
-- DATABASE SCHEMA & INITIAL DATA SCRIPT
-- Hệ quản trị CSDL: MySQL 8.x / MariaDB 10.x
-- Bảng mã ký tự: utf8mb4 (Hỗ trợ tiếng Việt và biểu tượng)
-- ==============================================================================

DROP DATABASE IF EXISTS `web_app_group_db`;
CREATE DATABASE `web_app_group_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `web_app_group_db`;

-- ------------------------------------------------------------------------------
-- 1. BẢNG ADMIN / USERS (Quản trị viên & Phân quyền)
-- ------------------------------------------------------------------------------
CREATE TABLE `admins` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password_hash` VARCHAR(255) NOT NULL COMMENT 'Mã hóa BCrypt hoặc SHA-256 kèm Salt',
    `full_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `phone` VARCHAR(20) NULL,
    `role` VARCHAR(20) NOT NULL DEFAULT 'ADMIN' COMMENT 'ADMIN, SUPER_ADMIN',
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `last_login` DATETIME NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 1.1. BẢNG USERS / KHÁCH HÀNG (Customer Accounts)
-- ------------------------------------------------------------------------------
CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password_hash` VARCHAR(255) NOT NULL COMMENT 'Mã hóa SHA-256 an toàn',
    `full_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `phone` VARCHAR(20) NULL,
    `address` VARCHAR(255) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'TRUE = Đang hoạt động, FALSE = Bị khóa',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX `idx_users_username` ON `users` (`username`);
CREATE INDEX `idx_users_email` ON `users` (`email`);

-- ------------------------------------------------------------------------------
-- 2. BẢNG CMS - THÔNG TIN CÔNG TY (Company Info)
-- ------------------------------------------------------------------------------
CREATE TABLE `company_info` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `company_name` VARCHAR(255) NOT NULL,
    `slogan` VARCHAR(255) NULL,
    `hotline` VARCHAR(50) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `about_summary` TEXT NULL COMMENT 'Tóm tắt giới thiệu trang chủ',
    `about_detail` LONGTEXT NULL COMMENT 'Bài viết giới thiệu chi tiết trang About',
    `vision` TEXT NULL COMMENT 'Tầm nhìn phát triển',
    `mission` TEXT NULL COMMENT 'Sứ mệnh',
    `core_values` TEXT NULL COMMENT 'Giá trị cốt lõi',
    `logo_url` VARCHAR(255) NULL,
    `facebook_url` VARCHAR(255) NULL,
    `youtube_url` VARCHAR(255) NULL,
    `working_hours` VARCHAR(100) NULL DEFAULT 'Thứ 2 - Thứ 7: 08:00 - 17:30',
    `bank_name` VARCHAR(100) NULL DEFAULT 'MBBank' COMMENT 'Tên ngân hàng thụ hưởng (VietQR)',
    `bank_account_no` VARCHAR(50) NULL DEFAULT '0988123456' COMMENT 'Số tài khoản ngân hàng (VietQR)',
    `bank_account_name` VARCHAR(100) NULL DEFAULT 'CTY TNHH BLEEZY SECURITY' COMMENT 'Tên chủ tài khoản thụ hưởng (VietQR)',
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 3. BẢNG CMS - ĐỘI NGŨ NHÂN SỰ (Team Members)
-- ------------------------------------------------------------------------------
CREATE TABLE `team_members` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `full_name` VARCHAR(100) NOT NULL,
    `position` VARCHAR(100) NOT NULL COMMENT 'Chức vụ: Giám đốc, Kỹ sư trưởng, v.v.',
    `avatar_url` VARCHAR(255) NULL,
    `bio` TEXT NULL COMMENT 'Tiểu sử / Giới thiệu ngắn',
    `email` VARCHAR(100) NULL,
    `sort_order` INT NOT NULL DEFAULT 0,
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 4. BẢNG DANH MỤC SẢN PHẨM ĐA CẤP (Categories - Self-referencing)
-- ------------------------------------------------------------------------------
CREATE TABLE `categories` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `parent_id` INT NULL COMMENT 'FK tới chính categories.id để tạo danh mục đa cấp (NULL = cấp 1)',
    `name` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(120) NOT NULL UNIQUE,
    `description` TEXT NULL,
    `image_url` VARCHAR(255) NULL,
    `sort_order` INT NOT NULL DEFAULT 0,
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_categories_parent` FOREIGN KEY (`parent_id`) 
        REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 5. BẢNG SẢN PHẨM (Products)
-- ------------------------------------------------------------------------------
CREATE TABLE `products` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `category_id` INT NOT NULL,
    `sku` VARCHAR(50) NOT NULL UNIQUE COMMENT 'Mã sản phẩm duy nhất',
    `name` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(270) NOT NULL UNIQUE,
    `brand` VARCHAR(100) NOT NULL COMMENT 'Hãng sản xuất: Mitsubishi, Schneider, ABB, ...',
    `power_str` VARCHAR(50) NULL COMMENT 'Công suất hiển thị: 0.75kW, 5.5kW, 15kW, 50kVA',
    `power_val` DECIMAL(8,2) NULL COMMENT 'Giá trị số công suất (kW) để lọc theo khoảng giá trị',
    `price` DECIMAL(12,2) NOT NULL COMMENT 'Giá niêm yết',
    `sale_price` DECIMAL(12,2) NULL COMMENT 'Giá khuyến mãi (nếu có)',
    `stock_quantity` INT NOT NULL DEFAULT 0,
    `short_description` VARCHAR(500) NULL,
    `detail_description` LONGTEXT NULL,
    `main_image_url` VARCHAR(255) NULL COMMENT 'Ảnh đại diện chính hiển thị danh sách',
    `is_featured` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Sản phẩm nổi bật trang chủ',
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `views_count` INT NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) 
        REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Thêm chỉ mục tìm kiếm và lọc tối ưu
CREATE INDEX `idx_products_brand` ON `products` (`brand`);
CREATE INDEX `idx_products_price` ON `products` (`price`);
CREATE INDEX `idx_products_power_val` ON `products` (`power_val`);
CREATE INDEX `idx_products_category` ON `products` (`category_id`);

-- ------------------------------------------------------------------------------
-- 6. BẢNG THƯ VIỆN ẢNH SẢN PHẨM (Product Images Gallery)
-- ------------------------------------------------------------------------------
CREATE TABLE `product_images` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `product_id` INT NOT NULL,
    `image_url` VARCHAR(255) NOT NULL,
    `is_primary` BOOLEAN NOT NULL DEFAULT FALSE,
    `sort_order` INT NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_product_images_product` FOREIGN KEY (`product_id`) 
        REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 7. BẢNG THÔNG SỐ KỸ THUẬT SẢN PHẨM (Product Specifications)
-- ------------------------------------------------------------------------------
CREATE TABLE `product_specs` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `product_id` INT NOT NULL,
    `spec_name` VARCHAR(100) NOT NULL COMMENT 'Tên thông số: Điện áp, Dòng điện, Kích thước, Cấp bảo vệ...',
    `spec_value` VARCHAR(255) NOT NULL COMMENT 'Giá trị: 3 Pha 380-480V, IP54, 250x180x150mm...',
    `sort_order` INT NOT NULL DEFAULT 0,
    CONSTRAINT `fk_product_specs_product` FOREIGN KEY (`product_id`) 
        REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 8. BẢNG ĐƠN HÀNG (Orders - Hỗ trợ Guest Checkout không cần tạo tài khoản)
-- ------------------------------------------------------------------------------
CREATE TABLE `orders` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `order_code` VARCHAR(30) NOT NULL UNIQUE COMMENT 'Mã đơn sinh tự động, ví dụ: ORD-20260920-A1B2',
    `user_id` INT NULL COMMENT 'Khóa ngoại tới users.id nếu khách hàng đã đăng nhập (NULL nếu là khách vãng lai)',
    `customer_name` VARCHAR(100) NOT NULL,
    `customer_phone` VARCHAR(20) NOT NULL,
    `customer_email` VARCHAR(100) NOT NULL,
    `shipping_address` VARCHAR(255) NOT NULL,
    `note` TEXT NULL,
    `total_amount` DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    `coupon_code` VARCHAR(50) NULL COMMENT 'Mã khuyến mãi đã áp dụng',
    `discount_amount` DECIMAL(12,2) NOT NULL DEFAULT 0.00 COMMENT 'Số tiền được giảm giá',
    `payment_method` VARCHAR(30) NOT NULL DEFAULT 'COD' COMMENT 'COD, BANK_TRANSFER',
    `status` VARCHAR(30) NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING (Chờ xử lý), SHIPPING (Đang giao), COMPLETED (Hoàn thành), CANCELLED (Đã hủy)',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) 
        REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX `idx_orders_status` ON `orders` (`status`);
CREATE INDEX `idx_orders_phone` ON `orders` (`customer_phone`);
CREATE INDEX `idx_orders_created_at` ON `orders` (`created_at`);

-- ------------------------------------------------------------------------------
-- 9. BẢNG CHI TIẾT ĐƠN HÀNG (Order Items)
-- ------------------------------------------------------------------------------
CREATE TABLE `order_items` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `order_id` INT NOT NULL,
    `product_id` INT NULL COMMENT 'Để NULL nếu sản phẩm gốc sau này bị gỡ bỏ',
    `product_sku` VARCHAR(50) NOT NULL COMMENT 'Snapshot mã SKU lúc mua',
    `product_name` VARCHAR(255) NOT NULL COMMENT 'Snapshot tên sản phẩm lúc mua',
    `product_image` VARCHAR(255) NULL COMMENT 'Snapshot ảnh sản phẩm lúc mua',
    `unit_price` DECIMAL(12,2) NOT NULL COMMENT 'Đơn giá thực tế thời điểm đặt',
    `quantity` INT NOT NULL DEFAULT 1,
    `subtotal` DECIMAL(12,2) NOT NULL COMMENT 'unit_price * quantity',
    CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) 
        REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) 
        REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 10. BẢNG LIÊN HỆ & YÊU CẦU TƯ VẤN (Contact Inquiries)
-- ------------------------------------------------------------------------------
CREATE TABLE `contact_inquiries` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `full_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(20) NOT NULL,
    `subject` VARCHAR(200) NULL,
    `message` TEXT NOT NULL,
    `status` VARCHAR(30) NOT NULL DEFAULT 'NEW' COMMENT 'NEW (Mới tiếp nhận), PROCESSING (Đang liên hệ), RESOLVED (Đã xử lý)',
    `admin_notes` TEXT NULL COMMENT 'Ghi chú của quản trị viên khi xử lý yêu cầu',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 11. BẢNG MÃ GIẢM GIÁ / VOUCHER (Coupons)
-- ------------------------------------------------------------------------------
CREATE TABLE `coupons` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `code` VARCHAR(50) NOT NULL UNIQUE COMMENT 'Mã voucher (VD: SECURITY2026, GIAM500K)',
    `description` VARCHAR(255) NULL COMMENT 'Mô tả chi tiết chương trình ưu đãi',
    `discount_type` VARCHAR(20) NOT NULL DEFAULT 'PERCENT' COMMENT 'PERCENT (giảm theo %) hoặc FIXED (giảm số tiền)',
    `discount_value` DECIMAL(12,2) NOT NULL COMMENT 'Giá trị giảm (VD: 10% hoặc 500,000đ)',
    `min_order_amount` DECIMAL(12,2) NOT NULL DEFAULT 0.00 COMMENT 'Giá trị đơn hàng tối thiểu để áp dụng voucher',
    `max_discount_amount` DECIMAL(12,2) NULL COMMENT 'Số tiền giảm tối đa (nếu là dạng PERCENT)',
    `usage_limit` INT NOT NULL DEFAULT 100 COMMENT 'Tổng lượt dùng tối đa của toàn hệ thống',
    `used_count` INT NOT NULL DEFAULT 0 COMMENT 'Số lượt đã sử dụng thực tế',
    `start_date` DATETIME NULL COMMENT 'Thời điểm bắt đầu áp dụng',
    `end_date` DATETIME NULL COMMENT 'Thời điểm hết hạn voucher',
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'TRUE = Đang hiệu lực, FALSE = Tạm khóa',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX `idx_coupons_code` ON `coupons` (`code`);

-- ------------------------------------------------------------------------------
-- 12. BẢNG ĐÁNH GIÁ & NHẬN XÉT SẢN PHẨM (Product Reviews & Ratings)
-- ------------------------------------------------------------------------------
CREATE TABLE `product_reviews` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `product_id` INT NOT NULL,
    `user_id` INT NULL COMMENT 'FK tới users.id nếu đã đăng nhập (NULL nếu đánh giá vãng lai)',
    `customer_name` VARCHAR(100) NOT NULL,
    `customer_email` VARCHAR(100) NULL,
    `rating` TINYINT NOT NULL COMMENT 'Số sao đánh giá từ 1 đến 5',
    `comment` TEXT NOT NULL COMMENT 'Nội dung nhận xét chi tiết về sản phẩm',
    `is_approved` BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'TRUE = Đã duyệt hiển thị, FALSE = Chờ duyệt/Ẩn',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_reviews_product` FOREIGN KEY (`product_id`) 
        REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_reviews_user` FOREIGN KEY (`user_id`) 
        REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX `idx_reviews_product_id` ON `product_reviews` (`product_id`);

-- ------------------------------------------------------------------------------
-- 13. BẢNG SẢN PHẨM YÊU THÍCH (Wishlists)
-- ------------------------------------------------------------------------------
CREATE TABLE `wishlists` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `unique_user_wishlist_product` (`user_id`, `product_id`),
    CONSTRAINT `fk_wishlist_user` FOREIGN KEY (`user_id`) 
        REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_wishlist_product` FOREIGN KEY (`product_id`) 
        REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- ==============================================================================
-- PHẦN DỮ LIỆU KHỞI TẠO MẪU (SEED DATA)
-- ==============================================================================

-- 1. Tài khoản Quản trị viên mặc định:
-- + Tài khoản 1:
--   - Tên đăng nhập (Username): admin
--   - Mật khẩu (Password): admin123 (hoặc Admin@123)
--   - Phân quyền: SUPER_ADMIN
-- + Tài khoản 2:
--   - Tên đăng nhập (Username): bleezy
--   - Mật khẩu (Password): 123456
--   - Phân quyền: ADMIN
INSERT INTO `admins` (`id`, `username`, `password_hash`, `full_name`, `email`, `phone`, `role`, `is_active`) VALUES
(1, 'admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Quản trị viên Hệ thống', 'admin@myptitgroup.vn', '0987654321', 'SUPER_ADMIN', 1),
(2, 'bleezy', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'Kỹ Sư Quản Trị Bleezy', 'bleezy@ptittech.vn', '0912345678', 'ADMIN', 1);

-- 2. Dữ liệu thông tin công ty (CMS)
INSERT INTO `company_info` (`id`, `company_name`, `slogan`, `hotline`, `email`, `address`, `about_summary`, `about_detail`, `vision`, `mission`, `core_values`, `logo_url`, `bank_name`, `bank_account_no`, `bank_account_name`) VALUES
(1, 
 'Công Ty TNHH Giải Pháp Công Nghệ & Thiết Bị An Ninh Bleezy', 
 'Giải pháp giám sát thông minh & Thiết bị an ninh toàn diện hàng đầu', 
 '1900 6868 - 0988 123 456', 
 'contact@bleezysecurity.vn', 
 'Km10 Đường Nguyễn Trãi, Q. Hà Đông, TP. Hà Nội',
 'Bleezy Security là đơn vị tiên phong phân phối camera giám sát, khóa thông minh, hệ thống kiểm soát ra vào và giải pháp an ninh công nghệ cao tại Việt Nam.',
 '<p>Được thành lập bởi đội ngũ kỹ sư tâm huyết từ Học viện Công nghệ Bưu chính Viễn thông, Bleezy Security tự hào mang đến các sản phẩm camera giám sát CCTV, khóa cửa điện tử Face ID, hệ thống kiểm soát ra vào sinh trắc học và cảnh báo chống trộm thông minh từ các thương hiệu hàng đầu thế giới như Hikvision, Dahua, Ezviz, Imou, Uniview, Bosch, Panasonic, Philips, Kaadas.</p><p>Chúng tôi cam kết chất lượng chuẩn quốc tế, bảo hành tận tâm 12-24 tháng và hỗ trợ kỹ thuật 24/7.</p>',
 'Trở thành nhà cung cấp giải pháp an ninh thông minh và thiết bị giám sát công nghệ AI uy tín số 1 Việt Nam đến năm 2030.',
 'Cung cấp thiết bị an ninh chất lượng cao, bảo vệ tối đa an toàn tính mạng và tài sản cho hộ gia đình, cơ quan, tòa nhà và nhà máy sản xuất.',
 'An toàn tuyệt đối - Công nghệ tiên phong - Tận tâm chuyên nghiệp - Đồng hành bền vững',
 'assets/img/site-logo.png',
 'MBBank',
 '0988123456',
 'CTY TNHH BLEEZY SECURITY'
);

-- 3. Đội ngũ nhân sự công ty (Team Members)
INSERT INTO `team_members` (`full_name`, `position`, `avatar_url`, `bio`, `email`, `sort_order`, `is_active`) VALUES
('TS. Nguyễn Văn An', 'Tổng Giám Đốc (CEO)', 'assets/img/team-1.jpg', 'Hơn 15 năm kinh nghiệm trong lĩnh vực Hệ thống Viễn thông & Giải pháp An ninh Thông minh.', 'an.nguyen@bleezysecurity.vn', 1, 1),
('ThS. Trần Thị Mai', 'Giám Đốc Kỹ Thuật (CTO)', 'assets/img/team-2.jpg', 'Chuyên gia tư vấn giải pháp Camera AI nhận diện khuôn mặt và an ninh tòa nhà thông minh.', 'mai.tran@bleezysecurity.vn', 2, 1),
('Kỹ sư Lê Hoàng Nam', 'Trưởng Phòng Dịch Vụ Khách Hàng', 'assets/img/team-3.jpg', 'Chuyên gia đào tạo triển khai thiết bị Hikvision, Dahua, Bosch và hỗ trợ kỹ thuật 24/7.', 'nam.le@bleezysecurity.vn', 3, 1),
('Kỹ sư Phạm Quốc Huy', 'Chuyên Viên Giải Pháp An Ninh', 'assets/img/team-1.jpg', 'Hỗ trợ khảo sát hiện trường, thiết kế giải pháp kiểm soát ra vào sinh trắc học và báo động.', 'huy.pham@bleezysecurity.vn', 4, 1);

-- 4. Cây danh mục đa cấp (Categories: Cấp 1 và Cấp 2)
-- Danh mục cấp 1:
INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `description`, `image_url`, `sort_order`, `is_active`) VALUES
(1, NULL, 'Camera Giám Sát & CCTV', 'camera-giam-sat-cctv', 'Camera IP, Camera Analog HD, Camera AI thông minh và đầu ghi hình', 'assets/img/product-1.jpg', 1, 1),
(2, NULL, 'Khóa Cửa Thông Minh & Smart Lock', 'khoa-cua-thong-minh', 'Khóa vân tay, thẻ từ, mã số, nhận diện khuôn mặt 3D Face ID', 'assets/img/product-2.jpg', 2, 1),
(3, NULL, 'Kiểm Soát Ra Vào & Báo Động', 'kiem-soat-ra-vao-bao-dong', 'Máy chấm công, chuông cửa có hình, cảm biến chống trộm, báo cháy', 'assets/img/product-3.jpg', 3, 1);

-- Danh mục cấp 2 (con của Camera Giám Sát):
INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `description`, `image_url`, `sort_order`, `is_active`) VALUES
(4, 1, 'Camera IP & Wifi Không Dây', 'camera-ip-wifi', 'Dành cho gia đình, cửa hàng: xoay 360 độ, đàm thoại 2 chiều, xem qua điện thoại', NULL, 1, 1),
(5, 1, 'Camera PTZ & Dự Án Ngoài Trời', 'camera-ptz-ngoai-troi', 'Dành cho biệt thự, nhà xưởng, giao thông: zoom quang học, chuẩn IP67', NULL, 2, 1),
(6, 1, 'Đầu Ghi Hình NVR / DVR 4K', 'dau-ghi-hinh-nvr-dvr', 'Đầu ghi 4/8/16/32 kênh chuẩn nén H.265+, hỗ trợ ổ cứng lưu trữ dài ngày', NULL, 3, 1);

-- Danh mục cấp 2 (con của Khóa cửa thông minh):
INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `description`, `image_url`, `sort_order`, `is_active`) VALUES
(7, 2, 'Khóa Cửa Nhận Diện Khuôn Mặt Face ID', 'khoa-face-id', 'Khóa thông minh nhận diện khuôn mặt 3D không chạm, camera chuông hình', NULL, 1, 1),
(8, 3, 'Máy Chấm Công & Kiểm Soát Cửa', 'may-cham-cong-kiem-soat-cua', 'Máy quét vân tay, khuôn mặt và thẻ cảm ứng kiểm soát an ninh cửa', NULL, 2, 1);

-- 5. Danh sách Sản phẩm mẫu (Products)
INSERT INTO `products` (`id`, `category_id`, `sku`, `name`, `slug`, `brand`, `power_str`, `power_val`, `price`, `sale_price`, `stock_quantity`, `short_description`, `detail_description`, `main_image_url`, `is_featured`, `is_active`) VALUES
(1, 4, 'DS-2CD2043G2-I', 'Camera IP Thân Trụ Hikvision DS-2CD2043G2-I (4MP, WDR 120dB, IP67)', 'camera-ip-hikvision-ds-2cd2043g2-i', 'Hikvision', '4.0 MP 2K', 4.00, 1850000, 1650000, 35, 
 'Camera IP thân trụ 4MP AcuSense lọc báo động giả người và phương tiện, chuẩn chống nước IP67 chuyên dụng ngoài trời.', 
 '<p>Camera IP <strong>Hikvision DS-2CD2043G2-I</strong> sở hữu cảm biến CMOS 1/3 inch độ phân giải 4.0 Megapixel (2560 &times; 1440), công nghệ chống ngược sáng thực WDR 120dB cho hình ảnh rõ nét trong mọi điều kiện ánh sáng.</p><p>Trang bị thuật toán Deep Learning AcuSense phân loại đối tượng chính xác, tầm xa hồng ngoại ban đêm 30m, hỗ trợ thẻ nhớ micro SD lên đến 256GB và chuẩn nén siêu tiết kiệm băng thông H.265+.</p>', 
 'assets/img/product-1.jpg', 1, 1),

(2, 5, 'DH-SD49225XA-HNR', 'Camera PTZ Quay Quét Dahua DH-SD49225XA-HNR (2MP, Zoom Quang 25X, AI)', 'camera-ptz-dahua-dh-sd49225xa-hnr', 'Dahua', 'Zoom 25X 2MP', 2.00, 8900000, 8200000, 12, 
 'Camera PTZ tốc độ cao tích hợp AI Starlight giám sát tầm xa lên tới 100m, bảo vệ chu vi thông minh.', 
 '<p>Camera PTZ <strong>Dahua DH-SD49225XA-HNR</strong> là dòng camera chuyên dụng cho khu đô thị, nhà xưởng và công trình lớn. Ống kính zoom quang học 25X (4.8 mm–120 mm) cho phép phóng to chi tiết biển số xe và khuôn mặt ở khoảng cách xa.</p><p>Hỗ trợ công nghệ Starlight cho độ nhạy sáng cực thấp, tính năng Auto Tracking bám theo mục tiêu và phát hiện xâm nhập hàng rào ảo thông minh.</p>', 
 'assets/img/product-2.jpg', 1, 1),

(3, 4, 'EZVIZ-C6N-PRO-3MP', 'Camera Wifi Không Dây Ezviz C6N Pro (3MP 2K, Xoay 360°, Đàm Thoại 2 Chiều)', 'camera-wifi-ezviz-c6n-pro-3mp', 'Ezviz', '3.0 MP 2K', 3.00, 850000, 690000, 50, 
 'Camera wifi thông minh trong nhà xoay 360 độ, độ phân giải 2K sắc nét, đàm thoại 2 chiều và cảnh báo chuyển động.', 
 '<p>Camera không dây <strong>Ezviz C6N Pro 3MP</strong> mang lại khả năng bao quát toàn cảnh không góc chết với góc xoay ngang 350° và dọc 55°. Tích hợp AI phát hiện dáng người thông minh, tự động theo dõi chuyển động và gửi thông báo tức thời về điện thoại.</p><p>Chế độ riêng tư một chạm và hỗ trợ đàm thoại hai chiều rõ ràng với mic lọc tiếng ồn.</p>', 
 'assets/img/product-3.jpg', 1, 1),

(4, 6, 'DS-7616NI-K2', 'Đầu Ghi Hình NVR 16 Kênh Hikvision DS-7616NI-K2 (Hỗ Trợ 2 Ổ Cứng 4K)', 'dau-ghi-hinh-nvr-hikvision-ds-7616ni-k2', 'Hikvision', '16 Kênh 4K', 16.00, 3600000, 3250000, 15, 
 'Đầu ghi hình mạng 16 kênh chuẩn nén H.265+, xuất hình cổng HDMI độ phân giải 4K Ultra HD.', 
 '<p>Đầu ghi NVR <strong>Hikvision DS-7616NI-K2</strong> hỗ trợ kết nối tối đa 16 camera IP độ phân giải lên đến 8MP (4K). Băng thông đầu vào 160Mbps, hỗ trợ 2 ổ cứng dung lượng lên tới 8TB mỗi ổ.</p><p>Tương thích giao thức ONVIF tiêu chuẩn, hỗ trợ dịch vụ đám mây Hik-Connect xem trực tiếp và xem lại mượt mà từ mọi nơi.</p>', 
 'assets/img/product-4.jpg', 1, 1),

(5, 7, 'PHILIPS-DDL702-FVP', 'Khóa Cửa Thông Minh Face ID Philips DDL702-FVP (Nhận Diện Khuôn Mặt 3D)', 'khoa-cua-thong-minh-philips-ddl702-fvp', 'Philips', '3D Face ID', 1.00, 16500000, 14800000, 8, 
 'Khóa thông minh cao cấp mở khóa khuôn mặt 3D Face ID không chạm, tích hợp camera chuông hình quan sát qua App.', 
 '<p><strong>Philips DDL702-FVP</strong> là dòng khóa cửa thông minh cao cấp nhất của thương hiệu Philips. Ứng dụng công nghệ quét gương mặt 3D mô phỏng ánh sáng cấu trúc, nhận diện chính xác kể cả trong bóng tối và chống giả mạo bằng ảnh chụp/video.</p><p>Màn hình IPS 3.5 inch trong nhà hiển thị khách bấm chuông, kết nối Wifi xem trực tiếp và mở cửa từ xa qua điện thoại.</p>', 
 'assets/img/product-5.jpg', 1, 1),

(6, 7, 'KAADAS-S500-C', 'Khóa Vân Tay Cao Cấp Kaadas S500-C (Vân Tay FPC Thụy Điển, Thẻ Từ)', 'khoa-van-tay-kaadas-s500-c', 'Kaadas', 'FPC Thụy Điển', 1.00, 5200000, 4650000, 20, 
 'Khóa cửa vân tay công nghệ bảo mật Đức, cảm biến FPC Thụy Điển nhận diện siêu tốc 0.5s trên tay nắm.', 
 '<p>Khóa điện tử <strong>Kaadas S500-C</strong> hỗ trợ đa dạng phương thức mở khóa: Vân tay, Mã số, Thẻ từ, Chìa cơ và Bluetooth. Chức năng mã số ảo chống nhìn trộm, thân khóa bằng hợp kim nguyên khối chống cắt phá và tính năng cảnh báo cạy cửa an toàn.</p>', 
 'assets/img/product-6.jpg', 0, 1),

(7, 8, 'RONALD-JACK-FA210', 'Máy Chấm Công & Kiểm Soát Khuôn Mặt Ronald Jack FA210 (Khuôn Mặt + Vân Tay)', 'may-cham-cong-ronald-jack-fa210', 'Ronald Jack', '1500 Face', 1.00, 3800000, 3450000, 25, 
 'Thiết bị chấm công kiểm soát cửa đa năng: 1.500 khuôn mặt, 2.000 vân tay, cổng TCP/IP xuất báo cáo tự động.', 
 '<p><strong>Ronald Jack FA210</strong> tích hợp chip xử lý thế hệ mới cho tốc độ nhận diện dưới 1 giây. Màn hình màu cảm ứng TFT 2.8 inch giao diện tiếng Việt thân thiện, tích hợp relay kết nối khóa từ kiểm soát cửa ra vào văn phòng.</p>', 
 'assets/img/product-7.jpg', 0, 1),

(8, 8, 'PANASONIC-VL-SV74VN', 'Chuông Cửa Có Hình Màn Hình 7 Inch Panasonic VL-SV74VN (Camera Góc Rộng)', 'chuong-cua-co-hinh-panasonic-vl-sv74vn', 'Panasonic', '7 Inch LCD', 7.00, 4850000, 4350000, 18, 
 'Bộ chuông hình Panasonic màn hình màu 7 inch, camera nút bấm chống nước IP54 và lưu hình ảnh khách ghé thăm.', 
 '<p>Bộ chuông cửa <strong>Panasonic VL-SV74VN</strong> gồm màn hình chính 7 inch chất lượng Nhật Bản và nút chuông camera góc nhìn siêu rộng 1.3MP. Tự động chụp và lưu 400 hình ảnh khách bấm chuông, hỗ trợ đổi giọng nói bảo vệ người già và trẻ nhỏ.</p>', 
 'assets/img/product-1.jpg', 0, 1);

-- 6. Thư viện ảnh chi tiết sản phẩm (Product Images Gallery)
INSERT INTO `product_images` (`product_id`, `image_url`, `is_primary`, `sort_order`) VALUES
(1, 'assets/img/product-1.jpg', 1, 1),
(1, 'assets/img/product-2.jpg', 0, 2),
(1, 'assets/img/product-3.jpg', 0, 3),

(2, 'assets/img/product-2.jpg', 1, 1),
(2, 'assets/img/product-4.jpg', 0, 2),
(2, 'assets/img/product-5.jpg', 0, 3),

(3, 'assets/img/product-3.jpg', 1, 1),
(3, 'assets/img/product-6.jpg', 0, 2),

(4, 'assets/img/product-4.jpg', 1, 1),
(4, 'assets/img/product-7.jpg', 0, 2);

-- 7. Thông số kỹ thuật chi tiết của sản phẩm (Product Specifications)
INSERT INTO `product_specs` (`product_id`, `spec_name`, `spec_value`, `sort_order`) VALUES
(1, 'Độ phân giải hình ảnh', '4.0 Megapixel (2560 x 1440 @ 25fps)', 1),
(1, 'Cảm biến hình ảnh', '1/3 inch Progressive Scan CMOS', 2),
(1, 'Tầm xa hồng ngoại ban đêm', '30 mét Smart IR', 3),
(1, 'Công nghệ xử lý hình ảnh', 'Chống ngược sáng thực WDR 120dB, 3D DNR, BLC', 4),
(1, 'Tính năng AI AcuSense', 'Phân loại người & phương tiện, giảm báo động giả 95%', 5),
(1, 'Cấp bảo vệ chống nước', 'IP67 chống bụi nước ngoài trời', 6),
(1, 'Thời gian bảo hành', '24 Tháng chính hãng', 7),

(2, 'Độ phân giải & Zoom', '2.0 Megapixel Full HD 1080P, Zoom quang học 25X', 1),
(2, 'Tầm nhìn ban đêm Starlight', 'Hồng ngoại thông minh lên tới 100 mét', 2),
(2, 'Tốc độ quay quét', 'Ngang 360° vô tận (tốc độ 240°/s), Dọc -15° đến 90°', 3),
(2, 'Tính năng thông minh AI', 'Auto Tracking bám đối tượng, Nhận diện khuôn mặt', 4),
(2, 'Chuẩn nén video', 'H.265+ / H.265 / H.264+ tiết kiệm 80% lưu trữ', 5),
(2, 'Thời gian bảo hành', '24 Tháng chính hãng', 6),

(5, 'Phương thức mở khóa', '3D Face ID, Vân tay, Mã số, Thẻ từ, Chìa cơ, App Mobile', 1),
(5, 'Công nghệ nhận diện mặt', 'Cảm biến gương mặt 3D cấu trúc ánh sáng (Khoảng cách 0.4 - 1.0m)', 2),
(5, 'Màn hình quan sát', 'IPS 3.5 inch màu sắc nét bên trong cửa', 3),
(5, 'Dung lượng lưu trữ', '20 Khuôn mặt, 100 Vân tay, 100 Mã số, 100 Thẻ từ', 4),
(5, 'Nguồn điện sử dụng', 'Pin sạc Lithium 5000mAh (Dùng 4-6 tháng / lần sạc)', 5),
(5, 'Thời gian bảo hành', '24 Tháng chính hãng Philips', 6);

-- 7.1. Danh sách Khách hàng mẫu (Users - Mật khẩu mặc định: 123456)
-- Mật khẩu băm SHA-256 của '123456': ba3253876aed6bc22d4a6ff53d8406e6ad92442c8de3563e0516ec0626ed514c
INSERT INTO `users` (`id`, `username`, `password_hash`, `full_name`, `email`, `phone`, `address`, `is_active`, `created_at`) VALUES
(1, 'thang.nd', 'ba3253876aed6bc22d4a6ff53d8406e6ad92442c8de3563e0516ec0626ed514c', 'Nguyễn Đức Thắng', 'thang.nd@gmail.com', '0912345678', 'Số 45 Lê Văn Lương, Trung Hòa, Cầu Giấy, Hà Nội', 1, '2026-09-15 08:30:00'),
(2, 'hoanggia_mech', 'ba3253876aed6bc22d4a6ff53d8406e6ad92442c8de3563e0516ec0626ed514c', 'Công ty Xây Dựng Hoàng Gia', 'hoanggia.sec@outlook.com', '0983112233', 'KCN Biên Hòa 2, TP. Biên Hòa, Đồng Nai', 1, '2026-09-16 11:20:00'),
(3, 'tuan.ptit', 'ba3253876aed6bc22d4a6ff53d8406e6ad92442c8de3563e0516ec0626ed514c', 'Vũ Minh Tuấn', 'tuanvm.ptit@gmail.com', '0977889900', 'Tòa nhà A2, Học viện Công nghệ BCVT, Hà Đông, Hà Nội', 1, '2026-09-17 15:45:00');

-- 8. Đơn hàng mẫu (Orders - Có đơn của thành viên và đơn khách vãng lai)
INSERT INTO `orders` (`id`, `order_code`, `user_id`, `customer_name`, `customer_phone`, `customer_email`, `shipping_address`, `note`, `total_amount`, `coupon_code`, `discount_amount`, `payment_method`, `status`, `created_at`) VALUES
(1, 'ORD-20260918-9102', 1, 'Nguyễn Đức Thắng', '0912345678', 'thang.nd@gmail.com', 'Số 45 Lê Văn Lương, Trung Hòa, Cầu Giấy, Hà Nội', 'Giao giờ hành chính, gọi trước khi giao 30 phút.', 1650000.00, NULL, 0.00, 'COD', 'COMPLETED', '2026-09-18 10:15:00'),
(2, 'ORD-20260919-4821', 2, 'Công ty Xây Dựng Hoàng Gia (Anh Hùng)', '0983112233', 'hoanggia.sec@outlook.com', 'KCN Biên Hòa 2, TP. Biên Hòa, Đồng Nai', 'Xuất hóa đơn VAT cho công ty kèm biên bản bàn giao.', 13800000.00, 'GIAM1TR', 1000000.00, 'BANK_TRANSFER', 'SHIPPING', '2026-09-19 14:30:00'),
(3, 'ORD-20260920-7734', 3, 'Vũ Minh Tuấn', '0977889900', 'tuanvm.ptit@gmail.com', 'Tòa nhà A2, Học viện Công nghệ BCVT, Hà Đông, Hà Nội', 'Cần kỹ thuật hỗ trợ hướng dẫn kết nối camera vào app điện thoại.', 3250000.00, NULL, 0.00, 'COD', 'PENDING', '2026-09-20 20:45:00');

-- 9. Chi tiết đơn hàng mẫu (Order Items)
INSERT INTO `order_items` (`order_id`, `product_id`, `product_sku`, `product_name`, `product_image`, `unit_price`, `quantity`, `subtotal`) VALUES
(1, 1, 'DS-2CD2043G2-I', 'Camera IP Thân Trụ Hikvision DS-2CD2043G2-I (4MP, WDR 120dB, IP67)', 'assets/img/product-1.jpg', 1650000.00, 1, 1650000.00),
(2, 5, 'PHILIPS-DDL702-FVP', 'Khóa Cửa Thông Minh Face ID Philips DDL702-FVP (Nhận Diện Khuôn Mặt 3D)', 'assets/img/product-5.jpg', 14800000.00, 1, 14800000.00),
(3, 4, 'DS-7616NI-K2', 'Đầu Ghi Hình NVR 16 Kênh Hikvision DS-7616NI-K2 (Hỗ Trợ 2 Ổ Cứng 4K)', 'assets/img/product-4.jpg', 3250000.00, 1, 3250000.00);

-- 10. Dữ liệu Liên hệ & Yêu cầu tư vấn mẫu (Contact Inquiries)
INSERT INTO `contact_inquiries` (`full_name`, `email`, `phone`, `subject`, `message`, `status`, `admin_notes`, `created_at`) VALUES
('Lê Đình Trọng', 'trong.ld@diennhe.vn', '0903456789', 'Báo giá trọn gói 16 Camera Hikvision 4MP cho nhà xưởng', 'Chào công ty, chúng tôi đang chuẩn bị dự án nâng cấp hệ thống an ninh nhà xưởng 2000m2 tại KCN Quế Võ. Vui lòng gửi bảng báo giá thiết bị và chi phí nhân công lắp đặt.', 'PROCESSING', 'Đã gọi điện tư vấn lần 1 lúc 09h sáng, hẹn gửi file báo giá thiết kế chi tiết qua email trong ngày.', '2026-09-19 08:30:00'),
('Phạm Thu Hà', 'thuha.nguyen@vinasmart.com', '0944556677', 'Tư vấn lắp đặt khóa cửa Face ID Philips cho biệt thự', 'Tôi muốn lắp 3 bộ khóa nhận diện khuôn mặt Philips cho biệt thự tại Vinhomes Riverside. Nhờ kỹ thuật tư vấn dòng khóa phù hợp với cửa gỗ lim.', 'NEW', NULL, '2026-09-20 16:10:00');

-- 11. Dữ liệu Mã giảm giá / Voucher mẫu (Coupons)
INSERT INTO `coupons` (`id`, `code`, `description`, `discount_type`, `discount_value`, `min_order_amount`, `max_discount_amount`, `usage_limit`, `used_count`, `start_date`, `end_date`, `is_active`) VALUES
(1, 'SECURITY2026', 'Ưu đãi giải pháp an ninh gia đình - Giảm 10% tối đa 2.000.000đ cho đơn từ 3.000.000đ', 'PERCENT', 10.00, 3000000.00, 2000000.00, 200, 15, '2026-01-01 00:00:00', '2026-12-31 23:59:59', 1),
(2, 'GIAM500K', 'Tri ân khách hàng thân thiết - Giảm ngay 500.000đ trực tiếp cho đơn từ 5.000.000đ', 'FIXED', 500000.00, 5000000.00, NULL, 100, 8, '2026-01-01 00:00:00', '2026-12-31 23:59:59', 1),
(3, 'CAMERAPRO', 'Chiết khấu đặc quyền đối tác dự án camera - Giảm 15% tối đa 5.000.000đ', 'PERCENT', 15.00, 10000000.00, 5000000.00, 50, 4, '2026-01-01 00:00:00', '2026-12-31 23:59:59', 1);

-- 12. Dữ liệu Đánh giá & Nhận xét sản phẩm mẫu (Product Reviews)
INSERT INTO `product_reviews` (`product_id`, `user_id`, `customer_name`, `customer_email`, `rating`, `comment`, `is_approved`, `created_at`) VALUES
(1, 1, 'Nguyễn Đức Thắng (Quản lý tòa nhà)', 'thang.nd@gmail.com', 5, 'Camera Hikvision 4MP độ nét cực cao, tính năng AI AcuSense lọc báo động chuẩn xác không bị báo ảo khi lá cây rung hay mưa gió. Hàng chính hãng bảo hành uy tín.', 1, '2026-09-18 14:20:00'),
(1, 2, 'Hoàng Văn Hùng (Kỹ sư MEP)', 'hung.hoang@hoanggia.vn', 5, 'Hàng full CO/CQ, tem hãng chuẩn chỉ. Kỹ thuật Bleezy hỗ trợ cấu hình qua Ultraviewer rất nhiệt tình và chuyên nghiệp!', 1, '2026-09-19 09:15:00'),
(3, 3, 'Vũ Minh Tuấn', 'tuanvm.ptit@gmail.com', 5, 'Camera Ezviz C6N Pro góc xoay 360 rất tiện theo dõi con nhỏ và người già ở nhà, loa đàm thoại to rõ không bị rè. Đáng đồng tiền!', 1, '2026-09-21 10:00:00'),
(5, NULL, 'Trần Quốc Đạt (Chủ biệt thự)', 'dat.tran@vinahome.com', 5, 'Khóa Philips Face ID mở cực nhạy, đứng trước cửa chưa tới 1s là đã mở, camera chuông hình gửi ảnh về điện thoại siêu nét. Rất hài lòng!', 1, '2026-09-22 16:30:00');

-- 13. Dữ liệu Danh sách Yêu thích mẫu (Wishlists)
INSERT INTO `wishlists` (`user_id`, `product_id`, `created_at`) VALUES
(1, 2, '2026-09-18 10:20:00'),
(1, 5, '2026-09-18 10:25:00'),
(2, 1, '2026-09-19 14:35:00');
