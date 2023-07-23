package org.lut.servlet;

import org.lut.dao.DigitalGoodsDao;
import org.lut.entity.DigitalGoods;
import org.lut.entity.User;
import org.lut.util.JDBCUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "DetailServlet", urlPatterns = "/detail")
public class DetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取商品id
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            // 根据id获取商品信息
            DigitalGoods goods = DigitalGoodsDao.getDao().getGoodsInfo(id);
            response.setContentType("text/html;charset=utf-8");

            if (goods != null) {
                request.setAttribute("goods", goods);

                request.getRequestDispatcher("goodsDetail.jsp").forward(request, response);
            } else {
                response.getWriter().println("商品不存在");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
