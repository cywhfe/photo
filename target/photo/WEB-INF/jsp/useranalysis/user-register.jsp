<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-注册用户</title>
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
					<span class="anas-type">用户分析_注册用户</span>
					<span class="anas-type"><a href="${ctx}/help/register.jsp" style="padding:2px 5px 2px;font-size:13px;"  >说明</a></span>
						<div style="float:right;width:90px;">
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
								<label class="control-label" for="selectError">注册类型</label>
								<div class="controls">
								 <s:select  onchange="changeType(this.value)" list="registerTypes" cssStyle="width:120px" id="caseids" name="templateVo.client_type"  listKey="key" listValue="value"></s:select>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" for="selectError">用户属性</label>
								<div class="controls">
									<select name="templateVo.attribute_id"   style="width: 120px" id="user_attr">
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
							 <jsp:include page="../common/channel.jsp" flush="true" />
					     </fieldset>
		 			 </form>
			    </div>
			    
			 <div id="chartdiv_column" style="width: 100%; height: 400px;float:left"></div>
			 
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
$("#user_attr option:last").remove();
$(".selcal").hide();
$(".channel").hide();
//$(".selcal select").attr("disabled",true);
//$(".channel input").attr("disabled",true);
//$("#visitform input").attr("disabled",true);
var options={};
options.sAjaxSource="${ctx}/useranalysis/loadTableData.action";
options.bServerSide=false;
options.aoColumns=[
	               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "date"},
                   { "sTitle": "星期", "sClass": "center","mDataProp": null, "fnRender": function (obj) {
                	   return "星期"+"天一二三四五六".charAt(new Date(""+obj.aData.date+"").getDay());
                	   },"bSortable":false
                   },
                   { "sTitle": "注册人数", "sClass": "center","mDataProp": "count" }
	             ];
function fnInitComplete(){
	  var options4={}
		options4.chartData=oTable.fnGetData();
	   options4.chartId="chartdiv_column";
	    options4.categoryField="date";
	    options4.valField=["count,注册用户数"];
	    options4.draw=createLineChart;
	    options4.unit="count";
	    $("#chartdiv_column").empty();
		SP.loadChart(options4);
}
options.fnInitComplete=fnInitComplete;
oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));

function changeType(val){
	        if(val=="0"){
	        	$(".selcal").hide();
				$(".channel").hide();
				$("#visitform").hide();
				$(".selcal select").attr("disabled",true);
				$(".channel input").attr("disabled",true);
				$("#visitform input").attr("disabled",true);
	        }else if(val=="1"){
	        	$(".selcal").show();
				$(".channel").show();
	        	$("#visitform").hide();
	        	$(".selcal select").attr("disabled",false);
				$(".channel input").attr("disabled",false);
				$("#visitform input").attr("disabled",false);
	        }else{
	        	$(".selcal").hide();
				$(".channel").hide();
				$("#visitform").show();
				$(".selcal select").attr("disabled",true);
				$(".channel input").attr("disabled",true);
				$("#visitform input").attr("disabled",false);
	        }
}
function exportData(){
	$("#tef").attr("action","${ctx}/useranalysis/exportReport.action");
	$("#tef").submit();
}
function search(){
	if(!checkParamters()){
		return false;
	}
	options.aoColumns=[
		               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "date"},
	                   { "sTitle": "星期", "sClass": "center","mDataProp": null, "fnRender": function (obj) {
	                	   return "星期"+"天一二三四五六".charAt(new Date(""+obj.aData.date+"").getDay());
	                	   },"bSortable":false
	                   }
		             ];
	var boo=false;
	if(!($("#fourChannelInput")[0].disabled) && ($("#fourChannelInput").val()!="")){
		boo=true;
		options.aoColumns.push({ "sTitle": "一级渠道", "sClass": "center" ,"mDataProp": "oneChannelString"});
		options.aoColumns.push({ "sTitle": "四级渠道", "sClass": "center" ,"mDataProp": "attr"});
		
	}else if(!($("#onChannelInput")[0].disabled) && ($("#onChannelInput").val()!="")){
		boo=true;
		options.aoColumns.push({ "sTitle": "一级渠道", "sClass": "center" ,"mDataProp": "attr"});
	}else if(!($("#fromChannelInput")[0].disabled) && ($("#fromChannelInput").val()!="") ){
		boo=true;
		options.aoColumns.push({ "sTitle": "渠道名称", "sClass": "center" ,"mDataProp": "attr"});
	}else if($("#user_attr").val()!="0"){
		boo=true;
		options.aoColumns.push({ "sTitle": "用户属性", "sClass": "center" ,"mDataProp": "attr"});
	}
	options.aoColumns.push({ "sTitle": "注册人数", "sClass": "center","mDataProp": "count" });
	if(boo){
		$("#chartdiv_column").hide();
	}else{
		$("#chartdiv_column").show();
	}
	
			oTable.fnDestroy();
			$("#contentlist").empty();
			oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));
}
</script>
