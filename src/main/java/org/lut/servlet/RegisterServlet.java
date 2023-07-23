package org.lut.servlet;

import org.lut.dao.UserDao;
import org.lut.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String userName = request.getParameter("userName");
        String phoneNum = request.getParameter("phoneNum");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        System.out.println(userName + email + phoneNum + gender + password + confirm);

        try {
            if (UserDao.getDao().findIfInBD(userName, phoneNum, email)) {
                System.out.println("已注册");
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().print("<script>alert('姓名、手机号或邮箱已注册')</script>;window.location.href='register.html'</script>");
                return;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        User user = new User();
        user.setUserName(userName);
        user.setPhoneNum(phoneNum);
        user.setEmail(email);
        user.setGender(gender);
        user.setPassword(password);

        int result = -1;
        try {
            result = UserDao.getDao().addUser(user);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (result > 0) {
            System.out.println("注册成功");
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().print("<script>alert('注册成功,点击确定返回登录');window.location.href='login.html'</script>");
        } else {
            System.out.println("注册失败");
        }
    }
}
