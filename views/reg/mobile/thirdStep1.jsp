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
							<link rel="<%=resourcesPath %>/stylesheet" href="js/pagination.css">
							<script src="<%=resourcesPath %>/js/jquery.pagination.js"></script>
							<script type="text/javascript" src="<%=resourcesPath %>/js/Registration.js"></script>
							<style type="text/css">
								html,
								body {
									height: 100%;
								}

								.item_mobile {
									display: block;
									width: 100%;
									margin-top: 8px;
								}

								.step_mobile {
									height: 48px;
									padding: 0 20px;
									line-height: 48px;
									font-size: 16px;
									background: #0085CF;
									color: white;
								}

								.step_mobile span {
									text-align: center;
								}

								.content_mobile {
									overflow: auto;
								}

								.btn-wrap {
									position: fixed;
									bottom: 0px;
									left: 0;
									right: 0;
									padding: 20px 0 10px 0;
									margin:0;
								}
							</style>
						</head>

						<body>
							<div class="step_mobile">
								<span class="col-md-12 col-xs-12">选择系/专业</span>
							</div>
							<div class="content_mobile">
								<input type="hidden" id="depid" value="${depts[0].depid }">
								<c:forEach items="${depts}" var="dept">
									<a onclick="selectDept('${dept.depid}')" href="javascript:;" class="item_mobile btn btn-info btn-lg">${dept.depname }</a>
								</c:forEach>
							</div>
							<div class="btn-wrap">
								<a class="btn btn-default btn-lg prev-step">上一步</a>
								<a class="btn btn-default btn-lg" onclick="toHistory();">报读历史班级</a>
							</div>
						</body>
						<script type="text/javascript">
							function toHistory() {
								location.href = '<%=basePath%>thirdStepHistory';
							}
							function selectDept(depid) {
								location.href = '<%=basePath%>thirdStep2?depid=' + depid;
							}
							$(function () {
								var bd_height = document.body.offsetHeight;
								var ct_height = bd_height - 48 - 77;
								$(".content_mobile").height(ct_height);
							});
						</script>

						</html>