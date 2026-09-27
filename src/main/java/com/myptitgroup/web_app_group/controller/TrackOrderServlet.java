package com.myptitgroup.web_app_group.controller;

import com.myptitgroup.web_app_group.dao.OrderDAO;
import com.myptitgroup.web_app_group.model.Order;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller tra cứu trạng thái đơn hàng cho khách vãng lai (URL: /track-order)
 * Cho phép khách tìm kiếm theo Mã đơn hàng (order_code) hoặc Số điện thoại đặt hàng.
 */
@WebServlet(name = "TrackOrderServlet", urlPatterns = {"/track-order"})
public class TrackOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String query = request.getParameter("q");
        if (query == null || query.trim().isEmpty()) {
            query = request.getParameter("keyword");
        }
        if (query == null || query.trim().isEmpty()) {
            query = request.getParameter("orderCode");
        }
        if (query == null || query.trim().isEmpty()) {
            query = request.getParameter("code");
        }
        if (query == null || query.trim().isEmpty()) {
            query = request.getParameter("phone");
        }

        if (query != null) {
            query = query.trim();
        }

        if (query != null && !query.isEmpty()) {
            String searchKey = query;
            if (searchKey.startsWith("#")) {
                searchKey = searchKey.substring(1).trim();
            }

            List<Order> orders = orderDAO.getOrders(null, searchKey, 1, 10);
            for (Order o : orders) {
                o.setItems(orderDAO.getOrderItems(o.getId()));
            }
            request.setAttribute("orders", orders);
            request.setAttribute("searchedQuery", query);
            request.setAttribute("hasSearched", true);
        }

        request.setAttribute("pageTitle", "Tra cứu đơn hàng - Bleezy Security");
        request.getRequestDispatcher("/track-order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
