<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-注册流程分析</title>
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
					<span class="anas-type">客户端__注册流程分析</span>
					<a id="kpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a><span id="kpiSpan"></span>
					<span class="anas-type"><a href="${ctx}/help/register_process.jsp" style="padding:2px 5px 2px;font-size:13px;"  >说明</a></span>
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
var sDay = getFormatDate(new Date().getTime()-(30*24*3600*1000));
var eDay = getFormatDate(new Date().getTime()-(1*24*3600*1000) );
$("#d4311").val(sDay);
$("#d4312").val(eDay);
//$(".channel").hide();
//$("#third_app_id_div").hide();
//$("#device_id_div").hide();
//$("#third_app_id_div select").attr("disabled",true);
$(".selcal select").attr("disabled",false);
$(".channel input").attr("disabled",false);
$("#visitform input").attr("disabled",false);

var options={};
options.sAjaxSource="${ctx}/client/loadRegisterProcess.action";
options.bServerSide=false;
options.aoColumns=[
	               { "sTitle": "日期", "sClass": "center" ,"sWidth":"60px","mDataProp": "date"},
                   { "sTitle": "星期", "sClass": "center","mDataProp": null, "fnRender": function (obj) {
                	   return "星期"+"天一二三四五六".charAt(new Date(""+obj.aData.date+"").getDay());
                	   },"bSortable":false,"sWidth":"40px"
                   },
                   { "sTitle": "注册人数", "sClass": "center","mDataProp": "number" },
                   { "sTitle": "填写姓名", "sClass": "center","mDataProp": "name" },
                   { "sTitle": "上传头像", "sClass": "center","mDataProp": "head" },
                   { "sTitle": "同步通讯录", "sClass": "center","mDataProp": "address" },
                   { "sTitle": "取新鲜事", "sClass": "center","mDataProp": "feed" },
                   { "sTitle": "人均好友申请数", "sClass": "center","mDataProp": "apply" },
                   { "sTitle": "人均通讯录好友申请数", "sClass": "center","mDataProp": "comu" },
                   { "sTitle": "人均好友数", "sClass": "center","mDataProp": "friend_count" },
                   { "sTitle": "平均通讯录条目", "sClass": "center","mDataProp": "addr_count" },
                   
	             ];

oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));

//显示指标定义
$("#kpiLink").hover(
		function(){
			var kpiContent="";
			kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
			kpiContent+="可查询客户端注册用户在注册流程中产生的各项数据，其中，\n";
			kpiContent+="• 填写姓名=用户名不为“新用户XXX”的人数/注册人数*100% \n";
			kpiContent+="• 上传头像=上传头像的人数/注册人数*100% \n";
			kpiContent+="• 同步通讯录=同步通讯录的人数/注册人数*100% \n";
			kpiContent+="• 取新鲜事=取新鲜事/注册人数*100% \n";
			kpiContent+="• 人均好友申请数=总好友申请数/注册人数\n";
			kpiContent+="• 人均通讯录好友申请数=总通讯录好友申请数/注册人数 \n";
			kpiContent+="• 人均好友数=总好友数/注册人数 \n";
			kpiContent+="• 平均通讯录条目=同步通讯录总数/同步通讯录人数";
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


function exportData(){
	window.location.href="${ctx}/client/exportRegisterProcess.action?"+$("#tef").serialize();
}
function search(){
	//if(getTimeBetween($("#d4311").val(),$("#d4312").val())>90){
	//	alert("开始时间和结束时间间隔在1-90范围内!")
		//return;
	//}
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
		               { "sTitle": "日期", "sClass": "center" ,"mDataProp": "date"},
	                   { "sTitle": "星期", "sClass": "center","mDataProp": null, "fnRender": function (obj) {
	                	   return "星期"+"天一二三四五六".charAt(new Date(""+obj.aData.date+"").getDay());
	                	   },"bSortable":false,"sWidth":"60px"
	                   }
		             ];
	if(!($("#onChannelInput")[0].disabled) && ($("#onChannelInput").val()!="")){
		boo=true;
		options.aoColumns.push({ "sTitle": "渠道名称", "sClass": "center" ,"mDataProp": "attr","sWidth":"80px" });
	}else if(!($("#fourChannelInput")[0].disabled) && ($("#fourChannelInput").val()!="")){
		boo=true;
		options.aoColumns.push({ "sTitle": "渠道名称", "sClass": "center" ,"mDataProp": "attr","sWidth":"80px" });
	}else if(!($("#fromChannelInput")[0].disabled) && ($("#fromChannelInput").val()!="") ){
		boo=true;
		options.aoColumns.push({ "sTitle": "渠道名称", "sClass": "center" ,"mDataProp": "attr","sWidth":"80px" });
	}
	
	options.aoColumns.push( { "sTitle": "注册人数", "sClass": "center","mDataProp": "number" });
	options.aoColumns.push( { "sTitle": "填写姓名", "sClass": "center","mDataProp": "name" });
	options.aoColumns.push( { "sTitle": "上传头像", "sClass": "center","mDataProp": "head" });
	options.aoColumns.push( { "sTitle": "同步通讯录", "sClass": "center","mDataProp": "address" });
	options.aoColumns.push( { "sTitle": "取新鲜事", "sClass": "center","mDataProp": "feed" });
	options.aoColumns.push( { "sTitle": "人均好友申请数", "sClass": "center","mDataProp": "apply" });
	options.aoColumns.push( { "sTitle": "人均通讯录好友申请数", "sClass": "center","mDataProp": "comu" });
	options.aoColumns.push( { "sTitle": "人均好友数", "sClass": "center","mDataProp": "friend_count"});
	options.aoColumns.push( { "sTitle": "平均通讯录条目", "sClass": "center","mDataProp": "addr_count"});
	oTable.fnDestroy();
	$("#contentlist").empty();
	oTable= SP.loadTableInfo($("#contentlist"),options,$("#tef"));
}




</script>
