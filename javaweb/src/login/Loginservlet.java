package login;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Loginservlet extends HttpServlet{
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException,IOException{
		response.setContentType("text/html");
		String driverName="com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url="jdbc:sqlserver://localhost:1433;DatabaseName=test";
		String user="sa";
		String pwd="160510111xyj";
		
		String username=request.getParameter("uname");
		String upwd=request.getParameter("pwd");
		try {
			Class.forName(driverName);
			try{
				Connection conn=DriverManager.getConnection(url,user,pwd);
				String sql="select * from user_table where id=?";
				PreparedStatement ps=conn.prepareStatement(sql);
				ps.setString(1, username);
				ResultSet rs=ps.executeQuery();
				String mima="";
				while(rs.next()){
					mima=rs.getString("pwd").trim();
				}
				if(mima.equals(upwd)){
					HttpSession session=request.getSession();
					session.setAttribute("uname", username);
					request.getRequestDispatcher("index.jsp").forward(request,response);
				}else{
					request.getRequestDispatcher("erro.jsp").forward(request,response);
				}
			}catch (SQLException e){
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e){
			e.printStackTrace();
		}
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException{
		this.doGet(request, response);
	}
}
