<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<html>
<head>
<title>图片展示</title>
<%@ include file="/include/script.jsp"%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
</head>
<!--header-->
<body>
	<div class="row">
		<div id="dateDiv" class="span4"></div>
		<div id="photoDiv" class="span8">
			<div data-ride="carousel" class="carousel slide" id="carousel-container">
				<!-- 图片容器 -->
				<div class="carousel-inner">
					<div class="item"><img alt="第一张图" src="${ctx}/static/images/1.jpg"/></div>
					<div class="item active"><img alt="第二张图" src="${ctx}/static/images/2.jpg"/></div>
					<div class="item"><img alt="第三张图" src="${ctx}/static/images/3.jpg"/></div>
				</div>
				<!-- 指示符 -->
				<ol class="carousel-indicators">
					<li date-slide-to="0" data-target="#carousel-container"></li>
					<li date-slide-to="1" data-target="#carousel-container"></li>
					<li date-slide-to="2" data-target="#carousel-container"></li>
				</ol>
				<!-- 左右控制按钮 -->
<!-- 				<a data-slide="prev" href="#carousel-container" class="left carousel-control">
					<span class="glyphicon glyphicon-chevron-left"></span>
				</a>
				<a data-slide="next" href="#carousel-container" class="right carousel-control">
					<span class="glyphicon glyphicon-chevron-right"></span>
				</a> -->
				<a class="carousel-control left" href="#carousel-container" data-slide="prev">&lsaquo;</a>
  				<a class="carousel-control right" href="#carousel-container" data-slide="next">&rsaquo;</a>
			</div>
		</div>
	</div>
</body>
<script>
	//页面加载完执行
	$(function() {
		WdatePicker({
			eCont : 'dateDiv',
			onpicked : function(dp) {
				alert('你选择的日期是:' + dp.cal.getDateStr());
				//TODO:
				//add photo info
			}
		})
	});
</script>
</html>