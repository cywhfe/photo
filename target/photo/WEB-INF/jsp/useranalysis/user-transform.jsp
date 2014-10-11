<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<%@ include file="/include/script.jsp"%>
<%-- <script type="text/javascript" src="${ctx}/js/wz_jsgraphics.js"></script> --%>
</head>
<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			     <div class="tablistbox">
					<span class="anas-type">用户分析_转化率</span>
					<span class="anas-type"><a href="${ctx}/help/transform.jsp" style="padding:2px 5px 2px;font-size:13px;"  >说明</a></span>
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
							 <s:include value="../common/selectbox.jsp"></s:include>
							 <jsp:include page="../common/channel.jsp" flush="true" />
					     </fieldset>
		 			 </form>
			    </div>
			    
			 <!-- <div id="chartdiv_ld" style="position:relative;left:50px;height:300px;width:800px;border:0px solid pink;margin-top:160px"></div> -->
			 <div id="chartdiv_column" style="width: 100%; height: 300px;float:left"></div>
			 
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
$("#user_attr1 option:last").hide();
$(".selcal").show();
$(".channel").show();
$(".selcal select").attr("disabled",false);
$(".channel input").attr("disabled",false);
//$("#visitform input").attr("disabled",true);
var options={};
options.sAjaxSource="${ctx}/useranalysis/loadTransformTableData.action";
options.bServerSide=false;
options.aoColumns=[
	               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "date","sWidth":"80px"},
                   { "sTitle": "星期", "sClass": "center","mDataProp": null, "fnRender": function (obj) {
                	   return "星期"+"天一二三四五六".charAt(new Date(""+obj.aData.date+"").getDay());
                	   },"bSortable":false
                   }
	             ];
var mynum=[{ "sTitle": "激活人数", "sClass": "center","mDataProp": "active_number","fnRender": function (obj) {return addCommas(obj.aData.active_number)} },
           { "sTitle": "注册人数", "sClass": "center","mDataProp": "register_number","fnRender": function (obj) {return addCommas(obj.aData.register_number)} },
           { "sTitle": "次日登录数", "sClass": "center","mDataProp": "login_number","fnRender": function (obj) {return addCommas(obj.aData.login_number)} },
           { "sTitle": "注册转化率", "sClass": "center","mDataProp": "register_transform"},
           { "sTitle": "次日登录率", "sClass": "center","mDataProp": "login_transform" }];	        
for(var i=0;i<mynum.length;i++){
	options.aoColumns.push(mynum[i]);
}
function fnInitComplete(){
	    var options4={};
		options4.chartData=oTable.fnGetData();
	    options4.chartId="chartdiv_column";
	    options4.categoryField="date";
	    options4.valField=["active_number,激活人数","login_number,登录人数","register_number,注册人数"];
	    options4.draw=createLineChart;
	    options4.unit="register_number";
	    $("#chartdiv_column").empty();
		SP.loadChart(options4);
		/* var ld=options4.chartData[0];
		$("#chartdiv_ld").empty();
		$("#chartdiv_ld").html("");
		if(ld){
			var dataArray=new Array(ld.active_number.replace(",",""),ld.register_number.replace(",",""),ld.login_number.replace(",",""));
			var labelArray = new Array("激活人数","注册人数","登录人数");
			var title=ld.date+"---转换率漏斗图"
			var loudou = new FunnelCanvas("chartdiv_ld",title,labelArray,dataArray);
			loudou.paint();
		} */
}
options.fnInitComplete=fnInitComplete;
oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));

function exportData(){
	window.location.href="${ctx}/useranalysis/exportTransformReport.action?"+$("#tef").serialize();
}
function search(){
	options.aoColumns=[
		               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "date","sWidth":"80px"},
	                   { "sTitle": "星期", "sClass": "center","mDataProp": null, "fnRender": function (obj) {
	                	   return "星期"+"天一二三四五六".charAt(new Date(""+obj.aData.date+"").getDay());
	                	   },"bSortable":false
	                   }
		             ];
	var boo=false;
	if(!($("#fourChannelInput")[0].disable) && ($("#fourChannelInput").val()!="")){
		if($("#fourChannelInput").val().split(",").length>1 ){
			boo=true;
		}
		options.aoColumns.push({ "sTitle": "一级渠道", "sClass": "center" ,"mDataProp": "oneChannelString","sWidth":"80px"});
		options.aoColumns.push({ "sTitle": "四级渠道", "sClass": "center" ,"mDataProp": "attr","sWidth":"120px"});
	}else  if(!($("#onChannelInput")[0].disabled) && ($("#onChannelInput").val()!="")){
		if($("#onChannelInput").val().split(",").length>1 ){
			boo=true;
		}
		options.aoColumns.push({ "sTitle": "一级渠道", "sClass": "center" ,"mDataProp": "attr"});
	}
	
	for(var i=0;i<mynum.length;i++){
		options.aoColumns.push(mynum[i]);
	}
	if(boo){
		$("#chartdiv_column").hide();
	}else{
		$("#chartdiv_column").show();
	}
	if(getTimeBetween($("#d4311").val(),$("#d4312").val())==0){
		$("#chartdiv_column").hide();
	}
			oTable.fnDestroy();
			$("#contentlist").empty();
			oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));
}
</script>
