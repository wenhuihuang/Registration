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
		.total {
			color: red;
			padding-right: 40px;
			text-align: right;
		}

		.top-tips h5 {
			font-weight: bold;
			font-size: 16px;
		}

		.btn-wrap .btn {
			margin: 0 20px;
		}
	</style>
</head>
<body>
	<div class="container-fluid">
		<div class="con-wrap">
			<!-- <div class="con-title hidden-xs">
				<h3>网络报名</h3>
			</div> -->
			<div class="con-content">
				<div class="step">&nbsp;&nbsp;<span>请输入开电子发票信息</span><a href="">[点击返回首页]</a></div>
				<div class="main-content">
					<div class="article-wrap">
						<h5 class="article-title" style="color: red;padding-left: 5px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请确保以下信息正确，成功缴费后，系统将自动开电子发票！</h5>
						<div class="article-content">
							<form action="" method="post" class="form-horizontal">
								<div class="form-group">
									<label for="name" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>手机号码：</label>
									<div class="col-md-6 col-sm-9 col-xs-8">
										${taxdep.mobiletelno }
									</div>
									<div class="col-md-3"></div>
								</div>
								<div class="form-group">
									<label for="name" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>单位类型：</label>
									<div class="col-md-6 col-sm-3 col-xs-8">
										<!-- <select  onchange="changelsrtype()" id="lsrtype" name="lsrtype">
											<option value="1">个人</option>
											<option value="2">单位</option>
										</select> -->
										<label><input onchange="changelsrtype()" type="radio" name="lsrtype" id="lsrtype" checked="checked" value="1">个人</label>
										<label><input onchange="changelsrtype()" type="radio" name="lsrtype" value="2">单位</label>
									</div>
									<div class="col-md-3"></div>
								</div>
								<div class="form-group">
									<label for="card" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>发票单位：</label>
									<div class="col-md-6 col-sm-9 col-xs-8">
										<input value="${taxdep.taxdepname }" id="taxdepname" name="taxdepname" placeholder="请输入发票单位" class="form-control" />
									</div>
									<div class="col-md-3"></div>
								</div>
								<div class="form-group" id="taxnodiv">
									<label for="auth_code" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>单位纳税人识别号：</label>
									<div class="col col-md-6 col-sm-6 col-xs-5">
										<input value="${taxdep.deptaxno }" type="text" id="deptaxno" name="deptaxno" placeholder="请输入单位纳税人识别号" class="form-control" />
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="btn-wrap mobile-footer">
						<a href="javascript:;" class="btn btn-default btn-lg prev-step">上一步</a>
						<a onclick="toAdd()" href="javascript:;" class="btn btn-default btn-lg ">下一步</a>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	function toAdd(){
		
		var taxdepname = $("#taxdepname").val();
		var deptaxno = $("#deptaxno").val();
		var lsrtype =  $("#lsrtype").prop("checked")==true?1:2;
		
		$.post("updatetaxdep",{taxdepname:taxdepname,deptaxno:deptaxno,lsrtype:lsrtype},function(data){
			if(data.code<=0){				
				alert(data.msg);
			}else{
				location.href='<%=basePath%>thirdStep'
			}
		},"json").error(function() { alert("保存开电子发票信息失败，请重试。"); });
	}
	
	function changelsrtype(){
		var lsrtype = $("#lsrtype").prop("checked");
		if(lsrtype==true){
			$("#taxnodiv").hide()
		}else{
			$("#taxnodiv").show()
		}
	}
	$(function(){
		changelsrtype();
	})
</script>
</html>