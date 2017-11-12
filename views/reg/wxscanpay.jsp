<%@page import="com.reg.common.RegConstants"%>
<%@page import="com.qx.shiro.QxShiroCommon"%>
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
	                <div class="step"><span>微信支付</span></div>
	                <div class="main-content">
	                    <div class="article-wrap">
	                        <h5 class="article-title">请用微信的“扫一扫”扫描下面的二维码进行支付</h5>
	                        <div class="article-content container-fluid" style="padding-top: 5px;padding-bottom: 5px;">
	                            <div class="row normal-row-top-bottom">
	                                <div class="col-md-2"></div>
	                                <div class="col-md-8" style="text-align: center;">
	                                	<c:choose>
	                                		<c:when test="${error !=null and error !=''  }"><div style="color:red;">${error }</div></c:when>
	                                		<c:otherwise>
	                                		<div style="color:red;">订单号：${billno }</div>
								        	<div style="color:red;">商品名称：${name }</div>
								        	<div style="color:red;">订单金额：${totalmoney }元</div>
								        	<div class="wx_img"><img alt="微信扫码支付" src="<%=basePath%>${code }">
								        	</div></c:otherwise>
	                                	</c:choose>
	                                	
	                                </div>
	                                <div class="col-md-2"></div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		setInterval("checkPay()",3000);
	})
	function checkPay(){
		var billno = "${billno}";
		$.post("<%=basePath %>checkPay",{billno:billno},function(data){
			if(data.code>0){
				/* if(confirm("是否关闭网页？")){
					window.close();	
				} */
				alert("支付成功，点击“确定”返回原页面。");
				window.close();	
			}
			
		}).error(function(){alert("支付失败，请重试。")});
	}
</script>
</html>