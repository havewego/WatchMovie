<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Home</title>
<!-- Custom Theme files -->
<link href="${pageContext.request.contextPath}/WatchMovie/app/css/loginstyle.css" rel="stylesheet" type="text/css" media="all"/>
<!-- Custom Theme files -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<meta name="keywords" content="Login form web template, Sign up Web Templates, Flat Web Templates, Login signup Responsive web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<!--Google Fonts-->
<!-- <link href='http://fonts.useso.com/css?family=Roboto:500,900italic,900,400italic,100,700italic,300,700,500italic,100italic,300italic,400' rel='stylesheet' type='text/css'>
<link href='http://fonts.useso.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'> -->
<script src="${pageContext.request.contextPath}/WatchMovie/app/js/jquery-3.2.1.js"
	type="text/javascript" charset="utf-8"></script>
<script
	src="${pageContext.request.contextPath}/WatchMovie/BootStrap/js/bootstrap.min.js"
	type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/WatchMovie/BootStrap/css/bootstrap.min.css" />
<!--Google Fonts-->
<style type="text/css">
			.pormat{
				color: red;
				text-align: center;
			}
			body{
			   background: url(/WatchMovie/WatchMovie/app/images/bg.jpg) fixed;
			   padding:100px 0px 30px 0px;
			   font-family: 'Roboto', sans-serif;
			   font-size: 100%;
			   font: 14px/25px Arial, Helvetica, sans-serif;background-size: 100%;
			}
</style>
<script type="text/javascript">
	function register(){
		$("#login").hide();
		$("#register").show();
	}
	function login(){
		$("#login").show();
		$("#register").hide();
		
	}
	$(function(){
		if("${mess}"==""){
		}else{
			var mess ="${mess}";
			alert(mess);
		}
	});
	function show(){
		$.ajax({
			type:"get",
			url:"${pageContext.request.contextPath}/getHeadpic",
			data:{"id":$("#loginid").val()},
			success:function(data){
				//alert(data);
				//$("#headpic").val(data);
				document.getElementById("headpic").innerHTML=data;
			}
			
		});
	}
	function checklogin(){
		var id = document.getElementById("loginid").value;
		var pwd = document.getElementById("loginpwd").value;
		if(id!=""||pwd!=""){
			return true;
		}else{
			return false;
		}
	}
	
	//Register所需的js方法
	function checkid(){
		var id=document.getElementById("id").value;
		var mes=document.getElementById("iddiv");
		var reg=/^[A-Z|a-z|0-9]+$/;
		if (!reg.test(id)) {
			mes.innerHTML="用户id不符合！";
			return false;
		} else{
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/judgeName",
				data:{"id":id},
				success:function(data){
					mes.innerHTML=data;
				}
			});
			return true;
		}
	}
	function checkname(){
		var name=document.getElementById("name").value;
		var mes=document.getElementById("namediv");
		if (name=="") {
			mes.innerHTML="请输入用户名！";
			return false;
		} else{
			mes.innerHTML="";
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
	function checkphone(){
		var phone = document.getElementById('phone').value;
		var mes=document.getElementById("phonediv");
		var reg=/^1(3|4|5|7|8)\d{9}$/;
		if (!reg.test(phone)) {
			mes.innerHTML="电话不符合规范！";
			return false;
		} else{
			mes.innerHTML="";
			return true;
		}
		
	}
	function PreviewImage(imgFile){
		var url = URL.createObjectURL(imgFile.files[0]);
		var div = document.getElementById("imgPreview");
		div.innerHTML = "<img src='"+url+"' class='img-rounded' style='height:200px;'/>";
	}
	function checkregister(){
		if (!checkid()) {
			return false;
		}else if(!checkname()){
			return false;
		}else if(!checkpwd()){
			return false;
		}else{
			return true;
		}
	}
</script>
</head>
<body style="padding-top: 20px">
<div class="login" id="login" style="display: ">
	<h2>登陆</h2>
	<div class="login-top">
		<h1>LOGIN</h1>
		<div id="headpic" class="form-group" align="center" style=" height:100px">
			<!-- <img alt="" src="/WatchMovie/WatchMovie/image/User/public.jpg" class="img-circle" width=100px height=100px> -->
		</div>
		<form method="post" action="${pageContext.request.contextPath}/login" onsubmit="return checklogin()">
			<label class="control-label">用户ID：</label><br/><input type="text" id="loginid" name="id" onblur="show()"><div id="liddiv"></div>
			<label class="control-label">密码：</label><br/><input type="password" id="loginpwd" name="pwd"><div id="lpwddiv"></div>
		    <div class="forgot">
		    	<input type="submit" value="登陆" >
		    </div>
		</form>
	</div>
	<div class="login-bottom">
		<h3>新用户 &nbsp;<a  href="#" type="btn btn-default" onclick="register()">注册</a>&nbsp</h3>
	</div>
</div>	

<div class="login" id="register" style="display: none">
	<h2>注册</h2>
	<div class="login-top">
		<h1>REGISTER</h1>
		<p style="color: black;">输入你的信息，会员名字必须由字母和数字组成，带*号项必须填写</p>
		<form method="post" action="${pageContext.request.contextPath}/register" onsubmit="return checkregister()">
			<label class="control-label">用户ID(*)：</label><br/><input type="text" name="id" id="id" onblur="checkid()" required><div id="iddiv" class="pormat"></div>
			<label class="control-label">用户名(*)：</label><br/><input type="text" name="name" id="name" onblur="checkname()" required><div id="namediv" class="pormat"></div>
			<label class="control-label">密码(*)：</label><br/><input type="password" name="pwd" id="pwd" onblur="checkpwd()" required><div id="pwddiv" class="pormat"></div>
			<label class="control-label">邮箱：</label><br/><input type="text" name="email" id="email" onblur="checkemail()"><div id="emaildiv" class="pormat"></div>
			<label class="control-label">电话：</label><br/><input type="text" name="phone" id="phone" onblur="checkphone()"><div id="phonediv" class="pormat"></div>
			<!-- <label class="control-label">头像：</label><br/><input type="file" onchange="PreviewImage(this)" id="exampleInputFile" name="pic" class="btn-info " style="border: 1px solid #ccc;box-shadow: inset 0 1px 1px rgba(0,0,0,.075); border-radius: 4px;">
							<p class="help-block">上传的图片会在</p>
							<div id="imgPreview" name="image">
								
								</div> -->
		    <div class="forgot" style="text-align: center">
		    	<input type="submit" value="注册" ><input type="reset" value="重置" >
		    </div>
	     </form>
	</div>
	<div class="login-bottom">
		<h3><a href="#" type="btn btn-default" onclick="login()">返回登陆</a></h3>
	</div>
</div>


</body>
</html>