<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-活跃用户</title>
<%@ include file="/include/script.jsp"%>
<script src="${ctx}/js/ligerUI/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="${ctx}/js/json2.js" type="text/javascript"></script>
</head>

<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
	<input type="hidden" id="roleType" value="${roleType}"/>
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">用户分析_日活跃用户</span>
				<a id="kpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a><span id="kpiSpan"></span>
				<span class="anas-type"><a href="${ctx}/help/dau.jsp" style="padding:2px 5px 2px;font-size:13px;"  >说明</a></span>
				<div style="float:right;width:90px">
						<button type="button" style="padding:2px 5px 2px;font-size:13px;" onclick="search()" class="btn btn-primary">查询</button>
						<button type="button" style="padding: 2px 5px 2px; font-size: 13px;float:right" onclick="exportData()" class="btn btn-primary">导出</button>
				</div>
			</div>
			
			<div class="subtitle" style="float:left">
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
							  <div class="control-group">
								  <label class="control-label" for="selectError">登陆类型</label>
								  <div class="controls">
<%-- 										<s:select  onchange="changeType(this.value)" list="registerTypes" cssStyle="width:120px" id="caseids" name="templateVo.client_type"  listKey="key" listValue="value"></s:select> --%>
								  			<select  onchange="changeType(this.value)" style="width:120px" id="caseids" name="templateVo.client_type" >
											<option value="all">全部</option>
											<option value="mcs">客户端</option>
											<option value="wap">WAP&TOUCH</option>
											<option value="third">第三方</option>
											</select>
								  </div>
							  </div>
							  <div class="control-group"	id="user_attr">
								<label class="control-label" for="selectError">用户属性</label>
								<div class="controls">
									<select name="templateVo.attribute_id"   style="width: 120px" id="user_attr1" onchange="attrChange()">
										<option value="0">不区分</option>
										<c:if test="${!empty userAttrList}">
											<c:forEach items="${userAttrList}" var="entity">
												<option value="${entity.id}">${entity.name}</option>
											</c:forEach>
										</c:if>
									</select>
								</div>
							  </div>
							 <s:include value="../common/selectbox.jsp"></s:include>
							 <div class="control-group" style="width:170px" id="auto">
								  <label class="control-label" for="selectError">是否驻留</label>
								  <div class="controls">
										<select id="is_auto" name="templateVo.auto" style="width:80px">
											<option value="0" select="selected">请选择</option>
											<option value="1">驻留</option>
											<option value="2">非驻留</option>
										</select>
								  </div>
							  </div>
							  </br>
							 <jsp:include page="../common/channel.jsp" flush="true" />
							
					     </fieldset>
		 			 </form>
			    </div>
			
			<div id="chartdiv_column"  style="width: 100%; height: 280px;float:left">
				
			</div>
			<div id="dau_result" style="margin: 0; padding: 0">
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
<script><!--
var options={};
var oTable=null;
options.sAjaxSource="${ctx}/dau/loadTableData.action";
options.bServerSide=false;
options.fnInitComplete=function(){
	var options4={}
	options4.chartData=oTable.fnGetData();
	options4.chartId="chartdiv_column";
    options4.categoryField="date";
    options4.valField=["dau,DAU"];
    options4.draw=createLineChart;
    options4.unit="dau";
	$("#chartdiv_column").empty();
	SP.loadChart(options4);
}

search();
changeType($("#caseids").val());
//显示指标定义
$("#kpiLink").hover(
		function(){
			var kpiContent="";
			kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
			kpiContent+="按天查看登录的用户数（按UID去重），提供平台、APPID、版本与渠道的交叉查询.不支持用户属性和渠道的交叉筛选. \n\n";
			kpiContent+="<span style=\"color: #369bd7;\"> 驻留登录：</span> 统计日期内，用户处于登录状态并且应用在后台运行时，为驻留登录. \n\n";
			kpiContent+="<span style=\"color: #369bd7;\"> 非驻留登录：</span> 统计日期内，用户有启动应用并且登录的行为，为非驻留登录. \n";
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

function attrChange(){
	if($("#user_attr1").val() != 0 && !($("#user_attr1").val() == null) && $("#user_attr1").val().length != 0) {
		$("#fromChannelInput").attr("disabled",true);
		$("#channelsel").attr("disabled",true);
		$("#user_attr1").attr("disabled",false);
		$("#fromChannelInput").val("");
	} else {
		$("#user_attr1").attr("disabled",false);
		$("#fromChannelInput").attr("disabled",false);
		$("#channelsel").attr("disabled",false);
	}
}

function channelChange(){
	if($("#fromChannelInput").val() != -1 && !($("#fromChannelInput").val() == null) && $("#fromChannelInput").val().length != 0 && !($("#fromChannelInput")[0].disabled)){
		$("#fromChannelInput").attr("disabled",false);
		$("#channelsel").attr("disabled",false);
		$("#user_attr1").attr("disabled",true);
		$("#user_attr1").val("");
	} else {
		$("#user_attr1").attr("disabled",false);
		$("#fromChannelInput").attr("disabled",false);
		$("#channelsel").attr("disabled",false);
	}
}

function changeType(val){
    if(val=="all"){
    	$(".selcal").hide();
		$(".channel").hide();
		$("#visitform").hide();
		$("#user_attr").show();	
		$("#third_app_id_div").hide();
		$("#auto").hide();
		$(".selcal select").attr("disabled",true);
		$(".channel input").attr("disabled",true);
		$("#visitform input").attr("disabled",true);
		$("#third_app_id_div select").attr("disabled",true);
		$("#auto select").attr("disabled",true);
    }else if(val=="mcs"){
		$("#auto").show();
    	$(".selcal").show();
		$(".channel").show();
		$("#user_attr").show();
		$("#visitform").hide();
		$("#third_app_id_div").hide();
		$(".selcal select").attr("disabled",false);
		$(".channel input").attr("disabled",false);
		$("#visitform input").attr("disabled",true);
		$("#third_app_id_div select").attr("disabled",true);
		$("#auto select").attr("disabled",false);
    }else if(val=="third"){
    	$(".selcal").hide();
		$(".channel").hide();
		$("#visitform").hide();
		$("#auto").hide();
		$("#user_attr").hide();	
		$("#third_app_id_div").hide();
		$(".selcal select").attr("disabled",true);
		$(".channel input").attr("disabled",true);
		$("#visitform input").attr("disabled",true);
		$("#third_app_id_div select").attr("disabled",false);
		$("#auto select").attr("disabled",true);
    }else{
    	$(".selcal").hide();
		$(".channel").hide();
		$("#user_attr").hide();	
		$(".selcal select").attr("disabled",true);
		$(".channel input").attr("disabled",true);
		$("#visitform").hide();
		$("#visitform input").attr("disabled",false); 
		$("#third_app_id_div").hide();
		$("#third_app_id_div select").attr("disabled",true);
		$("#auto").hide();
		$("#auto select").attr("disabled",true);
    }
}


function noJoin(){
	var boo=false;
	var ar=false;
	if(!($("#onChannelInput")[0].disabled) && ($("#onChannelInput").val()!="")){
		ar=true;;
	}else if(!($("#fourChannelInput")[0].disabled) && ($("#fourChannelInput").val()!="")){
		ar=true;
	}else if(!($("#fromChannelInput")[0].disabled) && ($("#fromChannelInput").val()!="") ){
		ar=true;
	}
	if($("#user_attr1").val()!=null && $("#user_attr1").val()!="0"){
		boo=true;
	}
	if(boo && ar){
		alert("暂不支持用户属性和渠道同时选择!");
		return false;
	} else {
		return true;
	}
}

function search(){
	var result=noJoin();
	if(result){
	options.aoColumns = new Array();
	if(oTable!=null){
		oTable.fnClearTable();
		$("#contentlist").empty();
		$("#dau_result").html('<table id="contentlist" class="table table-striped table-bordered bootstrap-datatable datatable"></table>');
	}
	options.aoColumns.push({ "sTitle": "日期", "sClass": "center" ,"mDataProp": "date"});
	options.aoColumns.push({ "sTitle": "星期", "sClass": "center","mDataProp": null,"fnRender": function (obj) {
		return "星期"+"天一二三四五六".charAt(new Date(""+obj.aData.date+"").getDay());
		},"bSortable":false});

	var boo=false;
	if($("#user_attr1").val() != 0 && !($("#user_attr1").val() == null) && $("#user_attr1").val().length != 0){
		boo=true;
		options.aoColumns.push({ "sTitle": "用户属性", "sClass": "center" ,"mDataProp": "attribute_name"});
	}
	if($("#fourChannelInput").val() != -1 && !($("#fourChannelInput").val() == null) && $("#fourChannelInput").val().length != 0 && !($("#fourChannelInput")[0].disabled)){
		boo=true;
		options.aoColumns.push({ "sTitle": "一级渠道", "sClass": "center" ,"mDataProp": "oneChannelString","sWidth" : "15%"});
		options.aoColumns.push({ "sTitle": "四级渠道", "sClass": "center" ,"mDataProp": "from_name","sWidth" : "25%"});
	}else if($("#onChannelInput").val() != -1 && !($("#onChannelInput").val() == null) && $("#onChannelInput").val().length != 0 && !($("#onChannelInput")[0].disabled)){
		boo=true;
		options.aoColumns.push({ "sTitle": "一级渠道", "sClass": "center" ,"mDataProp": "from_name"});
	}
	if($("#fromChannelInput").val() != -1 && !($("#fromChannelInput").val() == null) && $("#fromChannelInput").val().length != 0 && !($("#fromChannelInput")[0].disabled)){
		boo=true;
		options.aoColumns.push({ "sTitle": "WAP渠道名称", "sClass": "center" ,"mDataProp": "from_name"});
	}
	options.aoColumns.push({ "sTitle": "DAU", "sClass": "center" ,"mDataProp": "dau"});

	if(boo && ($("#caseids").val()=='all' || $("#caseids").val()=="mcs")){	
		$("#chartdiv_column").hide();
	}else{
		$("#chartdiv_column").show();
	}
		
	//alert($("#tef").serialize());
	oTable=SP.loadTableInfo($("#contentlist"),options,$("#tef"));
	}
	
}

function exportData(){
	$("#tef").attr("action","${ctx}/dau/exportReport.action");
	$("#tef").submit();
}

--></script>
