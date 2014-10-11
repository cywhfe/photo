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
				<span class="anas-type">客户端_action</span> <span class="anas-type"><a
					href="${ctx}/help/action.jsp"
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
						<div class="control-group">
							<label class="control-label" for="selectError">action</label>
							<div class="controls">
								<select name="templateVo.action" multiple="multiple" id="action"
									style="width: 120px;">
									<c:if test="${not empty actionList }">
										<c:forEach items="${actionList}" var="entity">
											<option value="${entity.id}">${entity.name}</option>
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
	$(".selcal").show();
	$(".selcal select").attr("disabled", false);
	$("#action").attr("multiple", "multiple");
	$("#action").multiselect({//action多选
		checkAllText : "全选",
		uncheckAllText : "取消",
		noneSelectedText : "请选择",
		minWidth : 150,
		height : 300,
		selectedList : 100
	}).multiselectfilter({
		label : '查询',
		width : 120,
		placeholder : ''
	});
	
	$("#client_version").attr("multiple", "multiple");
	$("#client_version").multiselect({//版本多选
		checkAllText : "全选",
		uncheckAllText : "取消",
		noneSelectedText : "请选择",
		minWidth : 140,
		selectedList : 100,
		beforeopen : function() {
			//client_version有时为空，需要删除该option
			$("#client_version option[value=]").remove();
			$("#client_version").multiselect("refresh");
		}
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
	options.sAjaxSource = "${ctx}/client/loadActionTableData.action";
	options.bServerSide = false;
	options.aoColumns = [ {
		"sTitle" : "日期",
		"sClass" : "center",
		"mDataProp" : "date"
	}, {
		"sTitle" : "action",
		"sClass" : "center",
		"mDataProp" : "action"
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

	function loadAppidVersion(app_id) {
		var defa = new Array();
		defa[0] = {
			"app_id" : app_id
		};
		SP.loadVersionMultiSelect("${ctx}/getAppidVersion.action",
				$("#client_version"), defa);
	}

	function search() {
		if (!SP.checker($("#tef"))) {
			return false;
		}

		var internames = $("#inter_name").multiselect("getChecked").map(
				function() {
					return this.value;
				}).get();
		$("#inter_name").attr("value", internames);

		var versions = $("#client_version").multiselect("getChecked").map(
				function() {
					return this.value;
				}).get();
		$("#client_version").val(versions);

		var options = {};
		options.sAjaxSource = "${ctx}/client/loadActionTableData.action";
		options.bServerSide = false;
		options.aoColumns = [ {
			"sTitle" : "日期",
			"sClass" : "center",
			"mDataProp" : "date"
		}, {
			"sTitle" : "action",
			"sClass" : "center",
			"mDataProp" : "action"
		} ];
		if ($("#action").val() != null) {
			options.aoColumns.push({
				"sTitle" : "operation",
				"sClass" : "center",
				"mDataProp" : "operation"
			});
		}

		if ($("#client_version").val() !== ""
				&& $("#client_version").val() !== null
				&& $("#client_version").val().join("") !== "") {
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
		/* 		window.location.href = "${ctx}/client/exportActionReport.action?"
		 + $("#tef").serialize(); */
		SP.exportExcel("${ctx}/client/exportActionReport.action");
	}
</script>
