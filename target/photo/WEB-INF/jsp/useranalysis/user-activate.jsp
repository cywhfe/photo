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
				<span class="anas-type">用户分析_客户端激活</span>
				<a id="kpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a><span id="kpiSpan"></span>
				<span class="anas-type"><a href="${ctx}/help/active.jsp" style="padding:2px 5px 2px;font-size:13px;"  >说明</a></span>
				<div style="float: right; width:90px;">
					<button type="button" style="padding: 2px 5px 2px; font-size: 13px;" onclick="search()"	class="btn btn-primary">查询</button>
					<button type="button" style="padding: 2px 5px 2px; font-size: 13px; float: right" onclick="exportData()" class="btn btn-primary">导出</button>
				</div>
			</div>

			<div class="subtitle" style="float: left">
				<form class="form-horizontal" action="" id="tef" name="tef" method="post">
					<fieldset style="height: auto">
						<div class="control-group">
							<label class="control-label" for="focusedInput">开始时间</label>
							<div class="controls">
								<input name="templateVo.start_time" onfocus="timeFocusBegin()"
									type="text" class="input-medium focused Wdate" id="d4311" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="focusedInput">结束时间</label>
							<div class="controls">
								<input name="templateVo.end_time" onfocus="timeFocusEnd()"
									type="text" class="input-medium focused Wdate" id="d4312" />
							</div>
						</div>
						<s:include value="../common/selectbox.jsp"></s:include>
						<jsp:include page="../common/channel.jsp" flush="true" />
					</fieldset>
				</form>
			</div>
			<div id="chartdiv_column"
				style="width: 100%; height: 250px; float: left"></div>

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
$(".selcal select").attr("disabled",false);
$(".channel input").attr("disabled",false);
	var options = {};
	options.sAjaxSource = "${ctx}/useranalysis/userActivateSearch.action";
	options.bServerSide = false;
	options.aoColumns = [ {
		"sTitle" : "日期",
		"sClass" : "center",
		"mDataProp" : "generatedTime"
	}, {
		"sTitle" : "星期",
		"sClass" : "center",
		"mDataProp" : "week_day"
	}, {
		"sTitle" : "新增激活数",
		"sClass" : "center",
		"mDataProp" : "newActivateCount"
	}, {
		"sTitle" : "当前激活数",
		"sClass" : "center",
		"mDataProp" : "currentCount"
	}, {
		"sTitle" : "当月累计激活数",
		"sClass" : "center",
		"mDataProp" : "accumulativeCount"
	} ];

	options.fnInitComplete = function() {
		var options4 = {}
		options4.chartData = oTable.fnGetData();

		options4.chartId = "chartdiv_column";
		options4.categoryField = "generatedTime";
		options4.valField = [ "newActivateCount,新增激活数" ];
		options4.draw = createLineChart;
		options4.unit = "newActivateCount";
		$("#chartdiv_column").empty();
		SP.loadChart(options4);
	}

	var oTable = SP.loadTableInfo($("#contentlist"), options, $("#tef"));

	function search() {
		options.aoColumns = [ {
			"sTitle" : "日期",
			"sClass" : "center",
			"mDataProp" : "generatedTime",
			"sWidth" : "10%"
		}, {
			"sTitle" : "星期",
			"sClass" : "center",
			"mDataProp" : "week_day"
		}, {
			"sTitle" : "新增激活数",
			"sClass" : "center",
			"mDataProp" : "newActivateCount"
		}, {
			"sTitle" : "当前激活数",
			"sClass" : "center",
			"mDataProp" : "currentCount"
		}, {
			"sTitle" : "当月累计激活数",
			"sClass" : "center",
			"mDataProp" : "accumulativeCount"
		}, ];
		var boo = false;
		if (!$("#fourChannelInput")[0].disabled && $("#fourChannelInput").val() != "") {
			boo = true;
			options.aoColumns = [ {
				"sTitle" : "日期",
				"sClass" : "center",
				"mDataProp" : "generatedTime",
				"sWidth" : "10%"
			}, {
				"sTitle" : "星期",
				"sClass" : "center",
				"mDataProp" : "week_day",
				"sWidth" : "10%"
			}, {
				"sTitle" : "一级渠道",
				"sClass" : "center",
				"mDataProp" : "oneChannelString",
				"sWidth" : "15%"
			},  {
				"sTitle" : "四级渠道",
				"sClass" : "center",
				"mDataProp" : "channelString",
				"sWidth" : "20%"
			}, {
				"sTitle" : "新增激活数",
				"sClass" : "center",
				"mDataProp" : "newActivateCount",
				"sWidth" : "15%"
			}, {
				"sTitle" : "当前激活数",
				"sClass" : "center",
				"mDataProp" : "currentCount",
				"sWidth" : "15%"
			}, {
				"sTitle" : "当月累计激活数",
				"sClass" : "center",
				"mDataProp" : "accumulativeCount",
				"sWidth" : "15%"
			}, ];
		}else if (!$("#onChannelInput")[0].disabled && $("#onChannelInput").val() != "") {
			boo = true;
			options.aoColumns = [ {
				"sTitle" : "日期",
				"sClass" : "center",
				"mDataProp" : "generatedTime"
			}, {
				"sTitle" : "星期",
				"sClass" : "center",
				"mDataProp" : "week_day"
			}, {
				"sTitle" : "一级渠道",
				"sClass" : "center",
				"mDataProp" : "channelString"
			}, {
				"sTitle" : "新增激活数",
				"sClass" : "center",
				"mDataProp" : "newActivateCount"
			}, {
				"sTitle" : "当前激活数",
				"sClass" : "center",
				"mDataProp" : "currentCount"
			}, {
				"sTitle" : "当月累计激活数",
				"sClass" : "center",
				"mDataProp" : "accumulativeCount"
			}, ];
		}
		if (boo) {
			$("#chartdiv_column").hide();
		} else {
			$("#chartdiv_column").show();
		}

		oTable.fnDestroy();
		$("#contentlist").empty();
		oTable = SP.loadTableInfo($("#contentlist"), options, $("#tef"));
	}

	function exportData() {
		$("#tef").attr("action","${ctx}/useranalysis/exportActivateReport.action");
		$("#tef").submit();
	}
	
	//显示指标定义
	$("#kpiLink").hover(
			function(){
				var kpiContent="";
				kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
				kpiContent+="<span style=\"color: #369bd7;\">新增激活数：</span> 第一次安装并打开应用的设备数（以设备为判断标准），排除升级或卸载后重装应用的设备. \n\n";
				kpiContent+="<span style=\"color: #369bd7;\">当前激活数：</span> 安装并打开应用的设备数，包含新增激活数（以设备为判断标准）. \n\n";
				kpiContent+="<span style=\"color: #369bd7;\">当月累计激活数：</span> 截至统计日期，当月新增激活的累计值. \n";
				kpiContent+="</pre>"
				$("#kpiSpan").ligerTip({
			        content:kpiContent,
			        width:620}
				);
			},
			function(){
				$("#kpiSpan").ligerHideTip();
			}
	);
</script>
