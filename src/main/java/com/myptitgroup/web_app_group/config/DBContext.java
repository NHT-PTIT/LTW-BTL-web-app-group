package com.myptitgroup.web_app_group.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * Lớp quản lý kết nối CSDL MySQL (JDBC) cho toàn bộ ứng dụng.
 * Đọc cấu hình từ src/main/resources/db.properties hoặc sử dụng cấu hình mặc định XAMPP.
 */
public class DBContext {

    private static String driver = "com.mysql.cj.jdbc.Driver";
    private static String url = "jdbc:mysql://localhost:3306/web_app_group_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Ho_Chi_Minh&useSSL=false&allowPublicKeyRetrieval=true";
    private static String user = "root";
    private static String password = "";

    // Nạp cấu hình từ file db.properties khi class được load
    static {
        try (InputStream input = DBContext.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input != null) {
                Properties prop = new Properties();
                prop.load(input);
                if (prop.getProperty("db.driver") != null) {
                    driver = prop.getProperty("db.driver").trim();
                }
                if (prop.getProperty("db.url") != null) {
                    url = prop.getProperty("db.url").trim();
                }
                if (prop.getProperty("db.user") != null) {
                    user = prop.getProperty("db.user").trim();
                }
                if (prop.getProperty("db.password") != null) {
                    password = prop.getProperty("db.password").trim();
                }
            } else {
                System.out.println("[DBContext] Không tìm thấy db.properties trong classpath, sử dụng cấu hình mặc định.");
            }
            // Nạp JDBC Driver
            Class.forName(driver);
        } catch (Exception e) {
            System.err.println("[DBContext] Cảnh báo khi khởi tạo: " + e.getMessage());
        }
    }

    /**
     * Lấy đối tượng kết nối Connection tới MySQL
     * @return Connection
     * @throws SQLException nếu kết nối thất bại
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Không tìm thấy MySQL Driver: " + driver, e);
        }
        return DriverManager.getConnection(url, user, password);
    }

    /**
     * Đóng an toàn các tài nguyên JDBC (Connection, Statement, ResultSet)
     * Tránh thất thoát bộ nhớ (resource leak) trong quá trình hoạt động
     */
    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException ignored) {}
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException ignored) {}
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ignored) {}
        }
    }

    /**
     * Hàm main hỗ trợ kiểm tra kết nối (Test Connection) trực tiếp trong IDE
     */
    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println("  KIỂM TRA KẾT NỐI MYSQL TRÊN XAMPP (DBContext)");
        System.out.println("==================================================");
        System.out.println("URL:  " + url);
        System.out.println("User: " + user);

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            System.out.println("\n[THÀNH CÔNG] Kết nối tới MySQL thành công!");

            // Kiểm tra thông tin phiên bản
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT DATABASE() AS current_db, VERSION() AS mysql_version");
            if (rs.next()) {
                System.out.println("CSDL hiện tại : " + rs.getString("current_db"));
                System.out.println("Phiên bản MySQL: " + rs.getString("mysql_version"));
            }
            rs.close();

            // Kiểm tra số lượng sản phẩm và danh mục đã nạp từ init.sql
            rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM products");
            if (rs.next()) {
                System.out.println("Số sản phẩm mẫu đã nạp trong DB: " + rs.getInt("total"));
            }
            rs.close();

            rs = stmt.executeQuery("SELECT COUNT(*) AS total FROM categories");
            if (rs.next()) {
                System.out.println("Số danh mục mẫu đã nạp trong DB: " + rs.getInt("total"));
            }
            rs.close();

            System.out.println("\n-> Toàn bộ cấu hình kết nối CSDL đã sẵn sàng cho ứng dụng!");

        } catch (SQLException e) {
            System.err.println("\n[LỖI KẾT NỐI] Không thể kết nối tới MySQL!");
            System.err.println("Chi tiết lỗi: " + e.getMessage());
            System.err.println("\n--- GỢI Ý KHẮC PHỤC ---");
            if (e.getMessage().contains("Communications link failure") || e.getMessage().contains("Connection refused")) {
                System.err.println("1. Bạn đã ấn 'Start' module MySQL trong XAMPP Control Panel chưa?");
                System.err.println("2. Kiểm tra lại cổng MySQL trong XAMPP (nếu không phải 3306, hãy sửa lại trong db.properties).");
            } else if (e.getMessage().contains("Access denied")) {
                System.err.println("1. Kiểm tra lại mật khẩu user 'root' của MySQL trong file src/main/resources/db.properties.");
            } else if (e.getMessage().contains("Unknown database")) {
                System.err.println("1. Chưa tạo cơ sở dữ liệu 'web_app_group_db'.");
                System.err.println("2. Vui lòng mở phpMyAdmin hoặc MySQL Workbench và chạy file 'database/init.sql'!");
            }
        } finally {
            close(conn, stmt, rs);
        }
    }
}
