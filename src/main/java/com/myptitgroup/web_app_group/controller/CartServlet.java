package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.ProductDAO;
import com.myptitgroup.web_app_group.model.Cart;
import com.myptitgroup.web_app_group.model.Product;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Controller xử lý luồng Giỏ hàng (URL: /cart, /cart-action)
 * Quản lý thêm, cập nhật số lượng, xóa và làm sạch giỏ hàng trong HttpSession.
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart", "/cart-action"})
public class CartServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/cart-action".equals(path)) {
            processAction(request, response);
            return;
        }

        // Truy cập /cart -> Hiển thị trang giỏ hàng
        HttpSession session = request.getSession(true);
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String msg = request.getParameter("msg");
        if ("added".equals(msg)) {
            request.setAttribute("alertSuccess", "Sản phẩm đã được thêm vào giỏ hàng thành công!");
        } else if ("updated".equals(msg)) {
            request.setAttribute("alertSuccess", "Giỏ hàng đã được cập nhật số lượng mới!");
        } else if ("removed".equals(msg)) {
            request.setAttribute("alertInfo", "Đã xóa sản phẩm khỏi giỏ hàng.");
        } else if ("cleared".equals(msg)) {
            request.setAttribute("alertInfo", "Đã xóa toàn bộ sản phẩm khỏi giỏ hàng.");
        } else if ("empty_cart".equals(msg)) {
            request.setAttribute("alertWarning", "Giỏ hàng của bạn đang trống. Vui lòng chọn sản phẩm trước khi thanh toán!");
        }

        request.setAttribute("pageTitle", "Giỏ hàng của bạn - Bleezy Inverter & Solar Power");
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processAction(request, response);
    }

    private void processAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(true);
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "view";
        }

        boolean isAjax = "1".equals(request.getParameter("ajax")) || 
                         "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"));

        switch (action) {
            case "add": {
                int productId = getIntParam(request, "productId", 0);
                int quantity = getIntParam(request, "quantity", 1);
                if (quantity < 1) quantity = 1;

                Product product = productDAO.getById(productId);
                if (product != null) {
                    cart.add(product, quantity);

                    if (isAjax) {
                        response.setContentType("application/json;charset=UTF-8");
                        PrintWriter out = response.getWriter();
                        out.print(String.format(
                            "{\"status\":\"success\",\"message\":\"Đã thêm %s vào giỏ hàng!\",\"totalQuantity\":%d,\"totalAmount\":\"%s\"}",
                            escapeJson(product.getName()), cart.getTotalQuantity(), cart.getFormattedTotalAmount()
                        ));
                        out.flush();
                        return;
                    }

                    // Nếu khách bấm nút "Mua ngay"
                    if ("1".equals(request.getParameter("buyNow"))) {
                        response.sendRedirect(request.getContextPath() + "/checkout");
                        return;
                    }

                    response.sendRedirect(request.getContextPath() + "/cart?msg=added");
                    return;
                }
                break;
            }

            case "update": {
                int productId = getIntParam(request, "productId", 0);
                int quantity = getIntParam(request, "quantity", 1);
                cart.update(productId, quantity);

                if (isAjax) {
                    response.setContentType("application/json;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.print(String.format(
                        "{\"status\":\"success\",\"totalQuantity\":%d,\"totalAmount\":\"%s\"}",
                        cart.getTotalQuantity(), cart.getFormattedTotalAmount()
                    ));
                    out.flush();
                    return;
                }

                response.sendRedirect(request.getContextPath() + "/cart?msg=updated");
                return;
            }

            case "remove": {
                int productId = getIntParam(request, "productId", 0);
                cart.remove(productId);
                response.sendRedirect(request.getContextPath() + "/cart?msg=removed");
                return;
            }

            case "clear": {
                cart.clear();
                response.sendRedirect(request.getContextPath() + "/cart?msg=cleared");
                return;
            }

            default:
                break;
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private int getIntParam(HttpServletRequest request, String paramName, int defaultValue) {
        String val = request.getParameter(paramName);
        if (val != null && !val.trim().isEmpty()) {
            try {
                return Integer.parseInt(val.trim());
            } catch (NumberFormatException ignored) {}
        }
        return defaultValue;
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}
