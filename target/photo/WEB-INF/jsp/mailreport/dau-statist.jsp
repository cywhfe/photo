<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<%@ include file="/include/script.jsp"%>
<script type="text/javascript" src="${ctx}/js/wz_jsgraphics.js"></script>
</head>
<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">DAU日报表</span> <span class="anas-type"></span>
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
					</fieldset>
				</form>
			</div>

			<div id="maingrid"
				style="margin: 0; padding: 0; float: left; width: 100%; margin-top: 0px; overflow-y: hidden;">
				<table id="contentlist"
					class="table table-striped table-bordered bootstrap-datatable datatable"
					style="margin: 0 0 0 0;">
				</table>
			</div>
		</div>
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>
<script>
	var options = buildTableOptions();
	$("#contentlist").append(buildHeaderStr());
	var oTable = SP.loadTableInfo($("#contentlist"), options, $("#tef"));

	function search() {
		if (!SP.checker($("#tef"))) {
			return false;
		}

		var options = buildTableOptions();
		oTable.fnDestroy();
		$("#contentlist").empty();
		$("#contentlist").append(buildHeaderStr());
		oTable = SP.loadTableInfo($("#contentlist"), options, $("#tef"));
	}

	function exportData() {
		window.location.href = "${ctx}/dau/exportStatistReport.action?"
				+ $("#tef").serialize();
	}

	//构造jquery dataTable请求options
	function buildTableOptions() {
		var options = {};
		options.sAjaxSource = "${ctx}/dau/loadStatistTableData.action";
		options.bServerSide = false;
		options.sScrollX = "100%";
		options.sScrollXInner = "150%";
		options.bScrollCollapse = true;
		options.aoColumns = [ {
			"sTitle" : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;期&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",
			"sClass" : "center",
			"mDataProp" : "date",
			"sWidth" : "15%"
		}, {
			"sTitle" : "3G登录",
			"sClass" : "center",
			"mDataProp" : "wirelessLogin",
			"sWidth" : "10%"
		}, {
			"sTitle" : "3G交互(非驻留)",
			"sClass" : "center",
			"mDataProp" : "wirelessSide",
			"sWidth" : "10%"
		},{
			"sTitle" : "取新鲜事UV",
			"sClass" : "center",
			"mDataProp" : "feedUv",
			"sWidth" : "10%"
		}, {
			"sTitle" : "仅3G登录",
			"sClass" : "center",
			"mDataProp" : "aloneWirelessLogin",
			"sWidth" : "10%"
		}, {
			"sTitle" : "wap登录",
			"sClass" : "center",
			"mDataProp" : "wapLogin",
			"sWidth" : "10%"
		}, {
			"sTitle" : "第三方接入UV",
			"sClass" : "center",
			"mDataProp" : "thirdUv",
			"sWidth" : "10%"
		}, {
			"sTitle" : "客户端登录",
			"sClass" : "center",
			"mDataProp" : "clientLogin",
			"sWidth" : "10%"
		}, {
			"sTitle" : "客户端交互(非驻留)",
			"sClass" : "center",
			"mDataProp" : "clientSide",
			"sWidth" : "10%"
		}, {
			"sTitle" : "IOS",
			"sClass" : "center",
			"mDataProp" : "clIOS",
			"sWidth" : "10%"
		}, {
			"sTitle" : "Android",
			"sClass" : "center",
			"mDataProp" : "clAndroid",
			"sWidth" : "10%"
		}, {
			"sTitle" : "Iphone",
			"sClass" : "center",
			"mDataProp" : "clIphone",
			"sWidth" : "10%"
		}, {
			"sTitle" : "Ipad",
			"sClass" : "center",
			"mDataProp" : "clIpad",
			"sWidth" : "10%"
		}, {
			"sTitle" : "Android Phone",
			"sClass" : "center",
			"mDataProp" : "clAphone",
			"sWidth" : "10%"
		}, {
			"sTitle" : "Android Pad",
			"sClass" : "center",
			"mDataProp" : "clApad",
			"sWidth" : "10%"
		}, {
			"sTitle" : "IOS",
			"sClass" : "center",
			"mDataProp" : "csIOS",
			"sWidth" : "10%"
		}, {
			"sTitle" : "Android",
			"sClass" : "center",
			"mDataProp" : "csAndroid",
			"sWidth" : "10%"
		}, {
			"sTitle" : "Iphone",
			"sClass" : "center",
			"mDataProp" : "csIphone",
			"sWidth" : "10%"
		}, {
			"sTitle" : "Ipad",
			"sClass" : "center",
			"mDataProp" : "csIpad",
			"sWidth" : "10%"
		}, {
			"sTitle" : "Android Phone",
			"sClass" : "center",
			"mDataProp" : "csAphone",
			"sWidth" : "10%"
		}, {
			"sTitle" : "Android Pad",
			"sClass" : "center",
			"mDataProp" : "csApad",
			"sWidth" : "10%"
		} ];
		return options;
	}

	//构造表头head
	function buildHeaderStr() {
		var headerArr = [];
		headerArr.push("<thead><tr align='center'>");
		headerArr.push("<th rowspan='2' align='center'>日期</th>");
		headerArr.push("<th colspan='8' align='center'>3G端登录</th>");
		headerArr.push("<th colspan='6' align='center'>客户端登录</th>");
		headerArr.push("<th colspan='6' align='center'>客户端交互</th>");
		headerArr.push("</tr>");
		headerArr.push("<tr><th align='center'>3G登录</th>");
		headerArr.push("<th align='center'>3G交互(非驻留)</th>");
		headerArr.push("<th align='center'>取新鲜事UV</th>");
		headerArr.push("<th align='center'>仅3G登录</th>");
		headerArr.push("<th align='center'>wap登录</th>");
		headerArr.push("<th align='center'>第三方接入UV</th>");
		headerArr.push("<th align='center'>客户端登录</th>");
		headerArr.push("<th align='center'>客户端交互(非驻留)</th>");
		headerArr.push("<th align='center'>IOS</th>");
		headerArr.push("<th align='center'>Android</th>");
		headerArr.push("<th align='center'>Iphone</th>");
		headerArr.push("<th align='center'>Ipad</th>");
		headerArr.push("<th align='center'>Android Phone</th>");
		headerArr.push("<th align='center'>Android Pad</th>");
		headerArr.push("<th align='center'>IOS</th>");
		headerArr.push("<th align='center'>Android</th>");
		headerArr.push("<th align='center'>Iphone</th>");
		headerArr.push("<th align='center'>Ipad</th>");
		headerArr.push("<th align='center'>Android Phone</th>");
		headerArr.push("<th align='center'>Android Pad</th>");
		headerArr.push("</tr>");
		headerArr.push("</thead>");
		return headerArr.join("");
	}
</script>
