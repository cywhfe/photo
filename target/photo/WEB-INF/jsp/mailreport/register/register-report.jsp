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
					<span class="anas-type">邮件报表_注册日报表</span>
						<div style="float:right;width:100px;">
							<button type="button" style="padding:2px 5px 2px;font-size:13px;" onclick="search()" class="btn btn-primary">查询</button>
							<button type="button" style="padding: 2px 5px 2px; font-size: 13px;float:right" onclick="exportReport()" class="btn btn-primary">导出</button>
						</div>
				</div>
				<div class="subtitle" style="float:left">
				     <form  class="form-horizontal" action="" id="tef" name="tef">
				      <input type="hidden" id="biz_type" value="voice"/>
					     <fieldset style="height:auto">
					     	 <div class="control-group">
								<label class="control-label" for="focusedInput">开始时间</label>
								<div class="controls">
								<input name="templateVo.start_time" value="${templateVo.start_time}" onfocus="timeFocusBegin()" type="text" class="input-medium focused Wdate"  id="d4311" /> 
								</div>
							  </div>
							   <div class="control-group">
								<label class="control-label" for="focusedInput">结束时间</label>
								<div class="controls">
								<input name="templateVo.end_time" value="${templateVo.end_time}" onfocus="timeFocusEnd()" type="text"  class="input-medium focused Wdate" id="d4312" />
								</div>
							  </div>
					     </fieldset>
		 			 </form>
			    </div>
			<div id="maingrid" style="margin: 0; padding: 0;float:left;width:100%;margin-top:5px">
			  <table id="contentlist" class="table table-striped table-bordered bootstrap-datatable datatable">
						   <thead >
						   		<tr>
									<th rowspan="2" style="text-align: center">时间</th>
									<th colspan="4" style="text-align: center">汇总</th>
									<th  colspan="6" style="text-align: center">客户端主要渠道注册数 </th>
									<th colspan="2" style="text-align: center">2014年客户端累计注册</th>
								</tr>
								<tr>
									<th style="text-align: center">总注册数</th>
									<th style="text-align: center">客户端</th>
									<th style="text-align: center">wap&tauch</th>
									<th style="text-align: center">其他</th>
									<th style="text-align: center">站内渠道</th>
									<th style="text-align: center">站外线上渠道</th>
									<th style="text-align: center">站外线上渠道付费</th>
									<th style="text-align: center">终端商合作</th>
									<th style="text-align: center">运营商合作</th>
									<th style="text-align: center">站外线下渠道付费</th>
									<th style="text-align: center">累计注册量</th>
									<th style="text-align: center">累计注册用户占当日客户端登录比</th>
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
	var sDay = getFormatDate(new Date().getTime()-(31*24*3600*1000));
	var eDay = getFormatDate(new Date().getTime()-(1*24*3600*1000));
	$("#d4311").val(sDay);
	$("#d4312").val(eDay);
	options.sAjaxSource="${ctx}/mailreport/loadRegisterReportData.action";
	options.bServerSide=false;
	options.aoColumns=[
	                   { "sClass": "center" ,"mDataProp": "date","bSortable":true,"sWidth":"100px"},
	                   
	                   { "sClass": "center" ,"mDataProp": "numAll","bSortable":true},
	                   { "sClass": "center" ,"mDataProp": "numType1","bSortable":true},
	                   { "sClass": "center" ,"mDataProp": "numType2","bSortable":true},
	                   { "sClass": "center" ,"mDataProp": "numType4","bSortable":true},
	                   
	                   { "sClass": "center" ,"mDataProp": "numFrom2069","bSortable":true},
	                   { "sClass": "center" ,"mDataProp": "numFrom2070","bSortable":true},
	                   { "sClass": "center" ,"mDataProp": "numFrom2071","bSortable":true},
	                   { "sClass": "center" ,"mDataProp": "numFrom5","bSortable":true},
	                   { "sClass": "center" ,"mDataProp": "numFrom1","bSortable":true},
	                   { "sClass": "center" ,"mDataProp": "numFrom2072","bSortable":true},
	                   { "sClass": "center" ,"mDataProp": "numRegister2014","bSortable":true},
	                   { "sClass": "center" ,"mDataProp": "proportion","bSortable":true}
		             ];
	options.fnInitComplete=tableInitCallback;
	oTable=SP.loadTableInfo($("#contentlist"),options,$("#tef"));
});

/*
 *表格初始化完成回调函数 
 */
function tableInitCallback(){
	
}
/**
 * 查询
 */
function search(){
	if(!$("#d4311").val() || $("#d4311").val() == ""
		|| !$("#d4312").val() || $("#d4312").val() == ""){
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
function exportReport(){
	window.location.href="${ctx}/mailreport/registerExportReport.action?"+$("#tef").serialize();
}
</script>
