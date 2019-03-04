<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML5>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>管理员登陆</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">	
	<meta http-equiv="description" content="This is my page">
	<script src="js/jquery-min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/login.css">
	
  </head>
  
  <body>
  	<div class="top">
		<i class="help_icon"></i>
		<a href="#" class="help">帮助</a>
	</div>
	<div class="title">
		<span class="Lost">Lost</span>
		<span class="and">and</span>
		<span class="Found">Found</span>
	</div>
	<div class="content">
		<div class="login_content">
			<span class="login_type">管理员登陆</span>

			<form action="Loginservlet" method="post" onsubmit="return jump()">
		    	<input class="person_box" type="text" placeholder="用户名" name="uname">

		    	<input class="pwd_box" type="password" name="pwd" placeholder="密码">

		    	<input class="login_btn" type="submit" value="登陆"/>
		    </form>
	    </div>
    </div>
  </body>

  <script>
  	
  	function jump(){
  		var username = $(".person_box").val();
  		var pwd =$(".pwd_box").val();
  		if(username == ""){
  			alert("请输入账号！！！");
  			return false;
  		}else{
  			if(pwd == ""){
  				alert("请输入密码！！！");
  				return false;
  			}
  			return true;
  		}
  	}
  	
  	
  </script>
</html>
