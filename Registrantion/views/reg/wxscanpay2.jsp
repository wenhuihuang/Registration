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
<script type="text/javascript" src="<%=resourcesPath %>/js/jquery-1.11.3.min.js"></script>
<title>网络报名</title>

<style>
    body{ background:#f5f5f5;}
    .wx_img{ margin-top:30px;}
    .wx_img img{ border:1px solid #ddd;}
</style>   
 <style>
        button{
            background-color: #7fbf4d;
            background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #7fbf4d), color-stop(100%, #63a62f));
            background-image: -webkit-linear-gradient(top, #7fbf4d, #63a62f);
            background-image: -moz-linear-gradient(top, #7fbf4d, #63a62f);
            background-image: -ms-linear-gradient(top, #7fbf4d, #63a62f);
            background-image: -o-linear-gradient(top, #7fbf4d, #63a62f);
            background-image: linear-gradient(top, #7fbf4d, #63a62f);
            border: 1px solid #63a62f;
            border-bottom: 1px solid #5b992b;
            border-radius: 3px;
            -webkit-box-shadow: inset 0 1px 0 0 #96ca6d;
            box-shadow: inset 0 1px 0 0 #96ca6d;
            color: #fff;
            font: bold 11px/1 "Lucida Grande", "Lucida Sans Unicode", "Lucida Sans", Geneva, Verdana, sans-serif;
            padding: 7px 0 8px 0;
            text-align: center;
            text-shadow: 0 -1px 0 #4c9021;
            width: 150px;
        }
    </style>
</head>
<body>
	<div align="center">
        <!-- <h1 style="color:red;">微信扫码支付</h1> -->
        <img src="<%=resourcesPath %>/img/WePayLogo.png" width="180px;" style="display:block; margin:0px auto; margin-top:20px;">
        <h5 style="color:red;">订单号：${billno }</h5>
        <h3 style="color:red;">商品名称：${name }</h3>
        <h5 style="color:red;">订单金额：${totalmoney }元</h5>
        <div class="wx_img"><img alt="微信扫码支付" src="<%=basePath%>${code }"></div>
    </div>
</body>
<script type="text/javascript">
	$(function(){
		setInterval("checkPay()",5000);
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