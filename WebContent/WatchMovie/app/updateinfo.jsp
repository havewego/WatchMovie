<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="en"> <!--<![endif]-->
<head>

    <!-- Basic Page Needs
  ================================================== -->
	<meta charset="utf-8">
	<title>zMovie</title>
	<meta name="description" content="Free Responsive Html5 Css3 Templates | zerotheme.com">
	<meta name="author" content="www.zerotheme.com">
	
    <!-- Mobile Specific Metas
  ================================================== -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    
    <!-- CSS
  ================================================== -->
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/WatchMovie/app/css/zerogrid.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/WatchMovie/app/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/WatchMovie/app/css/responsive.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/WatchMovie/app/css/writeborde.css">
	<script src="${pageContext.request.contextPath}/WatchMovie/app/js/jquery-3.2.1.js"
	type="text/javascript" charset="utf-8"></script>
	<style type="text/css">
		.search{
			background: url(${pageContext.request.contextPath}/WatchMovie/app/images/search-dark.png) no-repeat 7px 6px #fcab2b;
			padding: 7px 7px 7px 25px;
			color: #fff;
			font-size: 14px;
			cursor:pointer;
			-webkit-border-radius: 4px;
		    -moz-border-radius: 4px;
		    border-radius: 4px;
		}
		.m{
			margin-bottom: 70px;
		}
		.pormat{
				color: orange;
			}
	</style>
	<script type="text/javascript">
		$(function(){
			//若登陆，显示用户名称，未登录，则显示登陆
    		/* $.ajax({
    			type:"post",
    			url:"${pageContext.request.contextPath }/getUser",
    			success:function(data){
    				if(data==""){
    					$("#state").empty();
    					$("#state").append("登陆");
    				}else{
    					$("#state").empty();
    					$("#state").append(data.name);
    				}
    			}
    		}); */
    		//显示更新信息后的消息
			var mess = '${mess}';
    		if(mess==""){
    		}else{
    			alert(mess);
    		}
    		
    		//显示热门电影
    		$.ajax({
    			type:"post",
    			url:"${pageContext.request.contextPath}/hotMovies",
    			data:{"page":1},
    			success:function(data){
    				$("#hotmovies").empty();
    				$("#hotmovies").append(data);
    			}
    		});
    		//状态选择
    		$("#change").change(function(){
                //doSomething such as alert(1)
                //alert(1);
    			var choice = $("#change").val();
        		if(choice=="退出"){
        			location.href="${pageContext.request.contextPath}/exit";
        		}else if(choice=="登陆"){
        			location.href="${pageContext.request.contextPath}/WatchMovie/app/login.jsp";
        		}else{//修改个人信息
        			location.href="${pageContext.request.contextPath}/WatchMovie/app/updateinfo.jsp";
        		}
                //$(this).blur();
            }).focus(function(){
                $(this)[0].selectedIndex = -1;
            }).blur(function(){
            	$(this)[0].selectedIndex = 0;	
            });
			//头像
			$.ajax({
    			type:"post",
				url:"${pageContext.request.contextPath }/getHeadpic",
				data:{"id":0},
				success:function(data){
					document.getElementById("headpic").innerHTML=data;
				}
    		});
			//显示信息
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath }/getUser",
				success:function(data){
					//alert(data.id +"+"+data.name+"+"+data.pwd+"+"+data.email+"+"+data.phone+"+"+data.pic );
					//alert(data.id);
					var st = "";
					var str = "";
					if(data==""){
						alert("你还未登陆！")
    					location.href="${pageContext.request.contextPath}/WatchMovie/app/login.jsp";
    				}else{
    					$("#state").empty();
    					$("#state").append(data.name);
    					st += "<center><form id=\"ff\" method=\"post\" action=\"${pageContext.request.contextPath}/updateinfo\" enctype=\"multipart/form-data\" style=\"width: 50%\">";
						st += "<label style=\"text-align: left;\"><span>用户id：</span>";
						st += "<input type=\"text\"  name=\"id\" id=\"id\" required value=\""+data.id+"\" readonly=\"readonly\"></label>";
						st += "<label style=\"text-align: left;\"><span>用户名：</span>";
						st += "<input type=\"text\"  name=\"name\" value=\""+data.name+"\" id=\"name\" required><div class=\"pormat\" id=\"namediv\"></div></label>";
						st += "<label style=\"text-align: left;\"><span>邮箱地址：</span>";
						st += "<input type=\"email\"  name=\"email\" value=\""+data.email+"\" id=\"email\" ><div class=\"pormat\" id=\"emaildiv\"></div></label>";
						st += "<label style=\"text-align: left;\"><span>电话号码：</span>";
						st += "<input type=\"text\"  name=\"phone\" value=\""+data.phone+"\" id=\"phone\" ><div class=\"pormat\" id=\"phonediv\"></div></label>";
						st += "<label style=\"text-align: left;\"><span>头像：</span>";
						st += "<input type=\"file\" onchange=\"PreviewImage(this)\" name=\"pic\" id=\"exampleInputFile\" style=\"background-color:white;border: 1px solid #ccc;box-shadow: inset 0 1px 1px rgba(0,0,0,.075); border-radius: 4px;\"></label>";
						st += "<center><div id=\"imgPreview\" name=\"image\" ></div></center><br>";
						st += "<input class=\"sendButton\" type=\"submit\" name=\"Submit\" value=\"提交修改\" style=\"display: inline;\">&nbsp;&nbsp;&nbsp;";
						st += "<input class=\"sendButton\" onclick=\"changepwd()\" type=\"button\"  value=\"修改密码\" style=\"display: inline;\"></form></center>";
    					
						str +="<center><form id=\"ff\" method=\"post\"  style=\"width: 50%\">";
						str += "<label style=\"text-align: left;\"><span>旧密码：</span>";
						str += "<input type=\"password\"  name=\"pwd\" id=\"pwd\" required><div class=\"pormat\" id=\"pwddiv\"></div></label>";
						str += "<label style=\"text-align: left;\"><span>新密码：</span>";
						str += "<input type=\"password\"  name=\"newpwd\" id=\"newpwd\" required><div class=\"pormat\" id=\"newpwddiv\"></div></label>";
						str += "<center><input class=\"sendButton\" onclick=\"updatepwd()\" type=\"button\" name=\"Submit\" value=\"提交修改\" style=\"display: inline;\">&nbsp;&nbsp;&nbsp;";
						str += "<input class=\"sendButton\" onclick=\"changeinfo()\" type=\"button\"  value=\"修改信息\" style=\"display: inline;\"></center></form></center>";
    				
    				}
					$("#updateform1").empty();
					$("#updateform1").append(st);
					$("#updateform2").empty();
					$("#updateform2").append(str);
				}
			});
		});
		function PreviewImage(imgFile){
			var url = URL.createObjectURL(imgFile.files[0]);
			var div = document.getElementById("imgPreview");
			div.innerHTML = "<img src='"+url+"' style='height:200px;border-radius: 6px;'/>";
		}
		function changepwd(){
			$("#updateform1").hide();
			$("#updateform2").show();
		}
		function changeinfo(){
			$("#updateform2").hide();
			$("#updateform1").show();
		}
		/* function updateinfo(){
			alert("hhhhhh");
			//location.href="${pageContext.request.contextPath}/updatepwd?pwd=123&newpwd=123";
		} */
		//热门电影翻页
    	function jumpHotMovie(i){
    		$.ajax({
    			type:"post",
    			url:"${pageContext.request.contextPath}/hotMovies",
    			data:{"page":i},
    			success:function(data){
    				$("#hotmovies").empty();
    				$("#hotmovies").append(data);
    			}
    		});
    	}
		function updatepwd(){
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath }/updatepwd",
				data:{"pwd":$("#pwd").val(),"newpwd":$("#newpwd").val()},
				success:function(data){
					if(data=="success"){
						alert("修改密码成功！");
						location.href="${pageContext.request.contextPath}/WatchMovie/app/index.jsp";
					}else{
						alert("旧密码错误！");
					}
				}
			});
			
		}
	</script>
	<!--[if lt IE 8]>
       <div style=' clear: both; text-align:center; position: relative;'>
         <a href="http://windows.microsoft.com/en-US/internet-explorer/products/ie/home?ocid=ie6_countdown_bannercode">
           <img src="http://storage.ie6countdown.com/assets/100/images/banners/warning_bar_0000_us.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." />
        </a>
      </div>
    <![endif]-->
    <!--[if lt IE 9]>
		<script src="js/html5.js"></script>
		<script src="js/css3-mediaqueries.js"></script>
	<![endif]-->
</head>
<body>
<div class="wrap-body">

<!--////////////////////////////////////Header-->
<header>
	
	<div class="wrap-header zerogrid">
		<div class="row">
			<div class="col-1-3">
				<div class="wrap-col">
					<div class="logo"><a href="#"><img src="${pageContext.request.contextPath}/WatchMovie/app/images/logo.png"/></a></div>	
				</div>
			</div>
			<div class="col-1-3">
				<div class="wrap-col f-right">
					<form id="search" action="${pageContext.request.contextPath}/seesearch" method="post">
					  <input name="name" id="searchname" type="text" size="40" placeholder="Search..." />
					  <input name="page" value="1" type="hidden" >
					  <input class="search" type="submit" value="search" onclick="search()"/>
					</form>
				</div>
			</div>
			<div class="col-1-3" >
				<div class="wrap-col" >
					<div id="headpic" class="col-1-3" >
						<!-- <img alt="" src="/WatchMovie/WatchMovie/image/User/public.jpg" style="height:80px;width:80px;border-radius: 50%"> -->
					</div>
					<div  style="display: inline;" class="col-2-3">
						<select id="change" onchange="change()">
							<option id="state">登陆</option>
							<option>个人信息</option>
							<option>退出</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div id="menu">
				<nav>
					<div class="wrap-nav">
					   <ul>
						 <li><a href="${pageContext.request.contextPath}/WatchMovie/app/index.jsp">Home</a></li>
						 <li><a href="#">无效</a></li>
						 <li><a href="#">无效</a></li>
						 <li><a href="#">无效</a></li>
						 <li><a href="#">无效</a></li>
						 <li><a href="#">无效</a></li>
						 <li><a href="#">无效</a></li>
					   </ul>
					</div>
				</nav>
			</div>
		</div>
	</div>
</header>


<!--////////////////////////////////////Container-->
<section id="container">
	<div class="wrap-container zerogrid">
		<div id="main-content" class="col-2-3">
			<div class="wrap-content">
				<!-- 个人信息 -->
				<div class="contact">
					<h2>Update</h2>
					<div id="updateform1">
						<!-- <center>
							<form name="form1" id="ff" method="post" action="" onsubmit="return updateinfo()" style="width: 50%">
								<label style="text-align: left;">
								<span>用户id：</span>
								<input type="text"  name="id" id="id" required value="" readonly="readonly">
								</label>
								<label style="text-align: left;">
								<span>用户名：</span>
								<input type="text"  name="name" id="name" required>
								</label>
								<label style="text-align: left;">
								<span>邮箱地址：</span>
								<input type="email"  name="email" id="email" >
								</label>
								<label style="text-align: left;">
								<span>电话号码：</span>
								<input type="text"  name="phone" id="phone" >
								</label>
								<label style="text-align: left;">
								<span>头像：</span>
								<input type="file" onchange="PreviewImage(this)" name="pic" id="exampleInputFile" style="background-color:white;border: 1px solid #ccc;box-shadow: inset 0 1px 1px rgba(0,0,0,.075); border-radius: 4px;">
								</label>
								<center><div id="imgPreview" name="image" ></div></center><br>
								<center><input class="sendButton" type="submit" name="Submit" value="提交修改" style="display: inline;">
									<input class="sendButton" onclick="changepwd()" type="button"  value="修改密码" style="display: inline;"></center>
							</form>
						</center> -->
					</div>
					<div id="updateform2" style="display: none">
						<!-- 修改密码 -->
					</div>
				</div>
			</div>
		</div>
		<div id="sidebar" class="col-1-3">
			<div class="wrap-sidebar">
				<!---- Start Widget ---->
				<div class="widget wid-new-updates">
					<div class="wid-header">
						<h5>热门电影 !</h5>
					</div>
					<div class="wid-content" id="hotmovies" style="height: 347.6px;">
						
					</div>
				</div>
				<!---- Start Widget ---->
				<div class="widget wid-tag">
					<div class="wid-header">
						<h5>类型</h5>
					</div>
					<div class="wid-content">
						<ul>
						<li><a href="${pageContext.request.contextPath}/looktype?page=1&type=动作" >动作</a></li>
						<li><a href="${pageContext.request.contextPath}/looktype?page=1&type=喜剧" >喜剧</a></li>
						<li><a href="${pageContext.request.contextPath}/looktype?page=1&type=科幻" >科幻</a></li>
						<li><a href="${pageContext.request.contextPath}/looktype?page=1&type=枪战" >枪战</a></li>
						</ul>
					</div>
				</div>
				<!---- Start Widget ---->
				<div class="widget wid-post">
					<div class="wid-header">
						<h5>Today's movies</h5>
					</div>
					<div class="wid-content">
						<div class="post">
							<a href="#"><img src="${pageContext.request.contextPath}/WatchMovie/image/movie/1.jpg"/></a>
							<div class="wrapper">
							  <a href="#"><h6>A Blue Morning</h6></a>
							  <p>March 1, 2015</p>
							  <a href="#"><img src="/WatchMovie/WatchMovie/app/images/star.png" /></a>
							</div>
						</div>
						<div class="post">
							<a href="#"><img src="${pageContext.request.contextPath}/WatchMovie/image/movie/2.jpg"/></a>
							<div class="wrapper">
							 <a href="#"><h6>A Blue Morning</h6></a>
							  <p>March 1, 2015</p>
							  <a href="#"><img src="/WatchMovie/WatchMovie/app/images/star.png" /></a>
							</div>
						</div>
						<div class="post">
							<a href="#"><img src="${pageContext.request.contextPath}/WatchMovie/image/movie/3.jpg"/></a>
							<div class="wrapper">
							 <a href="#"><h6>A Blue Morning</h6></a>
							  <p>March 1, 2015</p>
							  <a href="#"><img src="/WatchMovie/WatchMovie/app/images/star.png" /></a>
							</div>
						</div>
					</div>
				</div>
				<!---- Start Widget ---->
				<div class="widget wid-last-updates">
					<div class="wid-header">
						<h5>Lastest Updates</h5>
					</div>
					<div class="wid-content">
						<div class="post">
							<a href="#"><img src="${pageContext.request.contextPath}/WatchMovie/image/movie/1.jpg"/></a>
							<div class="wrapper">
							  <a href="#"><h6>A Blue Morning</h6></a>
							  <p>March 1, 2015</p>
							  <a href="#"><img src="/WatchMovie/WatchMovie/app/images/star.png" /></a>
							</div>
						</div>
						<div class="post">
							<a href="#"><img src="${pageContext.request.contextPath}/WatchMovie/image/movie/2.jpg"/></a>
							<div class="wrapper">
							 <a href="#"><h6>A Blue Morning</h6></a>
							  <p>March 1, 2015</p>
							  <a href="#"><img src="/WatchMovie/WatchMovie/app/images/star.png" /></a>
							</div>
						</div>
						<div class="post">
							<a href="#"><img src="${pageContext.request.contextPath}/WatchMovie/image/movie/3.jpg"/></a>
							<div class="wrapper">
							 <a href="#"><h6>A Blue Morning</h6></a>
							  <p>March 1, 2015</p>
							  <a href="#"><img src="/WatchMovie/WatchMovie/app/images/star.png" /></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!--////////////////////////////////////Footer-->
<footer>
	<div class="zerogrid">
		<div class="wrap-footer">
			<div class="row">
				<div class="col-1-4">
					<div class="wrap-col">
						<div class="widget wid-about">
							<div class="wid-header">
								<h5>Welcome</h5>
							</div>
							<div class="logo"><a href="#"><img src="/WatchMovie/WatchMovie/app/images/logo.png"/></a></div>
							<p>Nam libero tempore, cum soluta nobis est eligendi optio cumque quod maxime placeat 
								facere possimus nihil impedit quo minus id quod maxime placeat facere possimus. </p>
						</div>
					</div>
				</div>
				<div class="col-1-4">
					<div class="wrap-col">
						<div class="widget wid-meta">
							<div class="wid-header">
								<h5>Links List</h5>
							</div>
							<div class="widget-content">
								<div class="row">
									<ul>
										<li><a href="#">> Lorem ipsum dolor sit </a></li>
										<li><a href="#">> Nullam venenatis lacus a </a></li>
										<li><a href="#">> Morbi ut sapien nec nisl</a></li>
										<li><a href="#">> Integer a enim ac ex.</a></li>
										<li><a href="#">> Sed in nunc non eleifend  </a></li>
										<li><a href="#">> Integer a enim ac ex.</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-1-4">
					<div class="wrap-col">
						<div class="widget wid-report">
							<div class="wid-header">
								<h5>Report Link</h5>
							</div>
							<div class="wid-content">
								<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy 
								eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. 
								At vero eos et accusam et justo duo dolores et ea rebum. Consetetur sadipscing elitr,  
								sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-1-4">
					<div class="wrap-col">
						<div class="widget wid-meta">
							<div class="wid-header">
								<h5>Links List</h5>
							</div>
							<div class="widget-content">
								<div class="row">
									<ul>
										<li><a href="#">> Lorem ipsum dolor sit </a></li>
										<li><a href="#">> Nullam venenatis lacus a </a></li>
										<li><a href="#">> Morbi ut sapien nec nisl</a></li>
										<li><a href="#">> Integer a enim ac ex.</a></li>
										<li><a href="#">> Sed in nunc non eleifend  </a></li>
										<li><a href="#">> Integer a enim ac ex.</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="bottom-footer">
		<div class="wrap-bottom">
			<div class="copyright">
				<p>Â©2015 - More Templates <a href="http://www.cssmoban.com/" target="_blank" title="æ¨¡æ¿ä¹å®¶">æ¨¡æ¿ä¹å®¶</a> - Collect from <a href="http://www.cssmoban.com/" title="ç½é¡µæ¨¡æ¿" target="_blank">ç½é¡µæ¨¡æ¿</a></p>
			</div>
		</div>
	</div>
</footer>


</div>

</body></html>