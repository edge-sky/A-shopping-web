package org.lut.dao;

import org.lut.entity.User;
import org.lut.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {

    // 单例模式
    private static UserDao dao;

    private UserDao() {
        // TODO Auto-generated constructor stub
    }

    public static UserDao getDao() {

        if (dao == null) {
            dao = new UserDao();
        }
        return dao;
    }

    // 注册账号
    public int addUser(User user) throws SQLException {
        // 链接数据库
        Connection con = JDBCUtil.connect();

        // 操作数据库
        // 建立新增记录的sql语句
        String sql = "insert into user_info(user_name, phone_number, email, gender, password, money) value(?, ?, ?, ?, ?, ?)";
        // 使用链接对象，预加载sql语句
        PreparedStatement pst = con.prepareStatement(sql);
        // 填充要记录的数据
        pst.setString(1, user.getUserName());
        pst.setString(2, user.getPhoneNum());
        pst.setString(3, user.getEmail());
        pst.setString(4, user.getGender());
        pst.setString(5, user.getPassword());
        pst.setBigDecimal(6, user.getMoney());
        // 正式执行sql语句，将记录填入表中
        int result = pst.executeUpdate();

        // 关闭数据库
        JDBCUtil.close();

        return result;
    }

    // 在数据库中寻找是否相同的姓名、电话、邮箱
    public boolean findIfInDB(String name, String phoneNum, String email) throws SQLException {
        Connection con = JDBCUtil.connect();
        String sql = "select user_name, phone_number, email from user_info";

        ResultSet rs = con.createStatement().executeQuery(sql);

        while (rs.next()) {
            if (name.equals(rs.getString("user_name")) || phoneNum.equals(rs.getString("phone_number")) || email.equals(rs.getString("email"))) {
                return true;
            }
        }
        return false;
    }

    // 登录账户
    public boolean checkToLogin(String phoneNum, String password) throws SQLException {
        Connection con = JDBCUtil.connect();
        String sql = "select phone_number, password from user_info";

        ResultSet rs = con.createStatement().executeQuery(sql);

        while (rs.next()) {
            if (phoneNum.equals(rs.getString("phone_number")) && password.equals(rs.getString("password"))) {
                JDBCUtil.close();
                return true;
            }
        }
        JDBCUtil.close();
        return false;
    }

    // 导入账户信息
    public User getUser(String phoneNum) throws SQLException {
        User user = new User();

        Connection con = JDBCUtil.connect();
        // 根据登录的手机号获取账户信息
        String sql = "select ID, user_name, phone_number, email, gender, password, money from user_info where phone_number = '" + phoneNum + "'";
        ResultSet rs = con.createStatement().executeQuery(sql);

        while (rs.next()) {
            user.setId(rs.getInt("ID"));
            user.setUserName(rs.getString("user_name"));
            user.setPhoneNum(rs.getString("phone_number"));
            user.setEmail(rs.getString("email"));
            user.setGender(rs.getString("gender"));
            user.setPassword(rs.getString("password"));
            user.setMoney(rs.getBigDecimal("money"));
        }

        JDBCUtil.close();

        return user;
    }

    // 修改用户密码
    public int modfiy(String phoneNum, String name, String email, String password) throws SQLException {
        Connection con = JDBCUtil.connect();

        String sql = "update user_info set password='"+ password +"' where phone_number='"+ phoneNum +"' and user_name='"+ name +"' and email='"+ email +"'";
        con.createStatement().executeUpdate(sql);

        String sqlFindPassword = "select password from user_info where phone_number='"+ phoneNum +"'";
        ResultSet rs = con.createStatement().executeQuery(sqlFindPassword);
        rs.next();
        if (rs.getString("password").equals(password)) {
            return 1;
        }

        // 关闭数据库
        JDBCUtil.close();

        return 0;
    }
}
