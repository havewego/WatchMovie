<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js"> 
    <head>
        <title>Admin Home Page</title>
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/WatchMovie/admin/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="${pageContext.request.contextPath}/WatchMovie/admin/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
        <link href="${pageContext.request.contextPath}/WatchMovie/admin/vendors/easypiechart/jquery.easy-pie-chart.css" rel="stylesheet" media="screen">
        <link href="${pageContext.request.contextPath}/WatchMovie/admin/assets/styles.css" rel="stylesheet" media="screen">
        <link href="${pageContext.request.contextPath}/WatchMovie/admin/css/mywrite.css" rel="stylesheet" media="screen">
        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/WatchMovie/admin/js/jquery-3.2.1.js"></script>
        <style type="text/css">
        	a{
        		text-decoration: none;
        	}
        </style>
        <script type="text/javascript">
        	$(function(){
        		//判断是否已登陆
        		var adminid = "${adminid}";
        		if(adminid==""){
        			//location.href="${pageContext.request.contextPath}/WatchMovie/admin/Login.jsp";
        			//alert("未登录！");
        		}else{
        			$("#adminid").html(adminid);	
        		}
        		//显示上传或者更新成功信息
        		if("${info}"==""){
        		}else{
        			alert("${info}");
        		}
        		//展示各个信息的数量
        		$.ajax({
        			type:"post",
        			url:"${pageContext.request.contextPath}/getCount",
        			success:function(data){
        				$("#adminAllMovieCount1").html(data["movieCount"]);
            			$("#allMessCount1").html(data["messCount"]);
            			$("#alluserCount1").html(data["userCount"]);
            			$("#alladminCount1").html(data["adminCount"]);
            			$("#adminAllMovieCount2").html(data["movieCount"]);
            			$("#allMessCount2").html(data["messCount"]);
            			$("#alluserCount2").html(data["userCount"]);
            			$("#alladminCount2").html(data["adminCount"]);
            			$("#allmovierankCount").html(data["movieCount"]);
        			}
        		});
        		//展示用户信息
        		$.ajax({
        			type:"post",
    				url:"${pageContext.request.contextPath }/allUser",
    				data:{"page":1},
    				success:function(data){
    					$("#alluser").empty();
    					$("#alluser").append(data);
    				}
        		});
        		//展示管理员信息
        		$.ajax({
        			type:"post",
    				url:"${pageContext.request.contextPath }/allAdmin",
    				data:{"page":1},
    				success:function(data){
    					$("#alladmin").empty();
    					$("#alladmin").append(data);
    				}
        		});
        		//展示电影排行信息
        		$.ajax({
        			type:"post",
    				url:"${pageContext.request.contextPath }/AdminMovieRank",
    				data:{"page":1},
    				success:function(data){
    					$("#allmovierank").empty();
    					$("#allmovierank").append(data);
    				}
        		});
        		//展示留言信息
				$.ajax({
					type:"post",
    				url:"${pageContext.request.contextPath }/showAllMess",
    				data:{"page":1},
    				success:function(data){
    					$("#allMess").empty();
    					$("#allMess").append(data);
    				}
        		});
        		//全部电影展示
				$.ajax({
        			type:"post",
    				url:"${pageContext.request.contextPath }/adminAllMovie",
    				data:{"page":1},
    				success:function(data){
    					$("#adminAllMovie").empty();
    					$("#adminAllMovie").append(data);
    				}
    			});
        	});
        	//评论翻页
        	function jumpMess(i){
        		$.ajax({
        			type:"post",
    				url:"${pageContext.request.contextPath }/showAllMess",
    				data:{"page":i},
    				success:function(data){
    					$("#allMess").empty();
    					$("#allMess").append(data);
    				}
    			});
        	}
        	//用户翻页
        	function jumpUser(i){
        		$.ajax({
        			type:"post",
    				url:"${pageContext.request.contextPath }/allUser",
    				data:{"page":i},
    				success:function(data){
    					$("#alluser").empty();
    					$("#alluser").append(data);
    				}
    			});
        	}
        	//管理员翻页
        	function jumpAdmin(i){
        		$.ajax({
        			type:"post",
    				url:"${pageContext.request.contextPath }/allAdmin",
    				data:{"page":i},
    				success:function(data){
    					$("#alladmin").empty();
    					$("#alladmin").append(data);
    				}
    			});
        	}
        	//排行电影翻页
        	function jumpMovie(i){
        		$.ajax({
        			type:"post",
    				url:"${pageContext.request.contextPath }/AdminMovieRank",
    				data:{"page":i},
    				success:function(data){
    					$("#allmovierank").empty();
    					$("#allmovierank").append(data);
    				}
    			});
        	}
        	//全部电影翻页jumpAllMovie
        	function jumpAllMovie(i){
        		$.ajax({
        			type:"post",
    				url:"${pageContext.request.contextPath }/adminAllMovie",
    				data:{"page":i},
    				success:function(data){
    					$("#adminAllMovie").empty();
    					$("#adminAllMovie").append(data);
    				}
    			});
        	}
        </script>
    </head>
    <body style="background: url(/WatchMovie/WatchMovie/admin/assets/login/img/backgrounds/1.jpg) fixed;">
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span>
                     <span class="icon-bar"></span>
                     <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="#">Admin Panel</a>
                    <div class="nav-collapse collapse">
                        <ul class="nav pull-right">
                            <li class="dropdown">
                                <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-user"></i><span id="adminid">name</span><i class="caret"></i>

                                </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a tabindex="-1" href="#">Profile</a>
                                    </li>
                                    <li class="divider"></li>
                                    <li>
                                        <a tabindex="-1" href="${pageContext.request.contextPath}/adminExit">退出</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                        <ul class="nav">
                            <li class="active">
                                <a href="#">总览</a>
                            </li>
                            <li class="dropdown">
                                <a href="#" data-toggle="dropdown" class="dropdown-toggle">Settings <b class="caret"></b>

                                </a>
                                <ul class="dropdown-menu" id="menu1">
                                    <li>
                                        <a href="#">Tools <i class="icon-arrow-right"></i>

                                        </a>
                                        <ul class="dropdown-menu sub-menu">
                                            <li>
                                                <a href="#">Reports</a>
                                            </li>
                                            <li>
                                                <a href="#">Logs</a>
                                            </li>
                                            <li>
                                                <a href="#">Errors</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <!-- <li>
                                        <a href="#">SEO Settings</a>
                                    </li>
                                    <li>
                                        <a href="#">Other Link</a>
                                    </li>
                                    <li class="divider"></li>
                                    <li>
                                        <a href="#">Other Link</a>
                                    </li>
                                    <li>
                                        <a href="#">Other Link</a>
                                    </li> -->
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">Content <i class="caret"></i>

                                </a>
                                <ul class="dropdown-menu">
                                    <!-- <li>
                                        <a tabindex="-1" href="#">Blog</a>
                                    </li>
                                    <li>
                                        <a tabindex="-1" href="#">News</a>
                                    </li>
                                    <li>
                                        <a tabindex="-1" href="#">Custom Pages</a>
                                    </li>
                                    <li>
                                        <a tabindex="-1" href="#">Calendar</a>
                                    </li> -->
                                    <li class="divider"></li>
                                    <li>
                                        <a tabindex="-1" href="#">FAQ</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">Users <i class="caret"></i>

                                </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a tabindex="-1" href="#">User List</a>
                                    </li>
                                    <li>
                                        <a tabindex="-1" href="#">Search</a>
                                    </li>
                                    <li>
                                        <a tabindex="-1" href="#">Permissions</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <!--/.nav-collapse -->
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span3" id="sidebar">
                    <ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
                        <li class="active">
                            <a href="${pageContext.request.contextPath}/WatchMovie/admin/Index.jsp"><i class="icon-chevron-right"></i>总览</a>
                        </li>
                        <!-- <li>
                            <a href="calendar.html"><i class="icon-chevron-right"></i> Calendar</a>
                        </li>
                        <li>
                            <a href="stats.html"><i class="icon-chevron-right"></i> Statistics (Charts)</a>
                        </li> -->
                        <li>
                            <a href="${pageContext.request.contextPath}/WatchMovie/admin/UploadMovie.jsp"><i class="icon-chevron-right"></i>上传电影</a>
                        </li>
                        <!-- <li>
                            <a href="tables.html"><i class="icon-chevron-right"></i> Tables</a>
                        </li>
                        <li>
                            <a href="buttons.html"><i class="icon-chevron-right"></i> Buttons & Icons</a>
                        </li>
                        <li>
                            <a href="editors.html"><i class="icon-chevron-right"></i> WYSIWYG Editors</a>
                        </li>
                        <li>
                            <a href="interface.html"><i class="icon-chevron-right"></i> UI & Interface</a>
                        </li> -->
                        <li>
                            <a href="#"><span class="badge badge-success pull-right" id="alluserCount2"></span>用户</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-important pull-right" id="alladminCount2"></span>管理员</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-info pull-right" id="adminAllMovieCount2"></span>电影</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-warning pull-right" id="allMessCount2"></span>评论</a>
                        </li>
                        <!-- <li>
                            <a href="#"><span class="badge badge-info pull-right">2,221</span> Messages</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-info pull-right">11</span> Reports</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-important pull-right">83</span> Errors</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-warning pull-right">4,231</span> Logs</a>
                        </li> -->
                    </ul>
                </div>
                
                <!--/span-->
                <div class="span9" id="content">
                    <div class="row-fluid">
                        <!-- <div class="alert alert-success">
							<button type="button" class="close" data-dismiss="alert">&times;</button>
                            <h4>Success</h4>
                        	The operation completed successfully</div> -->
                        	<div class="navbar">
                            	<div class="navbar-inner">
	                                <ul class="breadcrumb">
	                                    <i class="icon-chevron-left hide-sidebar"><a href='#' title="Hide Sidebar" rel='tooltip'>&nbsp;</a></i>
	                                    <i class="icon-chevron-right show-sidebar" style="display:none;"><a href='#' title="Show Sidebar" rel='tooltip'>&nbsp;</a></i>
	                                    <li>
	                                        <a href="#">Dashboard</a> <span class="divider">/</span>	
	                                    </li>
	                                    <li>
	                                        <a href="#">Settings</a> <span class="divider">/</span>	
	                                    </li>
	                                    <li class="active">Tools</li>
	                                </ul>
                            	</div>
                        	</div>
                    	</div>
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <div class="navbar navbar-inner block-header">
                                <div class="muted pull-left">Statistics</div>
                                <div class="pull-right"><span class="badge badge-warning">View More</span>

                                </div>
                            </div>
                            <div class="block-content collapse in">
                                <div class="span3">
                                    <div class="chart" data-percent="73">73%</div>
                                    <div class="chart-bottom-heading"><span class="label label-info">用户</span>

                                    </div>
                                </div>
                                <div class="span3">
                                    <div class="chart" data-percent="53">53%</div>
                                    <div class="chart-bottom-heading"><span class="label label-info">管理员</span>

                                    </div>
                                </div>
                                <div class="span3">
                                    <div class="chart" data-percent="83">83%</div>
                                    <div class="chart-bottom-heading"><span class="label label-info">电影</span>

                                    </div>
                                </div>
                                <div class="span3">
                                    <div class="chart" data-percent="13">13%</div>
                                    <div class="chart-bottom-heading"><span class="label label-info">评论</span>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /block -->
                    </div>
                    <div class="row-fluid">
                        <div class="span6">
                            <!-- block -->
                            <div class="block">
                                <div class="navbar navbar-inner block-header">
                                    <div class="muted pull-left">用户</div>
                                    <div class="pull-right"><span class="badge badge-info" id="alluserCount1"></span>

                                    </div>
                                </div>
                                <div class="block-content collapse in" id="alluser" style="height: 392.4px">
                                    
                                </div>
                            </div>
                            <!-- /block -->
                        </div>
                        <div class="span6">
                            <!-- block -->
                            <div class="block">
                                <div class="navbar navbar-inner block-header">
                                    <div class="muted pull-left">管理员</div>
                                    <div class="pull-right"><span class="badge badge-info" id="alladminCount1"></span>

                                    </div>
                                </div>
                                <div class="block-content collapse in" id="alladmin" style="height: 392.4px">
                                    
                                </div>
                            </div>
                            <!-- /block -->
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div class="span6">
                            <!-- block -->
                            <div class="block">
                                <div class="navbar navbar-inner block-header">
                                    <div class="muted pull-left" >电影排行</div>
                                    <div class="pull-right"><span class="badge badge-info" id="allmovierankCount"></span>

                                    </div>
                                </div>
                                <div class="block-content collapse in" id="allmovierank" style="height: 392.4px;">
                                    
                                </div>
                            </div>
                          <!--   /block -->
                        </div>
                        <div class="span6">
                            <!-- block -->
                            <div class="block">
                                <div class="navbar navbar-inner block-header">
                                    <div class="muted pull-left">最新评论</div>
                                    <div class="pull-right"><span class="badge badge-info" id="allMessCount1"></span>

                                    </div>
                                </div>
                                <div class="block-content collapse in" id="allMess" style="height: 392.4px">
                                    
                                </div>
                            </div>
                            <!-- /block -->
                        </div>
                    </div>
                    <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <div class="navbar navbar-inner block-header">
                                <div class="muted pull-left">全部电影</div>
                                <div class="pull-right"><span class="badge badge-info" id="adminAllMovieCount1"></span>
                                </div>
                            </div>
                            <div class="block-content collapse in" id="adminAllMovie" style="height: 700px">
                                <!-- 显示所有电影 -->        
                            </div>
                        </div>
                        <!-- /block -->
                    </div>
                </div>
            </div>
            <hr>
            <footer>
                <p>&copy; Vincent Gabriel 2013 - More Templates <a href="http://www.cssmoban.com/" target="_blank" title="cssmoban">cssmoban</a>
            </footer>
        </div>
        <!--/.fluid-container-->
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/vendors/jquery-1.9.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/vendors/easypiechart/jquery.easy-pie-chart.js"></script>
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/assets/scripts.js"></script>
        <script>
        $(function() {
            // Easy pie charts
            $('.chart').easyPieChart({animate: 1000});
        });
        </script>
    </body>

</html>