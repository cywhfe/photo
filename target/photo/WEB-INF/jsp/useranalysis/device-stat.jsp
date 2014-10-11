<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME%></title>
<%@ include file="/include/script.jsp"%>
<script src="${ctx}/js/ligerUI/plugins/ligerGrid.js"
	type="text/javascript"></script>
<script src="${ctx}/js/json2.js" type="text/javascript"></script>

</head>
<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">用户分析_终端属性</span>
				<a id="kpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a><span id="kpiSpan"></span>
				<span class="anas-type"><a href="${ctx}/help/device.jsp" style="padding:2px 5px 2px;font-size:13px;"  >说明</a></span>
				<div style="float: right; width: 90px;">
					<button type="button"
						style="padding: 2px 5px 2px; font-size: 13px;" onclick="search()"
						class="btn btn-primary">查询</button>
					<button type="button"
						style="padding: 2px 5px 2px; font-size: 13px; float: right"
						onclick="exportData()" class="btn btn-primary">导出</button>
				</div>
			</div>
			<div class="subtitle" style="float: left">
		  		<form class="form-horizontal" action="" id="tef" name="tef">
					<fieldset style="height: auto">
						<div class="control-group">
							<label class="control-label" for="focusedInput">开始时间</label>
							<div class="controls">
								<input name="deviceTemplateVo.start_time" onfocus="timeFocusBegin()"
									type="text" class="input-medium focused Wdate" id="d4311" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="focusedInput">结束时间</label>
							<div class="controls">
								<input name="deviceTemplateVo.end_time" onfocus="timeFocusEnd()"
									type="text" class="input-medium focused Wdate" id="d4312" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="selectError">登录类型</label>
							<div class="controls">
								<select id="login_type" name="deviceTemplateVo.login_type" style="width: 120px" onchange="changeType(this.value)">
									<option value="0">客户端登录</option>
									<option value="1">wap&touch登录</option>
									<option value="2">touch登录</option>
								</select>
							</div>
						</div>
						<div class="control-group client" id="isp" style="width:400px">
							<label class="control-label" for="selectError">设备属性：</label>
							<div class="controls" style="width:400px;margin-top:4px">								     
								<!-- 客户端登录 -->
								<span  class="client1"  >
								<input type="radio" id="isp"   			name="deviceTemplateVo.radio_btn" value="2" style="width: 20px;margin-top:-3px" checked>运营商     
								<input type="radio" id="network"  		name="deviceTemplateVo.radio_btn" value="3" style="width: 20px;margin-top:-3px">联网状况     
								<input type="radio" id="phone_brand"    name="deviceTemplateVo.radio_btn" value="4" style="width: 20px;margin-top:-3px">手机品牌     
								<input type="radio" id="phone_model" 	name="deviceTemplateVo.radio_btn" value="5" style="width: 20px;margin-top:-3px">机型  
								</span>
								<!-- 共用 -->
								<input type="radio" id="os_version"   	name="deviceTemplateVo.radio_btn" value="1" style="width: 20px;margin-top:-3px">系统版本
								<!-- wap，touch登录 -->
								<span  class="wap_touch"  >
								<input type="radio" id="browser" 		name="deviceTemplateVo.radio_btn" value="6" style="width: 20px;margin-top:-3px">浏览器  </span>								
							</div>
						</div>

					</fieldset>
				</form>
			</div>

			<!-- -----菜单------ -->
			<div id="maingrid" style="margin: 0; padding: 0">
				<table id="contentlist"
					class="table table-striped table-bordered bootstrap-datatable datatable">
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
$(".wap_touch").hide();
function changeType(val){
    if(val=="0"){
		$(".client1").show();
		$(".wap_touch").hide();
		$("input[type=radio][name=deviceTemplateVo.radio_btn][value=2]").attr("checked",true);
    }else{
    	$(".wap_touch").show();
		$(".client1").hide();
		$("input[type=radio][name=deviceTemplateVo.radio_btn][value=1]").attr("checked",true);
    }
//    search();
}

var options = {};
options.sAjaxSource = "${ctx}/useranalysis/loadInitData.action";
options.bServerSide = false;
options.aoColumns = [ {
	"sTitle" : "日期",
	"sClass" : "center",
	"mDataProp" : "log_date"
}, {
	"sTitle" : "星期",
	"sClass" : "center",
	"mDataProp" : "week_day"
}, {
	"sTitle" : "运营商",
	"sClass" : "center",
	"mDataProp" : "t_mobile"
}, {
	"sTitle" : "DAU",
	"sClass" : "center",
	"mDataProp" : "total"
} ];

var oTable = SP.loadTableInfo($("#contentlist"), options, $("#tef"));

//显示指标定义
$("#kpiLink").hover(
		function(){
			var kpiContent="";
			kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
			kpiContent+="可以查看指定时间段内，登录用户的运营商、联网状况、设备型号、系统版本、浏览器分布情况.\n";
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

function search() {
	options.sAjaxSource = "${ctx}/useranalysis/deviceInfoSearch.action";	
	
	if($("input[type=radio][name=deviceTemplateVo.radio_btn]:checked").val()=="2"){
		options.aoColumns = [ {
			"sTitle" : "日期",
			"sClass" : "center",
			"mDataProp" : "log_date"
		}, {
			"sTitle" : "星期",
			"sClass" : "center",
			"mDataProp" : "week_day"
		}, {
			"sTitle" : "运营商",
			"sClass" : "center",
			"mDataProp" : "t_mobile"
		}, {
			"sTitle" : "DAU",
			"sClass" : "center",
			"mDataProp" : "total"
		} ];
	} else if($("input[type=radio][name=deviceTemplateVo.radio_btn]:checked").val()=="3"){
		options.aoColumns = [ {
			"sTitle" : "日期",
			"sClass" : "center",
			"mDataProp" : "log_date"
		}, {
			"sTitle" : "星期",
			"sClass" : "center",
			"mDataProp" : "week_day"
		}, {
			"sTitle" : "联网状况",
			"sClass" : "center",
			"mDataProp" : "network"
		}, {
			"sTitle" : "DAU",
			"sClass" : "center",
			"mDataProp" : "total"
		} ];
	} else if($("input[type=radio][name=deviceTemplateVo.radio_btn]:checked").val()=="4"){
		options.aoColumns = [ {
			"sTitle" : "日期",
			"sClass" : "center",
			"mDataProp" : "log_date"
		}, {
			"sTitle" : "星期",
			"sClass" : "center",
			"mDataProp" : "week_day"
		}, {
			"sTitle" : "手机品牌",
			"sClass" : "center",
			"mDataProp" : "brand"
		}, {
			"sTitle" : "DAU",
			"sClass" : "center",
			"mDataProp" : "total"
		} ];
	} else if($("input[type=radio][name=deviceTemplateVo.radio_btn]:checked").val()=="5"){
		options.aoColumns = [ {
			"sTitle" : "日期",
			"sClass" : "center",
			"mDataProp" : "log_date"
		}, {
			"sTitle" : "星期",
			"sClass" : "center",
			"mDataProp" : "week_day"
		}, {
			"sTitle" : "手机品牌",
			"sClass" : "center",
			"mDataProp" : "brand"
		},{
			"sTitle" : "机型",
			"sClass" : "center",
			"mDataProp" : "phone_model"
		},  {
			"sTitle" : "DAU",
			"sClass" : "center",
			"mDataProp" : "total"
		} ];
	}  else if($("input[type=radio][name=deviceTemplateVo.radio_btn]:checked").val()=="6"){
		options.aoColumns = [ {
			"sTitle" : "日期",
			"sClass" : "center",
			"mDataProp" : "log_date"
		}, {
			"sTitle" : "星期",
			"sClass" : "center",
			"mDataProp" : "week_day"
		}, {
			"sTitle" : "浏览器",
			"sClass" : "center",
			"mDataProp" : "browser"
		}, {
			"sTitle" : "DAU",
			"sClass" : "center",
			"mDataProp" : "total"
		} ];
	} else if($("input[type=radio][name=deviceTemplateVo.radio_btn]:checked").val()=="1"){
		options.aoColumns = [ {
			"sTitle" : "日期",
			"sClass" : "center",
			"mDataProp" : "log_date"
		}, {
			"sTitle" : "星期",
			"sClass" : "center",
			"mDataProp" : "week_day"
		}, {
			"sTitle" : "系统版本",
			"sClass" : "center",
			"mDataProp" : "os_version"
		}, {
			"sTitle" : "DAU",
			"sClass" : "center",
			"mDataProp" : "total"
		} ];
	}
	
	$("#chartdiv_column").hide();
	oTable.fnDestroy();
	$("#contentlist").empty();
	oTable = SP.loadTableInfo($("#contentlist"), options, $("#tef"));
}

function exportData() {
	window.location.href = "${ctx}/useranalysis/exportDeviceReport.action?"
			+ $("#tef").serialize();
}
</script>
