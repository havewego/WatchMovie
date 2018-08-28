<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bootstrap Registration Form Template</title>

        <!-- CSS -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/css/form-elements.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/css/style.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

        <!-- Favicon and touch icons -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/ico/favicon.png">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/ico/apple-touch-icon-57-precomposed.png">
		<script src="${pageContext.request.contextPath}/WatchMovie/admin/js/jquery-3.2.1.js"
			type="text/javascript" charset="utf-8"></script>
		<style type="text/css">
			.pormat{
				color: #19b9e7;
				text-align: center;
				height: 20px;
			}
		</style>
		<script type="text/javascript">
			$(function(){
				if("${mess}"==""){
				}else{
					var mess ="${mess}";
					alert(mess);
				}
			});
			
			function changelogin(){
				$("#login").show();
				$("#register").hide();
			}
			function changeregister(){
				$("#login").hide();
				$("#register").show();
			}
			
			//登陆所需方法
			function logingetcode(){
				var id = $("#loginid").val();
				//alert(id);
				if(id==""){
					alert("请输入id。。。");
					return false;
				}else{
					$.ajax({
						type:"post",
						url:"${pageContext.request.contextPath}/loginsentcode",
						data:{"id":$("#loginid").val()},
						success:function(data){
							if(data=="fail"){
								alert("验证码发送失败！请检查ID后重试...");
							}else{
								alert("验证码发送成功！注意查收.....");
							}
						}
					});
				}
			}
			function checklogincode(){
				var mes = document.getElementById("logincodediv");
				$.ajax({
					type:"post",
					url:"${pageContext.request.contextPath}/judgecode",
					data:{"code":$("#logincode").val()},
					success:function(data){
						if(data=="fail"){
							mes.innerHTML="<font color='red'>验证码错误，重新输入....</font>";
						}else{
							mes.innerHTML="<font color='green'>验证码正确..</font>";
						}
					}
				});
				return true;
			}
			function checklogin(){
				var id = document.getElementById("loginid").value;
				var pwd = document.getElementById("loginpwd").value;
				var code = document.getElementById("logincode").value;
				var mess = $("#logincodediv").html();
				if(id!=""||pwd!=""||code!=""){
					if(mess=='<font color="red">验证码错误，重新输入....</font>'){
						return false;
					}else{
						return true;
					}
				}else{
					return false;
				}
			}
			//注册所需方法
			function checkid(){
				var id=document.getElementById("id").value;
				var mes=document.getElementById("iddiv");
				var reg=/^[A-Z|a-z|0-9]+$/;
				if (!reg.test(id)) {
					mes.innerHTML="管理员id不符合！";
					return false;
				} else{
					$.ajax({
						type:"post",
						url:"${pageContext.request.contextPath}/judgeAdminid",
						data:{"id":id},
						success:function(data){
							if(data=="fail"){
								mes.innerHTML="<font color='red'>该用户id已被注册，重新输入</font>";
								return false;
							}else{
								mes.innerHTML="<font color='green'>该用户id可用</font>"
								return true;
							}
							
						}
					});
					return true;
				}
			}
			function checkpwd(){
				var pwd=document.getElementById("pwd").value;
				var mes=document.getElementById("pwddiv");
				if (pwd=="") {
					mes.innerHTML="请输入密码！";
					return false;
				} else{
					mes.innerHTML="";
					return true;
				}
			}
			function checkemail(){
				var email=document.getElementById("email").value;
				var mes=document.getElementById("emaildiv");
				var reg=/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
				if (!reg.test(email)) {
					mes.innerHTML="邮箱地址不符合规范！";
					return false;
				} else{
					mes.innerHTML="";
					return true;
				}
			}
			function registergetcode(){
				$.ajax({
					type:"post",
					url:"${pageContext.request.contextPath}/sentcode",
					data:{"email":$("#email").val()},
					success:function(data){
						if(data=="fail"){
							alert("验证码发送失败！重新点击发送.....");
						}else{
							alert("验证码发送成功！注意查收.....");
						}
					}
				});
			}
			function checkcode(){
				var mes = document.getElementById("codediv");
				$.ajax({
					type:"post",
					url:"${pageContext.request.contextPath}/judgecode",
					data:{"code":$("#code").val()},
					success:function(data){
						if(data=="fail"){
							mes.innerHTML="<font color='red'>验证码错误，重新输入....</font>";
						}else{
							mes.innerHTML="<font color='green'>验证码正确..</font>";
						}
					}
				});
				return true;
			}
			function checkregister(){
				
				if (!checkid()) {
					
					return false;
				}else if(!checkcode()){
					
					return false;
				}else if(!checkpwd()){
					
					return false;
				}else{
					
					return true;
				}
			}
		</script>
    </head>

    <body style="background: url(/WatchMovie/WatchMovie/admin/assets/login/img/backgrounds/1.jpg) fixed;">

		<!-- Top menu -->
		<nav class="navbar navbar-inverse navbar-no-bg" role="navigation">
			<div class="container">
				<div style="display: inline;float: left;">
					<a href="#"><img src="${pageContext.request.contextPath}/WatchMovie/app/images/logo.png"/></a>
				</div>
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div style="clear: both;"></div>
			</div>
		</nav>

        <!-- Top content -->
        <div class="top-content">
        	
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-7 text">
                            <h1><strong>ZMovie</strong> 后台管理系统</h1>
                            <div class="description">
                            	<p>
	                            	<a href="#"><strong></strong></a>
                            	</p>
                            </div>
                            <div class="top-big-link">
                            	<!-- <a class="btn btn-link-1" href="#">Button 1</a>
                            	<a class="btn btn-link-2" href="#">Button 2</a> -->
                            </div>
                        </div>
                        <div class="col-sm-5 form-box" id="register" style="display: none;">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>Register now</h3>
                            		<p>Fill in the form below to get instant access:</p>
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-pencil"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form role="form" action="${pageContext.request.contextPath}/adminRegister" method="post" onsubmit="return checkregister()" class="registration-form">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-first-name">ID：</label>
			                        	<input type="text" name="id" onblur="checkid()" placeholder="ID..." class="form-first-name form-control" id="id" required="required">
			                        	<div id="iddiv" class="pormat"></div>
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-last-name">Pwd：</label>
			                        	<input type="password" name="pwd" onblur="checkpwd()" placeholder="Password..." class="form-last-name form-control" id="pwd" required="required">
			                        	<div id="pwddiv" class="pormat"></div>
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-email">Email：</label>
			                        	<input  type="email" name="email" onblur="checkemail()" placeholder="Email..." class="form-email form-control" id="email" style="display: inline;width: 68%" required="required">
			                        	<span><input type="button" onclick="registergetcode()" style="line-height: 1.42857143;display: inline;height: 34px" value="发送验证码"></span>
			                        	<div id="emaildiv" class="pormat"></div>
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-email">验证码：</label>
			                        	<input type="text" name="code" onblur="checkcode()" placeholder="验证码..." class="form-email form-control" id="code" required="required" style="width: 50%">
			                        	<div id="codediv" class="pormat"></div>
			                        </div>
			                        <!-- <div class="form-group">
			                        	<label class="sr-only" for="form-about-yourself">About yourself</label>
			                        	<textarea name="form-about-yourself" placeholder="About yourself..." 
			                        				class="form-about-yourself form-control" id="form-about-yourself"></textarea>
			                        </div> -->
			                        <button type="submit" class="btn">Register</button>&nbsp;&nbsp;&nbsp;<button class="btn" onclick="changelogin()">Login!</button>
			                    </form>
		                    </div>
                        </div>
                       	<div class="col-sm-5 form-box" id="login">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>Login now</h3>
                            		<p>Fill in the form below to get instant access:</p>
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-pencil"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form role="form" action="${pageContext.request.contextPath}/adminlogin" onsubmit="return checklogin()" method="post" class="registration-form">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-first-name">ID：</label>
			                        	<input type="text" name="id" placeholder="ID..." class="form-first-name form-control" id="loginid" required>
			                        	<div id="loginiddiv" class="pormat"></div>
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-last-name">Pwd：</label>
			                        	<input type="password" name="pwd" placeholder="Password..." class="form-last-name form-control" id="loginpwd" required>
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-email">验证码：</label>
			                        	<input  type="text" name="code" onblur="checklogincode()" placeholder="邮箱验证码..." class="form-email form-control" id="logincode" style="display: inline;width: 68%" required="required">
			                        	<span><input type="button" onclick="logingetcode()" style="line-height: 1.42857143;display: inline;height: 34px" value="发送验证码"></span>
			                        	<div id="logincodediv" class="pormat"></div>
			                        </div>
			                        <!-- <div class="form-group">
			                        	<label class="sr-only" for="form-last-name">Last name</label>
			                        	<input type="text" name="form-last-name" placeholder="Last name..." class="form-last-name form-control" id="form-last-name">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-email">Email</label>
			                        	<input type="text" name="email" placeholder="Email..." class="form-email form-control" id="eamil">
			                        </div> -->
			                        <!-- <div class="form-group">
			                        	<label class="sr-only" for="form-about-yourself">About yourself</label>
			                        	<textarea name="form-about-yourself" placeholder="About yourself..." 
			                        				class="form-about-yourself form-control" id="form-about-yourself"></textarea>
			                        </div> -->
			                        <button type="submit" class="btn">Login!</button>&nbsp;&nbsp;&nbsp;<button class="btn" onclick="changeregister()">Register!</button>
			                    </form>
		                    </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="copyrights">Collect from <a href="http://www.cssmoban.com/"  title="网站模板">网站模板</a></div>
        </div>


        <!-- Javascript -->
        <%-- <script src="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/js/jquery-1.11.1.min.js"></script> --%>
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/bootstrap/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/js/jquery.backstretch.min.js"></script>
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/js/retina-1.1.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/WatchMovie/admin/assets/login/js/scripts.js"></script>
        
        <!--[if lt IE 10]>
            <script src="assets/js/placeholder.js"></script>
        <![endif]-->

    </body>

</html>