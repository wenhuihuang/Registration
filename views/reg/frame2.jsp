<%@page import="com.qx.shiro.QxShiroCommon"%>
<%@page import="com.reg.common.RegConstants"%>
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
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>网络报名</title>
    <!--[if lt IE 9]>
    <script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
    <script src="http://apps.bdimg.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="<%=resourcesPath %>/bootstrap_3.3.5/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=resourcesPath %>/css/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="<%=resourcesPath %>/css/pop.css" />
    <link rel="stylesheet" type="text/css" href="<%=resourcesPath %>/css/Registration.css" />
    <script type="text/javascript" src="<%=resourcesPath %>/js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="<%=resourcesPath %>/js/pop.js"></script>
    <script type="text/javascript" src="<%=resourcesPath %>/js/Registration.js"></script>
    <style>
        @media (min-width: 768px) and (max-width: 1060px) {
            .md-right-content {
                padding-top: 20px;
            }
        }
    </style>
    <script>
        function resetSize() {
            var bodyHeight = $(window).height() - $('.header').height() - 1;
            $('.body').css({ 'height': bodyHeight })
            $('.body-height-fluid').css({ 'height': bodyHeight })
            var windowWidth = $(window).width();
            if (windowWidth >= 1190) {
                $('.md-left-menu').css({ 'width': '250px' })
                $('.md-right-content').css({ 'width': windowWidth - 250 })
            }else if(windowWidth > 768 && windowWidth < 1200){
                $('.md-left-menu').css({ 'width': '230px' })
                $('.md-right-content').css({ 'width': windowWidth - 230 })
            } 
            else {
                $('.md-left-menu').removeAttr('style')
                $('.md-right-content').removeAttr('style')
            }

        }

        $(function () {
            $('#xs-menu-btn').on('click', function () {
                $('.cover').show();
                $('.xs-right-menu').addClass('xs-right-menu-active');
            })
            $('.cover').on('click', function () {
                $('.cover').hide();
                $('.xs-right-menu').removeClass('xs-right-menu-active');
            })
            $('.close-menu').on('click', function () {
                $('.cover').hide();
                $('.xs-right-menu').removeClass('xs-right-menu-active');
            })

            //调节主体高度
            resetSize()
            $(window).resize(function () {
                resetSize()
            })

            //当屏幕是小的时候 点击菜单
            $('.menu-item').click(function () {
                if ($('.xs-right-menu-header:visible').length) {
                    $('.cover').hide();
                    $('.xs-right-menu').removeClass('xs-right-menu-active');
                }
            })
        })
    </script>
</head>
<body>
	<div class="header container-fluid">

        <div class="row">
            <div class="col-md-1 col-sm-2 col-xs-3"><img class="logo" src="<%=resourcesPath %>/img/logo.png" alt=""></div>
            <div class="col-md-6 col-sm-5 col-xs-7 xs-header-middle">
                <p class="title">广东省妇女儿童发展指导中心网上注册系统</p>
                <p class="visible-xs-block" style="margin:0;">您好，${cust.fullname }</p>
            </div>
            <div class="col-md-5 col-sm-5 hidden-xs header-bottom-group">
                <span class="header-name">您好，${cust.fullname }</span>
                <button type="button" class="btn btn-primary" onclick="location.href=''"><i class="iconfont">&#xe609;</i>回首页</button>
                <button onclick="location.href='<%=basePath%>logout'" type="button" class="btn btn-danger"><i class="iconfont">&#xe600;</i>退出</button>
            </div>
            <div class="visible-xs-block col-xs-2 menu-btn-wrap">
                <a href="javascript:;" id="xs-menu-btn">
                    <div><i class="iconfont">&#xe64a;</i></div>
                    <div>更多<br>功能</div>
                </a>
            </div>
        </div>
    </div>
    <div class="body container-fluid">
        <div class="row body-height-fluid">
            <div class="col-md-3 col-sm-3 xs-right-menu md-left-menu">
                <div class="xs-right-menu-header visible-xs-block">
                    <div class="close-menu">
                        <p style="text-align:center;margin-bottom:0;"><i class="iconfont " style="font-size:18px;margin-right:0;">&#xe63c;</i></p>
                        <p>关闭</p>
                    </div>
                </div>
                <div class="row"><a href="<%=basePath%>fun/baoming" target="iframe" class="btn btn-primary btn-lg menu-item active"><i class="iconfont">&#xe601;</i>我要报名</a></div>
                <div class="row"><a href="<%=basePath%>fun/jiaofei" target="iframe" class="btn btn-primary btn-lg menu-item"><i class="iconfont">&#xe62b;</i>我要缴费</a></div>
                <!-- <div class="row"><a href="./thirdStep.html" target="iframe" class="btn btn-primary btn-lg menu-item"><i class="iconfont">&#xe700;</i>选择班级</a></div> -->
                <div class="row"><a href="<%=basePath%>fun/chakan" target="iframe" class="btn btn-primary btn-lg menu-item"><i class="iconfont">&#xe6cb;</i>查看已报名班级</a></div>
                <div class="row"><a href="<%=basePath%>fun/xiugai" target="iframe" class="btn btn-primary btn-lg menu-item"><i class="iconfont">&#xe615;</i>学员资料修改</a></div>
                <div class="row"><a href="<%=basePath%>logout" class="btn btn-danger btn-lg menu-item"><i class="iconfont">&#xe600;</i>退出登录</a></div>

            </div>
            <div class="col-md-9 col-sm-9 col-xs-12 md-right-content">
            	<c:choose>
	            	<c:when test="${isBlankField == true }">
	            		<iframe src="<%=basePath%>completemsg" frameborder="0" scrolling="yes" style="width:100%;height:99%" name="iframe"></iframe>
	            	</c:when>
					<c:otherwise>
		                <iframe src="default" frameborder="0" scrolling="yes" style="width:100%;height:99%" name="iframe"></iframe>					
					</c:otherwise>            	
            	</c:choose>
            </div>
        </div>
    </div>
    <div class="footer">

    </div>
    <div class="cover"></div>
    <!-- 弹框 -->
    <div class="pop-wrap" style="display:none;">
        <div class="pop-cover"></div>
        <div class="pop-content">
            <div class="pop-content-title">请选择前往的页面</div>
            <div class="pop-content-text">
                <div class="page-option-wrapper">
                    <a href="" class="page-option">
                        <img src="<%=resourcesPath %>/img/error_icon.png" alt="">
                    </a>
                    <a href="" class="page-option">
                        <img src="<%=resourcesPath %>/img/success_icon.png" alt="">
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
<script>

</script>

</html>