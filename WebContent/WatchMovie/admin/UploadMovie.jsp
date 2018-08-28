<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    
    <head>
        <title>Forms</title>
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/WatchMovie/admin/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="${pageContext.request.contextPath}/WatchMovie/admin/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
        <link href="${pageContext.request.contextPath}/WatchMovie/admin/assets/styles.css" rel="stylesheet" media="screen">
        <!--[if lte IE 8]><script language="javascript" type="text/javascript" src="vendors/flot/excanvas.min.js"></script><![endif]-->
        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/WatchMovie/admin/js/jquery-3.2.1.js"></script>
        <script type="text/javascript">
        	$(function(){
        		//判断是更新还是上传
        		if("${movie.id}"==""){
        			//alert("${movie.id}");
    			}else{
    				$("#updateMovie").show();
    				$("#uploadMovie").hide();
    			}
        		//判断是否已登陆
        		var adminid = "${adminid}";
        		if(adminid==""){
        			//location.href="${pageContext.request.contextPath}/WatchMovie/admin/Login.jsp";
        			//alert("未登录！");
        		}else{
        			$("#adminid").html(adminid);
        		}
        		//若上传失败显示的信息
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
        			}
        		});
        	});
        	
        	function PreviewImage(imgFile){
        		var url = URL.createObjectURL(imgFile.files[0]);
        		var div1 = document.getElementById("imgPreview1");
        		var div2 = document.getElementById("imgPreview2");
        		div1.innerHTML = "<img src='"+url+"' class='img-rounded' style='width:200px;'/>";
        		div2.innerHTML = "<img src='"+url+"' class='img-rounded' style='width:200px;'/>";
        	}
        	/* function test(){
        		if($("#introduction").val()==""){
        			alert("没写介绍！");
        			alert($("#exampleInputFile").val());
        			if($("#type").val()==""){
        				alert("没写类型！");
        			}else{
        				alert($("#type").val());
        			}
        		}else{
        			alert($("#introduction").val());
        			if($("#type").val()==""){
        				alert("没写类型！");
        			}else{
        				alert($("#type").val());
        			}
        		}+/+9+
        	} */
        	
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
                                    </li>
                                    <li class="divider"></li> -->
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
                        <li>
                            <a href="${pageContext.request.contextPath}/WatchMovie/admin/Index.jsp"><i class="icon-chevron-right"></i>总览</a>
                        </li>
                        <!-- <li>
                            <a href="calendar.html"><i class="icon-chevron-right"></i> Calendar</a>
                        </li>
                        <li>
                            <a href="stats.html"><i class="icon-chevron-right"></i> Statistics (Charts)</a>
                        </li> -->
                        <li class="active">
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
                            <a href="${pageContext.request.contextPath}/WatchMovie/admin/Index.jsp"><span class="badge badge-success pull-right" id="alluserCount1"></span>用户</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/WatchMovie/admin/Index.jsp"><span class="badge badge-important pull-right" id="alladminCount1"></span>管理员</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/WatchMovie/admin/Index.jsp"><span class="badge badge-info pull-right" id="adminAllMovieCount1"></span>电影</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/WatchMovie/admin/Index.jsp"><span class="badge badge-warning pull-right" id="allMessCount1"></span>评论</a>
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
                      					
                     <!-- validation -->
                     <div class="row-fluid" id="updateMovie" style="display: none;">
                         <!-- block -->
                        <div class="block">
                            <div class="navbar navbar-inner block-header">
                                <div class="muted pull-left">更新电影资料</div>
                            </div>
                            <div class="block-content collapse in">
                                <div class="span12">
                                <h4><small style="color: rgb(217,83,79);">带*的必须填写</small></h4>
							<!-- BEGIN FORM-->
							<form action="${pageContext.request.contextPath}/UpdateMovie" method="post" class="form-horizontal" enctype="multipart/form-data">
								<fieldset>
									<div class="alert alert-error hide">
										<button class="close" data-dismiss="alert"></button>
										You have some form errors. Please check below.
									</div>
									<div class="alert alert-success hide">
										<button class="close" data-dismiss="alert"></button>
										Your form validation is successful!
									</div>
									<div class="control-group">
		  								<label class="control-label">电影ID<span class="required">*</span></label>
		  								<div class="controls">
		  									<input type="text" id="uid" value="${movie.id}" name="uid" data-required="1" class="span6 m-wrap" readonly="readonly"/>
		  								</div>
		  							</div>
		  							<div class="control-group">
		  								<label class="control-label">电影名字<span class="required">*</span></label>
		  								<div class="controls">
		  									<input type="text" id="uname" value="${movie.name}" required="required" name="uname" onblur="test()" data-required="1" class="span6 m-wrap"/>
		  								</div>
		  							</div>
		  							<div class="control-group">
		  								<label class="control-label">电影介绍<span class="required"></span></label>
		  								<div class="controls" style="width: ">
		  									<!-- <input name="url" type="text" class="span6 m-wrap"/> -->
		  									<textarea id="uintroduction"  name="uintroduction" required="required" placeholder="不写介绍默认是之前的介绍～"  class="span6 m-wrap">${movie.introduction}</textarea>
		  								</div>
		  							</div>
		  							<!-- 若自己上传的电影，把文本类型改为文件类型 -->
		  							<div class="control-group">
		  								<label class="control-label">电影地址<span class="required">*</span></label>
		  								<div class="controls">
		  									<input name="uurl" id="uurl" value="${movie.url}" required="required" type="text" class="span6 m-wrap"/>
		  									<span class="help-block">e.g: http://www.demo.com or http://demo.com</span>
		  								</div>
		  							</div>
		  							<div class="control-group">
		  								<label class="control-label">电影类型<span class="required">*</span></label>
		  								<div class="controls">
		  									<select class="span6 m-wrap" name="utype" id="utype" required="required">
		  										<option value="${movie.type}">类型..(不写默认是之前的)</option>
		  										<option value="动作">动作</option>
												<option value="喜剧">喜剧</option>
												<option value="科幻">科幻</option>
												<option value="枪战">枪战</option>
		  									</select>
		  								</div>
		  							</div>
		  							<div class="control-group">
		  								<label class="control-label">电影海报<span class="required"></span></label>
		  								<div class="controls">
		  									<input type="file" onchange="PreviewImage(this)" name="upic" id="exampleInputFile" class="span6 m-wrap">
		  									<!-- <input name="upic" onchange="PreviewImage(this)" id="exampleInputFile" type="file" class="span6 m-wrap" style="box-shadow: inset 1px 1px 1px rgba(0,0,0,.075); border-radius: 4px;"/> -->
		  									<span class="help-block"><h3><small>不选择图片默认就是之前的电影海报。。</small></h3></span>
		  								</div>
		  							</div>
		  							<div class="control-group" >
			  							<div class="span3"></div>
			  							<div id="imgPreview1" name="image"></div>
			  						</div>
		  							<div class="form-actions">
		  								<button type="submit" class="btn btn-primary">提交更新</button>
		  								<button type="reset" onclick="test()" class="btn">重置</button>
		  							</div>
								</fieldset>
							</form>
							<!-- END FORM-->
						</div>
					    </div>
					</div>
		                     	<!-- /block -->
				    </div>
                    <div class="row-fluid" id="uploadMovie">
                         <!-- block -->
                        <div class="block">
                            <div class="navbar navbar-inner block-header">
                                <div class="muted pull-left">电影资料</div>
                            </div>
                            <div class="block-content collapse in">
                                <div class="span12">
                                <h4><small style="color: rgb(217,83,79);">带*的必须填写</small></h4>
							<!-- BEGIN FORM-->
							<form action="${pageContext.request.contextPath}/UploadMovie" method="post" class="form-horizontal" enctype="multipart/form-data">
								<fieldset>
									<div class="alert alert-error hide">
										<button class="close" data-dismiss="alert"></button>
										You have some form errors. Please check below.
									</div>
									<div class="alert alert-success hide">
										<button class="close" data-dismiss="alert"></button>
										Your form validation is successful!
									</div>
		  							<div class="control-group">
		  								<label class="control-label">电影名字<span class="required">*</span></label>
		  								<div class="controls">
		  									<input type="text" id="name" name="name" data-required="1" required="required" class="span6 m-wrap"/>
		  								</div>
		  							</div>
		  							<div class="control-group">
		  								<label class="control-label">电影介绍<span class="required">*</span></label>
		  								<div class="controls" style="width: ">
		  									<!-- <input name="url" type="text" class="span6 m-wrap"/> -->
		  									<textarea id="introduction" name="introduction" required="required" placeholder="电影介绍。。" class="span6 m-wrap"></textarea>
		  								</div>
		  							</div>
		  							<!-- 若自己上传的电影，把文本类型改为文件类型 -->
		  							<div class="control-group">
		  								<label class="control-label">电影地址<span class="required">*</span></label>
		  								<div class="controls">
		  									<input name="url" id="url" type="text" class="span6 m-wrap" required="required"/>
		  									<span class="help-block">e.g: http://www.demo.com or http://demo.com</span>
		  								</div>
		  							</div>
		  							<div class="control-group">
		  								<label class="control-label">电影类型<span class="required">*</span></label>
		  								<div class="controls">
		  									<select class="span6 m-wrap" name="type" id="type" required="required">
		  										<option value="">类型...</option>
		  										<option value="动作">动作</option>
												<option value="喜剧">喜剧</option>
												<option value="科幻">科幻</option>
												<option value="枪战">枪战</option>
		  									</select>
		  								</div>
		  							</div>
		  							<div class="control-group">
		  								<label class="control-label">电影海报<span class="required">*</span></label>
		  								<div class="controls">
		  									<input name="pic" required="required" onchange="PreviewImage(this)" id="exampleInputFile" type="file" class="span6 m-wrap" style="box-shadow: inset 1px 1px 1px rgba(0,0,0,.075); border-radius: 4px;"/>
		  								</div>
		  							</div>
		  							<div class="control-group" >
			  							<div class="span3"></div>
			  							<div id="imgPreview2" name="image"></div>
			  						</div>
		  							<div class="form-actions">
		  								<button type="submit" class="btn btn-primary">上传</button>
		  								<button type="reset" class="btn">重置</button>
		  							</div>
								</fieldset>
							</form>
					<!-- END FORM-->
				</div>
			    </div>
			</div>
                     	<!-- /block -->
		    </div>
                     <!-- /validation -->
                </div>
            </div>
            <hr>
            <footer>
                <p>&copy; Vincent Gabriel 2013 - More Templates <a href="http://www.cssmoban.com/" target="_blank" title="cssmoban">cssmoban</a>
            </footer>
        </div>
        <!--/.fluid-container-->
        <link href="${pageContext.request.contextPath}/WatchMovie/admin/vendors/datepicker.css" rel="stylesheet" media="screen">
        <link href="${pageContext.request.contextPath}/WatchMovie/admin/vendors/uniform.default.css" rel="stylesheet" media="screen">
        <link href="${pageContext.request.contextPath}/WatchMovie/admin/vendors/chosen.min.css" rel="stylesheet" media="screen">

        <link href="${pageContext.request.contextPath}/WatchMovie/admin/vendors/wysiwyg/bootstrap-wysihtml5.css" rel="stylesheet" media="screen">

        <script src="${pageContext.request.contextPath}/WatchMovie/admin/vendors/jquery-1.9.1.js"></script>
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/vendors/jquery.uniform.min.js"></script>
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/vendors/chosen.jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/vendors/bootstrap-datepicker.js"></script>

        <script src="${pageContext.request.contextPath}/WatchMovie/admin/vendors/wysiwyg/wysihtml5-0.3.0.js"></script>
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/vendors/wysiwyg/bootstrap-wysihtml5.js"></script>

        <script src="${pageContext.request.contextPath}/WatchMovie/admin/vendors/wizard/jquery.bootstrap.wizard.min.js"></script>

		<script type="text/javascript" src="${pageContext.request.contextPath}/WatchMovie/admin/vendors/jquery-validation/dist/jquery.validate.min.js"></script>
		<script src="${pageContext.request.contextPath}/WatchMovie/admin/assets/form-validation.js"></script>
        
		<script src="${pageContext.request.contextPath}/WatchMovie/admin/assets/scripts.js"></script>
    </body>

</html>