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
INSERT INTO `company_info` (`id`, `company_name`, `slogan`, `hotline`, `email`, `address`, `about_summary`, `about_detail`, `vision`, `mission`, `core_values`, `logo_url`) VALUES
(1, 
 'Công Ty TNHH Giải Pháp Cơ Điện PTIT Tech', 
 'Giải pháp truyền động & Tự động hóa công nghiệp hàng đầu', 
 '1900 6868 - 0988 123 456', 
 'contact@ptittech.vn', 
 'Km10 Đường Nguyễn Trãi, Q. Hà Đông, TP. Hà Nội',
 'PTIT Tech là đơn vị tiên phong phân phối thiết bị điện công nghiệp, biến tần, động cơ và giải pháp tự động hóa thông minh cho các nhà máy tại Việt Nam.',
 '<p>Được thành lập bởi đội ngũ kỹ sư tâm huyết từ Học viện Công nghệ Bưu chính Viễn thông, PTIT Tech tự hào mang đến các sản phẩm thiết bị truyền động, biến tần, PLC và khí cụ điện chính hãng từ các thương hiệu hàng đầu thế giới như Schneider Electric, Mitsubishi Electric, ABB, Siemens.</p><p>Chúng tôi cam kết chất lượng chuẩn quốc tế, bảo hành tận tâm 12-24 tháng và hỗ trợ kỹ thuật 24/7.</p>',
 'Trở thành nhà cung cấp giải pháp tự động hóa công nghiệp và thiết bị điện thông minh uy tín số 1 Việt Nam đến năm 2030.',
 'Cung cấp thiết bị chất lượng cao, tối ưu hóa năng lượng tiêu thụ cho doanh nghiệp sản xuất và đồng hành cùng tiến trình chuyển đổi số của các nhà máy.',
 'Chất lượng chuẩn mực - Tận tâm chuyên nghiệp - Đổi mới sáng tạo - Bền vững cùng khách hàng',
 'assets/img/site-logo.png'
);

-- 3. Đội ngũ nhân sự công ty (Team Members)
INSERT INTO `team_members` (`full_name`, `position`, `avatar_url`, `bio`, `email`, `sort_order`, `is_active`) VALUES
('TS. Nguyễn Văn An', 'Tổng Giám Đốc (CEO)', 'assets/img/team-1.jpg', 'Hơn 15 năm kinh nghiệm trong lĩnh vực Tự động hóa và Năng lượng tái tạo.', 'an.nguyen@ptittech.vn', 1, 1),
('ThS. Trần Thị Mai', 'Giám Đốc Kỹ Thuật (CTO)', 'assets/img/team-2.jpg', 'Chuyên gia tư vấn giải pháp truyền động biến tần công suất lớn cho nhà máy xi măng, dệt may.', 'mai.tran@ptittech.vn', 2, 1),
('Kỹ sư Lê Hoàng Nam', 'Trưởng Phòng Dịch Vụ Khách Hàng', 'assets/img/team-3.jpg', 'Chuyên gia đào tạo vận hành thiết bị Schneider, ABB và bảo trì hệ thống 24/7.', 'nam.le@ptittech.vn', 3, 1),
('Kỹ sư Phạm Quốc Huy', 'Chuyên Viên Tư Vấn Kỹ Thuật', 'assets/img/team-1.jpg', 'Hỗ trợ khách hàng lựa chọn thiết bị, tính toán tải động cơ và lập trình tích hợp.', 'huy.pham@ptittech.vn', 4, 1);

-- 4. Cây danh mục đa cấp (Categories: Cấp 1 và Cấp 2)
-- Danh mục cấp 1:
INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `description`, `image_url`, `sort_order`, `is_active`) VALUES
(1, NULL, 'Biến tần - Biến tốc', 'bien-tan-bien-toc', 'Thiết bị điều khiển tốc độ và tiết kiệm năng lượng động cơ', 'assets/img/product-1.jpg', 1, 1),
(2, NULL, 'Động cơ điện & Hộp số', 'dong-co-dien-hop-so', 'Động cơ 1 pha, 3 pha và động cơ servo công nghiệp', 'assets/img/product-2.jpg', 2, 1),
(3, NULL, 'Khí cụ điện & Đóng cắt', 'khi-cu-dien-dong-cat', 'Aptomat, Contactor, Rơ le nhiệt, Khởi động từ bảo vệ hệ thống', 'assets/img/product-3.jpg', 3, 1);

-- Danh mục cấp 2 (con của Biến tần):
INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `description`, `image_url`, `sort_order`, `is_active`) VALUES
(4, 1, 'Biến tần hạ thế (0.4kW - 15kW)', 'bien-tan-ha-the', 'Dành cho tải nhẹ và trung bình: băng tải, bơm, quạt nhỏ', NULL, 1, 1),
(5, 1, 'Biến tần công nghiệp nặng (>15kW)', 'bien-tan-cong-nghiep-nang', 'Dành cho cẩu trục, máy nén khí, máy đùn, máy nghiền', NULL, 2, 1),
(6, 1, 'Biến tần chuyên dụng Bơm/Quạt', 'bien-tan-chuyen-dung-bom-quat', 'Tích hợp chức năng điều khiển đa bơm và tối ưu điện năng', NULL, 3, 1);

-- Danh mục cấp 2 (con của Đóng cắt):
INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `description`, `image_url`, `sort_order`, `is_active`) VALUES
(7, 3, 'Aptomat khối MCCB', 'aptomat-khoi-mccb', 'Thiết bị đóng cắt bảo vệ quá tải và ngắn mạch', NULL, 1, 1),
(8, 3, 'Contactor - Khởi động từ', 'contactor-khoi-dong-tu', 'Thiết bị đóng ngắt mạch điện từ xa với độ bền cơ học cao', NULL, 2, 1);

-- 5. Danh sách Sản phẩm mẫu (Products)
INSERT INTO `products` (`id`, `category_id`, `sku`, `name`, `slug`, `brand`, `power_str`, `power_val`, `price`, `sale_price`, `stock_quantity`, `short_description`, `detail_description`, `main_image_url`, `is_featured`, `is_active`) VALUES
(1, 4, 'FR-D740-0.75K', 'Biến tần Mitsubishi FR-D740-0.75K-CHT (0.75kW 3P 380V)', 'bien-tan-mitsubishi-fr-d740-075k', 'Mitsubishi', '0.75 kW', 0.75, 4200000, 3850000, 25, 
 'Biến tần Mitsubishi dòng D700 kích thước siêu nhỏ gọn, độ tin cậy cao, phù hợp băng tải, máy đóng gói.', 
 '<p>Biến tần <strong>Mitsubishi FR-D740-0.75K</strong> là dòng biến tần tiêu chuẩn, tiết kiệm chi phí nhưng mang lại hiệu suất vận hành bền bỉ. Trang bị khả năng chịu quá tải 150% trong 60s, tích hợp sẵn cổng giao tiếp RS-485 và bộ điều khiển PID.</p>', 
 'assets/img/product-1.jpg', 1, 1),

(2, 4, 'ATV310HU22N4E', 'Biến tần Schneider ATV310 2.2kW 3 Pha 380V (3HP)', 'bien-tan-schneider-atv310-2-2kw', 'Schneider', '2.2 kW', 2.20, 5600000, 5200000, 18, 
 'Dòng Easy Altivar 310 của Schneider Electric được thiết kế tối ưu cho môi trường khắc nghiệt và phụ tải phổ thông.', 
 '<p>Biến tần <strong>Schneider ATV310HU22N4E</strong> có dải công suất 2.2kW (3HP), khả năng tản nhiệt vượt trội, phủ lớp bo mạch chống bụi bẩn, phù hợp cho máy dệt, máy chế biến gỗ, máy trộn công nghiệp.</p>', 
 'assets/img/product-2.jpg', 1, 1),

(3, 4, 'ACS355-03E-08A8-4', 'Biến tần ABB ACS355 4kW 3 Pha 380V (5.5HP)', 'bien-tan-abb-acs355-4kw', 'ABB', '4.0 kW', 4.00, 8900000, 8400000, 12, 
 'Biến tần cho máy chế tạo OEM chất lượng Thụy Sĩ, điều khiển sensorless vector chính xác.', 
 '<p>Biến tần <strong>ABB ACS355</strong> được ứng dụng rộng rãi trong các hệ thống đòi hỏi độ chính xác cao như cẩu trục nhỏ, máy cắt CNC, máy in bao bì. Hỗ trợ đầy đủ các module giao tiếp Modbus, Profibus, EtherCAT.</p>', 
 'assets/img/product-3.jpg', 1, 1),

(4, 5, 'FR-A840-15K', 'Biến tần Mitsubishi FR-A840-15K-1 (15kW 3P 380V)', 'bien-tan-mitsubishi-fr-a840-15k', 'Mitsubishi', '15.0 kW', 15.00, 29500000, 27900000, 8, 
 'Dòng cao cấp nhất của Mitsubishi, điều khiển vector từ thông tiên tiến, chịu tải nặng xuất sắc.', 
 '<p>Biến tần công nghiệp <strong>Mitsubishi FR-A840-15K</strong> sở hữu độ phân giải tốc độ siêu cao, kiểm soát lực kéo moment ở tốc độ 0 rpm, độ bền thiết kế linh kiện trên 10 năm vận hành liên tục.</p>', 
 'assets/img/product-4.jpg', 1, 1),

(5, 5, 'ATV630D22N4', 'Biến tần Schneider ATV630 22kW 3 Pha 380V Process', 'bien-tan-schneider-atv630-22kw', 'Schneider', '22.0 kW', 22.00, 42000000, 39500000, 5, 
 'Biến tần thông minh kết nối IoT Schneider Altivar Process, tích hợp đo lường điện năng chính xác.', 
 '<p><strong>Schneider Altivar Process ATV630</strong> chuyên dụng quản lý tối ưu hiệu suất bơm quạt và xử lý nước, giám sát qua Ethernet tích hợp sẵn cổng Web server theo dõi thời gian thực.</p>', 
 'assets/img/product-5.jpg', 0, 1),

(6, 5, 'ACS580-01-073A-4', 'Biến tần ABB ACS580 37kW 3 Pha 380V (50HP)', 'bien-tan-abb-acs580-37kw', 'ABB', '37.0 kW', 37.00, 68000000, 65000000, 4, 
 'Biến tần vạn năng đa năng của ABB, tích hợp bộ cuộn kháng giảm sóng hài bậc cao.', 
 '<p><strong>ABB ACS580</strong> mang lại sự tin cậy tuyệt đối, bảng điều khiển phụ trợ thông minh đa ngôn ngữ, hỗ trợ chức năng tự chuẩn đoán lỗi và lập lịch bảo trì định kỳ.</p>', 
 'assets/img/product-6.jpg', 1, 1),

(7, 7, 'EZC100N3100', 'Aptomat khối Schneider MCCB EZC100N 3P 100A 18kA', 'mccb-schneider-ezc100n-3p-100a', 'Schneider', 'N/A', NULL, 1250000, 1150000, 40, 
 'Aptomat đúc 3 pha dòng định mức 100A, dòng cắt ngắn mạch 18kA bảo vệ mạng điện phân phối.', 
 '<p>MCCB Schneider EasyPact EZC100N là sự lựa chọn tiêu chuẩn cho tủ điện phân phối hạ thế nhà xưởng và tòa nhà, tuân thủ tiêu chuẩn IEC 60947-2.</p>', 
 'assets/img/product-7.jpg', 0, 1),

(8, 8, 'S-T20-AC220V', 'Contactor Khởi động từ Mitsubishi S-T20 (20A Coil 220VAC)', 'contactor-mitsubishi-s-t20-220v', 'Mitsubishi', 'N/A', NULL, 480000, 420000, 60, 
 'Khởi động từ điều khiển động cơ 3 pha công suất tới 7.5kW, cuộn hút 220VAC hoạt động ổn định.', 
 '<p>Contactor Mitsubishi S-T20 với thiết kế tiếp điểm bạc chống hàn dính, kích thước thon gọn, tuổi thọ đóng cắt lên tới 1.5 triệu lần.</p>', 
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
(1, 'Công suất định mức', '0.75 kW (1.0 HP)', 1),
(1, 'Điện áp vào', '3 Pha 380 - 480 V, 50/60 Hz', 2),
(1, 'Dòng điện định mức', '2.2 A', 3),
(1, 'Khả năng quá tải', '150% trong 60 giây, 200% trong 0.5 giây', 4),
(1, 'Cấp độ bảo vệ', 'IP20', 5),
(1, 'Xuất xứ', 'Mitsubishi Electric - Nhật Bản / Lắp ráp Trung Quốc', 6),
(1, 'Thời gian bảo hành', '12 Tháng chính hãng', 7),

(2, 'Công suất định mức', '2.2 kW (3.0 HP)', 1),
(2, 'Điện áp vào', '3 Pha 380 - 460 V AC', 2),
(2, 'Dòng định mức ra', '5.5 A', 3),
(2, 'Giao thức truyền thông', 'Modbus RTU (RJ45)', 4),
(2, 'Xuất xứ', 'Schneider Electric - Pháp / Indonesia', 5),
(2, 'Thời gian bảo hành', '18 Tháng chính hãng', 6),

(4, 'Công suất định mức', '15.0 kW (20.0 HP)', 1),
(4, 'Điện áp vào', '3 Pha 380 - 500 V, 50/60 Hz', 2),
(4, 'Dải tần số điều khiển', '0.2 Hz đến 590 Hz', 3),
(4, 'Chế độ điều khiển', 'V/F, Advanced Magnetic Flux, Real Sensorless Vector', 4),
(4, 'Khối lượng', '14.5 kg', 5),
(4, 'Thời gian bảo hành', '24 Tháng chính hãng', 6);

-- 7.1. Danh sách Khách hàng mẫu (Users - Mật khẩu mặc định: 123456)
-- Mật khẩu băm SHA-256 của '123456': ba3253876aed6bc22d4a6ff53d8406e6ad92442c8de3563e0516ec0626ed514c
INSERT INTO `users` (`id`, `username`, `password_hash`, `full_name`, `email`, `phone`, `address`, `is_active`, `created_at`) VALUES
(1, 'thang.nd', 'ba3253876aed6bc22d4a6ff53d8406e6ad92442c8de3563e0516ec0626ed514c', 'Nguyễn Đức Thắng', 'thang.nd@gmail.com', '0912345678', 'Số 45 Lê Văn Lương, Trung Hòa, Cầu Giấy, Hà Nội', 1, '2026-09-15 08:30:00'),
(2, 'hoanggia_mech', 'ba3253876aed6bc22d4a6ff53d8406e6ad92442c8de3563e0516ec0626ed514c', 'Công ty Cơ Khí Hoàng Gia', 'hoanggia.mech@outlook.com', '0983112233', 'KCN Biên Hòa 2, TP. Biên Hòa, Đồng Nai', 1, '2026-09-16 11:20:00'),
(3, 'tuan.ptit', 'ba3253876aed6bc22d4a6ff53d8406e6ad92442c8de3563e0516ec0626ed514c', 'Vũ Minh Tuấn', 'tuanvm.ptit@gmail.com', '0977889900', 'Tòa nhà A2, Học viện Công nghệ BCVT, Hà Đông, Hà Nội', 1, '2026-09-17 15:45:00');

-- 8. Đơn hàng mẫu (Orders - Có đơn của thành viên và đơn khách vãng lai)
INSERT INTO `orders` (`id`, `order_code`, `user_id`, `customer_name`, `customer_phone`, `customer_email`, `shipping_address`, `note`, `total_amount`, `payment_method`, `status`, `created_at`) VALUES
(1, 'ORD-20260918-9102', 1, 'Nguyễn Đức Thắng', '0912345678', 'thang.nd@gmail.com', 'Số 45 Lê Văn Lương, Trung Hòa, Cầu Giấy, Hà Nội', 'Giao giờ hành chính, gọi trước khi giao 30 phút.', 3850000.00, 'COD', 'COMPLETED', '2026-09-18 10:15:00'),
(2, 'ORD-20260919-4821', 2, 'Công ty Cơ Khí Hoàng Gia (Anh Hùng)', '0983112233', 'hoanggia.mech@outlook.com', 'KCN Biên Hòa 2, TP. Biên Hòa, Đồng Nai', 'Xuất hóa đơn VAT cho công ty.', 27900000.00, 'BANK_TRANSFER', 'SHIPPING', '2026-09-19 14:30:00'),
(3, 'ORD-20260920-7734', 3, 'Vũ Minh Tuấn', '0977889900', 'tuanvm.ptit@gmail.com', 'Tòa nhà A2, Học viện Công nghệ BCVT, Hà Đông, Hà Nội', 'Cần tư vấn hỗ trợ kỹ thuật cài đặt tham số ban đầu.', 10400000.00, 'COD', 'PENDING', '2026-09-20 20:45:00');

-- 9. Chi tiết đơn hàng mẫu (Order Items)
INSERT INTO `order_items` (`order_id`, `product_id`, `product_sku`, `product_name`, `product_image`, `unit_price`, `quantity`, `subtotal`) VALUES
(1, 1, 'FR-D740-0.75K', 'Biến tần Mitsubishi FR-D740-0.75K-CHT (0.75kW 3P 380V)', 'assets/images/products/mit-d740-075.jpg', 3850000.00, 1, 3850000.00),
(2, 4, 'FR-A840-15K', 'Biến tần Mitsubishi FR-A840-15K-1 (15kW 3P 380V)', 'assets/images/products/mit-a840-15k.jpg', 27900000.00, 1, 27900000.00),
(3, 2, 'ATV310HU22N4E', 'Biến tần Schneider ATV310 2.2kW 3 Pha 380V (3HP)', 'assets/images/products/schneider-atv310-22.jpg', 5200000.00, 2, 10400000.00);

-- 10. Dữ liệu Liên hệ & Yêu cầu tư vấn mẫu (Contact Inquiries)
INSERT INTO `contact_inquiries` (`full_name`, `email`, `phone`, `subject`, `message`, `status`, `admin_notes`, `created_at`) VALUES
('Lê Đình Trọng', 'trong.ld@diencongnghiep.vn', '0903456789', 'Báo giá biến tần Schneider 22kW số lượng lớn', 'Chào công ty, chúng tôi đang chuẩn bị dự án nâng cấp trạm bơm xử lý nước, cần mua 05 bộ biến tần ATV630 22kW. Vui lòng gửi bảng báo giá và chiết khấu đại lý.', 'PROCESSING', 'Đã gọi điện tư vấn lần 1 lúc 09h sáng, hẹn gửi file báo giá qua email trong ngày.', '2026-09-19 08:30:00'),
('Phạm Thu Hà', 'thuha.nguyen@vinamech.com', '0944556677', 'Hỗ trợ kỹ thuật lỗi E.OV3 biến tần Mitsubishi', 'Biến tần bên em đang chạy máy dệt bị báo lỗi quá áp khi dừng máy (E.OV3). Nhờ các anh kỹ sư tư vấn giúp nguyên nhân và hướng xử lý.', 'NEW', NULL, '2026-09-20 16:10:00');
