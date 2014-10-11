<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title>用户分析_月活跃用户</title>
<%@ include file="/include/script.jsp"%>
<script src="${ctx}/js/ligerUI/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="${ctx}/js/json2.js" type="text/javascript"></script>
</head>

<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
	<input type="hidden" id="roleType" value="${roleType}"/>
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">用户分析_月活跃用户</span>
				<a id="kpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a><span id="kpiSpan"></span>
				<span class="anas-type"><a href="${ctx}/help/mau.jsp" style="padding:2px 5px 2px;font-size:13px;"  >说明</a></span>
				<div style="float:right;width:90px">
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
								<input name="templateVo.start_time" onfocus="timeMonthFocusBegin()" type="text" class="input-medium focused Wdate"  id="d4311" /> 
								</div>
							  </div>
							   <div class="control-group">
								<label class="control-label" for="focusedInput">结束时间</label>
								<div class="controls">
								<input name="templateVo.end_time" onfocus="timeMonthFocusEnd()" type="text"  class="input-medium focused Wdate" id="d4312" />
								</div>
							  </div>
							  <div class="control-group">
								  <label class="control-label" for="selectError">登陆类型</label>
								  <div class="controls">
								  			<select  onchange="changeType(this.value)" style="width:120px" id="caseids" name="templateVo.client_type" >
											<c:if test="${!empty type}">
												<c:forEach items="${type}" var="type">
													<option value="${type}" >${type.typeName}</option>
												</c:forEach>
											</c:if>
											</select>
								  </div>
							  </div>
							  <div class="control-group" id="user_attribute_div">
								<label class="control-label" for="selectError">用户属性</label>
								<div class="controls">
									<select name="templateVo.attribute_id"   style="width: 120px" id="user_attr1" onchange="changeType($('#caseids').val())">
										<option value="0">不区分</option>
										<c:if test="${!empty userAttrList}">
											<c:forEach items="${userAttrList}" var="entity">
												<option value="${entity.id}">${entity.name}</option>
											</c:forEach>
										</c:if>
									</select>
								</div>
							  </div>
							 <jsp:include page="../common/selectbox.jsp" flush="true" ></jsp:include>
							 <div class="control-group" style="width:170px" id="auto">
								  <label class="control-label" for="selectError">是否驻留</label>
								  <div class="controls">
										<select id="is_auto" name="templateVo.auto" style="width:80px">
											<option value="0" select="selected">请选择</option>
											<option value="1">驻留</option>
											<option value="2">非驻留</option>
										</select>
								  </div>
							  </div>
					     </fieldset>
		 			 </form>
			    </div>
			
<!-- 			<div id="chartdiv_column"  style="width: 100%; height: 400px;float:left"></div> -->				
			<div id="dau_result" style="margin: 0; padding: 0">
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
//设置初始时间
var be = getFormatDate((new Date().getTime()), "yyyy-") + "01";
var en = getFormatDate(new Date().getTime(), "yyyy-MM");
$("#d4311").val(be);
$("#d4312").val(en);

var options={};
var oTable=null;
options.sAjaxSource="${ctx}/mau/loadTableData.action";
options.bServerSide=false;
options.aoColumns = [ {
    "sTitle" : "日期",
    "sClass" : "center",
    "mDataProp" : "date"
}, {
    "sTitle" : "MAU",
    "sClass" : "center",
    "mDataProp" : "mau"
}];

/* options.fnInitComplete=function(){
    var options4={};
    options4.chartData=oTable.fnGetData();
    options4.chartId="chartdiv_column";
    options4.categoryField="date";
    options4.valField=["mau,MAU"];
    options4.draw=createLineChart;
    options4.unit="mau";
    $("#chartdiv_column").empty();
    SP.loadChart(options4);
}; */

$(function(){
    $("#user_attr1 option[value=1]").remove();
    $("#user_attr1 option[value=2]").remove();
    $("#user_attr1 option[value=3]").remove();
    $("#user_attr1 option[value=5]").remove();
    $("#user_attr1 option[value=6]").remove();//remove the default select value

    $("#caseids").change(function(){
        changeType($(this).val());
        
        if($(this).val() === 'all' || $(this).val() === 'mcs'){
            if($("#user_attr1 option").length == 1){
                $('#user_attr1').append("<option value='4'>province</option>");
            }
        }else{
            $("#user_attr1 option[value=4]").remove();
            $("#user_attr1 option[value=0]").attr("selected", true);
        }
    });
});

changeType($("#caseids").val());

var oTable = SP.loadTableInfo($("#contentlist"), options, $("#tef"));

//显示指标定义
$("#kpiLink").hover(
		function(){
			var kpiContent="";
			kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
			kpiContent+="按月查看登录的用户数（按UID去重），提供登录类型与登录省份的交叉查询.\n\n";
			kpiContent+="<span style=\"color: #369bd7;\">驻留登录：</span> 统计日期内，用户处于登录状态并且应用在后台运行时，为驻留登录. \n\n";
			kpiContent+="<span style=\"color: #369bd7;\">非驻留登录：</span> 统计日期内，用户有启动应用并且登录的行为，为非驻留登录. \n";
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

function changeType(val){
    if(val=="all"){//all
        $("#user_attribute_div").show();
        var attribute_id = $("#user_attr1").val();
        if(attribute_id == "4"){//province
            $(".selcal").hide();
            $(".channel").hide();
            $("#visitform").hide();
            $("#third_app_id_div").hide();//appid
            $("#auto").show();
        }else{
            $(".selcal").hide();
            $(".channel").hide();
            $("#visitform").hide();
            $("#third_app_id_div").hide();
            $("#auto").hide();
        }
    }else if(val=="mcs"){//mcs
    	$("#user_attribute_div").show();
    	var attribute_id = $("#user_attr1").val();
        if(attribute_id == "4"){//province
            $(".selcal").hide();
            $(".channel").hide();
            $("#visitform").hide();
            $("#third_app_id_div").hide();//appid
            $("#auto").show();
        }else{
            $("#auto").show();
            $(".selcal").show();
            $(".channel").show();
            $("#visitform").hide();
            $("#third_app_id_div").hide();
            $(".selcal select").attr("disabled",false);
        }
    }else if(val=="third"){//third
        $(".selcal").hide();
        $(".channel").hide();
        $("#visitform").hide();
        $("#auto").hide();
        $("#third_app_id_div").hide();
        $("#user_attribute_div").hide();
    }else{
        $(".selcal").hide();
        $(".channel").hide();
        $(".selcal select").attr("disabled",true);
        $(".channel input").attr("disabled",true);
        $("#visitform").show();
        $("#user_attribute_div").hide();
        $("#visitform input").attr("disabled",false); 
        $("#third_app_id_div").hide();
        $("#third_app_id_div select").attr("disabled",true);
        $("#auto").hide();
    }
    clearAllSelect();
}

function clearAllSelect(){
	$(".selcal select").attr("disabled",false);
    $(".channel input").attr("disabled",false);
    $("#visitform input").attr("disabled",false);
    $("#third_app_id_div select").attr("disabled",true);
    $("#auto select").attr("disabled",false); 
    
	$("#device_id option[value=-1]").attr("selected", true);
	$("#os_id option[value=-1]").attr("selected", true);
	$("#app_id option[value=-1]").attr("selected", true);
	$("#client_version option[value=-1]").attr("selected", true);
	$("#is_auto option[value=0]").attr("selected", true);
	
	$("#device_id").val("-1");
	$("#os_id").val("-1");
	$("#app_id").attr("value", "-1");
	$("#client_version_div").val("-1");
	$("#is_auto").val("-1");
}

function search(){
    var options = {};
    options.sAjaxSource="${ctx}/mau/loadTableData.action";
    options.bServerSide=false;
    options.aoColumns = [ {
        "sTitle" : "日期",
        "sClass" : "center",
        "mDataProp" : "date"
    }];
    if ($("#user_attr1").val() !== "" && $("#user_attr1").val() === '4') {
        options.aoColumns.push({
            "sTitle" : "province",
            "sClass" : "center",
            "mDataProp" : "province"
        });
    }
    options.aoColumns.push({
        "sTitle" : "MAU",
        "sClass" : "center",
        "mDataProp" : "mau"
    });
    
/*     options.fnInitComplete=function(){
        var options4={};
        options4.chartData=oTable.fnGetData();
        options4.chartId="chartdiv_column";
        options4.categoryField="date";
        options4.valField=["mau,MAU"];
        options4.draw=createLineChart;
        options4.unit="mau";
        $("#chartdiv_column").empty();
        SP.loadChart(options4);
    }; */

    oTable.fnDestroy();
    $("#contentlist").empty();
    $("#chartdiv_column").empty();
    oTable = SP.loadTableInfo($("#contentlist"), options, $("#tef"));
}

function exportData(){
    //window.location.href="${ctx}/mau/exportReport.action?"+$("#tef").serialize();
	SP.exportExcel("${ctx}/mau/exportReport.action");
}
</script>
