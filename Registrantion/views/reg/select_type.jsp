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
                <div class="step"><span>第一步：请选择报名类型</span></div>
                <div class="main-content">
                    <div class="article-wrap">
                        <h5 class="article-title">1、请选择报名类型</h5>
                        <div class="article-content container-fluid">
                            <div class="row normal-row-top-bottom">
                                <div class="col-md-2"></div>
                                <div class="col-md-8"><button onclick="location.href='firstep/1'" type="button" class="btn btn-primary btn-block btn-lg">老人大学</button></div>
                                <div class="col-md-2"></div>
                            </div>
                            <div class="row normal-row-top-bottom">
                                <div class="col-md-2"></div>
                                <div class="col-md-8"><button onclick="location.href='firstep/2'" type="button" class="btn btn-primary btn-block btn-lg">少儿培训</button></div>
                                <div class="col-md-2"></div>
                            </div>
                            <div class="row normal-row-top-bottom">
                                <div class="col-md-2"></div>
                                <div class="col-md-8"><button onclick="location.href='firstep/3'" type="button" class="btn btn-primary btn-block btn-lg">活动报名</button></div>
                                <div class="col-md-2"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>