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

public class lost_li extends HttpServlet {
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
		//创建数据库对象st
		Statement st;
		//获取参数
		
		try {
			Class.forName(driverName);
			try {
				Connection conn = DriverManager.getConnection(url,user,pwd);
				//创建查询对象
				st = conn.createStatement();
				System.out.println("连接lost成功");
				
				//连接成功后开始查询
				
				List<Map> list = new ArrayList<Map>();//创建list集合用于存入map的键值对集合
				//写查询语句
				String sql = "select * from lost";
				//获取结果
				ResultSet rs = st.executeQuery(sql);
				while(rs.next()){
					int id = rs.getInt("id");
					String name = rs.getString("name");
					String kind = rs.getString("kind");
					String description = rs.getString("description");
					String time = rs.getString("time");
					String location = rs.getString("location");
					//创建Map
					Map map = new HashMap();
					map.put("id", id);
					map.put("name", name);
					map.put("kind", kind);
					map.put("description", description);
					map.put("time", time);
					map.put("location", location);

					list.add(map);//将这个map对象放入list
				}
				JSONArray jsonArray = JSONArray.fromObject(list);
				System.out.print(jsonArray);
				PrintWriter out = response.getWriter();
				out.println(jsonArray);
				out.close();
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println("连接lost错误2");
		}
	
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("连接lost错误1");
		}
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}
