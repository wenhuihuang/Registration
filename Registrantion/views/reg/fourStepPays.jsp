<%@page import="com.reg.bean.BCustomer"%>
<%@page import="com.qx.shiro.QxShiroCommon"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
				<div class="step"><span>您已经报读的班级列表</span><a href="">[点击返回首页]</a></div>
				<div class="main-content">
					<%-- <div class="top-tips">
						<h5>您好，<%=cust.getFullname() %>。以下信息为您当前所报名的班级情况</h5>
						<p>
							您可以直接使用网络缴费，也可以点击现场根据提示时间到校缴费;
						</p>
						<p>
							若还想继续选择班级，可点击“继续选报班级”进入选择报名班级界面;
						</p>
					</div> --%>
					<div class="tables">
						
						
					<c:forEach items="${masters }" var="master">
						<table class="table table-striped table-hover">
							
								<thead>
									<tr>
										<th colspan="5" style="text-align: left;background: white;">
											<div style="margin-left: 20px;">单号：${master.BillNO }</div>
											<div style="margin-left: 20px;margin-top: 5px;">付款日期：<fmt:formatDate value="${master.BillDate }"  pattern="yyyy-MM-dd HH:mm:ss"/></div>
										</th>
										<c:choose>
											<c:when test="${master.TaxNO == '' or master.TaxNO == null}">
											<th style="text-align: left;background: white;" class="td-button"><a style="margin-bottom: 8px;" onclick="openinvoice('${master.BillNO }')" href="javascript:;" class="btn btn-danger">开  发  票</a></th>
											</c:when>
											<c:otherwise>
											<th style="text-align: left;background: white;" class="td-button"><a style="margin-bottom: 8px;" onclick="downloadtax('${master.BillNO }')" href="javascript:;" class="btn btn-danger">下载发票</a></th>
											</c:otherwise>
										</c:choose>
									</tr>
								</thead>
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
										<c:if test="${item.BillNO == master.BillNO }">
											<tr>
												<td>${item.ClassName }</td>
												<td>${item.TeacherID }</td>
												<td>${item.ClassTime }</td>
												<td>${item.Qty }</td>
												<td>${item.rcMoney }</td>
												<td>
													<c:choose>
														<c:when test="${item.isPay == 1 }">
														已缴费
														</c:when>
														<c:otherwise>
														未缴费
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							
							
							<%-- <tfoot>
								<tr>
									<td>学费合计：</td>
									<td class="total" colspan="4">${paytotal }</td>
								</tr>
							</tfoot> --%>
						</table>
					</c:forEach>
						<table class="table table-striped table-hover">
						</table>
						
						
						<%-- <table class="table table-striped table-hover wait-table">
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
										<td>${item.fee }<input value="${item.fee }" type="hidden" id="fee-${item.regclassid}"></td>
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
						</table> --%>
					</div>
					<div class="btn-wrap mobile-footer">
						<a href="javascript:;" class="btn btn-orange btn-lg" onclick="print()">打印课程列表</a>
						<!-- <a href="javascript:;" class="btn btn-orange btn-lg" onclick="print2()">打印电子发票</a> -->
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
		function print(){
			
			$.post("<%=basePath%>createReport",{},function(data){
				<%-- console.log("<%=basePath %>report_view?report=StudentRegBill&data="+data.title+"&title=报读班级"); --%>
				window.open("<%=basePath %>report/report_view.htm?report=StudentRegBill&data="+data.result+"&title=打印课程列表");
			}).error(function(){alert("打印课程列表出错，请重试。")})
		}
		<%-- function print2(){
			$.post("<%=basePath%>print2?type=1",{},function(data){
				console.log("<%=basePath %>report_view?report=StudentRegBill&data="+data.title+"&title=报读班级");
				alert(data.result)
			}).error(function(){alert("error")})
		} --%>
	</script>
	
	<script type="text/javascript">
	
		function openinvoice(billno){
			$.post("<%=basePath%>print2?billno="+billno,{},function(data){
				<%-- console.log("<%=basePath %>report_view?report=StudentRegBill&data="+data.title+"&title=报读班级"); --%>				
				if(data.code>0){
					location.reload();
					alert("开电子发票成功。");
				}
				else{
					alert(data.result)
				}
			}).error(function(){alert("开电子发票出错！请重试。")})
		}
		
		function downloadtax(billno){
			$.post("<%=basePath%>downloadtax?billno="+billno,{},function(data){
				<%-- console.log("<%=basePath %>report_view?report=StudentRegBill&data="+data.title+"&title=报读班级"); --%>				
				if(data.code>0){
					window.open("http://www.bwfapiao.com" + data.result);
				}
				else {
					alert(data.result)
				}
			}).error(function(){alert("下载发票出错！请重试。")})
		}
		
		function openurl(url){
			window.open(url);
		}
	</script>
	
	<script>
		function showParentPop(){
			window.parent.showPop()
		}
	</script><%-- 
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
	</script> --%>
</body>

</html>