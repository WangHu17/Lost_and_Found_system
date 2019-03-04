<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>错误处理页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style>
		*{
			margin: 0;
			padding: 0;
		}
		div{
			width: 200px;
			height: 150px;
			background: #FF4C4C;
			border-radius: 5px;
			position: absolute;
			left: 50%;
			top: 50%;
			margin-top: -75px;
			margin-left: -100px;
			font-size: 22px;
			font-weight: bold;
			color: white;
			text-align: center;
			padding-top: 40px;
			box-sizing: border-box;
		}
		a{
			text-decoration: none;
		}
	</style>

  </head>
  
  <body>
  	<div>账号或者密码错误!!!<br><br><a href="login.jsp">重新登陆</a></div>
    
  </body>
</html>
