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
	BCustomer cust = QxShiroCommon.getLoginUser();
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
				<div class="step"><span>第四步：确认你所选课程</span><a href="index.html">[点击返回首页]</a></div>
				<div class="main-content">
					<div class="top-tips">
						<h5>您好，<%=cust.getFullname() %>。以下信息为您当前所报名的班级情况</h5>
						<p>
							您可以直接使用网络缴费，也可以点击现场根据提示时间到校缴费;
						</p>
						<p>
							若还想继续选择班级，可点击“继续选报班级”进入选择报名班级界面;
						</p>
						<span id="timeParentTips">请在<span id="timetips" style="font-size: 20px;color: red;"></span>内完成缴费，否则所报课程自动取消</span>
					</div>
					<div class="tables">
						<table class="table table-striped table-hover">
							<thead>
								<tr>
									<th>已缴费班级</th>
									<th>任课老师</th>
									<th>上课时间</th>
									<th>人数</th>
									<th>学费</th>
									<th>状态</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${pays }" var="item">
									<tr>
										<td>${item.classname }</td>
										<td>${item.teacherid }</td>
										<td>${item.classtime }</td>
										<td>${item.qty }</td>
										<td>${item.rcMoney }</td>
										<td>
											<c:choose>
												<c:when test="${item.ispay == 1 }">
												已缴费
												</c:when>
												<c:otherwise>
												未缴费
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td>学费合计：</td>
									<td class="total" colspan="4">${paytotal }</td>
								</tr>
							</tfoot>
						</table>
						<table class="table table-striped table-hover wait-table">
							<thead>
								<tr>
									<th>未缴费班级</th>
									<th>任课老师</th>
									<th>上课时间</th>
									<th>人数</th>
									<th>学费</th>
									<th>状态</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${notpays }" var="item">
									<tr id="course-${item.regclassid}">
										<td>${item.classname }</td>
										<td>${item.teacherid }</td>
										<td>${item.classtime }</td>
										<td>${item.qty }</td>
										<td>${item.rcMoney }<input value="${item.fee }" type="hidden" id="fee-${item.regclassid}"></td>
										<td>
											<c:choose>
												<c:when test="${item.ispay == 1 }">
												已缴费
												</c:when>
												<c:otherwise>
												未缴费
												</c:otherwise>
											</c:choose>
										</td>
										<td class="td-button"><a onclick="cancelCourse('${item.regclassid}')" href="javascript:;" class="btn btn-danger">退班</a></td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td>学费合计：</td>
									<td id="notpaytotal" class="total" colspan="5">${notpaytotal }</td>
								</tr>
							</tfoot>
						</table>
					</div>
					<div class="btn-wrap xs-btn-group">
						<a href="javascript:;" class="btn btn-orange btn-lg" onclick="zhifubaoPay()">支付宝支付</a>
						<a href="javascript:;" class="btn btn-orange btn-lg" onclick="wechatPay()">微信支付</a>
						<a href="javascript:;" class="btn btn-default btn-lg" onclick="location.href='<%=basePath %>thirdStep'">继续报选班级</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 弹框 -->
	<!-- <div class="pop-wrap">
		<div class="pop-cover"></div>
		<div class="pop-content">
			<div class="pop-content-title">请选择前往的页面</div>
			<div class="pop-content-text">
				<div class="page-option-wrapper">
					<a href="" class="page-option">
							<img src="img/error_icon.png" alt="">
						</a>
					<a href="" class="page-option">
							<img src="img/success_icon.png" alt="">
						</a>
				</div>
			</div>
		</div>
	</div> -->
	<script type="text/javascript">
		function zhifubaoPay(){
			 window.open("<%=basePath %>wxscanpay");
			<%-- $.post("<%=basePath %>scanpay",{paytype:'zhifubao'},function(data){
				alert(data.msg);
			}).error(function(){alert("error")}) --%>
			showParentPop();
		}
		function wechatPay(){
			<%-- $.post("<%=basePath %>wxscanpay",{paytype:'wechat'},function(data){
				alert(data.msg);
			}).error(function(){alert("error")}) --%>
			window.open("<%=basePath %>wxscanpay");
			showParentPop();
			
		}
	</script>
	<script>
		function showParentPop(){
			window.parent.showPop()
		}
	</script>
	<script type="text/javascript">
		function cancelCourse(regclassid){
			if(confirm("是否退班")){
				$.post("<%=basePath %>cancelCourse",{regclassid:regclassid},function(data){
					if(data.code<0){
						alert(data.msg);
					}else{
						$("#notpaytotal").html(parseFloat($("#notpaytotal").html())-parseFloat($("#fee-"+regclassid).val()));
						$("#course-"+regclassid).remove();
					}
				}).error(function(){alert("退班出错，请重试。")})				
			}
			
		}
		
		
	</script>
	
	
	<script>
        var x = 30,
            interval;
        window.onload = function() {
            var d = new Date("1111/1/1,0:" + x + ":0");
            interval = setInterval(function() {
                var m = d.getMinutes();
                var s = d.getSeconds();
                m = m < 10 ? "0" + m : m;
                s = s < 10 ? "0" + s : s;
                $("#timetips").html(m + "分钟" + s+"秒");
                
                if (m == 0 && s == 0) {
                    clearInterval(interval);
                    $("#timeParentTips").html("已经超过缴费时间限制，课程已被取消");
                    return;
                }
                d.setSeconds(s - 1);
                
                
            }, 1000);
            
            
        }
    </script>
	
</body>

</html>