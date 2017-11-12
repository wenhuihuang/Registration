<%@page import="com.reg.bean.BCustomer"%>
<%@page import="com.qx.shiro.QxShiroCommon"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String resourcesPath = basePath+"statics/reg";
	BCustomer cust =  QxShiroCommon.getLoginUser();
%>

<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>网络报名</title>
	<link rel="stylesheet" href="<%=resourcesPath %>/bootstrap_3.3.5/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="<%=resourcesPath %>/css/Registration.css" />
	<script type="text/javascript" src="<%=resourcesPath %>/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcesPath %>/js/Registration.js"></script>
	<style>
		@media only screen and (max-width: 768px) {
			div.header .xs-header-middle {
				margin-top: 33px;
			}
			.step {
				top: 106px;
			}

			.main-content {
				top: 154px;
			}
		}
	</style>
</head>
<body>
	<div class="header container-fluid">

		<div class="row">
			<div class="col-md-1 col-sm-2 col-xs-3"><img class="logo" src="<%=resourcesPath %>/img/logo.png" alt=""></div>
			<div class="col-md-6 col-sm-5 col-xs-7 xs-header-middle">
				<p class="title">广东省妇女儿童发展指导中心网上注册系统</p>
			</div>

		</div>
	</div>
	<div class="container-fluid">
		<div class="con-wrap">
			<!-- <div class="con-title hidden-xs">
				<h3>网络报名</h3>
			</div> -->
			<div class="con-content">
				<div class="step"><span>新生手机验证</span><a href="index.html">[点击返回首页]</a></div>
				<div class="main-content">
					<div class="article-wrap">
						<h5 class="article-title">新生手机验证</h5>
						<div class="article-content">
							<form action="" method="post" class="form-horizontal">
								<div class="form-group">
									<label for="phone-number" class="control-label col-md-3 col-sm-3 col-xs-3"><b class="red">*</b>手机号码：</label>
									<div class="col-md-6 col-sm-6 col-xs-5">
										<!-- <input type="text" id="mobile" name="mobile" placeholder="请输入手机号码" class="form-control"> -->
										<%=cust.getMobiletelno() %>
									</div>
									<div class="col-md-3 col-sm-3 col-xs-4"><button type="button" class="btn btn-primary" onclick="sendCode(this)">获取验证码</button></div>
								</div>
								<div class="form-group">
									<label for="auth_code" class="control-label col-md-3 col-sm-3 col-xs-3"><b class="red">*</b>验证码：</label>
									<div class="col col-md-9 col-sm-9 col-xs-9 clearfix">
										<input type="text" id="auth_code" name="auth_code" placeholder="请输入验证码" class="form-control" />
									</div>
								</div>
								<div class="form-group">
									<label for="password" class="control-label col-md-3 col-sm-3 col-xs-3"><b class="red">*</b>新密码：</label>
									<div class="col col-md-9 col-sm-9 col-xs-9 clearfix">
										<input type="password" id="password" name="password" placeholder="请输入新密码" class="form-control" />
									</div>
								</div>
								<div class="form-group">
									<label for="repassword" class="control-label col-md-3 col-sm-3 col-xs-3"><b class="red">*</b>确认新密码：</label>
									<div class="col col-md-9 col-sm-9 col-xs-9 clearfix">
										<input type="password" id="repassword" name="repassword" placeholder="请确认密码" class="form-control" />
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="btn-wrap">
						<a href="javascript:;" class="btn btn-default btn-lg prev-step">上一步</a>
						<a href="javascript:;" class="btn btn-default btn-lg " onclick="changePwd()" >确定</a>
						<!-- position="thirdStep" -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		function sendCode(self) {
			var mobile =  '<%=cust.getMobiletelno() %>';//$("#mobile").val();
			if(mobile==null||mobile==""){
				alert("请输入手机号码");
				return ;
			}
			$.post("getPhoneCode",{mobile:mobile},function(data){
				
				if(data.code==1){
					
				}else{
					alert(data.msg);
				}
			},"json").error(function() { alert("发送验证码失败，请重试。"); });
			
			
			countDown(self, 60);
		}
		
		function changePwd(){
			var validcode = $("#auth_code").val();
			var pwd = $("#password").val();
			var repwd =$("#repassword").val();
			
			if(validcode==""){
				alert("请输入验证码。");
				return;
			}
			if(pwd==""){
				alert("请输入新密码。");
				return;
			}
			if(pwd!=repwd){
				alert("“新密码”与“确认新密码”不相同。请重新输入。");
				return;
			}

			$.post("changepwd",{validCode:validcode,pwd:pwd},function(data){
				if(data.code==1){
					location.href="<%=basePath%>frame"
				}else{
					alert(data.msg+":"+data.code);
				}
			},"json").error(function() { alert("修改密码出错，请重试。"); });
			
		}
	</script>

</body>
</html>