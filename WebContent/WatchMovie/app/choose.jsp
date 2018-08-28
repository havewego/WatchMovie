<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<script src="${pageContext.request.contextPath}/WatchMovie/app/js/jquery-3.2.1.js"
	type="text/javascript" charset="utf-8"></script>
	<style type="text/css">
		.search{
			background: url(/WatchMovie/WatchMovie/app/images/search-dark.png) no-repeat 7px 6px #fcab2b;
			padding: 7px 7px 7px 25px;
			color: #fff;
			font-size: 14px;
			cursor:pointer;
			-webkit-border-radius: 4px;
		    -moz-border-radius: 4px;
		    border-radius: 4px;
		}
	</style>
	
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
    		//头像
    		$.ajax({
    			type:"post",
				url:"${pageContext.request.contextPath }/getHeadpic",
				data:{"id":0},
				success:function(data){
					document.getElementById("headpic").innerHTML=data;
				}
    		});
    	});
    	function search() {
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath }/search",
				data:{"name":$("#searchname").val()},
				success:function(data){
					var str = "";
					var movies =data["movies"]; 
					$.each(movies,function(index,obj){
			    		str +="<div class='col-1-4'>";
						str +="<div class='wrap-col'>";
						str +="<div class='post'>";
						str +="<div class='view effect'>";
						//str +="<img class='thumb' src='${pageContext.request.contextPath}/WatchMovie/image/movie/1.jpg'  />";
						str +="<img class='thumb' src='/WatchMovie/WatchMovie/image/movie/"+obj.pic+"'  />";
						str +="<div class='mask'>";	  
						str +="<a href='${pageContext.request.contextPath}/seemovie?id="+obj.id+"' class='info' title='Full Image'><img src='${pageContext.request.contextPath}/WatchMovie/app/images/play_button_64.png' /></a></div></div>";
						str +="<div class='clear'></div>";	  
						str +="<a href='${pageContext.request.contextPath}/seemovie?id="+obj.id+"'><h3>"+obj.name+"</h3></a>";	
						str +="<span>Lorem ipsum dolor sit</span></div></div></div>";		
					});
					$("#moviediv").empty();
					$("#moviediv").append(str);
					var page = data["pages"];
					var st = "";
					for(var j=0; j<parseInt(page);j++){
						if(j==0){
							st +="<span class='page active'>"+(j+1)+"</span>";
						}else{
							st +="<a href='${pageContext.request.contextPath}/looksearch?page="+(j+1)+"&type="+data["movietype"]+"' class='page gradient'>"+(j+1)+"</a>";
						}
					}
					$("#page").empty();
					$("#page").append(st);
					
				}
			});	
		}
    	function searchtype() {
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath }/searchtype",
				data:{"type":$("#type").val()},
				success:function(data){
					var str = "";
					var movies =data["movies"]; 
					$.each(movies,function(index,obj){
			    		str +="<div class='col-1-4'>";
						str +="<div class='wrap-col'>";
						str +="<div class='post'>";
						str +="<div class='view effect'>";
						//str +="<img class='thumb' src='${pageContext.request.contextPath}/WatchMovie/image/movie/1.jpg'  />";
						str +="<img class='thumb' src='/WatchMovie/WatchMovie/image/movie/"+obj.pic+"'  />";
						str +="<div class='mask'>";	  
						str +="<a href='${pageContext.request.contextPath}/seemovie?id="+obj.id+"' class='info' title='Full Image'><img src='${pageContext.request.contextPath}/WatchMovie/app/images/play_button_64.png' /></a></div></div>";
						str +="<div class='clear'></div>";	  
						str +="<a href='${pageContext.request.contextPath}/seemovie?id="+obj.id+"'><h3>"+obj.name+"</h3></a>";	
						str +="<span>Lorem ipsum dolor sit</span></div></div></div>";		
					});
					$("#moviediv").empty();
					$("#moviediv").append(str);
					var page = data["pages"];
					var st = "";
					for(var j=0; j<parseInt(page);j++){
						if(j==0){
							st +="<span class='page active'>"+(j+1)+"</span>";
						}else{
							st +="<a href='${pageContext.request.contextPath}/looktype?page="+(j+1)+"&type="+data["movietype"]+"' class='page gradient'>"+(j+1)+"</a>";
						}
					}
					$("#page").empty();
					$("#page").append(st);
					
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
					<form id="search">
					  <input name="name" id="searchname" type="text" size="40" placeholder="Search..." />
					  <input class="search" type="button" value="Submit" onclick="search()"/>
					</form>
				</div>
			</div>
			<div class="col-1-3">
				<div class="wrap-col">
					<div id="headpic" class="col-1-3" >
						<!-- <img alt="" src="/WatchMovie/WatchMovie/image/User/public.jpg" class="img-circle" style="height:80px;width:80px"> -->
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
<div class="copyrights">Collect from <a href="http://www.cssmoban.com/" >ä¼ä¸ç½ç«æ¨¡æ¿</a></div>

<!--////////////////////////////////////Container-->
<section id="container">
	<div class="wrap-container zerogrid">
		<div id="main-content" class="col-2-3">
			<div class="wrap-content">
				<div class="movie">
					<div class="row type">
						<div class="title">
							<center><h2>MOVIE</h2></center>
						</div>
						<ul>
							<li>
								<select id="type">
									<option value="audi" selected>Type</option>
									<option value="动作">动作</option>
									<option value="喜剧">喜剧</option>
									<option value="科幻">科幻</option>
									<option value="枪战">枪战</option>
								</select>
							</li>
							<li><a class="button " href="#" onclick="searchtype()">Search</a></li>
						</ul>
					</div>
					<div id="MovieAndPage">
						<div class="row" id="moviediv">
							<!-- 电影 -->
							<c:forEach items="${movies}" var="movie">
								<div class="col-1-4">
									<div class="wrap-col">
										<div class="post">
											<div class="view effect">  
											 <img class="thumb" src="${pageContext.request.contextPath}/WatchMovie/image/movie/${movie.pic}"  /> 
											  <div class="mask">  
												<a href="${pageContext.request.contextPath}/seemovie?id=${movie.id}" class="info" title="Full Image"><img src="${pageContext.request.contextPath}/WatchMovie/app/images/play_button_64.png" /></a> 
											  </div>
											</div>
											<a href="single.jsp"><h3>${movie.name}</h3></a>
											<span>Lorem ipsum dolor sit</span>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					
						<center><div class="pagination" id="page">
							${guide}
						</div></center>
					</div>
				</div>
				<div class="serie">
					<div class="row type">
						<div class="title">
							<center><h2>SERIE</h2></center>
						</div>
						<ul>
							<li>
								<select>
									<option value="audi" selected>Type</option>
									<option value="volvo">Text Text</option>
									<option value="saab">Text Text</option>
									<option value="volvo">Text Text</option>
									<option value="saab">Text Text</option>
									<option value="volvo">Text Text</option>
									<option value="saab">Text Text</option>
									<option value="volvo">Text Text</option>
									<option value="saab">Text Text</option>
									<option value="volvo">Text Text</option>
									<option value="saab">Text Text</option>
								</select>
							</li>
							
							<li><a class="button " href="#">Search</a></li>
						</ul>
					</div>
					<div class="row">
						<div class="col-1-4">
							<div class="wrap-col">
								<div class="post">
									<div class="view effect">  
									  <img class="thumb" src="${pageContext.request.contextPath}/WatchMovie/image/movie/9.jpg"  /> 
									  <div class="mask">  
										<a href="single.jsp" class="info" title="Full Image"><img src="${pageContext.request.contextPath}/WatchMovie/app/images/play_button_64.png" /></a>  
									  </div>  
									</div>
									<a href="single.jsp"><h3>Film's Name</h3></a>
									<span>Lorem ipsum dolor sit</span>
								</div>
							</div>
						</div>
						<div class="col-1-4">
							<div class="wrap-col">
								<div class="post">
									<div class="view effect">  
									  <img class="thumb" src="${pageContext.request.contextPath}/WatchMovie/image/movie/10.jpg"  /> 
									  <div class="mask">  
										<a href="single.jsp" class="info" title="Full Image"><img src="${pageContext.request.contextPath}/WatchMovie/app/images/play_button_64.png" /></a> 
									  </div>  
									</div>
									<a href="single.jsp"><h3>Film's Name</h3></a>
									<span>Lorem ipsum dolor sit</span>
								</div>
							</div>
						</div>
						<div class="col-1-4">
							<div class="wrap-col">
								<div class="post">
									<div class="view effect">  
									 <img class="thumb" src="${pageContext.request.contextPath}/WatchMovie/image/movie/4.jpg"  /> 
									  <div class="mask">  
										<a href="single.jsp" class="info" title="Full Image"><img src="${pageContext.request.contextPath}/WatchMovie/app/images/play_button_64.png" /></a> 
									  </div>  
									</div>
									<a href="single.jsp"><h3>Film's Name</h3></a>
									<span>Lorem ipsum dolor sit</span>
								</div>
							</div>
						</div>
						<div class="col-1-4">
							<div class="wrap-col">
								<div class="post">
									<div class="view effect"> 
									  <img class="thumb" src="${pageContext.request.contextPath}/WatchMovie/image/movie/11.jpg"  />  
									  <div class="mask">  
										<a href="single.jsp" class="info" title="Full Image"><img src="${pageContext.request.contextPath}/WatchMovie/app/images/play_button_64.png" /></a> 
									  </div>  
									</div>
									<a href="single.jsp"><h3>Film's Name</h3></a>
									<span>Lorem ipsum dolor sit</span>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-1-4">
							<div class="wrap-col">
								<div class="post">
									<div class="view effect">  
									  <img class="thumb" src="${pageContext.request.contextPath}/WatchMovie/image/movie/12.jpg"  />   
									  <div class="mask">  
										<a href="single.jsp" class="info" title="Full Image"><img src="${pageContext.request.contextPath}/WatchMovie/app/images/play_button_64.png" /></a> 
									  </div>  
									</div>
									<a href="single.jsp"><h3>Film's Name</h3></a>
									<span>Lorem ipsum dolor sit</span>
								</div>
							</div>
						</div>
						<div class="col-1-4">
							<div class="wrap-col">
								<div class="post">
									<div class="view effect">  
									  <img class="thumb" src="${pageContext.request.contextPath}/WatchMovie/image/movie/13.jpg"  />   
									  <div class="mask">  
										<a href="single.jsp" class="info" title="Full Image"><img src="${pageContext.request.contextPath}/WatchMovie/app/images/play_button_64.png" /></a>  
									  </div>  
									</div>
									<a href="single.jsp"><h3>Film's Name</h3></a>
									<span>Lorem ipsum dolor sit</span>
								</div>
							</div>
						</div>
						<div class="col-1-4">
							<div class="wrap-col">
								<div class="post">
									<div class="view effect">  
									  <img class="thumb" src="${pageContext.request.contextPath}/WatchMovie/image/movie/19.jpg"  /> 
									  <div class="mask">  
										<a href="single.jsp" class="info" title="Full Image"><img src="${pageContext.request.contextPath}/WatchMovie/app/images/play_button_64.png" /></a>  
									  </div>  
									</div>
									<a href="single.jsp"><h3>Film's Name</h3></a>
									<span>Lorem ipsum dolor sit</span>
								</div>
							</div>
						</div>
						<div class="col-1-4">
							<div class="wrap-col">
								<div class="post">
									<div class="view effect">  
									  <img class="thumb" src="${pageContext.request.contextPath}/WatchMovie/image/movie/20.jpg"  />   
									  <div class="mask">  
										<a href="single.jsp" class="info" title="Full Image"><img src="${pageContext.request.contextPath}/WatchMovie/app/images/play_button_64.png" /></a>  
									  </div>  
									</div>
									<a href="single.jsp"><h3>Film's Name</h3></a>
									<span>Lorem ipsum dolor sit</span>
								</div>
							</div>
						</div>
					</div>
					<center><div class="pagination">
						<a href="#" class="page gradient">first</a><a
						href="#" class="page gradient">2</a><a href="#"
						class="page gradient">3</a><span class=
						"page active">4</span><a href="#" class=
						"page gradient">5</a><a href="#" class=
						"page gradient">6</a><a href="#" class=
						"page gradient">last</a>
					</div></center>
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
							<div class="logo"><a href="#"><img src="${pageContext.request.contextPath}/WatchMovie/app/images/logo.png"/></a></div>
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
		<div class="wrap-bottom ">
			<div class="copyright">
				<p>Â©2015 - More Templates <a href="http://www.cssmoban.com/" target="_blank" title="æ¨¡æ¿ä¹å®¶">æ¨¡æ¿ä¹å®¶</a> - Collect from <a href="http://www.cssmoban.com/" title="ç½é¡µæ¨¡æ¿" target="_blank">ç½é¡µæ¨¡æ¿</a></p>
			</div>
		</div>
	</div>
</footer>


</div>
<script src="${pageContext.request.contextPath}/WatchMovie/app/js/css3-mediaqueries.js"></script>
<script src="${pageContext.request.contextPath}/WatchMovie/app/js/jquery.min.js"></script>
</body></html>