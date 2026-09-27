package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.CategoryDAO;
import com.myptitgroup.web_app_group.dao.ProductDAO;
import com.myptitgroup.web_app_group.model.Category;
import com.myptitgroup.web_app_group.model.Product;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller xử lý danh mục sản phẩm, bộ lọc, tìm kiếm và phân trang (URL: /shop, /products)
 */
@WebServlet(name = "ShopServlet", urlPatterns = {"/shop", "/products"})
public class ShopServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 1. Tiếp nhận các tham số bộ lọc từ Request
        String catParam = request.getParameter("categoryId");
        if (catParam == null || catParam.isEmpty()) {
            catParam = request.getParameter("cid");
        }
        Integer categoryId = null;
        if (catParam != null && !catParam.trim().isEmpty()) {
            try {
                categoryId = Integer.parseInt(catParam.trim());
            } catch (NumberFormatException ignored) {}
        }

        String brand = request.getParameter("brand");
        if (brand != null && brand.trim().isEmpty()) {
            brand = null;
        }

        String minPriceStr = request.getParameter("minPrice");
        Double minPrice = null;
        if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
            try {
                minPrice = Double.parseDouble(minPriceStr.trim());
            } catch (NumberFormatException ignored) {}
        }

        String maxPriceStr = request.getParameter("maxPrice");
        Double maxPrice = null;
        if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
            try {
                maxPrice = Double.parseDouble(maxPriceStr.trim());
            } catch (NumberFormatException ignored) {}
        }

        String keyword = request.getParameter("keyword");
        if (keyword == null || keyword.trim().isEmpty()) {
            keyword = request.getParameter("q");
        }
        if (keyword != null) {
            keyword = keyword.trim();
            if (keyword.isEmpty()) {
                keyword = null;
            }
        }

        String sort = request.getParameter("sort");
        if (sort == null || sort.trim().isEmpty()) {
            sort = "newest";
        }

        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageParam.trim());
                if (page < 1) page = 1;
            } catch (NumberFormatException ignored) {}
        }

        int pageSize = 9;

        // 2. Truy vấn dữ liệu từ DAO
        List<Product> productList = productDAO.filterProducts(
            categoryId, brand, minPrice, maxPrice, null, null, keyword, sort, page, pageSize
        );
        int totalCount = productDAO.countFilteredProducts(
            categoryId, brand, minPrice, maxPrice, null, null, keyword
        );
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        if (totalPages < 1) totalPages = 1;

        List<Category> categories = categoryDAO.getAllActive();
        List<String> brands = productDAO.getAllBrands();
        List<Product> featuredSidebar = productDAO.getFeaturedProducts(3);

        // 3. Đưa dữ liệu vào Request Attributes
        request.setAttribute("productList", productList);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.setAttribute("featuredSidebar", featuredSidebar);

        javax.servlet.http.HttpSession session = request.getSession(false);
        com.myptitgroup.web_app_group.model.User currentUser = (session != null) ? (com.myptitgroup.web_app_group.model.User) session.getAttribute("currentUser") : null;
        if (currentUser != null) {
            com.myptitgroup.web_app_group.dao.WishlistDAO wishlistDAO = new com.myptitgroup.web_app_group.dao.WishlistDAO();
            request.setAttribute("wishlistProductIds", wishlistDAO.getWishlistProductIds(currentUser.getId()));
        }

        // Giữ lại trạng thái bộ lọc trên UI
        request.setAttribute("selectedCategoryId", categoryId);
        request.setAttribute("selectedBrand", brand);
        request.setAttribute("selectedMinPrice", minPrice);
        request.setAttribute("selectedMaxPrice", maxPrice);
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedSort", sort);
        request.setAttribute("isShopDataLoaded", true);

        // Tiêu đề động
        String pageTitle = "Cửa hàng thiết bị an ninh - Bleezy Security";
        if (categoryId != null) {
            Category currentCat = categoryDAO.getById(categoryId);
            if (currentCat != null) {
                pageTitle = currentCat.getName() + " - Bleezy Store";
                request.setAttribute("currentCategory", currentCat);
            }
        }
        request.setAttribute("pageTitle", pageTitle);

        // 4. Forward tới View shop.jsp
        request.getRequestDispatcher("/shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
