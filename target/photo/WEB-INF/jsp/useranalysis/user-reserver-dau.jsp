<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-活跃保留率</title>
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
					<span class="anas-type">用户分析_活跃保留率</span>
					<a id="kpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a><span id="kpiSpan"></span>
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
							  <div class="control-group" id="client_type_div">
								<label class="control-label" id="bizcategory" for="selectError">登录类型</label>
								<div class="controls">
								 <select style="width:120px" id="bizcategorysel" name="templateVo.client_type" onchange="changeType(this.value)" >
								 	<option value="0">全部</option>
								 	<option value="1">客户端</option>
								 	<option value="2">wap&touch</option>
								 	<option value="3">touch</option>
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
var sDay = getFormatDate(new Date().getTime()-(33*24*3600*1000));
var eDay = getFormatDate(new Date().getTime()-(2*24*3600*1000) );
$("#d4311").val(sDay);
$("#d4312").val(eDay);
$(".selcal").hide();
$(".channel").hide();
$("#third_app_id_div").hide();
$("#third_app_id_div select").attr("disabled",true);
var options={};
options.sAjaxSource="${ctx}/useranalysis/loadReserverDau.action";
//options.bServerSide=false;
options.aoColumns=[
	               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "now_date","bSortable":false ,"sWidth":"80px"},
                   { "sTitle": "星期", "sClass": "center","mDataProp": null, "fnRender": function (obj) {
                	   return "星期"+"天一二三四五六".charAt(new Date(""+obj.aData.now_date+"").getDay());
                	   },"bSortable":false,"sWidth":"60px"
                   },
                   { "sTitle": "活跃人数", "sClass": "center","mDataProp": "number","sWidth":"80px","bSortable":false }
	             ];
var daycom=[{ "sTitle": "第1天", "sClass": "center","mDataProp": "day1","sWidth":"60px","bSortable":false },
            { "sTitle": "第2天", "sClass": "center","mDataProp": "day2","sWidth":"60px","bSortable":false },
            { "sTitle": "第3天", "sClass": "center","mDataProp": "day3","sWidth":"60px","bSortable":false },
            { "sTitle": "第4天", "sClass": "center","mDataProp": "day4","sWidth":"60px","bSortable":false },
            { "sTitle": "第5天", "sClass": "center","mDataProp": "day5","sWidth":"60px","bSortable":false },
            { "sTitle": "第6天", "sClass": "center","mDataProp": "day6","sWidth":"60px","bSortable":false },
            { "sTitle": "第7天", "sClass": "center","mDataProp": "day7","sWidth":"60px","bSortable":false },
            { "sTitle": "第15天", "sClass": "center","mDataProp": "day15","sWidth":"60px","bSortable":false },
            { "sTitle": "第20天", "sClass": "center","mDataProp": "day20","sWidth":"60px","bSortable":false },
            { "sTitle": "第25天", "sClass": "center","mDataProp": "day25","sWidth":"60px","bSortable":false },
            { "sTitle": "第30天", "sClass": "center","mDataProp": "day30","sWidth":"60px","bSortable":false }]
            
for(var i=0;i<daycom.length;i++){
	options.aoColumns.push(daycom[i]);
}

oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));

//显示指标定义
$("#kpiLink").hover(
		function(){
			var kpiContent="";
			kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
			kpiContent+="某天从移动端登录的用户中，在之后的一段时间内，仍继续从移动端登录的用户，被视为登录的保留用户.这部分用户占当天登录用户数的比例即活跃保留率.\n\n";
			kpiContent+="例如，10.1登录用户数为800W，在这800W个用户中，10.2登录的用户为700W个，则10.1第1天的活跃保留率为87.5%.\n\n";
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

//渠道的清除函数，当用户切换注册类型和数据指标时使用
function clearFromChannelInput(){
	$("#fromChannelInput").val("");
}

function changeType(val){
	        if(val=="0"){
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
	        if(val=="2" || val=="3"){
	        	$(".selcal").hide();
				$(".channel").hide();
				$("#visitform").show();
				$(".selcal select").attr("disabled",true);
				$(".channel input").attr("disabled",true);
				$("#visitform input").attr("disabled",false);
	        }
	        clearFromChannelInput();
}
function search(){
	if(!$("#d4311").val() || $("#d4311").val() == ""
		|| !$("#d4312").val() || $("#d4312").val() == ""){
		alert("必须输入起止时间查询！");
		return;
	}
	if( ($("#onChannelInput").val()!="" ||  $("#fourChannelInput").val()!="" ) && ($("#device_id").val()!="-1" || $("#os_id").val()!="-1") ){
		alert("渠道不能按设备、平台查询！");
		return;
	}
	
	options.aoColumns=[
		               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "now_date","bSortable":false , "sWidth":"80px"},
	                   { "sTitle": "星期", "sClass": "center","mDataProp": null, "fnRender": function (obj) {
	                	   return "星期"+"天一二三四五六".charAt(new Date(""+obj.aData.now_date+"").getDay());
	                	   },"bSortable":false,"sWidth":"60px"
	                   }
		             ];
	if(!($("#fourChannelInput")[0].disabled) && ($("#fourChannelInput").val()!="")){
		boo=true;
		options.aoColumns.push({ "sTitle": "一级渠道", "sClass": "center" ,"mDataProp": "oneChannelString","sWidth":"80px","bSortable":false});
		options.aoColumns.push({ "sTitle": "四级渠道", "sClass": "center" ,"mDataProp": "attr","sWidth":"80px","bSortable":false});
	}else if(!($("#onChannelInput")[0].disabled) && ($("#onChannelInput").val()!="")){
		boo=true;
		options.aoColumns.push({ "sTitle": "一级渠道", "sClass": "center" ,"mDataProp": "attr","sWidth":"80px","bSortable":false});
	}else if(!($("#fromChannelInput")[0].disabled) && ($("#fromChannelInput").val()!="") ){
		boo=true;
		options.aoColumns.push({ "sTitle": "渠道名称", "sClass": "center" ,"mDataProp": "attr","sWidth":"80px","bSortable":false});
	}
	
	options.aoColumns.push( { "sTitle": "活跃人数", "sClass": "center","mDataProp": "number","sWidth":"80px","bSortable":false });
	for(var i=0;i<daycom.length;i++){
		options.aoColumns.push(daycom[i]);
	}
	oTable.fnDestroy();
	$("#contentlist").empty();
	oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));
}

function exportData(){
	$("#tef").attr("action","${ctx}/useranalysis/exportReserverDau.action");
	$("#tef").submit();
}
</script>
