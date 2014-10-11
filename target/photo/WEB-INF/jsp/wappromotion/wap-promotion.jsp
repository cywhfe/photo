<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-Wap外部推广</title>
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
					<span class="anas-type">Wap_Wap外部推广</span>
					<a id="kpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a><span id="kpiSpan"></span>
					<span class="anas-type"><a href="${ctx}/help/wap_promotion.jsp" style="padding:2px 5px 2px;font-size:13px;"  >说明</a></span>	
						<div style="float:right;width:90px;">
							<button type="button" style="padding:2px 5px 2px;font-size:13px;" onclick="search()" class="btn btn-primary">查询</button>
							<button type="button" style="padding: 2px 5px 2px; font-size: 13px;float:right" onclick="exportData()" class="btn btn-primary">导出</button>
						</div>
				</div>
				<div class="subtitle" style="float:left">
				     <form  class="form-horizontal" action="" id="tef" name="tef">
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
							 <s:include value="../common/wap-channel.jsp"></s:include>
					     </fieldset>
		 			 </form>
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
var options={};
var daycom=null;
$(function(){
	$("#wapchannelDiv").show();
	options.sAjaxSource="${ctx}/wap/loadPromotionData.action";
	options.aoColumns=[
		               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "date","bSortable":true ,"sWidth":"20%"},
	                   { "sTitle": "星期", "sClass": "center","mDataProp": "day","bSortable":true,"sWidth":"20%"
	                   }
		             ];
	options.bServerSide=false;
	daycom=[{ "sTitle": "点击人数", "sClass": "center","mDataProp": "uv","bSortable":true },
	            { "sTitle": "点击次数", "sClass": "center","mDataProp": "pv","bSortable":true }]
	for(var i=0;i<daycom.length;i++){
		options.aoColumns.push(daycom[i]);
	}
	oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));
	
	//显示指标定义
	$("#kpiLink").hover(
			function(){
				var kpiContent="";
				kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
				kpiContent+="可以查询wap外部推广跳链的点击人数和点击次数";
				kpiContent+="</pre>"
				$("#kpiSpan").ligerTip({
			        content:kpiContent,
			        width:300}
				);
			},
			function(){
				$("#kpiSpan").ligerHideTip();
			}
	);
});
//导出表格
function exportData(){
	SP.exportExcel("${ctx}/wap/exportPromotionData.action");
}
//查询
function search(){
	if(!$("#d4311").val() || $("#d4311").val() == ""
		|| !$("#d4312").val() || $("#d4312").val() == ""){
		alert("必须输入起止时间查询！");
		return;
	}
	options.aoColumns=[
		               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "date","bSortable":true ,"sWidth":"10%"},
	                   { "sTitle": "星期", "sClass": "center","mDataProp": "day","bSortable":true ,"sWidth":"10%"
	                   }
		             ];
	if(!($("#wapChannelInput")[0].disabled) && ($("#wapChannelInput").val()!="")){
		options.aoColumns.push({ "sTitle": "渠道Id", "sClass": "center" ,"mDataProp": "channelId","sWidth":"10%","bSortable":true});
		options.aoColumns.push({ "sTitle": "渠道名称", "sClass": "center" ,"mDataProp": "channelName","sWidth":"25%","bSortable":false});
	}
	for(var i=0;i<daycom.length;i++){
		options.aoColumns.push(daycom[i]);
	}

	oTable.fnDestroy();
	$("#contentlist").empty();
	oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));
}
</script>
