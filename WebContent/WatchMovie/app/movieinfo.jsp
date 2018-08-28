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
	</style>
	<script type="text/javascript">
		$(function(){
			
			//若登陆，显示用户名称，未登录，则显示登陆
    		$.ajax({
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
    		});
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
			
			$.ajax({
    			type:"post",
				url:"${pageContext.request.contextPath }/getHeadpic",
				data:{"id":0},
				success:function(data){
					document.getElementById("headpic").innerHTML=data;
				}
    		});
		});
		function addcontent(){
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath }/addcontent",
				data:{"text":$("#content").val()},
				success:function(data){
					
				}
			});
		}
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
				<article>
					<div class="art-header">
						<div class="col-1-3">
							<div class="wrap-col">
								<img src="${pageContext.request.contextPath}/WatchMovie/image/movie/${movie.pic}" width="240px" />
							</div>
						</div>
						<div class="col-2-3">
							<div class="wrap-col">
								<ul>
									<li><p>Tags: <a href="#">${movie.type}</a></p></li>
									<li><p>Production: <a href="#">环球影业</a></p></li>
									<li><p>Actor: <a href="#">jrrdy</a></p></li>
									<li><p>Director: <a href="#">James Cameron</a></p></li>
									<li><p>Nation: <a href="#">美国</a></p></li>
									<li><p>Upload: <a href="#">Action</a></p></li>
									<li><p>PlayTimes: <a href="#">${movie.times}</a></p></li>
									<li><a class="button bt1" href="${pageContext.request.contextPath}/play?id=${movie.id}">Play</a><!-- <a class="button bt1" href="#">Trailer</a> --></li>
									<li class="star"><a href="#"><img src="/WatchMovie/WatchMovie/app/images/star.png" /></a></li>
								</ul>
							</div>
						</div>
						<div class="clear"></div>
					</div>
					<div class="art-content">
						<img alt="电影介绍图片" src="${pageContext.request.contextPath}/WatchMovie/image/movie/${movie.pic}" style="width: auto;height: auto"/>
						<h2>影片简介：</h2>
						<p>${movie.introduction}</p>
						
						<div class="clear"></div>
					</div>
				
				</article>
				<div class="widget wid-related">
					<div class="wid-header">
						<h5>Related Post</h5>
					</div>
					<div class="wid-content">
						<div class="row">
							<div class="col-1-3">
								<div class="wrap-col">
									<a href="#"><img src="${pageContext.request.contextPath}/WatchMovie/image/movie/10.jpg" /></a>
									<a href="#"><h4>Vero eros et accumsan et iusto odio </h4></a>
								</div>
							</div>
							<div class="col-1-3">
								<div class="wrap-col">
									<a href="#"><img src="${pageContext.request.contextPath}/WatchMovie/image/movie/13.jpg" /></a>
									<a href="#"><h4>Vero eros et accumsan et iusto odio </h4></a>
								</div>
							</div>
							<div class="col-1-3">
								<div class="wrap-col">
									<a href="#"><img src="${pageContext.request.contextPath}/WatchMovie/image/movie/6.jpg" /></a>
									<a href="#"><h4>Vero eros et accumsan et iusto odio </h4></a>
								</div>
							</div>
						</div>
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