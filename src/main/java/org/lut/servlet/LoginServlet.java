package org.lut.servlet;

import org.lut.dao.UserDao;
import org.lut.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String phoneNum = request.getParameter("phoneNum");
        String password = request.getParameter("password");

        try {
            if (UserDao.getDao().checkToLogin(phoneNum, password)) {
                System.out.println("登录成功");
                request.setAttribute("user", UserDao.getDao().getUser(phoneNum));
                request.getRequestDispatcher("main.jsp").forward(request, response);
            } else {
                System.out.println("登录失败");
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().print("<script>alert('手机号或密码错误');window.location.href='login.html'</script>");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
