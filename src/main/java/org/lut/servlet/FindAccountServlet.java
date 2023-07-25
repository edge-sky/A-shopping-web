package org.lut.servlet;

import org.lut.dao.UserDao;
import org.lut.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "FindAccountServlet", urlPatterns = "/findAccount")
public class FindAccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String userName = request.getParameter("userName");
        String phoneNum = request.getParameter("phoneNum");
        String email = request.getParameter("email");
        String password = request.getParameter("resetPassword");

        try {
            if (!UserDao.getDao().findIfInBD(userName, phoneNum, email)) {
                System.out.println("找不到用户");
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().print("<script>alert('账号未注册');window.location.href='findAccount.html'</script>");
                return;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        int result;
        try {
            result = UserDao.getDao().modfiy(phoneNum, userName, email, password);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (result == 1) {
            System.out.println("修改成功");
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().print("<script>alert('修改成功，点击确定返回登录');window.location.href='login.html'</script>");
        } else {
            System.out.println("修改失败");
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().print("<script>alert('修改失败');window.location.href='findAccount.html'</script>");
        }
    }
}
