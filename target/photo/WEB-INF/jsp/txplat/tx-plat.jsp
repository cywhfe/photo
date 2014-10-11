<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-${ugcModelName}</title>
<%@ include file="/include/script.jsp"%>
<script src="${ctx}/js/export/export.js" type="text/javascript"></script> 
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
					<span class="anas-type">通讯平台_小时汇总</span>
					<a id="kpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a><span id="kpiSpan"></span>
						<div style="float:right;width:100px;">
							<button type="button" style="padding:2px 5px 2px;font-size:13px;" onclick="search()" class="btn btn-primary">查询</button>
							<button type="button" style="padding: 2px 5px 2px; font-size: 13px;float:right" onclick="txPlatExportReport()" class="btn btn-primary">导出</button>
						</div>
				</div>
				<div class="subtitle" style="float:left">
				     <form  class="form-horizontal" action="" id="tef" name="tef">
				      <input type="hidden" id="biz_type" value="voice"/>
					     <fieldset style="height:auto">
					     	 <div class="control-group">
								<label class="control-label" for="focusedInput">开始时间</label>
								<div class="controls">
								<input name="begin_date" value="${begin_date}" onfocus="timeFocusBegin()" type="text" class="input-medium focused Wdate"  id="d4311" /> 
								</div>
							  </div>
							   <div class="control-group">
								<label class="control-label" for="focusedInput">结束时间</label>
								<div class="controls">
								<input name="end_date" value="${end_date}" onfocus="timeFocusEnd()" type="text"  class="input-medium focused Wdate" id="d4312" />
								</div>
							  </div>
					     </fieldset>
		 			 </form>
			    </div>
			
			<div id="chartdiv_column" style="width: 100%; height: 400px;float:left"></div>
			    
			<div id="maingrid" style="margin: 0; padding: 0;float:left;width:100%;margin-top:5px">
			  <table id="contentlist" class="table table-striped table-bordered bootstrap-datatable datatable">
						   <thead>
						   		<tr align="center">
									<th rowspan="3" align="center">时间</th>
									<th rowspan="3" align="center">消息类型</th>
									<th rowspan="2" colspan="2" align="center">总量</th>
									<th  colspan="6" align="center">单聊</th>
									<th  colspan="6" align="center">群聊</th>
								</tr>
								<tr align="center" >
									<th  colspan="2" align="center">客户端</th>
									<th  colspan="2" align="center">webpager</th>
									<th  colspan="2" align="center">人人桌面</th>
									<th  colspan="2" align="center">客户端</th>
									<th  colspan="2" align="center">webpager</th>
									<th  colspan="2" align="center">人人桌面</th>
								</tr>
								<tr >
									<th align="center">使用人数</th>
									<th align="center">发送量</th>
									<th align="center">使用人数</th>
									<th align="center">发送量</th>
									<th align="center">使用人数</th>
									<th align="center">发送量</th>
									<th align="center">使用人数</th>
									<th align="center">发送量</th>
									<th align="center">使用人数</th>
									<th align="center">发送量</th>
									<th align="center">使用人数</th>
									<th align="center">发送量</th>
									<th align="center">使用人数</th>
									<th align="center">发送量</th>
								</tr>
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
var options={};
var oTable;
$(function(){
	var yDay = getFormatDate(new Date().getTime());
	$("#d4311").val(yDay);
	$("#d4312").val(yDay);
	options.sAjaxSource="${ctx}/tx/loadTxPlatData.action";
	options.bServerSide=false;
	options.aoColumns=[
	                   { "sClass": "center" ,"mDataProp": "date","bSortable":true,"sWidth":"100px"},
	                   { "sClass": "center" ,"mDataProp": "msgType","bSortable":true ,"sWidth":"50px","fnRender": function (obj) {
	                	   if(obj){
	                		   if(obj.aData.msgType==0) return "汇总";
	                		   if(obj.aData.msgType==1) return "文本";
	                		   if(obj.aData.msgType==2) return "图像";
	                		   if(obj.aData.msgType==3) return "音频";
	                		   if(obj.aData.msgType==4) return "表情";
	                	   }else{
	                		   return "";
	                	   }
	            	   }},
	                   { "sClass": "center" ,"mDataProp": "userNumAll","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "sendNumAll","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "userNumAllChar1Plat1","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "sendNumAllChar1Plat1","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "userNumAllChar1Plat2","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "sendNumAllChar1Plat2","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "userNumAllChar1Plat3","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "sendNumAllChar1Plat3","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "userNumAllChar2Plat1","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "sendNumAllChar2Plat1","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "userNumAllChar2Plat2","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "sendNumAllChar2Plat2","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "userNumAllChar2Plat3","bSortable":false},
	                   { "sClass": "center" ,"mDataProp": "sendNumAllChar2Plat3","bSortable":false}
		             ];
	options.fnInitComplete=tableInitCallback;
	oTable=SP.loadTableInfo($("#contentlist"),options,$("#tef"));
	//显示指标定义
	$("#kpiLink").hover(
			function(){
				var kpiContent="";
				kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
				kpiContent+="提供0-24时各时段内使用聊天的人数及消息发送量.\n统计结果为聊天类型、发送终端类型、消息类型的交叉查询.";
				kpiContent+="</pre>"
				$("#kpiSpan").ligerTip({
			        content:kpiContent,
			        width:350}
				);
			},
			function(){
				$("#kpiSpan").ligerHideTip();
			}
	);
});

/*
 *表格初始化完成回调函数 
 */
function tableInitCallback(){
	$.ajax({
	    url: "${ctx}/tx/loadTxPlatChartData.action?"+$("#tef").serialize(),
	    dataType: 'json',type: 'post',
	    success: function (res){
	    	var options4={}
	    	options4.chartData=res;
	        options4.chartId="chartdiv_column";
	        options4.categoryField="date";
	        options4.valField=["sendNumAll,汇总发送量","userNumAll,汇总使用人数"];
	        options4.draw=createLineChart;
	        options4.unit="sendNumAll";
	        $("#chartdiv_column").empty();
	    	SP.loadChart(options4);
	    	}
	    });
}
/**
 * 查询
 */
function search(){
	if(!SP.checker($("#tef"))){
		return false;
	}
	if(!$("input[name='begin_date']").val() || $("input[name='begin_date']").val() == ""
		|| !$("input[name='end_date']").val() || $("input[name='end_date']").val() == ""){
		alert("必须输入起止时间查询！");
		return;
	}
	oTable.fnDestroy();
	//$("#contentlist").empty();
    SP.loadTableInfo($("#contentlist"),options,$("#tef"));
    options.fnInitComplete();
}
/**
 * 导出表格
 */
function txPlatExportReport(){
	window.location.href="${ctx}/tx/exportReport.action?"+$("#tef").serialize();
}
</script>
