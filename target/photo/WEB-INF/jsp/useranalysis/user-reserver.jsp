<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-保留率</title>
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
					<span class="anas-type">用户分析_保留率</span>
					<span class="anas-type"><a href="${ctx}/help/reserver.jsp" style="padding:2px 5px 2px;font-size:13px;"  >说明</a></span>
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
							  <div class="control-group">
								<label class="control-label" for="selectError">数据指标</label>
								<div class="controls">
								 <select style="width:120px" name="templateVo.user_type" id="usertype" onchange="changeIt(this.value)">
								    <option value="2">活跃用户</option>
								 	<option value="1">注册用户</option>
								 </select>
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" id="bizcategory" for="selectError">注册类型</label>
								<div class="controls">
								 <select style="width:120px" id="bizcategorysel" name="templateVo.client_type" onchange="changeType(this.value)" >
								 	<option value="11">全部</option>
								 	<option value="1">客户端</option>
								 	<option value="12">wap&touch</option>
								 	<option value="4">touch</option>
								 	<option id="registeroption" value="13">其他</option>
								 </select>
								</div>
							  </div>
							  
							 <div class="control-group selcal">
								<label class="control-label" for="selectError">后台驻留</label>
								<div class="controls">
								 <select style="width:120px" id="isautos" name="templateVo.auto">
								    <option value="0">全部</option>
								 	<option value="1">是</option>
								 	<option value="2">否</option>
								 </select>
								</div>
							  </div>
							  
							  
							 <s:include value="../common/selectbox.jsp"></s:include>
							 <jsp:include page="../common/channel.jsp" flush="true" />
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

$(".selcal").hide();
$(".channel").hide();
//$(".selcal select").attr("disabled",true);
//$(".channel input").attr("disabled",true);
var options={};
options.sAjaxSource="${ctx}/useranalysis/loadReserverTableData.action";
//options.bServerSide=false;
options.aoColumns=[
	               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "date","bSortable":false},
                   { "sTitle": "星期", "sClass": "center","mDataProp": null, "fnRender": function (obj) {
                	   return "星期"+"天一二三四五六".charAt(new Date(""+obj.aData.date+"").getDay());
                	   },"bSortable":false,"sWidth":"60px"
                   },
                   { "sTitle": "活跃人数", "sClass": "center","mDataProp": "number","sWidth":"80px","bSortable":false }
	             ];
var daycom=[{ "sTitle": "第1天", "sClass": "center","mDataProp": "one","sWidth":"60px","bSortable":false },
            { "sTitle": "第2天", "sClass": "center","mDataProp": "two","sWidth":"60px","bSortable":false },
            { "sTitle": "第3天", "sClass": "center","mDataProp": "three","sWidth":"60px","bSortable":false },
            { "sTitle": "第4天", "sClass": "center","mDataProp": "four","sWidth":"60px","bSortable":false },
            { "sTitle": "第5天", "sClass": "center","mDataProp": "five","sWidth":"60px","bSortable":false },
            { "sTitle": "第6天", "sClass": "center","mDataProp": "six","sWidth":"60px","bSortable":false },
            { "sTitle": "第7天", "sClass": "center","mDataProp": "seween","sWidth":"60px","bSortable":false },
            { "sTitle": "第15天", "sClass": "center","mDataProp": "fifteen","sWidth":"60px","bSortable":false },
            { "sTitle": "第20天", "sClass": "center","mDataProp": "twenty","sWidth":"60px","bSortable":false },
            { "sTitle": "第25天", "sClass": "center","mDataProp": "tenty_five","sWidth":"60px","bSortable":false },
            { "sTitle": "第30天", "sClass": "center","mDataProp": "thirty","sWidth":"60px","bSortable":false }]
            
for(var i=0;i<daycom.length;i++){
	options.aoColumns.push(daycom[i]);
}

oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));

function changeIt(val){
	if(val=="1"){
		$("#bizcategory").text("注册用户")
		$("#registeroption").show();
	}else{
		$("#bizcategory").text("活跃用户")
		$("#registeroption").hide();
	}
	$("#bizcategorysel").val("0");
	$("#bizcategorysel").trigger("change");
}

//渠道的清除函数，当用户切换注册类型和数据指标时使用
function clearFromChannelInput(){
	$("#fromChannelInput").val("");
}

function changeType(val){
	        if(val=="11"){
	        	$(".selcal").hide();
				$(".channel").hide();
				$("#visitform").hide();
				$(".selcal select").attr("disabled",true);
				$(".channel input").attr("disabled",true);
				$("#visitform input").attr("disabled",true);
	        }
	        if(val=="1"){
	        	$(".selcal").show();
				$(".channel").show();
	        	$("#visitform").hide();
	        	$(".selcal select").attr("disabled",false);
				$(".channel input").attr("disabled",false);
				$("#visitform input").attr("disabled",false);
	        }
	        if(val=="12" || val=="4" || val=="13"){
	        	$(".selcal").hide();
				$(".channel").hide();
				$("#visitform").show();
				$(".selcal select").attr("disabled",true);
				$(".channel input").attr("disabled",true);
				$("#visitform input").attr("disabled",false);
	        }
	        if(val=="6"){//第三方
	        	$(".selcal").hide();
				$(".channel").hide();
				$("#visitform").hide();
				$(".selcal select").attr("disabled",true);
				$(".channel input").attr("disabled",true);
				$("#visitform input").attr("disabled",true);
				$("#third_app_id_div").show();
				$("#third_app_id_div select").attr("disabled",false);
				return;
	        }
	        clearFromChannelInput();
	        $("#third_app_id_div").hide();
			$("#third_app_id_div select").attr("disabled",true);
}
function exportData(){
	window.location.href="${ctx}/useranalysis/exportReserverReport.action?"+$("#tef").serialize();
}
function search(){
	if(!SP.checker($("#tef"))){
		return false;
	}
	options.aoColumns=[
		               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "date","bSortable":false},
	                   { "sTitle": "星期", "sClass": "center","mDataProp": null, "fnRender": function (obj) {
	                	   return "星期"+"天一二三四五六".charAt(new Date(""+obj.aData.date+"").getDay());
	                	   },"bSortable":false,"sWidth":"60px"
	                   }
		             ];
	if(!($("#onChannelInput")[0].disabled) && ($("#onChannelInput").val()!="")){
		boo=true;
		options.aoColumns.push({ "sTitle": "渠道名称", "sClass": "center" ,"mDataProp": "attr","sWidth":"80px","bSortable":false});
	}else if(!($("#fourChannelInput")[0].disabled) && ($("#fourChannelInput").val()!="")){
		boo=true;
		options.aoColumns.push({ "sTitle": "渠道名称", "sClass": "center" ,"mDataProp": "attr","sWidth":"80px","bSortable":false});
	}else if(!($("#fromChannelInput")[0].disabled) && ($("#fromChannelInput").val()!="") ){
		boo=true;
		options.aoColumns.push({ "sTitle": "渠道名称", "sClass": "center" ,"mDataProp": "attr","sWidth":"80px","bSortable":false});
	}
	
	if($("#usertype").val()=="1"){
		options.aoColumns.push( { "sTitle": "注册人数", "sClass": "center","mDataProp": "number","sWidth":"80px","bSortable":false });
	}else{
		options.aoColumns.push( { "sTitle": "活跃人数", "sClass": "center","mDataProp": "number","sWidth":"80px","bSortable":false });
	}
	for(var i=0;i<daycom.length;i++){
		options.aoColumns.push(daycom[i]);
	}

			oTable.fnDestroy();
			$("#contentlist").empty();
			oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));
}
</script>