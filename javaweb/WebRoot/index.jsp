<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>首页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<link rel="stylesheet" href="css/index.css"/>
	<script src="js/jquery-min.js"></script>
	
  </head>
  
  <body>
   
    <div class="top">
		<input type="button" class="index" value="首页"></input>
		<i class="person"></i>
		<a href="javascript:;" class="login">欢迎您，<%=session.getAttribute("uname")%>!</a>
		<i class="help_icon"></i>
		<a href="javascript:;" class="help">帮助</a>
	</div>

	<div class="title">
		<span class="Lost">Lost</span>
		<span class="and">and</span>
		<span class="Found">Found</span>
		<input class="search" type="text" name="search" placeholder="请输入关键字">

		<input class="kind" type="text" name="search_kind" value= "所有类别" readonly="readonly">
		<i class="down"></i>
		<ul class="down_ul">
			<li>饭卡</li>
			<li>银行卡</li>
			<li>钱包</li>
			<li>电子产品</li>
			<li>生活用品</li>
			<li>书本</li>
			<li>钥匙</li>
			<li>所有类别</li>
		</ul>

		<div class="search_btn"><i class="search_icon"></i></div>
		<div class="new_lost">新增失物招领</div>
	</div>

	<div class="menu">
		<div class="lost selected"><i class="wait"></i>待领取</div>
		<div class="found"><i class="ok"></i>已领取</div>
	</div>

	<div class="menu1">
		<div class="menu_word"><i class="menu_icon"></i>内容列表</div>
	</div>
	
	<div class="content_top lost_top">
		<div class="same number">序号</div>
		<div class="same id">ID</div>
		<div class="same keyword">物品名称</div>
		<div class="same classify">分类</div>
		<div class="same description">物品描述</div>
		<div class="same date">拾取时间</div>
		<div class="same location">拾取地点</div>
		<div class="same operation">操作</div>
	</div>
	<div class="content_top found_top">
		<div class="same number">序号</div>
		<div class="same keyword">物品名称</div>
		<div class="same classify">分类</div>
		<div class="same description">物品描述</div>
		<div class="same date">拾取时间</div>
		<div class="same location">拾取地点</div>
		<div class="same operation">操作</div>
	</div>
	
	<div class="content">
		<ul class="wait_ul">
		</ul>

		<ul class="found_ul">
		</ul>
	</div>
	
	<div class="add_lost">
		<div class="top_blue">
			<i class="add_icon"></i>/ 新增拾物
		</div>
		<span class="new_word">新增拾物</span>

		<div class="add_content">
			<form>
				<div class="add1">
					物品种类<input type= "text" class="add_kind" name="kind" value="饭卡" readonly="readonly">
					<i class="down1"></i>
					<ul class="down_ul1">
						<li>饭卡</li>
						<li>银行卡</li>
						<li>钱包</li>
						<li>电子产品</li>
						<li>生活用品</li>
						<li>书本</li>
						<li>钥匙</li>
					</ul>
				</div>
				<div>
					物品名称<input type="text" class="name" name="name">
				</div>
				<div>
					<span>物品描述</span>
					<textarea placeholder="请尽量描述拾到物品的详细信息，帮助失主更好认领" name="description"></textarea>
				</div>
				<div>
					拾取时间<input type="text" class="time" name="time">
				</div>
				<div>
					拾取地点<input type="text" class="place" name="location">
				</div>
				<input type="button" class="btn go_back" value="返回"></input>
				<input type="button" class="btn reset" value="重置"></input>
				<input type="button"  id="submit" class="btn send" value="提交">
			</form>
		</div>
	</div>

	<div class="back">
		<div class="success">提交成功
			<input type="button" class="yes" value="确定"></input>
			<input type="button" class="yes to_index" value="回首页"></input>
		</div>
	</div>
	
	<div class="null_box">
		<img src="icon/null.png" class="null_img">
		<span>未搜索到数据</span>
	</div>
  </body>

  <script>
  
	$(function(){
		
		//从数据库获取数据并插入到待领取列表
		$.ajax({
			url:'lost_li',
			type:'get',
			dataType:'json',
		})
		.done(function(data){
			$.each(data,function(index,ele){
				var $lost_li = createSqlLost(index,ele);
				$(".wait_ul").prepend($lost_li);
			});
			$(".l").each(function(index,ele){
				ele.index = index;
				$(ele).children(".number").text(index+1);
			});
		})

		//从数据库获取数据并插入到已领取列表
		$.ajax({
			url:'found_li',
			type:'get',
			dataType:'json',
		})
		.done(function(data){
			$.each(data,function(index,ele){
				var $found_li = createSqlFound(index,ele);
				$(".found_ul").prepend($found_li);
			});
			$(".f").each(function(index,ele){
				ele.index = index;
				$(ele).children(".number").text(index+1);
			});
		})


		//搜索按钮
		$(".search_btn").on('click',function(){
			//获取搜索框中输入的值和分类选项框的值
			var keyword = $(".search").val();
			var kind = $(".kind").val();

			//清空搜索框的输入内容
			$(".search").val('');
			$(".kind").val('所有类别');

			var $lost_li = $(".l");
			var $found_li = $(".f");

			if($(".found").attr("class").indexOf("selected")!=-1){
				//在已领取页面

				//如果没输入关键字
				if(keyword == ''){
					if(kind == "所有类别"){
						$found_li.removeClass('li_none');
					}else{
						for(var i = 0; i < $found_li.length; i++){
							var f_li_kind = $(".f .classify").eq(i).text();	
							if(f_li_kind != kind){
								$found_li.eq(i).addClass('li_none');
							}else{
								$found_li.eq(i).removeClass('li_none');
							}
						}
					}
				}else if(keyword != ''){
					var all_text = new Array();
					//如果输入了关键字
					for(var j = 0; j < $found_li.length; j++){
						
						all_text[j] = $found_li.eq(j).text();
						if(all_text[j].indexOf(keyword) == -1){
							$found_li.eq(j).addClass('li_none');
						}else{
							$found_li.eq(j).removeClass('li_none');
						}
					}		
				}
				//重新排序
				var block_li = $(".f").not('.li_none');
				$(block_li).each(function(index,ele){
					ele.index = index;
					$(ele).children(".number").text(index+1);
				});
				//如果未搜索到，显示未搜索到的图片
				var flag = 1;
				for(var m=0; m<$found_li.length; m++){
					if($found_li.eq(m).attr("class").indexOf("li_none") == -1){
						flag = 0;
					}
				}
				if(flag == 1){
					$(".null_box").show();
				}else{
					$(".null_box").hide();
				}

			}else{
				//在待领取页面

				//如果没输入关键字
				if(keyword == ''){
					if(kind == "所有类别"){
						$lost_li.removeClass('li_none');
					}else{
						for(var i = 0; i < $lost_li.length; i++){
							var l_li_kind = $(".l .classify").eq(i).text();	
							if(l_li_kind != kind){
								$lost_li.eq(i).addClass('li_none');
							}else{
								$lost_li.eq(i).removeClass('li_none');
							}
						}
					}
				}else if(keyword != ''){
					var all_text = new Array();
					//如果输入了关键字
					for(var j=0; j<$lost_li.length; j++){
						
						all_text[j] = $lost_li.eq(j).text();
						if(all_text[j].indexOf(keyword) == -1){
							$lost_li.eq(j).addClass('li_none');
						}else{
							$lost_li.eq(j).removeClass('li_none');
						}
					}		
				}
				//重新排序
				var block_l_li = $(".l").not('.li_none');
				$(block_l_li).each(function(index,ele){
					ele.index = index;
					$(ele).children(".number").text(index+1);
				});
				//如果未搜索到，显示未搜索到的图片
				var flag1 = 1;
				for(var n=0; n<$lost_li.length; n++){
					if($lost_li.eq(n).attr("class").indexOf("li_none") == -1){
						flag1 = 0;
					}
				}
				if(flag1 == 1){
					$(".null_box").show();
				}else{
					$(".null_box").hide();
				}
			}

		});
		
		
		//下拉菜单（顶部）
		var down = $('.down');
		down.click(function(){
			$(".down_ul").toggleClass('down_ul_none');
		});
		var li = $(".down_ul li");
		li.click(function(){
			$(".down_ul").toggleClass('down_ul_none');
			var $value = $(this).text();
			$(".kind").val($value);
		});
		//点击其他地方让下拉菜单消失
		if($(".down_ul").attr("class").indexOf("down_ul_none") == -1){

		}

		//下拉菜单（新增失物招领）
		var down1 = $('.down1');
		down1.click(function(){
			$(".down_ul1").toggleClass('down_ul_none');
		});
		var li1 = $(".down_ul1 li");
		li1.click(function(){
			$(".down_ul1").toggleClass('down_ul_none');
			var $value = $(this).text();
			$(".add_kind").val($value);
		});

		//已领取按钮
		$(".found").click(function(){
			$(".found").addClass('selected');
			$(".lost").removeClass('selected');
			$(".lost_top").hide();
			$(".found_top").show();
			$(".found_ul").show();
			$(".wait_ul").hide();
			//点击时让待领取列表恢复原状态
			$(".l").show();
			//让未搜索到图片消失
			$(".null_box").hide();
		});

		//待领取按钮
		$(".lost").click(function(){
			$(".lost").addClass('selected');
			$(".found").removeClass('selected');
			$(".lost_top").show();
			$(".found_top").hide();
			$(".wait_ul").show();
			$(".found_ul").hide();
			//点击时让已领取列表恢复原状态
			$(".f").show();
			//让未搜索到图片消失
			$(".null_box").hide();

		});

		//首页按钮
		$(".index").click(function(){
			$(".add_lost").css("display","none");
			if($(".found").attr("class").indexOf("selected") != -1){
				$(".lost").trigger('click');
			}
			//重置填写的内容
			$(".add_kind").val("饭卡");
			$(".add_content").find('.name').val('');
			$(".add_content").find('textarea').val('');
			$(".add_content").find('.time').val('');
			$(".add_content").find('.place').val('');
		});

		//新增失物招领按钮
		$(".new_lost").click(function(){
			$(".add_lost").css("display","block");
		});

		//返回按钮
		$(".go_back").click(function(){
			$(".add_lost").css("display","none");
			if($(".found").attr("class").indexOf("selected") != -1){
				$(".lost").trigger('click');
			}
		});

		//重置按钮
		var $reset = $(".reset");
		$reset.click(function(){
			$(".add_kind").val("饭卡");
			$(".add_content").find('.name').val('');
			$(".add_content").find('textarea').val('');
			$(".add_content").find('.time').val('');
			$(".add_content").find('.place').val('');
		});

		//提交按钮
		var $submit = $("#submit");
		 $submit.on('click', function(event) {
		 	event.preventDefault();
		 	var name = $(".name").val();
		 	var kind = $(".add_kind").val();
		 	var description = $("textarea").val();
		 	var time = $(".time").val();
		 	var location = $(".place").val();
		 	$.ajax({
		 		url: 'insert_li',
		 		type: 'post',
		 		dataType: 'text',
		 		data: {
		 			'name': name,
		 			'kind': kind,
		 			'description': description,
		 			'time': time,
		 			'location': location
		 		}
		 	})
		 	.done(function(data) {

		 	})
		 	.fail(function() {
		 		console.log("error");
		 	})
		 	
		 });
		//提交按钮
		$(".send").click(function(){
			//获取提交的数据
			var classify = $(this).parent().find('.add_kind').val();
			var name = $(this).parent().find('.name').val();
			var description = $(this).parent().find('textarea').val();
			var time = $(this).parent().find('.time').val();
			var place = $(this).parent().find('.place').val();
			//填写完整才能提交
			if(name == '' || description == '' || time == '' || place == ''){
				alert("请填写完整！！！");
				return;
			}
			//将提交的数据插入到待领取页面
			var add_li = createLost(name,classify,description,time,place);
			$(".wait_ul").prepend(add_li);
			//重新排序待领取列表
			$(".l").each(function(index,ele){
				ele.index = index;
				$(ele).find(".number").text(index+1);
			});
			//弹出提交成功框
			$(".back").css("display","block");
			//确定按钮点击事件
			$(".yes").click(function(){
				$(".back").css("display","none");
			});
			//回首页点击事件
			$(".to_index").click(function(){
				$(".back").css("display","none");
				$(".add_lost").css("display","none");
				if($(".found").attr("class").indexOf("selected") != -1){
					$(".lost").trigger('click');
				}
				//重置填写的内容
				$(".add_kind").val("饭卡");
				$(".add_content").find('.name').val('');
				$(".add_content").find('textarea').val('');
				$(".add_content").find('.time').val('');
				$(".add_content").find('.place').val('');
			});
		});

		//修改按钮
		$(document).on('click','.change',function(){
			//点击后隐藏修改、已领取按钮，显示完成按钮，并使文本可编辑
			$(this).hide();
			$(this).siblings('.delete').hide();
			$(this).siblings('.finish_icon').show();
			$(this).parents(".l").children('.keyword').attr("contenteditable","true");
			$(this).parents(".l").children('.description').attr("contenteditable","true");
			$(this).parents(".l").children('.date').attr("contenteditable","true");
			$(this).parents(".l").children('.location').attr("contenteditable","true");
		});

		//完成按钮
		$(document).on('click','.finish_icon',function(){
			//点击后显示修改、已领取按钮，隐藏完成按钮，并使文本不可编辑
			$(this).hide();
			$(this).siblings('.delete').show();
			$(this).siblings('.change').show();
			$(this).parents(".l").children('.keyword').attr("contenteditable","false");
			$(this).parents(".l").children('.description').attr("contenteditable","false");
			$(this).parents(".l").children('.date').attr("contenteditable","false");
			$(this).parents(".l").children('.location').attr("contenteditable","false");
			//获取该列修改后的内容
			var id = $(this).parents(".l").find(".id").text();
			var name = $(this).parents(".l").find(".keyword").text();
			var description = $(this).parents(".l").find(".description").text();
			var time = $(this).parents(".l").find(".date").text();
			var location = $(this).parents(".l").find(".location").text();
			console.log(id,name,description,time,location);
 			//修改数据库的数据
			$.ajax({
		 		url: 'change_lost_li',
		 		type: 'post',
		 		dataType: 'text',
		 		data: {
		 			'id': id,
		 			'name': name,
		 			'description': description,
		 			'time': time,
		 			'location': location
		 		}
		 	})
		 	.done(function(data) {

		 	})
		 	.fail(function() {
		 		console.log("error");
		 	})
		});
		
		//已领取按钮
		$(document).on('click','.delete',function(){
			//获取删除列表中的数据
			var name = $(this).parents(".l").find(".keyword").text();
			var kind = $(this).parents(".l").find(".classify").text();
			var description = $(this).parents(".l").find(".description").text();
			var time = $(this).parents(".l").find(".date").text();
			var location = $(this).parents(".l").find(".location").text();
			//插入到已领取列表
			var found_li = createFound(name,kind,description,time,location);
			$(".found_ul").prepend(found_li);
			//插入到数据库的found表
			$.ajax({
		 		url: 'insert_to_found',
		 		type: 'post',
		 		dataType: 'text',
		 		data: {
		 			'name': name,
		 			'kind': kind,
		 			'description': description,
		 			'time': time,
		 			'location': location
		 		}
		 	})
		 	.done(function() {
		 		
		 	})
		 	.fail(function() {
		 		console.log("error");
		 	})
			//删除页面中对应的列表
			$(this).parents(".l").remove();
			//重新排序（待领取和已领取列表都要重新排序）
			$(".l").each(function(index,ele){
				ele.index = index;
				$(ele).children(".number").text(index+1);
			});
			$(".f").each(function(index,ele){
				ele.index = index;
				$(ele).children(".number").text(index+1);
			});
		});
		$(document).on('click','.delete',function(){
			//获取删除列表中的数据
			var name = $(this).parents(".l").find(".keyword").text();
			var kind = $(this).parents(".l").find(".classify").text();
			var description = $(this).parents(".l").find(".description").text();
			var time = $(this).parents(".l").find(".date").text();
			var location = $(this).parents(".l").find(".location").text();
			//删除数据库的lost表对应的行
			$.ajax({
		 		url: 'delete_lost_li',
		 		type: 'post',
		 		dataType: 'text',
		 		data: {
		 			'name': name,
		 			'kind': kind,
		 			'description': description,
		 			'time': time,
		 			'location': location
		 		}
		 	})
		 	.done(function() {
		 	})
		 	.fail(function() {
		 		console.log("error");
		 	})
		});

		//已领取列表的删除按钮
		$(document).on('click','.delete_found',function(){
			//获取删除列表中的数据
			var name = $(this).parents(".f").find(".keyword").text();
			var kind = $(this).parents(".f").find(".classify").text();
			var description = $(this).parents(".f").find(".description").text();
			var time = $(this).parents(".f").find(".date").text();
			var location = $(this).parents(".f").find(".location").text();
			//删除数据库的found表对应的行
			$.ajax({
		 		url: 'delete_found_li',
		 		type: 'post',
		 		dataType: 'text',
		 		data: {
		 			'name': name,
		 			'kind': kind,
		 			'description': description,
		 			'time': time,
		 			'location': location
		 		}
		 	})
		 	.done(function() {
		 	})
		 	.fail(function() {
		 		console.log("error");
		 	})
		 	//删除页面中对应的列表
			$(this).parents(".f").remove();
			//重新排序（待领取和已领取列表都要重新排序）
			$(".f").each(function(index,ele){
				ele.index = index;
				$(ele).children(".number").text(index+1);
			});
		});
		
		//创建已领取的li
		function createFound(name,kind,description,time,location){
			var found_li = $("<li class=\"li f\">"+
					"<div class=\"li_same number\">1</div>"+
					"<div class=\"li_same keyword\">"+name+"</div>"+
					"<div class=\"li_same classify\">"+kind+"</div>"+
					"<div class=\"li_same description\">"+description+"</div>"+
					"<div class=\"li_same date\">"+time+"</div>"+
					"<div class=\"li_same location\">"+location+"</div>"+
					"<div class=\"li_same operation got\">已领取<i class=\"delete_found\"></i></div>"+
				"</li>");
			return found_li;
		}
		//创建新增的待领取的li
		function createLost(name,kind,description,time,location){
			var lost_li = $("<li class=\"li l\">"+
					"<div class=\"li_same number\">1</div>"+
					"<div class=\"li_same id\">1</div>"+
					"<div class=\"li_same keyword\">"+name+"</div>"+
					"<div class=\"li_same classify\">"+kind+"</div>"+
					"<div class=\"li_same description\">"+description+"</div>"+
					"<div class=\"li_same date\">"+time+"</div>"+
					"<div class=\"li_same location\">"+location+"</div>"+
					"<div class=\"li_same operation\">"+
						"<button class=\"change\"><i class=\"change_icon\"></i>修改</button>"+
						"<button class=\"delete\"><i class=\"delete_icon\"></i>领取</button>"+
						"<i class=\"finish_icon\"></i>"+
					"</div>"+
				"</li>");
			return lost_li;
		}
		//创建数据库的lost列表
		function createSqlLost(index,ele){
			var $lost_li = $("<li class=\"li l\">"+
					"<div class=\"li_same number\">1</div>"+
					"<div class=\"li_same id\">"+ele.id+"</div>"+
					"<div class=\"li_same keyword\">"+ele.name+"</div>"+
					"<div class=\"li_same classify\">"+ele.kind+"</div>"+
					"<div class=\"li_same description\">"+ele.description+"</div>"+
					"<div class=\"li_same date\">"+ele.time+"</div>"+
					"<div class=\"li_same location\">"+ele.location+"</div>"+
					"<div class=\"li_same operation\">"+
						"<button class=\"change\"><i class=\"change_icon\"></i>修改</button>"+
						"<button class=\"delete\"><i class=\"delete_icon\"></i>领取</button>"+
						"<i class=\"finish_icon\"></i>"+
					"</div>"+
				"</li>");
			return $lost_li;
		}
		//创建数据库的found列表
		function createSqlFound(index,ele){
			var $found_li = $("<li class=\"li f\">"+
					"<div class=\"li_same number\">1</div>"+
					"<div class=\"li_same keyword\">"+ele.name+"</div>"+
					"<div class=\"li_same classify\">"+ele.kind+"</div>"+
					"<div class=\"li_same description\">"+ele.description+"</div>"+
					"<div class=\"li_same date\">"+ele.time+"</div>"+
					"<div class=\"li_same location\">"+ele.location+"</div>"+
					"<div class=\"li_same operation got\">已领取<i class=\"delete_found\"></i></div>"+
				"</li>");
			return $found_li;
		}
	})	

  </script>
</html>
