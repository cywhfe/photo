<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-${ugcModelName}</title>
<%@ include file="/include/script.jsp"%>
<script src="${ctx}/js/export/export.js" type="text/javascript"></script> 
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
					<span class="anas-type">${ugcModelName}</span>
					<a id="kpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a><span id="kpiSpan"></span>
					<span class="anas-type"><a href="${ctx}/help/ugc.jsp" style="padding:2px 5px 2px;font-size:13px;"  >说明</a></span>
						<div style="float:right;width:100px;">
							<button type="button" style="padding:2px 5px 2px;font-size:13px;" onclick="search()" class="btn btn-primary">查询</button>
							<button type="button" style="padding: 2px 5px 2px; font-size: 13px;float:right" onclick="voiceUgcExportReport()" class="btn btn-primary">导出</button>
						</div>
				</div>
				<div class="subtitle" style="float:left">
				     <form  class="form-horizontal" action="" id="tef" name="tef">
				      <input type="hidden" id="biz_type" value="voice"/>
					     <fieldset style="height:auto">
					     	 <div class="control-group">
								<label class="control-label" for="focusedInput">开始时间</label>
								<div class="controls">
								<input name="begin_date" value="${begin_date}" onfocus="timeFocusBegin()" type="text" class="input-medium focused Wdate"  id="d4311" /> 
								</div>
							  </div>
							   <div class="control-group">
								<label class="control-label" for="focusedInput">结束时间</label>
								<div class="controls">
								<input name="end_date" value="${end_date}" onfocus="timeFocusEnd()" type="text"  class="input-medium focused Wdate" id="d4312" />
								</div>
							  </div>
							  <div class="control-group">
								<label class="control-label" for="selectError">UGC类型</label>
								<div class="controls">
									<select id="ugcTypeList" name="ugcType" style="width:120px">
										<c:if test="${!empty categoryMap}">
											<c:forEach items="${categoryMap}" var="map" >
													 <option value="${map.key}" >${map.value}</option>
											</c:forEach>
										</c:if>
									</select> 
								</div>
							  </div>
							  <s:include value="../common/selectbox.jsp"></s:include>
					     </fieldset>
		 			 </form>
			    </div>
			    
		    <div id="chartdiv_column" style="width: 100%; height: 400px;float:left"></div>
			    
			<div id="maingrid" style="margin: 0; padding: 0;float:left;width:100%;margin-top:30px">
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

var options={};
options.sAjaxSource="${ctx}/ugc/voiceUgcQueryUGC.action";
options.bServerSide=false;
options.aoColumns=[
                   { "sTitle": "日期", "sClass": "center" ,"mDataProp": "generated_time","bSortable":false},
	               { "sTitle": "发布次数", "sClass": "center" ,"mDataProp": "update_status_pv"},
	               { "sTitle": "发布人数", "sClass": "center","mDataProp": "update_status_uv" },
	               { "sTitle": "次数/人数", "sClass": "center","mDataProp": "update_status_pvuv" ,"bSortable":false},
	               { "sTitle": "回复次数", "sClass": "center","mDataProp": "reply_status_pv" },
	               { "sTitle": "回复人数", "sClass": "center","mDataProp": "reply_status_uv" },
	               { "sTitle": "次数/人数", "sClass": "center","mDataProp": "reply_status_pvuv" ,"bSortable":false},
	               { "sTitle": "播放次数", "sClass": "center","mDataProp": "doing_playcount" },
	               { "sTitle": "语音时长（s）", "sClass": "center","mDataProp": "status_media_length" }
	             ];
options.fnInitComplete=function(){
	if($("#ugcTypeList").val()=='all') {
	  var options4={}
		options4.chartData=oTable.fnGetData();
	    options4.chartId="chartdiv_column";
	    options4.categoryField="generated_time";
	    options4.valField="uv";
		SP.loadUGC_LineChart(options4);
		$("#chartdiv_column").show();
	} else {
		$("#chartdiv_column").hide();
	}
}
	             
var oTable=SP.loadTableInfo($("#contentlist"),options,$("#tef"));

//显示指标定义
$("#kpiLink").hover(
		function(){
			var kpiContent="";
			kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
			kpiContent+="可以查看客户端中，语音状态和语音图片的发布人数、发布次数、播放次数等结果.\n";
			kpiContent+="</pre>"
			$("#kpiSpan").ligerTip({
		        content:kpiContent,
		        width:500}
			);
		},
		function(){
			$("#kpiSpan").ligerHideTip();
		}
);

var defaut=new Array();
defaut[0]=0;
defaut[1]="不区分";
SP.loadSelectDate("${ctx}/getPlatform.action",$("#os_id"));
SP.loadSelectDate("${ctx}/getDeviceId.action",$("#device_id"));

$("#os_id").attr("disabled",false);
$("#device_id").attr("disabled",false);
$("#app_id").attr("disabled",false);
$("#client_version").attr("disabled",false);

function search(){
	if(!SP.checker($("#tef"))){
		return false;
	}
	if($("#ugcTypeList").val()=='photo') {
		options.aoColumns=[
		                   { "sTitle": "日期", "sClass": "center" ,"mDataProp": "generated_time","sWidth":"50px","bSortable":false},
			               { "sTitle": "发布次数", "sClass": "center" ,"mDataProp": "upload_photo_pv","sWidth":"50px"},
			               { "sTitle": "发布人数", "sClass": "center","mDataProp": "upload_photo_uv","sWidth":"50px" },
			               { "sTitle": "次数/人数", "sClass": "center","mDataProp": "upload_photo_pvuv" ,"sWidth":"50px","bSortable":false},
			               { "sTitle": "回复次数", "sClass": "center","mDataProp": "photo_comment_pv" ,"sWidth":"50px"},
			               { "sTitle": "回复人数", "sClass": "center","mDataProp": "photo_comment_uv" ,"sWidth":"50px"},
			               { "sTitle": "次数/人数", "sClass": "center","mDataProp": "photo_comment_pvuv","sWidth":"50px","bSortable":false },
			               { "sTitle": "分享次数", "sClass": "center","mDataProp": "share_pv","sWidth":"50px" },
			               { "sTitle": "分享人数", "sClass": "center","mDataProp": "share_uv" ,"sWidth":"50px"},
			               { "sTitle": "次数/人数", "sClass": "center","mDataProp": "share_pvuv","sWidth":"50px" ,"bSortable":false},
			               { "sTitle": "播放次数", "sClass": "center","mDataProp": "photo_playcount","sWidth":"50px" },
			               { "sTitle": "浏览次数", "sClass": "center","mDataProp": "photo_viewcount","sWidth":"50px" },
			               { "sTitle": "语音时长（s）", "sClass": "center","mDataProp": "photo_media_length" ,"sWidth":"50px"}
			             ];
	}
	
	if($("#ugcTypeList").val()=='status') {
		options.aoColumns=[
		                   { "sTitle": "日期", "sClass": "center" ,"mDataProp": "generated_time","bSortable":false},
			               { "sTitle": "发布次数", "sClass": "center" ,"mDataProp": "update_status_pv"},
			               { "sTitle": "发布人数", "sClass": "center","mDataProp": "update_status_uv" },
			               { "sTitle": "次数/人数", "sClass": "center","mDataProp": "update_status_pvuv" ,"bSortable":false},
			               { "sTitle": "回复次数", "sClass": "center","mDataProp": "reply_status_pv" },
			               { "sTitle": "回复人数", "sClass": "center","mDataProp": "reply_status_uv" },
			               { "sTitle": "次数/人数", "sClass": "center","mDataProp": "reply_status_pvuv" ,"bSortable":false},
			               { "sTitle": "播放次数", "sClass": "center","mDataProp": "doing_playcount" },
			               { "sTitle": "语音时长（s）", "sClass": "center","mDataProp": "status_media_length" }
			             ];
	}
	
	oTable.fnDestroy();
	$("#contentlist").empty();
    SP.loadTableInfo($("#contentlist"),options,$("#tef"));
    options.fnInitComplete();
}
</script>
