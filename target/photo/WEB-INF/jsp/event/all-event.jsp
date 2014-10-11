<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-崩溃分析</title>
<%@ include file="/include/script.jsp"%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
</head>
<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			     <div class="tablistbox">
					<span class="anas-type">崩溃分析</span>
					<a id="kpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a><span id="kpiSpan"></span>
					<span class="anas-type"><a href="${ctx}/help/event.jsp" style="padding:2px 5px 2px;font-size:13px;"  >说明</a></span>
						<div style="float:right;width:90px;">
							<button type="button" style="padding:2px 5px 2px;font-size:13px;" onclick="search()" class="btn btn-primary">查询</button>
							<button type="button" style="padding: 2px 5px 2px; font-size: 13px;float:right" onclick="exportData()" class="btn btn-primary">导出</button>
						</div>
				</div>
				<div class="subtitle" >
				     <form  class="form-horizontal" action="" id="tef" name="tef" method="post">
					     <fieldset style="height:auto">
					     	 <div class="control-group">
								<label class="control-label" for="focusedInput">开始时间</label>
								<div class="controls">
								<input name="templateVo.start_time" onfocus="timeFocusBegin()" type="text" class="input-medium focused Wdate"  id="d4311" /> 
								</div>
							  </div>
							   <div class="control-group">
								<label class="control-label" for="focusedInput">结束时间</label>
								<div class="controls">
								<input name="templateVo.end_time" onfocus="timeFocusEnd()" type="text"  class="input-medium focused Wdate" id="d4312" />
								</div>
							  </div>
							  
							  
							 <s:include value="../common/selectbox.jsp"></s:include>
					     </fieldset>
		 			 </form>
			    </div>
			 <div>
			<div id="baseTab">
				<ul>
					<li><a href="#base-1">机型分布</a></li>
					<li><a href="#base-2">崩溃类型分布</a></li>
					<li><a href="#base-3">操作系统分布</a></li>
				</ul>
				<div id="base-1">
					<div id="eventModel" style="width: 100%; height: 300px"></div>
				</div>
				<div id="base-2">
					<div id="eventException" style="width: 50%; height: 300px ; margin-left: 200px;" ></div>
				</div>
				<div id="base-3">
					<div id="eventOs" style="width: 100%; height: 300px"></div>
				</div>
			</div>
			</div>
			<div id="maingrid" style="margin: 0; padding: 0;float:left;width:100%;margin-top:0px">
			  <table id="contentlist" class="table table-striped table-bordered bootstrap-datatable datatable">
						   <thead>
						   </thead>
			  </table>
			</div>
		</div>
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
	
	
		
</body>
</html>
<script>
var sDay = getFormatDate(new Date().getTime()-(1*24*3600*1000));
var eDay = getFormatDate(new Date().getTime()-(1*24*3600*1000) );
$("#d4311").val(sDay);
$("#d4312").val(eDay);
$("#device_id_div").hide();
$("#os_id").attr("disabled",false);
$("#app_id").attr("disabled",false);
$("#client_version").attr("disabled",false);
var options={};
options.bServerSide=false;
options.sAjaxSource="${ctx}/event/loadTableData.action";
options.aoColumns=[
	               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "date"},
	               { "sTitle": "星期", "sClass": "center","mDataProp": null, "fnRender": function (obj) {
                	   return "星期"+"天一二三四五六".charAt(new Date(""+obj.aData.date+"").getDay());
                	   },"bSortable":false
                   },
	               { "sTitle": "平台", "sClass": "center","mDataProp": "os" },
	               { "sTitle": "appid", "sClass": "center","mDataProp": "appid","sWidth": "30%"},
	               { "sTitle": "版本", "sClass": "center","mDataProp": "version" },
	               { "sTitle": "人数", "sClass": "center","mDataProp": "uv" },
	               { "sTitle": "次数", "sClass": "center","mDataProp": "pv" },
	               { "sTitle": "崩溃率", "sClass": "center","mDataProp": "per" },
	             ];
	             
	
var oTable=SP.loadTableInfo($("#contentlist"),options,$("#tef"));

var baseTab = $("#baseTab").tabs({
	collapsible: true ,
	cache: true ,
	select : function( event, ui ) {
		var index=ui.index;
		var selected=baseTab.tabs('option', 'selected');
		//选择当前显示的tab,则收缩tab
		if(index==selected) return;
		if(index==0){
			showChartModel();
		}
		if(index==1){
			showPieException();
		}
		if(index==2){
			showChartOs();
		}
	}
});
showChartModel();
//崩溃分析机型分布图
function showChartModel() {
		$.ajax({
			url : "${ctx}/event/loadModelInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField=["count,机型"];
				options.categoryField="model";
				options.chartData=data;
				options.draw=createColumnBarChart;
				options.chartId="eventModel";
				$("#eventModel").empty();
				SP.loadChart(options);
			}
		});
}

//崩溃分析崩溃类型分布图
function showPieException(){
	$.ajax({
		url : "${ctx}/event/loadExceptionInfos.action?"+$("#tef").serialize(),
		cache : false,
		dataType : "json",
		success : function(data) {
			var options = {};
			options.valField="count";
			options.categoryField="exception";
			options.chartData=data;
			options.draw=createPieChartWithTable;
			options.chartId="eventException";
			$("#eventException").empty();
			SP.loadChart(options);
		}
	});
}


//崩溃分析操作系统分布图
function showChartOs() {
	$.ajax({
		url : "${ctx}/event/loadOsInfos.action?"+$("#tef").serialize(),
		cache : false,
		dataType : "json",
		success : function(data) {
			var options = {};
			options.valField=["count,操作系统"];
			options.categoryField="os";
			options.chartData=data;
			options.draw=createColumnBarChart;
			options.chartId="eventOs";
			$("#eventOs").empty();
			SP.loadChart(options);
		}
	});
}


function exportData(){
	$("#tef").attr("action","${ctx}/event/exportReport.action");
	$("#tef").submit();
	
}
function search(){
	var selected=baseTab.tabs('option', 'selected');
	//选择当前显示的tab,则收缩tab
	if(selected==0){
		showChartModel();
	}
	if(selected==1){
		showPieException();
	}
	if(selected==2){
		showChartOs();
	}
	oTable.fnDestroy();
	$("#contentlist").empty();
	oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));
	
}

//显示指标定义
$("#kpiLink").hover(
		function(){
			var kpiContent="";
			kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
			kpiContent+="可以查看客户端各版本的崩溃人数，崩溃次数，崩溃率（崩溃次数/接口调用次数），同时提供崩溃机型、崩溃类型、崩溃操作系统的分布图。 \n";

				
			$("#kpiSpan").ligerTip({
		        content:kpiContent,
		        width:620}
			);
		},
		function(){
			$("#kpiSpan").ligerHideTip();
		}
);
</script>
