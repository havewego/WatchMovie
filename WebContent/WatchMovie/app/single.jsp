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
			var userid = "${userid}";
			if(userid==""){
				$("#contentlogin").show();
			}else{
				$("#contentlogin").hide();
			}
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
			//头像
			$.ajax({
    			type:"post",
				url:"${pageContext.request.contextPath }/getHeadpic",
				data:{"id":0},
				success:function(data){
					
					document.getElementById("headpic").innerHTML=data;
				}
    		});
			//留言
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath }/showmoviecontent",
				data:{"page":1,"movieid":'${movie.id}'},
				success:function(data){
					$("#allconment").empty();
					$("#allconment").append(data);
				}
			});
		});
		function addcontent(){
			/* var text = $("#content").val();
			location.href="${pageContext.request.contextPath }/addcontent?text="+text; */
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath }/addcontent",
				data:{"text":$("#content").val(),"movieid":'${movie.id}'},
				success:function(data){
					if(data=='error'){
						location.href="${pageContext.request.contextPath }/WatchMovie/app/login.jsp";
					}else{
						$("#content").val("");
						$("#allconment").empty();
						$("#allconment").append(data);
					}
					
				}
			});
		}
		function jump(i){
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath }/showmoviecontent",
				data:{"page":i,"movieid":'${movie.id}'},
				success:function(data){
					$("#allconment").empty();
					$("#allconment").append(data);
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
	
	<div class="wrap-header zerogrid" >
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
					<div class="art-header" style="height: auto">
						
								<%-- <head>
									<meta charset="utf-8">
									<title>Video.js 7.0</title>
									<link href="${pageContext.request.contextPath}/WatchMovie/app/css/video-js.min.css" rel="stylesheet">
									<style>
								body {
									background-color: #191919
								}
								
								</style>
									</head>
								
									<body>
								    <div class="m">
								      <video id="my-video" class="video-js" controls preload="auto" width="780px"
										  poster="${pageContext.request.contextPath}/WatchMovie/image/movie/${movie.pic}" data-setup="{}">
										 <source src="http://vjs.zencdn.net/v/oceans.mp4" type="video/mp4">
								        <!-- <source src="http://vali-dns.cp31.ott.cibntv.net/6975699D7B63171385A7E27BB/03000A0F0159C9DDEB07B700000001F08E4F88-A9EF-8E34-7AA0-134E9B1F3CEC.mp4?ccode=0502&duration=391&expire=18000&psid=280e1d0965575e089480318645441529&sp=&ups_client_netip=7407124f&ups_ts=1535279880&ups_userid=&utid=E2XLE9ajo1wCAduGttCv21bC&vid=XMjc5NDk0Mzk2MA%3D%3D&vkey=B1a77b635e014c4c68496f0d4c7459d38&s=380c1e43912711e69c81" type="video/mp4">
								    	 -->
								    	<source src="http://vjs.zencdn.net/v/oceans.webm" type="video/webm">
								    	<source src="http://vjs.zencdn.net/v/oceans.ogv" type="video/ogg">
								        <p class="vjs-no-js"> To view this video please enable JavaScript, and consider upgrading to a web browser that <a href="http://videojs.com/html5-video-support/" target="_blank">supports HTML5 video</a> </p>
								      </video>
								      <script src="${pageContext.request.contextPath}/WatchMovie/app/js/video.min.js"></script> 
								      <script src="http://vjs.zencdn.net/5.19/lang/zh-CN.js"></script>
								      <script type="text/javascript">
											var myPlayer = videojs('my-video');
											videojs("my-video").ready(function(){
												var myPlayer = this;
												myPlayer.play();
											});
											  
										</script> 
								    </div>
								</body> --%>
								<embed src='${movie.url}' allowFullScreen='true' quality='high' width='780' height='400' align='middle' allowScriptAccess='always' type='application/x-shockwave-flash' style='margin-bottom: 20px;'></embed>
					</div>
					<!-- 写评论 -->
					<div class="art-content">
						<div class="comment-form ">
							<div class="form-cell form-content commentFormContent">
									<div class="form-user-info">
										<div id="contentlogin">
											<a href="${pageContext.request.contextPath}/WatchMovie/app/login.jsp" class="form-user-login" hzcharset="hz-4003764-1000494" style="color: white; " charset="404-0-1">登录</a>
											<span>|</span>
											<a href="${pageContext.request.contextPath}/WatchMovie/app/login.jsp" target="_blank" style="color: white;">注册</a>
										</div>
									</div>
									<div class="form-wordlimit"><span class="form-wordlimit-input input-count">0</span><span class="form-wordlimit-upper">/300</span></div>
									<div class="form-textarea form-textarea-picdom">
										<textarea data-maxlength="300" id="content" name="content" placeholder="快来说说想法吧～" style="height: auto"></textarea>
										
									</div>
							
									<div class="form-toolbar">
										<div class="form-toolbar-right">
											<div class="form-tool form-action">
													<a href="#" onclick="addcontent()" class="form-btn form-btn-large form-btn-submit">发表评论</a>
												
											</div>
											<div class="form-tooltip" style="display:none">
												<div class="com_overlay_con">
													<div class="tips"></div>
												</div>
											</div>
										</div>
									</div>
							
								</div>
						</div>
					</div>
					
					<!-- 所有评论 -->
					
					<div class="art-content"  style="margin-top: 30px">
						<h2>所有评论：</h2>
						<hr/>
						<div class="comment-item" id="allconment" style="margin-top: 20px;height: 1155px;">
							
						</div>
						
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