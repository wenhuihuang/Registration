<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script type="text/javascript">
	$(function(){
		var msg = '${msg}';
		if(msg!=null&&msg!==''){
			alert(msg);
		}
	})
</script>
</head>
<body>
	<div class="container-fluid">
			<div class="container con-wrap">
				<!-- <div class="con-title hidden-xs">
					<h3>网络报名</h3>
				</div> -->
				<div class="con-content">
					<div class="step"><span>第二步：填写报名资料</span><a href="index.html">[点击返回首页]</a></div>
					<div class="main-content">
					<div class="article-wrap">
						<form id="frm" action="<%=basePath%>submitComplete" method="post" class="form-horizontal">
						<input type="hidden" value="${isreset }" name="isreset">
						<!--
                        	时间：2015-11-23
                        	描述：第一部分
                        -->
						<div class="article-one">
							<h5 class="article-title">1.请填写您的基本资料(以下带<b class="red">*</b>的是<b class="red">必填项</b>)</h5>
							<div class="article-content">
										<div class="form-group">
											<label for="card" class="control-label col-md-3 col-sm-3 col-xs-4">身份证：</label>
											<div class="col-md-6 col-sm-9 col-xs-8">
												<input value="${cust.idcardno }" type="number" id="idcardno" name="idcardno" placeholder="请输入身份证号" class="form-control" />
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group radio-wrap">
											<span class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>性别：</span>
												<div class="col-md-3 radio">
													<label for="sex1" class="control-label">
														<input <c:if test="${cust.sex == 1 }">checked="true"</c:if>  type="radio" name="sex" id="sex1" value="1"  />
														<span>男</span>
													</label>
												</div>
												<div class="col-md-3 radio">
													<label for="sex2" class="control-label">
														<input <c:if test="${cust.sex == 2 }">checked="true"</c:if> type="radio" name="sex" id="sex2" value="2" />
														<span>女</span>
													</label>
												</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="name" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>姓名：</label>
											<div class="col-md-6 col-sm-9 col-xs-8">
												<input value="${cust.fullname }" type="text" id="fullname" name="fullname" placeholder="请输入姓名" class="form-control" />
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="birthday" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>请选择出生日期</label>
											<div class="col-md-6 col-sm-9 col-xs-8">
											
											<fmt:formatDate var="birthdayGre" value="${cust.birthdayGre }" pattern="yyyy-MM-dd" />
												<input value="${birthdayGre }" type="date" id="birthdayGreStr" name="birthdayGreStr" class="form-control"/>
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="phone" class="col-md-3  col-sm-3 col-xs-4 control-label"><b class="red">*</b>手机：</label>
											<div class="col-md-6  col-sm-9 col-xs-8">
												<input value="${cust.mobiletelno }" type="tel" name="mobiletelno" id="mobiletelno" placeholder="请输入手机" class="form-control" />
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="contact" class="col-md-3  col-sm-3 col-xs-4 control-label"><b class="red">*</b>应急联系人：</label>
											<div class="col-md-6  col-sm-9 col-xs-8">
												<input value="${cust.urgencyman }" type="text" name="urgencyman" id="urgencyman" class="form-control" placeholder="请输入应急联系人" />
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="contact_tel" class="control-label col-md-3  col-sm-3 col-xs-4"><b class="red">*</b>联系人电话：</label>
											<div class="col-md-6  col-sm-9 col-xs-8">
												<!-- <input type="tel" name="telno" id="telno" class="telno" placeholder="请输入联系人电话" /> -->
												<input value="${cust.urgencytelno }" type="tel" id="urgencytelno" name="urgencytelno" placeholder="请输入联系人电话" class="form-control" />
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="disease" class="control-label col-md-3 col-sm-3 col-xs-4">疾病史：</label>
											<div class="col-md-6 col-sm-9 col-xs-8">
												<input value="${cust.healthstatus}" type="text" name="healthstatus" id="healthstatus" placeholder="请如实输入疾病史，不输入代表您无任何疾病史" class="form-control" />
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="work" class="control-label col-md-3 col-sm-3 col-xs-4">退休前单位：</label>
											<div class="col-md-6 col-sm-9 col-xs-8">
												<input value="${cust.unitname}" type="text" name="unitname" id="unitname" placeholder="请输入退休前单位" class="form-control" />
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="position" class="control-label col-md-3 col-sm-3 col-xs-4">退休前职务：</label>
											<div class="col-md-6 col-sm-9 col-xs-8">
												<input value="${cust.oriduty }" type="text" name="oriduty" id="oriduty" placeholder="请输入退休前职务" class="form-control" />
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="native_place" class="control-label col-md-3  col-sm-3 col-xs-4"><b class="red">*</b>籍贯：</label>
											<div class="col-md-6  col-sm-9 col-xs-8">
												<input type="text" value="${cust.nativeplace }" id="nativeplace" name="nativeplace" class="form-control" placeholder="请输入籍贯" />
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="nation" class="control-label col-md-3  col-sm-3 col-xs-4"><b class="red">*</b>民族：</label>
											<div class="col-md-6  col-sm-9 col-xs-8">
												<!-- <select name="nation" class="form-control">
													<option value="汉族">汉族</option>
												</select>  -->
												<input type="text" value="${cust.nationality }" id="nationality" name="nationality" class="form-control" placeholder="请输入民族" />
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="politics" class="control-label col-md-3  col-sm-3 col-xs-4"><b class="red">*</b>政治面貌：</label>
											<div class="col-md-6 col-sm-9 col-xs-8">
												 <select name="politicsstatus" class="form-control">
													 <c:choose>
													 	<c:when test="${cust.politicsstatus == 1}"><option selected="selected" value="1">团员</option></c:when>
													 	<c:otherwise><option value="1">团员</option></c:otherwise>
													 </c:choose>
													
													<c:choose>
													 	<c:when test="${cust.politicsstatus == 2}"><option selected="selected" value="2">党员</option></c:when>
													 	<c:otherwise><option value="2">党员</option></c:otherwise>
													 </c:choose>
													 
													 
													 <c:choose>
													 	<c:when test="${cust.politicsstatus == 2}"><option selected="selected" value="3">其他</option></c:when>
													 	<c:otherwise><option value="3">其他</option></c:otherwise>
													 </c:choose>
													
												</select> 
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="education" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>文化程度：</label>
											<div class="col-md-6 col-sm-9 col-xs-8">
												<!--  <select name="education" class="form-control">
													<option value="大专">大专</option>
												</select>   -->
												
												<select name="edulevel" class="form-control">
												
													<option <c:if test="${cust.edulevel == 1 }">selected='selected'</c:if> value="1">中学</option>
													<option <c:if test="${cust.edulevel == 2 }">selected='selected'</c:if> value="2">大专</option>
													<option <c:if test="${cust.edulevel == 3 }">selected='selected'</c:if> value="3">本科</option>
													<option <c:if test="${cust.edulevel == 4 }">selected='selected'</c:if> value="4">其他</option>
												</select>
											</div>
											<div class="col-md-3"></div>
										</div>
										
										<div class="form-group">
											<label for="work_status" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>在职状况：</label>
											<div class="col-md-6 col-sm-9 col-xs-8">
												<select name="isonduty" class="form-control">
													<option <c:if test='${cust.isonduty != 0}'>selected='selected'</c:if> value="0">离职</option>
													<option <c:if test='${cust.isonduty == 1}'>selected='selected'</c:if> value="1">在职</option>
												</select>
											</div>
											<div class="col-md-3"></div>
										</div>
										
										<!--
										<div class="form-group">
											<label for="company_type" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>原单位类型：</label>
											<div class="col-md-6 col-sm-9 col-xs-8">
												<select name="company_type" id="company_type" class="form-control">
													<option value="私有">私有</option>
												</select>
											</div>
											<div class="col-md-3"></div>
										</div>
										
										<div class="form-group">
											<label for="rank" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>职级：</label>
											<div class="col-md-6 col-sm-9 col-xs-8">
												<select name="rank" id="rank" class="form-control">
													<option value="经理">经理</option>
												</select>
											</div>
											<div class="col-md-3"></div>
										</div>
										<div class="form-group">
											<label for="rank_name" class="control-label col-md-3 col-sm-3 col-xs-4"><b class="red">*</b>职称：</label>
											<div class="col-md-6 col-sm-9 col-xs-8">
												<select name="rank_name" class="form-control">
													<option value="私有">私有</option>
												</select>
											</div>
											<div class="col-md-3"></div>
										</div>
										-->
							</div>
						</div>
						<!--第二部分-->
						<!--<div class="article-two">
							<h5 class="article-title">2.请填写您的联系方式(以下为非必填项)</h5>
							<div class="article-content">
								<div class="form-group">
									<label for="home_phone" class="control-label col-md-3 col-sm-3 col-xs-4">住宅电话：</label>
									<div class="col-md-6 col-sm-9 col-xs-8">
										<input type="tel" id="home_phone" name="home_phone" placeholder="请输入住宅电话" class="form-control" />
									</div>
									<div class="col-mnd-3"></div>
								</div>
								<div class="form-group">
									<label for="family_address" class="control-label col-md-3 col-sm-3 col-xs-4">家庭住址：</label>
									<div class="col-md-6 col-sm-9 col-xs-8">
										<input type="text" id="family_address" name="family_address" placeholder="请输入家庭住址" class="form-control" />
									</div>
									<div class="col-md-3"></div>
								</div>
								<div class="form-group">
									<label for="now_address" class="control-label col-md-3 col-sm-3 col-xs-4">现居住址：</label>
									<div class="col-md-6 col-sm-9 col-xs-8">
										<input type="text" id="now_address" name="now_address" placeholder="请输入现居住址" class="form-control" />
									</div>
									<div class="col-md-3"></div>
								</div>
							</div>
						</div>-->
						<!--第三部分-->
						<!-- <div class="article-three">
							<h5 class="article-title">3.请填写其它资料(以下为非必填项)</h5>
							<div class="article-content">
								<div class="form-group">
									<label for="speciality" class="control-label col-md-3 col-sm-3 col-xs-4">特长：</label>
									<div class="col-md-6 col-sm-9 col-xs-8">
										<input type="text" id="speciality" name="speciality" placeholder="请输入特长" class="form-control" />
									</div>
									<div class="col-md-3"></div>
								</div>
								<div class="form-group">
									<label for="remarks" class="control-label col-md-3 col-sm-3 col-xs-4">备注：</label>
									<div class="col-md-6 col-sm-9 col-xs-8">
										<input type="text" id="remarks" name="remarks" placeholder="请输入备注" class="form-control" />
									</div>
									<div class="col-md-3"></div>
								</div>
							</div>
						</div>
						</form>
					</div> -->
					<div class="btn-wrap">
						<c:choose>
							<c:when test="${isreset == 1}">
								<a onclick="submitfrm()" href="javascript:;" class="btn btn-default btn-lg">保存</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:;" class="btn btn-default btn-lg prev-step">上一步</a>
								<a onclick="submitfrm()" href="javascript:;" class="btn btn-default btn-lg">下一步</a>
							</c:otherwise>
						</c:choose>
						
						
					</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			function submitfrm(){
				$("#frm").submit();
			}
		</script>
	</body>
</html>
