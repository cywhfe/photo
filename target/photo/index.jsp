<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<html>
<head>
<title><%=Constants.HTML_SYSTEM_NAME%>-系统概况</title>
<%@ include file="/include/script.jsp"%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
</head>
<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<!-- main content start -->
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">系统概况</span>
			</div>

			<div class="subtitle" style="float: left;">
				<form class="form-horizontal" action="" id="tef" name="tef">
					<input name="templateVo.start_time" type="hidden" id="d4311" /> 
					<input name="templateVo.end_time" type="hidden" id="d4312" /> 
					<input name="type" type="hidden" id="typeTxt" />
				</form>
			</div>
			<label class="control-label" style="font-weight: bold; font-size: 14px;">
				基本指标<a id="baseKpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a>
				<span id="baseKpiSpan"></span>
			</label>
			<div id="baseTab">
				<ul>
					<li><a href="#base-1">新增激活</a></li>
					<li><a href="#base-2">注册用户</a></li>
					<li><a href="#base-3">活跃用户</a></li>
					<li><a href="#base-4">日保留率</a></li>
					<li><a href="#base-5">周保留率</a></li>
				</ul>
				<div id="base-1">
					<div id="chartActive" style="width: 100%; height: 300px"></div>
				</div>
				<div id="base-2">
					<div id="chartRegitser" style="width: 100%; height: 300px"></div>
				</div>
				<div id="base-3">
					<div id="chartLive" style="width: 100%; height: 300px"></div>
				</div>
				<div id="base-4">
					<div id="chartDayReserver" style="width: 100%; height: 300px"></div>
				</div>
				<div id="base-5">
					<div id="chartWeekReserver" style="width: 100%; height: 300px"></div>
				</div>
			</div>
			<label class="control-label" style="font-weight: bold; font-size: 14px;">UGC分析</label>
			<div id="ugcTab">
				<ul>
					<li><a href="#ugc-1">客户端</a></li>
					<li><a href="#ugc-2">wap&touch</a></li>
					<li><a href="#ugc-3">第三方</a></li>
				</ul>
				<div id="ugc-1">
					<div id="chartUgcClient" style="width: 100%; height: 300px"></div>
				</div>
				<div id="ugc-2">
					<div id="chartUgcWap" style="width: 100%; height: 300px"></div>
				</div>
				<div id="ugc-3">
					<div id="chartUgcThird" style="width: 100%; height: 300px"></div>
				</div>
			</div>
			<label class="control-label" style="font-weight: bold; font-size: 14px;">
				用户属性分析<a id="attrKpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a>
				<span id="attrKpiSpan"></span>
			</label>
			<div id="userAttrTab">
				<ul>
					<li><a href="#userAttr-1">注册用户</a></li>
					<li><a href="#userAttr-2">活跃用户</a></li>
				</ul>
				<div id="userAttr-1">
					<table style="width: 100%;border: 0px;">
						<tr>
							<td width="50%">
								<div style="margin-left: 150px;"><span style="font-weight: bold;">地域分布</span></div>
								<div id="chartRegArea" style="width: 100%; height: 300px"></div>
							</td>
							<td width="50%">
								<div  style="margin-left: 200px;"><span style="font-weight: bold;">阶段分布</span></div>
								<div id="chartRegStage" style="width: 100%; height: 300px"></div>
							</td>
						</tr>
					</table>
				</div>
				<div id="userAttr-2">
					<table style="width: 100%;border: 0px;">
						<tr>
							<td width="50%">
								<div style="margin-left: 150px;"><span style="font-weight: bold;">地域分布</span></div>
								<div id="chartLiveArea" style="width: 100%; height: 300px"></div>
							</td>
							<td width="50%">
								<div style="margin-left: 200px;"><span style="font-weight: bold;">阶段分布</span></div>
								<div id="chartLiveStage" style="width: 100%; height: 300px"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<label class="control-label" style="font-weight: bold; font-size: 14px;">
				运营分析：客户端top10渠道<a id="topKpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a>
				<span id="topKpiSpan"></span>
			</label>
			<div id="topTab">
				<ul>
					<li><a href="#top-1">新增激活</a></li>
					<li><a href="#top-2">注册用户</a></li>
					<li><a href="#top-3">活跃用户</a></li>
				</ul>
				<div id="top-1">
					<div id="chartActiveTop" style="width: 100%; height: 450px"></div>
				</div>
				<div id="top-2">
					<div id="chartRegTop" style="width: 100%; height: 450px"></div>
				</div>
				<div id="top-3">
					<div id="chartLiveTop" style="width: 100%; height: 450px"></div>
				</div>
			</div>
			
		</div>
		<!-- main content end -->
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />


</body>
<script>
	//页面加载完执行
	$(function() {
		//基本指标tab显示
		var baseTab = $("#baseTab").tabs({
			collapsible: true ,
			cache: true ,
			select : function( event, ui ) {
				var index=ui.index;
				var selected=baseTab.tabs('option', 'selected');
				//选择当前显示的tab,则收缩tab
				if(index==selected) return;
				if(index==0){
					showChartActive();
				}
				if(index==1){
					showChartRegister();
				}
				if(index==2){
					showChartLive();
				}
				if(index==3){
					showChartDayReserver();
				}
				if(index==4){
					showChartWeekReserver();
				}
			}
		});
		
		//UGC分析tab显示
		var ugcTab = $("#ugcTab").tabs({
			collapsible: true ,
			cache: true ,
			select : function( event, ui ) {
				var index=ui.index;
				var selected=baseTab.tabs('option', 'selected');
				//选择当前显示的tab,则收缩tab
				if(index==selected) return;
				if(index==0){
					showChartUgcClient();
				}
				if(index==1){
					showChartUgcWap();
				}
				if(index==2){
					showChartUgcThird();
				}
			}
		});
		
		//用户属性分析tab显示
		var ugcTab = $("#userAttrTab").tabs({
			collapsible: true ,
			cache: true ,
			select : function( event, ui ) {
				var index=ui.index;
				var selected=baseTab.tabs('option', 'selected');
				//选择当前显示的tab,则收缩tab
				if(index==selected) return;
				if(index==0){
					showChartRegAttr();
				}
				if(index==1){
					showChartLiveAttr();
				}
			}
		});
		
		//运营分析：客户端top10渠道tab显示
		var baseTab = $("#topTab").tabs({
			collapsible: true ,
			cache: true ,
			select : function( event, ui ) {
				var index=ui.index;
				var selected=baseTab.tabs('option', 'selected');
				//选择当前显示的tab,则收缩tab
				if(index==selected) return;
				if(index==0){
					showChartActiveTop();
				}
				if(index==1){
					showChartRegTop();
				}
				if(index==2){
					showChartLiveTop();
				}
			}
		});
		
		//由于使用jquery ui tabs时,影藏的内容里获取不到dom的高度和宽度,而amcharts必须获取图所附属的dom元素的height,会执行错误.
		//添加默认展示，只在显示时加载amcharts
		showChartActive();//基本指标
		showChartUgcClient();//Ugc分析
		showChartRegAttr();//用户属性分析
		showChartActiveTop();//运营分析：客户端top10渠道
		//显示指标定义
		showKpis();
	});
	
	//新增激活趋势图
	function showChartActive() {
		$("#typeTxt").val("active");
		$.ajax({
			url : "${ctx}/loadUserInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField=["newActivateCount,新增激活数","currentCount,当前激活数"];
				options.unit="newActivateCount";
				options.categoryField="generatedTime";
				options.chartData=data;
				options.draw=createLineChart;
				options.chartId="chartActive";
				$("#chartActive").empty();
				SP.loadChart(options);
			}
		});
	}
	//注册用户趋势图
	function showChartRegister() {
		$("#typeTxt").val("register");
		$.ajax({
			url : "${ctx}/loadUserInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField=["all,总注册用户数", "client,客户端注册用户数","wap,wap注册用户数", "other,其他注册用户数"];
				options.unit="other";
				options.categoryField="date";
				options.chartData=data;
				options.draw=createLineChart;
				options.chartId="chartRegitser";
				$("#chartRegitser").empty();
				SP.loadChart(options);
			}
		});
	}
	//活跃用户趋势图
	function showChartLive() {
		$("#typeTxt").val("live");
		$.ajax({
			url : "${ctx}/loadUserInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField=["allDau,3g登录数","clientDau,client登录数","wapDau,wap登录数"];
				options.unit="clientDau";
				options.categoryField="date";
				options.chartData=data;
				options.draw=createLineChart;
				options.chartId="chartLive";
				$("#chartLive").empty();
				SP.loadChart(options);
			}
		});
	}
	//日保留率趋势图
	function showChartDayReserver() {
		$("#typeTxt").val("dayReserver");
		$.ajax({
			url : "${ctx}/loadUserInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField=["activeResRate,激活保留率","registerResRate,注册保留率","liveResRate,活跃保留率"];
				options.unit="%";
				options.categoryField="date";
				options.chartData=data;
				options.draw=createLineDefinedUnitChart;
				options.chartId="chartDayReserver";
				$("#chartDayReserver").empty();
				SP.loadChart(options);
			}
		});
	}
	//周保留率趋势图
	function showChartWeekReserver() {
		$("#typeTxt").val("weekReserver");
		$.ajax({
			url : "${ctx}/loadUserInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField=["activeResRate,激活保留率","registerResRate,注册保留率","liveResRate,活跃保留率"];
				options.unit="%";
				options.categoryField="date";
				options.chartData=data;
				options.draw=createLineDefinedUnitChart;
				options.chartId="chartWeekReserver";
				$("#chartWeekReserver").empty();
				SP.loadChart(options);
			}
		});
	}
	
	//UGC分析-客户端
	function showChartUgcClient() {
		$("#typeTxt").val("mcs");
		$.ajax({
			url : "${ctx}/loadUgcInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField=["ugcDay1,昨天发布次数","ugcDay2,前天发布次数"];
				options.categoryField="ugcName";
				options.chartData=data;
				options.draw=createColumnBarChart;
				options.chartId="chartUgcClient";
				$("#chartUgcClient").empty();
				SP.loadChart(options);
			}
		});
	}
	
	//UGC分析-wap&touch
	function showChartUgcWap() {
		$("#typeTxt").val("wap");
		$.ajax({
			url : "${ctx}/loadUgcInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField=["ugcDay1,昨天发布次数","ugcDay2,前天发布次数"];
				options.categoryField="ugcName";
				options.chartData=data;
				options.draw=createColumnBarChart;
				options.chartId="chartUgcWap";
				$("#chartUgcWap").empty();
				SP.loadChart(options);
			}
		});
	}
	
	//UGC分析-第三方
	function showChartUgcThird() {
		$("#typeTxt").val("third");
		$.ajax({
			url : "${ctx}/loadUgcInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField=["ugcDay1,昨天发布次数","ugcDay2,前天发布次数"];
				options.categoryField="ugcName";
				options.chartData=data;
				options.draw=createColumnBarChart;
				options.chartId="chartUgcThird";
				$("#chartUgcThird").empty();
				SP.loadChart(options);
			}
		});
	}
	//用户属性分析-注册用户
	function showChartRegAttr(){
		$("#typeTxt").val("register");
		//地域分布
		$.ajax({
			url : "${ctx}/loadAreaTopInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField="value";
				options.categoryField="name";
				options.chartData=data;
				options.draw=createPieChartWithTable;
				options.chartId="chartRegArea";
				$("#chartRegArea").empty();
				SP.loadChart(options);
			}
		});
		//阶段分布
		$.ajax({
			url : "${ctx}/loadStageTopInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField="value";
				options.categoryField="name";
				options.chartData=data;
				options.draw=createPieChartWithTable;
				options.chartId="chartRegStage";
				$("#chartRegStage").empty();
				SP.loadChart(options);
			}
		});
	}
	
	//用户属性分析-活跃用户
	function showChartLiveAttr(){
		$("#typeTxt").val("live");
		//地域分布
		$.ajax({
			url : "${ctx}/loadAreaTopInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField="value";
				options.categoryField="name";
				options.chartData=data;
				options.draw=createPieChartWithTable;
				options.chartId="chartLiveArea";
				$("#chartLiveArea").empty();
				SP.loadChart(options);
			}
		});
		//阶段分布
		$.ajax({
			url : "${ctx}/loadStageTopInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField="value";
				options.categoryField="name";
				options.chartData=data;
				options.draw=createPieChartWithTable;
				options.chartId="chartLiveStage";
				$("#chartLiveStage").empty();
				SP.loadChart(options);
			}
		});
	}
	
	//运营分析：客户端top10渠道-新增激活
	function showChartActiveTop() {
		$("#typeTxt").val("active");
		$.ajax({
			url : "${ctx}/loadChannelTopInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField=["day1,昨天激活数","day2,前天激活数"];
				options.categoryField="name";
				options.chartData=data;
				options.draw=createColumnBarChart;
				options.chartId="chartActiveTop";
				$("#chartActiveTop").empty();
				SP.loadChart(options);
			}
		});
	}
	
	//运营分析：客户端top10渠道-注册用户
	function showChartRegTop() {
		$("#typeTxt").val("register");
		$.ajax({
			url : "${ctx}/loadChannelTopInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField=["day1,昨天注册数","day2,前天注册数"];
				options.categoryField="name";
				options.chartData=data;
				options.draw=createColumnBarChart;
				options.chartId="chartRegTop";
				$("#chartRegTop").empty();
				SP.loadChart(options);
			}
		});
	}
	
	//运营分析：客户端top10渠道-活跃用户
	function showChartLiveTop() {
		$("#typeTxt").val("live");
		$.ajax({
			url : "${ctx}/loadChannelTopInfos.action?"+$("#tef").serialize(),
			cache : false,
			dataType : "json",
			success : function(data) {
				var options = {};
				options.valField=["day1,昨天活跃用户数","day2,前天活跃用户数"];
				options.categoryField="name";
				options.chartData=data;
				options.draw=createColumnBarChart;
				options.chartId="chartLiveTop";
				$("#chartLiveTop").empty();
				SP.loadChart(options);
			}
		});
	}
	
	//显示指标定义
	function showKpis() {
		//基本指标定义
		$("#baseKpiLink").hover(
				function(){
					var kpiContent="";
					kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
					kpiContent+="<span style=\"color: #369bd7;\">新增激活：</span> 第一次安装并打开应用的设备数（以设备为判断标准），排除升级或卸载后重装应该的设备. \n";
					kpiContent+="<span style=\"color: #369bd7;\">注册用户：</span> 通过3G端注册的用户数. \n";
					kpiContent+="<span style=\"color: #369bd7;\">活跃用户：</span> 通过3G端登录的用户数. \n";
					kpiContent+="<span style=\"color: #369bd7;\">日保留率：</span> 新增激活的设备/注册用户/登录用户，在第2天，该设备/该用户继续从3G端登录的用户数，占当天新增激活的设备数/注册用户数/登录用户数的比例，即日保留率. \n";
					kpiContent+="<span style=\"color: #369bd7;\">周保留率：</span> 新增激活的设备/注册用户/登录用户，在第7天，该设备/该用户继续从3G端登录的用户数，占当天新增激活的设备数/注册用户数/登录用户数的比例，即周保留率. \n";
					kpiContent+="</pre>"
					$("#baseKpiSpan").ligerTip({
				        content:kpiContent,
				        width:610}
					);
				},
				function(){
					$("#baseKpiSpan").ligerHideTip();
				}
		);
		//用户属性分析
		$("#attrKpiLink").hover(
				function(){
					var kpiContent="";
					kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
					kpiContent+="昨天的注册用户/活跃用户所在省份和阶段的分布情况.";
					kpiContent+="</pre>"
					$("#attrKpiSpan").ligerTip({
				        content:kpiContent,
				        width:350}
					);
				},
				function(){
					$("#attrKpiSpan").ligerHideTip();
				}
		);
		//用户属性分析
		$("#topKpiLink").hover(
				function(){
					var kpiContent="";
					kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
					kpiContent+="新增激活/注册用户/活跃用户，取昨天新增激活数/注册用户数/活跃用户数的top10渠道，并与前天的情况进行对比.";
					kpiContent+="</pre>"
					$("#topKpiSpan").ligerTip({
				        content:kpiContent,
				        width:350}
					);
				},
				function(){
					$("#topKpiSpan").ligerHideTip();
				}
		);
	}
	
</script>
</html>