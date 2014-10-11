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
					<span class="anas-type">${ugcModelName}</span>	
					<a id="kpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a><span id="kpiSpan"></span>
					<span class="anas-type"><a href="${ctx}/help/ugc.jsp" style="padding:2px 5px 2px;font-size:13px;"  >说明</a></span>
						<div style="float:right;width:100px;">
							<button type="button" style="padding:2px 5px 2px;font-size:13px;" onclick="search()" class="btn btn-primary">查询</button>
							<button type="button" style="padding: 2px 5px 2px; font-size: 13px;float:right" onclick="exportUgcData()" class="btn btn-primary">导出</button>
						</div>
				</div>
				<div class="subtitle" style="float:left">
				     <form  class="form-horizontal" action="" id="tef" name="tef">
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
							  
							  <div class="control-group">
								<label class="control-label" for="selectError">登录来源</label>
								<div class="controls">
									<select id="biz_type" name="biz_type" style="width:120px" onchange="changeBiz_type();">
											<c:if test="${!empty source}">
												<c:forEach items="${source}" var="type">
													<option value="${type}" >${type.typeName}</option>
												</c:forEach>
											</c:if>
									</select> 
								</div>
							  </div>
							   
							  <div class="control-group">
								<label class="control-label" for="selectError">UGC类型</label>
								<div class="controls">
									<select multiple="multiple" id="ugcTypeList" name="ugcAttr" style="width:120px" >
											<c:if test="${!empty ugcTypeList}">
												<c:forEach items="${ugcTypeList}" var="type">
													<option value="${type}" >${type.typeName}</option>
												</c:forEach>
											</c:if>
									</select> 
								</div>
							  </div>
							  
							  <div class="control-group selcal" id="third_app_id_div" hidden="true">
								<label class="control-label" for="selectError">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AppID</label>
								<div class="controls">
									<select id="third_app_id" name="third_app_id" style="width: 120px"></select>
								</div>
							</div>
							  
							  <s:include value="../common/selectbox.jsp"></s:include>
					     </fieldset>
		 			 </form>
			    </div>
			    
		    <div id="chartdiv_column" style="width: 100%; height: 400px;float:left"></div>
			    
			<div id="maingrid" style="margin: 0; padding: 0;float:left;width:100%;margin-top:30px">
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
$("#ugcTypeList").multiselect({
	 checkAllText : "全选",
	 uncheckAllText :"取消",
	 noneSelectedText : "",
	 minWidth : 80,
	 selectedList: 10 // 0-based index 
});
var options={};
options.sAjaxSource="${ctx}/ugc/allUgcQueryUGC.action";
options.aoColumns=[
	               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "generated_time"},
	               { "sTitle": "星期", "sClass": "center" ,"mDataProp": "week","bSortable":false},
	               { "sTitle": "发布人数", "sClass": "center","mDataProp": "uv" },
	               { "sTitle": "人数同比", "sClass": "center","mDataProp": "uvTB","bSortable":false, "fnRender": function (obj) {
                	   return (obj.aData.uvTB*100).toFixed(2)+"%";
                	   },
                   },
	               { "sTitle": "人数环比", "sClass": "center","mDataProp": "uvHB","bSortable":false, "fnRender": function (obj) {
                	   return (obj.aData.uvHB*100).toFixed(2)+"%";
                	   },
                   },
	               { "sTitle": "发布次数", "sClass": "center","mDataProp": "pv" },
	               { "sTitle": "次数同比", "sClass": "center","mDataProp": "pvTB","bSortable":false, "fnRender": function (obj) {
                	   return (obj.aData.pvTB*100).toFixed(2)+"%";
                	   },
                   },
                   { "sTitle": "次数环比", "sClass": "center","mDataProp": "pvHB","bSortable":false, "fnRender": function (obj) {
                	   return (obj.aData.pvHB*100).toFixed(2)+"%";
                	   },
                   },
	               { "sTitle": "次数/人数", "sClass": "center","mDataProp": "pvuv","bSortable":false }
	             ];
	             
options.fnInitComplete=function(){
	if($("#ugcTypeList").val()=='all') {
	  var options4={}
		options4.chartData=oTable.fnGetData();
	    options4.chartId="chartdiv_column";
	    options4.categoryField="generated_time";
 	    options4.valField=["uv,发布人数","pv,发布次数"];
	    options4.unit="uv";
	    options4.draw=createLineChart;
		SP.loadChart(options4);
		$("#chartdiv_column").show();
	} else {
		$("#chartdiv_column").hide();
	} 
}
	             
var oTable=SP.loadTableInfo($("#contentlist"),options,$("#tef"));

//显示指标定义
$("#kpiLink").hover(
		function(){
			var kpiContent="";
			kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
			if('${ugcModelName}'=='UGC汇总'){
				kpiContent+="可以查看各登录类型中，各类型UGC的发布人数和发布次数，包括客户端的分版本数据.\n";
			}else{
				kpiContent+="可以查看当天注册的新用户中，各类型UGC的发布人数和发布次数，包括客户端的分版本数据.\n";
			}
			kpiContent+="</pre>"
			$("#kpiSpan").ligerTip({
		        content:kpiContent,
		        width:550}
			);
		},
		function(){
			$("#kpiSpan").ligerHideTip();
		}
);

var defaut=new Array();
defaut[0]=0;
defaut[1]="不区分";
SP.loadSelectDate("${ctx}/getPlatform.action",$("#os_id"));
SP.loadSelectDate("${ctx}/getDeviceId.action",$("#device_id"));
$("#os_id").attr("disabled",false);
$("#device_id").attr("disabled",false);
$("#app_id").attr("disabled",false);
$("#client_version").attr("disabled",false);
changeBiz_type();
function search(){
	if(!SP.checker($("#tef"))){
		return false;
	}
	if($("#ugcTypeList").val()!=null) {
		options.aoColumns=[
			               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "generated_time"},
			               { "sTitle": "星期", "sClass": "center" ,"mDataProp": "week","bSortable":false,},
			               { "sTitle": "UGC", "sClass": "center","mDataProp": "ugcName","bSortable":false, },
			               { "sTitle": "发布人数", "sClass": "center","mDataProp": "uv" },
			               { "sTitle": "人数同比", "sClass": "center","mDataProp": "uvTB", "bSortable":false,"fnRender": function (obj) {
		                	   return (obj.aData.uvTB*100).toFixed(2)+"%";
		                	   },
		                   },
			               { "sTitle": "人数环比", "sClass": "center","mDataProp": "uvHB","bSortable":false, "fnRender": function (obj) {
		                	   return (obj.aData.uvHB*100).toFixed(2)+"%";
		                	   },
		                   },
			               { "sTitle": "发布次数", "sClass": "center","mDataProp": "pv" },
			               { "sTitle": "次数同比", "sClass": "center","mDataProp": "pvTB","bSortable":false, "fnRender": function (obj) {
		                	   return (obj.aData.pvTB*100).toFixed(2)+"%";
		                	   },
		                   },
		                   { "sTitle": "次数环比", "sClass": "center","mDataProp": "pvHB", "bSortable":false,"fnRender": function (obj) {
		                	   return (obj.aData.pvHB*100).toFixed(2)+"%";
		                	   },
		                   },
			               { "sTitle": "次数/人数", "sClass": "center","bSortable":false,"mDataProp": "pvuv" }			             ];
		} else {
			options.aoColumns=[
				               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "generated_time"},
				               { "sTitle": "星期", "sClass": "center" ,"mDataProp": "week","bSortable":false},
				               { "sTitle": "发布人数", "sClass": "center","mDataProp": "uv" },
				               { "sTitle": "人数同比", "sClass": "center","mDataProp": "uvTB","bSortable":false, "fnRender": function (obj) {
			                	   return (obj.aData.uvTB*100).toFixed(2)+"%";
			                	   },
			                   },
				               { "sTitle": "人数环比", "sClass": "center","mDataProp": "uvHB","bSortable":false, "fnRender": function (obj) {
			                	   return (obj.aData.uvHB*100).toFixed(2)+"%";
			                	   },
			                   },
				               { "sTitle": "发布次数", "sClass": "center","mDataProp": "pv" },
				               { "sTitle": "次数同比", "sClass": "center","mDataProp": "pvTB","bSortable":false, "fnRender": function (obj) {
			                	   return (obj.aData.pvTB*100).toFixed(2)+"%";
			                	   },
			                   },
			                   { "sTitle": "次数环比", "sClass": "center","mDataProp": "pvHB","bSortable":false, "fnRender": function (obj) {
			                	   return (obj.aData.pvHB*100).toFixed(2)+"%";
			                	   },
			                   },
				               { "sTitle": "次数/人数", "sClass": "center","mDataProp": "pvuv","bSortable":false }			             ];
		}
	oTable.fnDestroy();
	$("#contentlist").empty();
    SP.loadTableInfo($("#contentlist"),options,$("#tef"));
    options.fnInitComplete();
}


//切换分析类型

function changeBiz_type(){
	//UGC.BizType.all, UGC.BizType.mcs, UGC.BizType.wap, UGC.BizType.touch, UGC.BizType.third };
	if($("#biz_type").val()=='all'||$("#biz_type").val()=='register_all'){
		$("#device_id_div").hide();
		$("#os_id_div").hide();
		$("#app_id_div").hide();
		$("#client_version_div").hide();
		$("#third_app_id_div").hide();
	}
	if($("#biz_type").val()=='mcs'||$("#biz_type").val()=='register_mcs'){
		$("#device_id_div").show();
		$("#os_id_div").show();
		$("#app_id_div").show();
		$("#client_version_div").show();
		$("#third_app_id_div").hide();
	}
	if($("#biz_type").val()=='wap'||$("#biz_type").val()=='register_wap'){ 
		$("#device_id_div").hide();
		$("#os_id_div").hide();
		$("#app_id_div").hide();
		$("#client_version_div").hide();
		$("#third_app_id_div").hide();
	}
	if($("#biz_type").val()=='touch'||$("#biz_type").val()=='register_touch'){ 
		$("#device_id_div").hide();
		$("#os_id_div").hide();
		$("#app_id_div").hide();
		$("#client_version_div").hide();
		$("#third_app_id_div").hide();
	}	
	if($("#biz_type").val()=='third'||$("#biz_type").val()=='register_third'){
		$("#device_id_div").hide();
		$("#os_id_div").hide();
		$("#app_id_div").hide();
		$("#client_version_div").hide();
		$("#third_app_id_div").show();
		
		var defaut=new Array();
		defaut[0]=-1;
		defaut[1]="所有";
		SP.loadSelectDate("${ctx}/getThirdAppidInfo.action",$("#third_app_id"),defaut);
	}	
}
</script>
