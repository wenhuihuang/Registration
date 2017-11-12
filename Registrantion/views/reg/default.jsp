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
                    <link rel="stylesheet" type="text/css" href="<%=resourcesPath %>/css/iconfont.css" />
                    <link rel="stylesheet" href="<%=resourcesPath %>/bootstrap_3.3.5/css/bootstrap.min.css" />
                    <link rel="stylesheet" type="text/css" href="<%=resourcesPath %>/css/Registration.css" />
                    <script type="text/javascript" src="<%=resourcesPath %>/js/jquery-1.11.3.min.js"></script>
                    <script type="text/javascript" src="<%=resourcesPath %>/js/Registration.js"></script>
                    <style>
                        html,
                        body {
                            height: 100%;
                        }

                        .main-content-home {
                            position: relative;
                            height: 100%;
                        }

                        .center-text-h {
                            position: absolute;
                            top: 0;
                            bottom: 0;
                            right: 0;
                            left: 0;
                            margin: auto;
                            font-size: 25px;
                            font-weight: bold;
                            text-align: center;
                            height: 26px;
                        }

                        .mobile-index .btn {
                            width: 80%;
                            margin-bottom: 20px;
                            padding-left: 10%;
                            text-align: left;
                        }

                        .mobile-index .btn .iconfont {
                            margin-right: 10px;
                        }

                        .mobile-index {
                            display: none;
                            padding-top: 20px;
                        }

                        .wellcome-text {
                            display: block;
                        }
                    </style>
                    <script>
                        $(function () {
                            //判断是不是手机端
                            var is_mobile = !!navigator.userAgent.match(/mobile/i);
                            if (is_mobile) {
                                $('.mobile-index').show();
                                $('.wellcome-text').hide();
                                $('.center-text-h').css({ 'position': 'static' })
                                //加载loading
                                $('[target="iframe"]').click(function () {
                                    var loading = $('<div class="loading-pop" style="position:fixed;top:0;bottom:0;left:0;right:0;z-index:10000;  opacity:1; filter:alpha(opacity=60);background:rgba(0, 0, 0, 0.78)" ><div style="position:fixed;top:0;bottom:0;left:0;right:0;z-index:11000;"  class="loading-icon"></div></div>');
                                    window.parent.$('body').append(loading);
                                })
                            }
                        })
                    </script>
                </head>

                <body>
                    <div class="container-fluid main-content-home">
                        <div class="center-text-h">
                            <p class="wellcome-text">欢迎使用广东省妇女儿童发展指导中心网上注册系统</p>
                            <!-- 手机版专用 -->
                            <div class="mobile-index container-fluid">
                                <div class="row">
                                    <a href="<%=basePath%>fun/baoming" target="iframe" class="btn btn-primary btn-lg menu-item active">
                                        <i class="iconfont">&#xe601;</i>我要报名</a>
                                </div>
                                <div class="row">
                                    <a href="<%=basePath%>fun/jiaofei" target="iframe" class="btn btn-primary btn-lg menu-item">
                                        <i class="iconfont">&#xe62b;</i>我要缴费</a>
                                </div>
                                <!-- <div class="row"><a href="./thirdStep.html" target="iframe" class="btn btn-primary btn-lg menu-item"><i class="iconfont">&#xe700;</i>选择班级</a></div> -->
                                <div class="row">
                                    <a href="<%=basePath%>fun/chakan" target="iframe" class="btn btn-primary btn-lg menu-item">
                                        <i class="iconfont">&#xe6cb;</i>查看已报名班级</a>
                                </div>
                                <div class="row">
                                    <a href="<%=basePath%>fun/xiugai" target="iframe" class="btn btn-primary btn-lg menu-item">
                                        <i class="iconfont">&#xe615;</i>学员资料修改</a>
                                </div>
                                <div class="row">
                                    <a href="<%=basePath%>logout" class="btn btn-danger btn-lg menu-item">
                                        <i class="iconfont">&#xe600;</i>退出登录</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </body>

                </html>