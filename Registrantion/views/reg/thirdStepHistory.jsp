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
<style>
		.top-class .row {
			margin: 8px 0;
			border-bottom: 1px dashed #ccc;
		}

		.left-label {
			display: inline-block;
			vertical-align: top;
			width: 80px;
		}

		.right-content {
			display: inline-block;
			vertical-align: top;
			width: 80%;
		}

		.right-content .item {
			margin-left: 8px;
			margin-bottom: 8px;
		}

		.money-color {
			color: #F67524;
		}
	</style>
	<script>
	var lastPage = 1;//最后一页
	var selCourses = [];//选择的课程
	var search = "";
	//var delCourses = [];//删除的课程
	function selectDept(depid){
		$("#depid").val(depid);
		search=""
		getCourse(1)
	}
	function selectWeek(week){
		$("#week").val(week);
		search=""
		getCourse(1)
	}
	function selectIsFull(isfull){
		$("#isfull").val(isfull);
		search=""
		getCourse(1)
	}
	
	function changepage(change){
		
		var pageNum = parseInt($("#pageNum").val())+(parseInt(change));
		
		if(pageNum<=0){
			pageNum = 1;
		}
		if(pageNum>=lastPage){
			pageNum = lastPage;
		}
		
		getCourse(pageNum);
	}
	
	function getCourse(pageNum){
		$("#pageNum").val(pageNum);
		//var depid = $("#depid").val();
		var week = $("#week").val();
		var isfull = $("#isfull").val();
		var pageSize = 5;
		var selectIds = "";
		if(selCourses.length>0){
			for(var i = 0;i<selCourses.length;i++){
				selectIds += "'"+selCourses[i].classid+"',";
			}
			selectIds = selectIds.substring(0,selectIds.length-1);
		}
		$.post("getCourseHistory",{week:week,isfull:isfull,selectIds:selectIds,pageNum:pageNum,pageSize:pageSize,search:search},function(data){
			
			if(data!=null){
				
				$("#pagtitle").html(data.pageNum+"/"+data.pages);
				$("#prePage").show();
				$("#nextPage").show();
				$("#firstPage").show();
				$("#lastPage").show();
				if(data.isFirstPage){
					$("#prePage").hide();
					$("#firstPage").hide();
				}
				if(data.isLastPage){
					$("#nextPage").hide();
					$("#lastPage").hide();
				}
				
				
				lastPage = data.pages
				
				var json = data.list;
				var ele_array = [];

				for (var i = 0; i < json.length; i++) {
					ele_array.push('<tr id="course-'+json[i].classid+'" >')
					ele_array.push('<td>' + json[i].classname + '</td>')
					ele_array.push('<td>' + json[i].classtime + '</td>')
					ele_array.push('<td>' + json[i].teacherid + '</td>')
					ele_array.push('<td>' + json[i].qty + '</td>')
					ele_array.push('<td class="money-color">' + json[i].fee + '</td>')
					ele_array.push('<td><a href="javascript:;" class="btn btn-orange" onclick="addCourse(\''+json[i].classid+'\',\''+json[i].classname+'\',\''+json[i].classtime+'\',\''+json[i].teacherid+'\',\''+json[i].qty+'\',\''+json[i].fee+'\',\''+json[i].dictionaryid+'\',\''+json[i].regclassid+'\')" >选择</a></td>')
					/* ele_array.push('<td><a href="javascript:;" class="btn btn-primary">查看</a></td>') */
					ele_array.push('</tr>')
				}


				$('.select-tbody').html(ele_array.join(''));
			}
			
		},"json").error(function(){alert("获取课程列表失败，请重试。")});
	}
	var isAdd20Precent = <%=RegConstants.isAdd20Precent()%>
	
	function addCourse(classid,classname,classtime,teacherid,qty,fee,dictionaryid,regclassid) {
		
		var tmpJson = {classid:classid,classname:classname,classtime:classtime,teacherid:teacherid,qty:qty,fee:fee,dictionaryid:dictionaryid,regclassid:regclassid};
		
		//判断人数是否已满和时间冲突
			$.post('<%=basePath%>checkconflict',{selCourse:JSON.stringify(tmpJson),selCourses:JSON.stringify(selCourses)},function(data){
			
			if(data.code>0){
				var tbody = $('.select-tbody-yet');
				
				selCourses.push(tmpJson);
				
				//如果成功执行
				$('#course-' + classid).remove();
				var ele_array = [];
				ele_array.push('<tr id="course-' + classid + '">')
				ele_array.push('<td>'+classname+'</td>')
				ele_array.push('<td>'+classtime+'</td>')
				ele_array.push('<td>'+teacherid+'</td>')
				ele_array.push('<td>'+qty+'</td>')
				//对于老人大学，如果学员没达到退休年龄的，学费自动加收20%；
				var truefee = 0;
				if(isAdd20Precent==1){
					truefee = (parseFloat(fee)+parseFloat(fee*20/100)).toFixed(2);
					ele_array.push('<td class="money-color">'+truefee+'</td>')
				}else{
					truefee = fee;
					ele_array.push('<td class="money-color">'+truefee+'</td>')			
				}
				
				ele_array.push('<td><a href="javascript:;" class="btn btn-default" onclick="cancelCourse(\''+classid+'\',\''+classname+'\',\''+classtime+'\',\''+teacherid+'\',\''+qty+'\',\''+fee+'\',\''+dictionaryid+'\',\''+regclassid+'\')">取消</a></td>')
				/* ele_array.push('<td><a href="javascript:;" class="btn btn-primary">查看</a></td>') */
				ele_array.push('</tr>')

				tbody.append(ele_array.join(''))
				
				$("#totalpay").html(parseFloat($("#totalpay").html())+parseFloat(fee))
			}else{
				alert(data.msg);
			}
			
		}).error(function(){alert("增加选择课程失败，请重试。")});
		

	}
	function cancelCourse(classid,classname,classtime,teacherid,qty,fee,dictionaryid,regclassid) {
		var tbody = $('.select-tbody');
		
		if(selCourses.length>0){
			for(var i = 0;i<selCourses.length;i++){
				if(selCourses[i].classid==classid){
					selCourses.splice(i,1);					
					break;
				}
			}
		}
		
		/* if(regclassid!=null&&regclassid!=''&&regclassid!=undefined){			
			delCourses.push({classid:classid,classname:classname,classtime:classtime,teacherid:teacherid,qty:qty,fee:fee,dictionaryid:dictionaryid,regclassid:regclassid});
		} */
		
		
		
		
		//如果成功执行
		$('#course-' + classid).remove();
		var ele_array = [];
		ele_array.push('<tr id="course-' + classid + '">')
		ele_array.push('<td>'+classname+'</td>')
		ele_array.push('<td>'+classtime+'</td>')
		ele_array.push('<td>'+teacherid+'</td>')
		ele_array.push('<td>'+qty+'</td>')
		ele_array.push('<td class="money-color">'+fee+'</td>')
		ele_array.push('<td><a href="javascript:;" class="btn btn-orange" onclick="addCourse(\''+classid+'\',\''+classname+'\',\''+classtime+'\',\''+teacherid+'\',\''+qty+'\',\''+fee+'\',\''+dictionaryid+'\',\''+regclassid+'\')" >选择</a></td>')
		/* ele_array.push('<td><a href="javascript:;" class="btn btn-primary">查看</a></td>') */
		ele_array.push('</tr>')

		tbody.append(ele_array.join(''))
		
		
		$("#totalpay").html(parseFloat($("#totalpay").html())-parseFloat(fee))
	}
	function searchCourse(){
		search = $("#search").val();
		getCourse(1);
	}
	/*function initCourse(){
		var json = ${notpays};
		for(var i = 0;i<json.length;i++){			
			addCourse(json[i].classid,json[i].classname,json[i].classtime,json[i].teacherid,json[i].qty,json[i].fee,json[i].dictionaryid,json[i].regclassid);
		}
	}*/
	</script>
	
	<script>
		$(function () {
			//initCourse();
			
			getCourse(1);
		})
		
		function changepagej(page){
		if(page==1){
			getCourse(1);	
		}else{
			getCourse(lastPage);
		}
		
	}
	</script>
</head>
<body>
	<div class="container-fluid">
		<div class="con-wrap">
			<!-- <div class="con-title hidden-xs">
				<h3>网络报名</h3>
			</div> -->
			<div class="con-content">
				<div class="step"><span>第三步：选择课程</span><a href="">[点击返回首页]</a></div>
				<div class="main-content">
					<div class="article-wrap top-class">
						<!-- <h5 class="article-title">选择课程</h5> -->
						<%-- <div class="row">
							<div class="col-md-12">
								<span class="left-label">系/专业：</span>
								<div class="right-content">
									<input type="hidden" id="depid" value="${depts[0].depid }">
									<c:forEach items="${depts }" var="dept">
										<a  onclick="selectDept('${dept.depid}')" href="javascript:;" class="item btn btn-default btn-sm">${dept.depname }</a>									
									</c:forEach>
								</div>
							</div>
						</div> --%>
						<!-- <div class="row">
							<div class="col-md-12">
								<span class="left-label">课程：</span>
								<div class="right-content">
									<a href="" class="item btn btn-default btn-sm">中医养生</a>
								</div>
							</div>
						</div> -->
						<div class="row">
							<div class="col-md-12">
								<span class="left-label">搜索：</span>
								<div class="right-content" style="margin-bottom: 10px;">
									<input id="search" placeholder="按班级名称或序号搜索" type="text" class="form-control" style="width: 50%;float: left;margin-right: 10px;">
									<input onclick="searchCourse()" type="button" value="搜索" class="form-control" style="width: 50px;">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<span class="left-label">上课时间：</span>
								<div class="right-content">
									<input type="hidden" id="week" value="0">
									<a onclick="selectWeek(1)" href="javascript:;" class="item btn btn-default btn-sm">周一</a>
									<a onclick="selectWeek(2)" href="javascript:;" class="item btn btn-default btn-sm">周二</a>
									<a onclick="selectWeek(3)" href="javascript:;" class="item btn btn-default btn-sm">周三</a>
									<a onclick="selectWeek(4)" href="javascript:;" class="item btn btn-default btn-sm">周四</a>
									<a onclick="selectWeek(5)" href="javascript:;" class="item btn btn-default btn-sm">周五</a>
									<a onclick="selectWeek(6)" href="javascript:;" class="item btn btn-default btn-sm">周六</a>
									<a onclick="selectWeek(7)" href="javascript:;" class="item btn btn-default btn-sm">周日</a>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<span class="left-label">人数：</span>
								<div class="right-content">
									<input type="hidden" id="isfull" value="1">
									<a onclick="selectIsFull('0')" href="javascript:;" class="item btn btn-default btn-sm">未满</a>
									<a onclick="selectIsFull('1')" href="javascript:;" class="item btn btn-default btn-sm">全部</a>
								</div>
							</div>
						</div>
						<div class="row article-content">

							<div class="col col-md-12">
								<div class="select-lesson">
									<h6>选择课程</h6>
									<table class="table table-striped table-hover">
										<thead>
											<tr>
												<th>课程名称</th>
												<th>上课时间</th>
												<th>任课老师</th>
												<th>人数</th>
												<th>学费(元)</th>
												<th>操作</th>
												<!-- <th>班级介绍</th> -->
											</tr>
										</thead>
										<tbody class="select-tbody">
											<!-- <tr id="course-9">
												<td>9中医养生</td>
												<td>星期四上午</td>
												<td>叶龙霖</td>
												<td>未满</td>
												<td class="money-color">0</td>
												<td><a href="javascript:;" class="btn btn-orange" onclick="addCourse(9)">选择</a></td>
												<td><a href="javascript:;" class="btn btn-primary">查看</a></td>
											</tr>
											<tr id="course-12">
												<td>12中医养生</td>
												<td>星期四上午</td>
												<td>叶龙霖</td>
												<td>未满</td>
												<td class="money-color">0</td>
												<td><a href="javascript:;" class="btn btn-orange" onclick="addCourse(12)">选择</a></td>
												<td><a href="javascript:;" class="btn btn-primary">查看</a></td>
											</tr> -->
										</tbody>
									</table>
									<!-- <div class="paging-wrapper" style="text-align:center;margin-bottom:20px;">
										<div class="paging" style="display:inline-block;"></div>
									</div> -->
									
									<div class="paging-wrapper" style="text-align:center;margin-bottom:20px;">
										<input type="hidden" id="pageNum" value="1">
										<div class="btn-wrap">
											<a id="firstPage" onclick="changepagej(1)"  href="javascript:;" class="btn btn-default btn-lg">首页</a>
											<a id="prePage" onclick="changepage(-1)"  href="javascript:;" class="btn btn-default btn-lg">上一页</a>
											<span id="pagtitle">0/0</span>
											<a id="nextPage" onclick="changepage(1)" href="javascript:;" class="btn btn-default btn-lg">下一页</a>
											<a id="lastPage" onclick="changepagej(-1)"  href="javascript:;" class="btn btn-default btn-lg">尾页</a>
										</div>
									</div>

								</div>
								<div class="no-lesson">
									<h6>已选择的课程</h6>
									<table class="table table-striped table-hover">
										<thead>
											<tr>
												<th>课程名称</th>
												<th>上课时间</th>
												<th>任课老师</th>
												<th>人数</th>
												<th>学费(元)</th>
												<th>操作</th>
												<!-- <th>班级介绍</th> -->
											</tr>
										</thead>
										<tbody class="select-tbody-yet">
											<!-- <tr id="course-14">
												<td>14中医养生</td>
												<td>星期四上午</td>
												<td>叶龙霖</td>
												<td>未满</td>
												<td class="money-color">0</td>
												<td><a href="javascript:;" class="btn btn-default" onclick="cancelCourse(14)">取消</a></td>
												<td><a href="javascript:;" class="btn btn-primary">查看</a></td>
											</tr>
											<tr id="course-15">
													<td>15中医养生</td>
													<td>星期四上午</td>
													<td>叶龙霖</td>
													<td>未满</td>
													<td class="money-color">0</td>
													<td><a href="javascript:;" class="btn btn-default" onclick="cancelCourse(15)">取消</a></td>
													<td><a href="javascript:;" class="btn btn-primary">查看</a></td>
												</tr> -->
										</tbody>
										<tfoot>
											<tr>
												<th>合计</th>
												<th></th>
												<th></th>
												<th></th>
												<th id="totalpay" class="all-count money-color">0</th>
												<th></th>
											</tr>
										</tfoot>
									</table>
								</div>
							</div>
						<div style="float: right;color: red;margin-right: 15px;">${agetips }</div>
						</div>
					</div>
					<div class="btn-wrap">
						<a href="javascript:;" class="btn btn-default btn-lg prev-step">上一步</a>
						<a href="javascript:;" class="btn btn-default btn-lg" onclick="checkCourse()" >下一步</a>
						<a onclick="toNew()" href="javascript:;" class="btn btn-default btn-lg">报读新开班</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	function toNew(){
		if(selCourses.length>0){
			if(!confirm("你已经选择了课程，是否跳过？")){
				return;
			}
		}
		
		<%-- location.href='<%=basePath%>fun/baoming'; --%>
		location.href='<%=basePath%>thirdStep';		
	}
	
	function checkCourse(){
		if(confirm("是否确认报名选择的班级？")){
			$.post('<%=basePath%>checkCourse',{selCourses:JSON.stringify(selCourses)},function(data){
				if(data.code>0){
					location.href="<%=basePath%>fourStep";
				}else{
					alert(data.msg)
				}
			}).error(function(){alert("保存报名班级失败，请重试。")});			
		}
	}
</script>
</html>