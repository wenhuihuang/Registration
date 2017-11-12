<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String resourcesPath = basePath+"statics/report";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<base href="<%=basePath%>">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>网络报名</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="<%=resourcesPath %>/grhtml5-1.0.0beta-min.js"></script>
    <script language="javascript" type="text/javascript">
        function window_onload() {
            var reportURL = "<%=resourcesPath %>/grf/" + getQueryString("report") + ".grf",
                dataURL = "<%=resourcesPath %>/data/" + getQueryString("data") + ".txt",
                options = getQueryString("options"),
                reportViewer = window.rubylong.grhtml5.insertReportViewer("report_holder", reportURL, dataURL);

            document.title += getQueryString("title"); //设置当前网页标题

            if (options) {
                options = options.split(";");
                options.forEach(function (item) {
                    reportViewer.options[item] = true;
                });
            }

            reportViewer.start();
        }

        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) {
                return decodeURI(r[2]); //return unescape(r[2]);
            }
            return null;
        }
    </script>
</head>
<body onload="window_onload()">
    <div id="report_holder">
    </div>
</body>
</html>