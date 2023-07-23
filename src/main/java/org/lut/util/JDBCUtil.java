package org.lut.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// 加载Mysql数据库驱动
public class JDBCUtil {
	static{
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	// 建立java与数据库的连接
	private static Connection  con = null;// 数据库和java的连接对象

	// 建立项目的数据库和java项目的操作链接
	public static  Connection  connect(){
		// 127.0.0.1:3306 本地IP地址:端口号
		// lut2023 数据库名称
		// characterEncoding=UTF-8 数据库传输的格式
		String url = "jdbc:mysql://127.0.0.1:3306/lut2023?user=hmp&password=root&characterEncoding=UTF-8";
		
		try {
			con = DriverManager.getConnection(url);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return  con;
	}

	// 关闭数据库连接
	public static void  close(){
		
		if (con!=null) {
			
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
