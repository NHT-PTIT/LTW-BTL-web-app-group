package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.CategoryDAO;
import com.myptitgroup.web_app_group.dao.CompanyInfoDAO;
import com.myptitgroup.web_app_group.dao.ProductDAO;
import com.myptitgroup.web_app_group.model.Category;
import com.myptitgroup.web_app_group.model.CompanyInfo;
import com.myptitgroup.web_app_group.model.Product;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller xử lý luồng trang chủ (URL: /home, /index, /home-controller)
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home", "/home-controller", "/index"})
public class HomeServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final CompanyInfoDAO companyInfoDAO = new CompanyInfoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 1. Lấy danh sách sản phẩm nổi bật
        List<Product> featuredProducts = productDAO.getFeaturedProducts(8);

        // 2. Lấy danh sách sản phẩm mới nhất
        List<Product> latestProducts = productDAO.getLatestProducts(6);

        // 3. Lấy cây danh mục đa cấp phục vụ điều hướng
        List<Category> categoryTree = categoryDAO.getCategoryTree();

        // 4. Lấy thông tin công ty CMS
        CompanyInfo companyInfo = companyInfoDAO.getCompanyInfo();

        // 5. Đính kèm dữ liệu vào Request
        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("latestProducts", latestProducts);
        request.setAttribute("categoryTree", categoryTree);
        request.setAttribute("companyInfo", companyInfo);
        request.setAttribute("pageTitle", "Bleezy Security - Thiết Bị & Giải Pháp An Ninh Hàng Đầu");
        request.setAttribute("isHomeDataLoaded", true);

        // 6. Forward tới View index.jsp
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
