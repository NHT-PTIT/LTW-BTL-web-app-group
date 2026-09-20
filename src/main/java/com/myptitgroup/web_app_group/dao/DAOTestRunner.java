package com.myptitgroup.web_app_group.dao;

import com.myptitgroup.web_app_group.model.Admin;
import com.myptitgroup.web_app_group.model.Category;
import com.myptitgroup.web_app_group.model.CompanyInfo;
import com.myptitgroup.web_app_group.model.Order;
import com.myptitgroup.web_app_group.model.Product;
import com.myptitgroup.web_app_group.model.TeamMember;
import java.util.List;
import java.util.Map;

/**
 * Runner kiểm thử độc lập cho toàn bộ các lớp DAO
 * Chạy trực tiếp (Run File / Shift+F6) trong NetBeans để kiểm tra tương tác với CSDL XAMPP.
 */
public class DAOTestRunner {

    public static void main(String[] args) {
        System.out.println("==================================================================");
        System.out.println("       KIỂM THỬ TOÀN DIỆN TẦNG DAO (DATA ACCESS OBJECTS)          ");
        System.out.println("==================================================================");

        int totalPassed = 0;
        int totalTests = 5;

        // 1. Kiểm tra CategoryDAO
        System.out.println("\n[TEST 1] Kiểm tra CategoryDAO (Cây danh mục đa cấp)...");
        try {
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Category> tree = categoryDAO.getCategoryTree();
            System.out.println("  -> Số danh mục gốc cấp 1: " + tree.size());
            for (Category root : tree) {
                System.out.println("     + [" + root.getId() + "] " + root.getName() + " (" + root.getSubCategories().size() + " danh mục con)");
                for (Category sub : root.getSubCategories()) {
                    System.out.println("        - [" + sub.getId() + "] " + sub.getName());
                }
            }
            if (!tree.isEmpty()) {
                System.out.println("  ==> PASSED!");
                totalPassed++;
            } else {
                System.err.println("  ==> FAILED: Chưa có dữ liệu categories trong DB.");
            }
        } catch (Exception e) {
            System.err.println("  ==> ERROR: " + e.getMessage());
        }

        // 2. Kiểm tra ProductDAO
        System.out.println("\n[TEST 2] Kiểm tra ProductDAO (Sản phẩm nổi bật, Gallery, Specs, Bộ lọc)...");
        try {
            ProductDAO productDAO = new ProductDAO();
            List<Product> featured = productDAO.getFeaturedProducts(4);
            System.out.println("  -> Số sản phẩm nổi bật: " + featured.size());

            // Lấy chi tiết sản phẩm 1
            Product p1 = productDAO.getById(1);
            if (p1 != null) {
                System.out.println("  -> Chi tiết SP 1: " + p1.getName());
                System.out.println("     - Giá bán: " + p1.getFormattedEffectivePrice());
                System.out.println("     - Số ảnh Gallery: " + p1.getGallery().size());
                System.out.println("     - Số thông số KT: " + p1.getSpecifications().size());
            }

            // Test bộ lọc đa tiêu chí (Lọc hãng Mitsubishi)
            List<Product> mitsubishiProducts = productDAO.filterProducts(null, "Mitsubishi", null, null, null, null, null, "price_asc", 1, 10);
            System.out.println("  -> Số sản phẩm lọc theo hãng 'Mitsubishi': " + mitsubishiProducts.size());

            // Test lấy danh sách hãng
            List<String> brands = productDAO.getAllBrands();
            System.out.println("  -> Danh sách thương hiệu hiện có: " + String.join(", ", brands));

            if (p1 != null && !featured.isEmpty()) {
                System.out.println("  ==> PASSED!");
                totalPassed++;
            } else {
                System.err.println("  ==> FAILED: Chưa có sản phẩm mẫu trong DB.");
            }
        } catch (Exception e) {
            System.err.println("  ==> ERROR: " + e.getMessage());
        }

        // 3. Kiểm tra OrderDAO
        System.out.println("\n[TEST 3] Kiểm tra OrderDAO (Đơn hàng & Thống kê)...");
        try {
            OrderDAO orderDAO = new OrderDAO();
            List<Order> orders = orderDAO.getOrders(null, null, 1, 5);
            System.out.println("  -> Số đơn hàng mẫu đọc được: " + orders.size());
            if (!orders.isEmpty()) {
                Order first = orderDAO.getOrderById(orders.get(0).getId());
                System.out.println("     - Đơn đầu tiên: " + first.getOrderCode() + " | Khách: " + first.getCustomerName() + " | Tổng tiền: " + first.getFormattedTotalAmount());
                System.out.println("     - Số mặt hàng trong đơn: " + first.getItems().size());
            }
            Map<String, Integer> stats = orderDAO.getOrderStatistics();
            System.out.println("  -> Thống kê trạng thái: " + stats);

            if (!orders.isEmpty()) {
                System.out.println("  ==> PASSED!");
                totalPassed++;
            } else {
                System.err.println("  ==> FAILED: Chưa có đơn hàng mẫu trong DB.");
            }
        } catch (Exception e) {
            System.err.println("  ==> ERROR: " + e.getMessage());
        }

        // 4. Kiểm tra AdminDAO (Xác thực đăng nhập)
        System.out.println("\n[TEST 4] Kiểm tra AdminDAO (Xác thực tài khoản Admin)...");
        try {
            AdminDAO adminDAO = new AdminDAO();
            // Test đăng nhập đúng với tài khoản seed ban đầu (hỗ trợ Admin@123 hoặc admin123)
            Admin validAdmin = adminDAO.authenticate("admin", "Admin@123");
            if (validAdmin == null) {
                validAdmin = adminDAO.authenticate("admin", "admin123");
            }
            // Test đăng nhập sai
            Admin invalidAdmin = adminDAO.authenticate("admin", "WrongPass123");

            if (validAdmin != null && invalidAdmin == null) {
                System.out.println("  -> Đăng nhập thành công với user: " + validAdmin.getUsername() + " (" + validAdmin.getFullName() + ")");
                System.out.println("  -> Đăng nhập mật khẩu sai: Bị từ chối chính xác!");
                System.out.println("  ==> PASSED!");
                totalPassed++;
            } else {
                System.err.println("  ==> FAILED: Xác thực đăng nhập chưa chính xác.");
            }
        } catch (Exception e) {
            System.err.println("  ==> ERROR: " + e.getMessage());
        }

        // 5. Kiểm tra CompanyInfoDAO & ContactDAO
        System.out.println("\n[TEST 5] Kiểm tra CompanyInfoDAO & ContactDAO...");
        try {
            CompanyInfoDAO compDAO = new CompanyInfoDAO();
            CompanyInfo info = compDAO.getCompanyInfo();
            List<TeamMember> team = compDAO.getActiveTeamMembers();
            if (info != null) {
                System.out.println("  -> Công ty: " + info.getCompanyName() + " | Hotline: " + info.getHotline());
            }
            System.out.println("  -> Số thành viên ban điều hành: " + team.size());

            ContactDAO contactDAO = new ContactDAO();
            int totalContacts = contactDAO.countInquiries(null);
            System.out.println("  -> Số liên hệ/tư vấn tiếp nhận: " + totalContacts);

            if (info != null && !team.isEmpty()) {
                System.out.println("  ==> PASSED!");
                totalPassed++;
            } else {
                System.err.println("  ==> FAILED: Chưa có thông tin công ty/nhân sự.");
            }
        } catch (Exception e) {
            System.err.println("  ==> ERROR: " + e.getMessage());
        }

        System.out.println("\n==================================================================");
        System.out.println("KẾT QUẢ KIỂM THỬ TỔNG QUAN: " + totalPassed + "/" + totalTests + " BÀI TEST THÀNH CÔNG");
        System.out.println("==================================================================");
    }
}
