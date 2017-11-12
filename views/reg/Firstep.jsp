<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String resourcesPath = basePath+"statics/reg";
%>

<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>

<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>网络报名</title>
	<link rel="stylesheet" type="text/css" href="<%=resourcesPath %>/css/iconfont.css" />
	<link rel="stylesheet" href="<%=resourcesPath %>/bootstrap_3.3.5/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="<%=resourcesPath %>/css/Registration.css" />
	<script type="text/javascript" src="<%=resourcesPath %>/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcesPath %>/js/Registration.js"></script>
	<script type="text/javascript" src="<%=resourcesPath %>/js/sub_common.js"></script>
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
				<div class="step"><span>您好，欢迎登录！</span><a href="">[点击返回首页]</a></div>
				<div class="main-content">
					<div class="article-wrap">
						<h5 class="article-title">请填写身份证号及密码登录系统</h5>
						<div class="article-content">
							<form action="" method="post" class="form-horizontal">
								<div class="form-group">
									<label for="name" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>身份证号码：</label>
									<div class="col-md-6 col-sm-9 col-xs-8">
										<input value="440104197904150023" type="text" id="idcard" name="idcard" placeholder="请输入身份证号码" class="form-control">
									</div>
									<div class="col-md-3"></div>
								</div>
								<div class="form-group">
									<label for="card" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>密码：</label>
									<div class="col-md-6 col-sm-9 col-xs-8">
										<input type="password" id="pwd" name="pwd" placeholder="请输入登录密码" class="form-control" />
									</div>
									<div class="col-md-3"></div>
								</div>
								<div class="form-group">
									<label for="card" class="control-label col-md-3 col-sm-3 col-xs-4">温馨提示：</label>
									<div class="col-md-6 col-sm-9 col-xs-8" style="padding-top:7px;">
										首次登录，默认密码为<span style="color:#F57625">123456</span>。登录后，必须修改密码！
									</div>
									<div class="col-md-3"></div>
								</div>
								<div class="form-group">
									<label for="auth_code" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>验证码：</label>
									<div class="col col-md-6 col-sm-6 col-xs-3">
										<input type="text" id="code" name="code" placeholder="请输入验证码" class="form-control" />
									</div>
									<div class="col col-md-3 col-sm-3 col-xs-5 auth-img"><img id="validcodeimg" onclick="changeValidateCode(this)" src="<%=basePath %>validateImage.jsp"></div>
								</div>
							</form>
						</div>
					</div>
					<div class="btn-wrap">
						<a href="javascript:;" class="btn btn-default btn-lg prev-step">上一步</a>
						<a onclick="checklogin()" href="javascript:;" class="btn btn-default btn-lg ">下一步</a>
						<a onclick="findpwd()" href="javascript:;" class="btn btn-default btn-lg ">找回密码</a>
						 <!-- position="secondStep" -->
						<!-- <a href="javascript:;" class="btn btn-default prev-step">找回密码</a> -->
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	
	function checklogin(){
		
		var cardno = $("#idcard").val();
		var pwd = $("#pwd").val();
		var code = $("#code").val();
		
		
		$.post("checklogin",{cardno:cardno,pwd:pwd,code:code},function(data){
			if(data.code<=0){				
				alert(data.msg);
				changeValidateCode($("#validcodeimg"));
			}else{

				if(data.code==1){
					location.href='<%=basePath %>frame'
				}else if(data.code==2){
					location.href='<%=basePath %>newStudent';
				}
				
			}
		},"json").error(function() { alert("登录失败，请重试。"); });
	}
	
    function changeValidateCode(obj) {  
		var timenow = new Date().getTime();  
		obj.src="<%=basePath %>validateImage.jsp?d="+timenow;  
	}  
	
	function findpwd(){
		var cardno = $("#idcard").val();
		$.post("checkcardnofortel",{cardno:cardno},function(data){
			if(data.code<=0){				
				alert(data.msg);
			}else{
				location.href="<%=basePath %>findpwd";
				
			}
		},"json").error(function() { alert("登录失败，请重试。"); });
		
		
		
	}
</script>
</html>