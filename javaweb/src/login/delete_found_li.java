package login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

public class delete_found_li extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//初始化
		response.setContentType("text/html");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;DatabaseName=test";
		String user = "sa";
		String pwd = "160510111xyj";
		
		String name = request.getParameter("name");
		String kind = request.getParameter("kind");
		String description = request.getParameter("description");
		String time = request.getParameter("time");
		String location = request.getParameter("location");
		//创建数据库对象st
		Statement st;
		//获取参数
		
		try {
			Class.forName(driverName);
			try {
				Connection conn = DriverManager.getConnection(url,user,pwd);
				//创建查询对象
				st = conn.createStatement();
				System.out.println("连接test成功");
				
				//写删除语句
				String sql = "delete found where name='"+(name)+"' and description='"+(description)+"' and time='"+(time)+"' and location='"+(location)+"'";

				//获取结果
				st.execute(sql);
				
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println("连接test错误2");
		}
	
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("连接test错误1");
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}
