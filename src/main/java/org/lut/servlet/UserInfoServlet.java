package org.lut.servlet;

import org.lut.dao.DigitalGoodsDao;
import org.lut.dao.UserDao;
import org.lut.entity.DigitalGoods;
import org.lut.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UserInfoServlet", urlPatterns = "/userInfo")
public class UserInfoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String phoneNum = request.getParameter("phoneNum");

        try {

            User user = UserDao.getDao().getUser(phoneNum);
            response.setContentType("text/html;charset=utf-8");

            if (user != null) {
                request.setAttribute("userInfo", user);

                request.getRequestDispatcher("userInfo.jsp").forward(request, response);
            } else {
                response.getWriter().println("用户不存在");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
