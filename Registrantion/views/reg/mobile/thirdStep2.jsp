<%@page import="com.reg.common.RegConstants"%>
<%@page import="com.qx.shiro.QxShiroCommon"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String resourcesPath = basePath + "statics/reg";
%>
<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>网络报名</title>
<link rel="stylesheet" href="<%=resourcesPath%>/bootstrap_3.3.5/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<%=resourcesPath%>/css/Registration.css" />
<script type="text/javascript" src="<%=resourcesPath%>/js/jquery-1.11.3.min.js"></script>
<link rel="<%=resourcesPath%>/stylesheet" href="js/pagination.css">
<script src="<%=resourcesPath%>/js/jquery.pagination.js"></script>
<script type="text/javascript" src="<%=resourcesPath%>/js/Registration.js"></script>
<style>
	.step_mobile {
	    height: 48px;
	    padding: 0 20px;
	    line-height: 48px;
	    font-size: 16px;
	    background: #0085CF;
		color: white;
		position: fixed;
		top:0;
		left:0;
		right:0;
	}
	.step_mobile span{
		text-align: center;
	}
	.content_mobile{
		overflow: auto;
		position: fixed;
		top:48px;
		left:0;
		right:0;
		bottom:60px;
	}
	.btn-wrap{
		position: fixed;
		bottom: 0px;
		left:0;
		right:0;
		padding:20px 0 10px 0;
		margin: 0;
		background:#fff;
	}
	.content_mobile th, .content_mobile td{
		font-weight: normal !important;
		font-size: 10px !important;
		vertical-align: middle !important;
	}
	.money-color {
		color: #F67524;
	}
	
</style>
<script type="text/javascript">
	var isAdd20Precent = <%=RegConstants.isAdd20Precent()%>
	var selCourses = [];//选择的课程
	function getCourse(){
		var depid = $("#depid").val();
		var selectIds = "";
		if(selCourses.length>0){
			for(var i = 0;i<selCourses.length;i++){
				selectIds += "'"+selCourses[i].classid+"',";
			}
			selectIds = selectIds.substring(0,selectIds.length-1);
		}
		$.post("getCourse",{depid:depid,selectIds:selectIds,pageNum:1,pageSize:9999},function(data){
			if(data!=null && data.list != null && data.list.length>0){
				var json = data.list;
				var ele_array = [];
				for (var i = 0; i < json.length; i++) {
					ele_array.push('<tr id="course-'+json[i].classid+'" >')
					ele_array.push('<td>' + json[i].classname + '</td>')
					ele_array.push('<td>' + json[i].classtime + '</td>')
					ele_array.push('<td>' + json[i].teacherid + '</td>')
					ele_array.push('<td>' + json[i].qty + '</td>')
					var fee = json[i].fee;
					//对于老人大学，如果学员没达到退休年龄的，学费自动加收20%；
					if(isAdd20Precent==1){
						ele_array.push('<td class="money-color">'+fee*20/100+'</td>')
					}else{
						ele_array.push('<td class="money-color">'+fee+'</td>')			
					}
					ele_array.push('<td><a href="javascript:;" class="btn btn-orange" onclick="addCourse(this,\''+json[i].classid+'\',\''+json[i].classname+'\',\''+json[i].classtime+'\',\''+json[i].teacherid+'\',\''+json[i].qty+'\',\''+json[i].fee+'\',\''+json[i].dictionaryid+'\',\''+json[i].regclassid+'\')" >选择</a></td>')
					ele_array.push('</tr>')
				}
				$('.select-tbody').html(ele_array.join(''));
			}else{
				$('.select-tbody').html("<tr><td colspan=\"6\">暂无课程</td></tr>");
			}
		},"json").error(function(){alert("获取课程列表失败，请重试。")});
	}
	function addCourse(obj,classid,classname,classtime,teacherid,qty,fee,dictionaryid,regclassid) {
		var tmpJson = {classid:classid,classname:classname,classtime:classtime,teacherid:teacherid,qty:qty,fee:fee,dictionaryid:dictionaryid,regclassid:regclassid};
		//判断人数是否已满和时间冲突
			$.post('<%=basePath%>checkconflict',{selCourse:JSON.stringify(tmpJson),selCourses:JSON.stringify(selCourses)},function(data){
			if(data.code>0){
				selCourses.push(tmpJson);
				//如果成功执行
				$(obj).parent().html('<a href="javascript:;" class="btn btn-default" onclick="cancelCourse(this,\''+classid+'\',\''+classname+'\',\''+classtime+'\',\''+teacherid+'\',\''+qty+'\',\''+fee+'\',\''+dictionaryid+'\',\''+regclassid+'\')">取消</a>')
				$("#totalpay").html(parseFloat($("#totalpay").html())+parseFloat(fee))
			}else{
				alert(data.msg);
			}
		}).error(function(){alert("增加选择课程失败，请重试。")});
	}
	function cancelCourse(obj,classid,classname,classtime,teacherid,qty,fee,dictionaryid,regclassid) {
		var tbody = $('.select-tbody');
		if(selCourses.length>0){
			for(var i = 0;i<selCourses.length;i++){
				if(selCourses[i].classid==classid){
					selCourses.splice(i,1);					
					break;
				}
			}
		}
		//如果成功执行
		$(obj).parent().html('<a href="javascript:;" class="btn btn-orange" onclick="addCourse(this,\''+classid+'\',\''+classname+'\',\''+classtime+'\',\''+teacherid+'\',\''+qty+'\',\''+fee+'\',\''+dictionaryid+'\',\''+regclassid+'\')" >选择</a>')
		$("#totalpay").html(parseFloat($("#totalpay").html())-parseFloat(fee))
	}
	$(function () {
		if(isAdd20Precent==1){
			$("#tip_info").show();
		}
		getCourse();
	})
	</script>
</head>
<body>
	<div class="step_mobile">
		<span class="col-md-12 col-xs-12">选择课程</span>
	</div>
	<div class="content_mobile">
		<input id="depid" type="hidden" value="${depid}"/>
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th>课程名称</th>
					<th>上课时间</th>
					<th>任课老师</th>
					<th>人数</th>
					<th>学费(元)</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody class="select-tbody"></tbody>
			<tfoot>
				<tr>
					<th>合计</th>
					<th></th>
					<th></th>
					<th></th>
					<th id="totalpay" class="all-count money-color">0</th>
					<th></th>
				</tr>
				<tr id="tip_info" style="display: none;"><td colspan="6" style="color: red;">您还未达退休年龄，每个课程加收20%学费</td></tr>
			</tfoot>
		</table>
	</div>
	<div class="btn-wrap">
		<a class="btn btn-default btn-lg prev-step">上一步</a>
		<a class="btn btn-default btn-lg" onclick="checkCourse()">下一步</a>
	</div>
</body>
<script type="text/javascript">
	function checkCourse(){
		if(confirm("是否确认报名选择的班级？")){
			$.post('<%=basePath%>checkCourse',{selCourses:JSON.stringify(selCourses)},function(data){
				if(data.code>0){
					location.href="<%=basePath%>fourStep";
				} else {
					alert(data.msg)
				}
			}).error(function() {
				alert("保存报名班级失败，请重试。")
			});
		}
	}
	// $(function(){
	// 	var bd_height = document.body.offsetHeight;
	// 	var ct_height = bd_height - 48 -77;
	// 	$(".content_mobile").height(ct_height);
	// });
</script>
</html>