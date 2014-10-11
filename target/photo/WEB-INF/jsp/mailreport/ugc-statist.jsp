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
				<span class="anas-type">UGC日报表</span> <span class="anas-type"></span>
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
						<input type="hidden" id="biztype" name="biztype" value="mcs" />
					</fieldset>
				</form>
			</div>
			<ul id="tabs" class="nav nav-tabs">
				<li class="active"><a href="#mcs" data-toggle="tab">客户端_UGC</a>
				</li>
				<li><a href="#wap" data-toggle="tab">WAP_UGC</a></li>
				<li><a href="#touch" data-toggle="tab">TOUCH_UGC</a></li>
			</ul>
			<div class="tab-content">
				<div id="mcs" class="tab-pane active"
					style="margin: 0; padding: 0; float: left; width: 100%; margin-top: 0px; overflow-y: hidden;">
					<table id="mcsContentlist"
						class="table table-striped table-bordered bootstrap-datatable datatable"
						style="margin: 0 0 0 0;">
					</table>
				</div>
				<div class="tab-pane" id="wap"
					style="margin: 0; padding: 0; float: left; width: 100%; margin-top: 0px; overflow-y: hidden;">
					<table id="wapContentlist"
						class="table table-striped table-bordered bootstrap-datatable datatable"
						style="margin: 0 0 0 0;">
					</table>
				</div>
				<div class="tab-pane" id="touch"
					style="margin: 0; padding: 0; float: left; width: 100%; margin-top: 0px; overflow-y: hidden;">
					<table id="touchContentlist"
						class="table table-striped table-bordered bootstrap-datatable datatable"
						style="margin: 0 0 0 0;">
					</table>
				</div>
			</div>
		</div>
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>
<script>
	var oTable = "";
	$(function() {
		$('.nav-tabs a:first').tab('show');
		$("#tabs a").click(
				function(e) {
					e.preventDefault();
					$(this).tab("show");

					var biztype = $(this).attr("href").replace("#", "");
					$("#biztype").attr("value", biztype);

					var options = buildTableOptions(biztype);
					oTable.fnDestroy();
					$("#" + biztype + "Contentlist").empty();
					$("#" + biztype + "Contentlist").append(
							buildHeaderStr(biztype));
					oTable = SP.loadTableInfo($("#" + biztype + "Contentlist"),
							options, $("#tef"));
				});
		var biztype = $("#biztype").val();
		var options = buildTableOptions(biztype);
		$("#mcsContentlist").append(buildHeaderStr(biztype));
		oTable = SP.loadTableInfo($("#mcsContentlist"), options, $("#tef"));
	});

	function search() {
		if (!SP.checker($("#tef"))) {
			return false;
		}

		var biztype = $("#biztype").val();
		var options = buildTableOptions(biztype);
		oTable.fnDestroy();
		$("#" + biztype + "Contentlist").empty();
		$("#" + biztype + "Contentlist").append(buildHeaderStr(biztype));
		oTable = SP.loadTableInfo($("#" + biztype + "Contentlist"), options,
				$("#tef"));
	}

	function exportData() {
		window.location.href = "${ctx}/mailreport/exportUGCReport.action?"
				+ $("#tef").serialize();
	}

	//构造jquery dataTable请求options
	function buildTableOptions(biztype) {
		var options = {};
		options.sAjaxSource = "${ctx}/mailreport/loadUGCReportTableData.action";
		options.bServerSide = false;
		options.sScrollX = "100%";
		options.sScrollXInner = "150%";
		options.bScrollCollapse = true;
		options.aoColumns = [ {
			"sTitle" : "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;期&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",
			"sClass" : "center",
			"mDataProp" : "generated_time",
			"sWidth" : "10%"
		}, {
			"sTitle" : "次数",
			"sClass" : "center",
			"mDataProp" : "update_status_pv"
		}, {
			"sTitle" : "人数",
			"sClass" : "center",
			"mDataProp" : "update_status_uv"
		}, {
			"sTitle" : "次数",
			"sClass" : "center",
			"mDataProp" : "reply_status_pv"
		}, {
			"sTitle" : "人数",
			"sClass" : "center",
			"mDataProp" : "reply_status_uv"
		}, {
			"sTitle" : "次数",
			"sClass" : "center",
			"mDataProp" : "upload_photo_pv"
		}, {
			"sTitle" : "人数",
			"sClass" : "center",
			"mDataProp" : "upload_photo_uv"
		}, {
			"sTitle" : "次数",
			"sClass" : "center",
			"mDataProp" : "photo_comment_pv"
		}, {
			"sTitle" : "人数",
			"sClass" : "center",
			"mDataProp" : "photo_comment_uv"
		}, {
			"sTitle" : "次数",
			"sClass" : "center",
			"mDataProp" : "post_blog_pv"
		}, {
			"sTitle" : "人数",
			"sClass" : "center",
			"mDataProp" : "post_blog_uv"
		}, {
			"sTitle" : "次数",
			"sClass" : "center",
			"mDataProp" : "blog_comment_pv"
		}, {
			"sTitle" : "人数",
			"sClass" : "center",
			"mDataProp" : "blog_comment_uv"
		}, {
			"sTitle" : "次数",
			"sClass" : "center",
			"mDataProp" : "share_pv"
		}, {
			"sTitle" : "人数",
			"sClass" : "center",
			"mDataProp" : "share_uv"
		}, {
			"sTitle" : "次数",
			"sClass" : "center",
			"mDataProp" : "share_comment_pv"
		}, {
			"sTitle" : "人数",
			"sClass" : "center",
			"mDataProp" : "share_comment_uv"
		} ];
		if (biztype === 'mcs') {
			var column = [ {
				"sTitle" : "次数",
				"sClass" : "center",
				"mDataProp" : "place_checkin_pv"
			}, {
				"sTitle" : "人数",
				"sClass" : "center",
				"mDataProp" : "place_checkin_uv"
			}, {
				"sTitle" : "次数",
				"sClass" : "center",
				"mDataProp" : "like_pv"
			}, {
				"sTitle" : "人数",
				"sClass" : "center",
				"mDataProp" : "like_uv"
			} ];
			options.aoColumns = options.aoColumns.concat(column);
		}
		return options;
	}

	//构造表头head
	function buildHeaderStr(biztype) {
		var headerArr = [];
		headerArr.push("<thead><tr align='center'>");
		headerArr.push("<th rowspan='2' align='center'>日期</th>");
		headerArr.push("<th colspan='2' align='center'>状态发布</th>");
		headerArr.push("<th colspan='2' align='center'>状态回复</th>");
		headerArr.push("<th colspan='2' align='center'>照片上传</th>");
		headerArr.push("<th colspan='2' align='center'>照片评论</th>");
		headerArr.push("<th colspan='2' align='center'>日志发布</th>");
		headerArr.push("<th colspan='2' align='center'>日志评论</th>");
		headerArr.push("<th colspan='2' align='center'>分享</th>");
		headerArr.push("<th colspan='2' align='center'>分享评论</th>");
		if (biztype === 'mcs') {
			headerArr.push("<th colspan='2' align='center'>签到</th>");
			headerArr.push("<th colspan='2' align='center'>赞</th>");
		}

		headerArr.push("</tr>");
		headerArr.push("<tr><th align='center'>次数</th>");
		headerArr.push("<th align='center'>人数</th>");
		headerArr.push("<th align='center'>次数</th>");
		headerArr.push("<th align='center'>人数</th>");
		headerArr.push("<th align='center'>次数</th>");
		headerArr.push("<th align='center'>人数</th>");
		headerArr.push("<th align='center'>次数</th>");
		headerArr.push("<th align='center'>人数</th>");
		headerArr.push("<th align='center'>次数</th>");
		headerArr.push("<th align='center'>人数</th>");
		headerArr.push("<th align='center'>次数</th>");
		headerArr.push("<th align='center'>人数</th>");
		headerArr.push("<th align='center'>次数</th>");
		headerArr.push("<th align='center'>人数</th>");
		headerArr.push("<th align='center'>次数</th>");
		headerArr.push("<th align='center'>人数</th>");
		if (biztype === 'mcs') {
			headerArr.push("<th align='center'>次数</th>");
			headerArr.push("<th align='center'>人数</th>");
			headerArr.push("<th align='center'>次数</th>");
			headerArr.push("<th align='center'>人数</th>");
		}
		headerArr.push("</tr>");
		headerArr.push("</thead>");
		return headerArr.join("");
	}
</script>
