<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<%@ include file="/include/script.jsp"%>
</head>
<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">客户端_接口PV&UV</span> <span class="anas-type"><a
					href="${ctx}/help/interface.jsp"
					style="padding: 2px 5px 2px; font-size: 13px;">说明</a> </span>
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
								<input name="templateVo.start_time"
									onfocus="timeFocusBeginOneDay()" type="text"
									class="input-medium focused Wdate" id="d4311" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="focusedInput">结束时间</label>
							<div class="controls">
								<input name="templateVo.end_time" onfocus="timeFocusEnd()"
									type="text" class="input-medium focused Wdate" id="d4312" />
							</div>
						</div>
						<div class="control-group selcal" id="device_id_div">
							<label class="control-label" for="selectError">接&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;口</label>
							<div class="controls">
								<select name="templateVo.inter_name" disabled="true"
									id="inter_name" style="width: 160px" multiple="multiple">
									<c:if test="${!empty interfaceList}">
										<c:forEach items="${interfaceList}" var="entity">
											<option value="${entity.name}">${entity.name}</option>
										</c:forEach>
									</c:if>
								</select>
							</div>
						</div>
						<s:include value="../common/selectbox.jsp"></s:include>
					</fieldset>
				</form>
			</div>

			<div id="maingrid"
				style="margin: 0; padding: 0; float: left; width: 100%; margin-top: 0px">
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
	$("#user_attr1 option:last").hide();
	$(".selcal").show();
	$(".channel").show();
	$(".selcal select").attr("disabled", false);
	$(".channel input").attr("disabled", false);

	$("#inter_name").multiselect({
		checkAllText : "全选",
		uncheckAllText : "取消",
		noneSelectedText : "请选择",
		minWidth : 140,
		selectedList : 100
	// 0-based index
	}).multiselectfilter({
		label : '查询',
		width : 70,
		placeholder : ''
	});

	var yesterday = getFormatDate(new Date().getTime() - (24 * 3600 * 1000));
	$("#d4311").val(yesterday);
	$("#d4312").val(yesterday);

	var options = {};
	options.sAjaxSource = "${ctx}/client/loadInterfaceTableData.action";
	options.bServerSide = false;
	options.aoColumns = [ {
		"sTitle" : "日期",
		"sClass" : "center",
		"mDataProp" : "date"
	}, {
		"sTitle" : "接口",
		"sClass" : "center",
		"mDataProp" : "inter_name"
	}, {
		"sTitle" : "PV",
		"sClass" : "center",
		"mDataProp" : "pv"
	}, {
		"sTitle" : "UV",
		"sClass" : "center",
		"mDataProp" : "uv"
	} ];
	var oTable = SP.loadTableInfo($("#contentlist"), options, $("#tef"));
	
	function loadAppidVersion(app_id){
		var defa=new Array();
		defa[0]={"app_id" :app_id};
		SP.loadVersionMultiSelect("${ctx}/getAppidVersion.action",$("#client_version"),defa);
	}

	function search() {
		var internames = $("#inter_name").multiselect("getChecked").map(
				function() {
					return this.value;
				}).get();
		$("#inter_name").val(internames)
		
		var versions = $("#client_version").multiselect("getChecked").map(
				function() {
					return this.value;
				}).get();
		$("#client_version").attr("value", versions);

		var options = {};
		options.sAjaxSource = "${ctx}/client/loadInterfaceTableData.action";
		options.bServerSide = false;
		options.aoColumns = [ {
			"sTitle" : "日期",
			"sClass" : "center",
			"mDataProp" : "date"
		}, {
			"sTitle" : "接口",
			"sClass" : "center",
			"mDataProp" : "inter_name"
		} ];
		if ($("#client_version").val() !== "" && $("#client_version").val() !== null && $("#client_version").val().join("") !== "") {
			options.aoColumns.push({
				"sTitle" : "版本",
				"sClass" : "center",
				"mDataProp" : "version"
			});
		}
		options.aoColumns.push({
			"sTitle" : "PV",
			"sClass" : "center",
			"mDataProp" : "pv"
		});
		options.aoColumns.push({
			"sTitle" : "UV",
			"sClass" : "center",
			"mDataProp" : "uv"
		});

		oTable.fnDestroy();
		$("#contentlist").empty();
		oTable = SP.loadTableInfo($("#contentlist"), options, $("#tef"));
	}

	function exportData() {
		/* window.location.href = "${ctx}/client/exporInterfaceReport.action?"
				+ $("#tef").serialize(); */
		SP.exportExcel("${ctx}/client/exporInterfaceReport.action");
	}
</script>
