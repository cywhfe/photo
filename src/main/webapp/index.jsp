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
				<div class="carousel-inner" id="photos"></div>
				<ol class="carousel-indicators" id="container"></ol>
				<a class="carousel-control left" id="prev" href="#carousel-container" data-slide="prev">&lsaquo;</a>
  				<a class="carousel-control right" id="next" href="#carousel-container" data-slide="next">&rsaquo;</a>
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
				ajaxPhotoShow(dp.cal.getDateStr());
			}
		});
		//click today date
		ajaxPhotoShow(new Date().format("yyyy-MM-dd"));
	});
	
	function ajaxPhotoShow(date){
		$.ajax({
			url : "${ctx}/photoShow",
			method : "post",
			dataType : "json",
			async : false,
			data : {
				date : date
			},
		    success : function(data){
		    	$("#photos").empty();
		    	$("#container").empty();
		    	$.each(data, function(index, item){
		    		$("#photos").append('<div class="item"><img alt="' + item.name + '" src="${ctx}/tmp/' + item.path + '"/></div>');
		    		$("#container").append('<li date-slide-to="' + index + '" data-target="#carousel-container"></li>');
		    	});
		    	if(data.length > 0){
		    		console.log("data");
		    		$("#prev").attr("href", "#carousel-container");
		    		$("#next").attr("href", "#carousel-container");
			    	$("carousel").carousel("pause").removeData();
			    	$('.carousel').carousel(0);
			    	$("#next").click();
		    	}else{
		    		console.log("no data");
		    		$("#photos").append('<div class="span ">暂无图片</div>');
		    		$("#prev").attr("href", "#");
		    		$("#next").attr("href", "#");
		    	}
		    }
		});		
	}
</script>
</html>