
var defaut=new Array();
defaut[0]=0;
defaut[1]="不区分";

var be = getFormatDate(new Date().getTime()-(30*24*3600*1000));
var en = getFormatDate(new Date().getTime());
$("#d4311").val(be);
$("#d4312").val(en);
//additional functions for data table
$.fn.dataTableExt.oApi.fnPagingInfo = function ( oSettings )
{
	return {
		"iStart":         oSettings._iDisplayStart,
		"iEnd":           oSettings.fnDisplayEnd(),
		"iLength":        oSettings._iDisplayLength,
		"iTotal":         oSettings.fnRecordsTotal(),
		"iFilteredTotal": oSettings.fnRecordsDisplay(),
		"iPage":          Math.ceil( oSettings._iDisplayStart / oSettings._iDisplayLength ),
		"iTotalPages":    Math.ceil( oSettings.fnRecordsDisplay() / oSettings._iDisplayLength )

	};
}
$.extend($.fn.dataTable.defaults.oLanguage, {
	"sLengthMenu": "每页显示 _MENU_ 条记录",
	"sZeroRecords": "没有检索到数据",
	"sEmptyTable": "无数据",
	"sInfoEmpty": "0条记录",
	"sSearch":"搜索",
	"sInfo": "当前数据从第 _START_ 到第 _END_ 条;总共 _TOTAL_ 条记录",
	"sInfoEmtpy": "没有数据",
	"sProcessing": "正在加载数据...",
	"sInfoFiltered": "(从 _MAX_ 条中筛选出)",
	"oPaginate": {
		"sFirst": "首页",
		"sPrevious": "前页",
		"sNext": "后页",
		"sLast": "尾页"
	}
});
$.extend($.fn.dataTable.defaults, {
    "bRetrieve":true,
    "bDestroy":false,
    "sPaginationType":"bootstrap",
    "bRetrieve":true,
	 "sServerMethod": "POST",
	 "bProcessing": true,
	 "iDisplayLength":30,
	 "aLengthMenu":[[5,10,15,20,30,50,100, -1],[5,10,15,20,30,50,100,"ALL"]], // change per page values here
	 "bDeferRender":true,
	 "bServerSide": true 
});

//获取开始时间
function timeFocusBegin(){
	WdatePicker({isShowClear:false,maxDate:'#F{$dp.$D(\'d4312\')||\'%y-%M-{%d}\'}',dateFmt:'yyyy-MM-dd'});
}
//获取结束时间
function timeFocusEnd(){
	WdatePicker({isShowClear:false,minDate:'#F{$dp.$D(\'d4311\')}',maxDate:'%y-%M-{%d}',dateFmt:'yyyy-MM-dd'});
}

//获取一天之前时间
function timeFocusBeginOneDay(){
	WdatePicker({isShowClear:false,maxDate:'#F{$dp.$D(\'d4312\')||\'%y-%M-{%d}\'}',dateFmt:'yyyy-MM-dd'});
}

//获取开始时间(月)
function timeMonthFocusBegin(){
	WdatePicker({isShowClear:false,maxDate:'#F{$dp.$D(\'d4312\')||\'%y-%M\'}',dateFmt:'yyyy-MM'});
}

//获取结束时间(月)
function timeMonthFocusEnd(){
	WdatePicker({isShowClear:false,minDate:'#F{$dp.$D(\'d4311\')}',maxDate:'%y-%M\'}',dateFmt:'yyyy-MM'});
}

function createColumnChart(chartdiv_columnID, columnChartData,categoryField,valField) {
	 columnChartData=columnChartData.sort(function(a,b){return a[""+valField+""]>b[""+valField+""]?-1:a[""+valField+""]==b[""+valField+""]?0:1});
	  var temp;
	  if(columnChartData.length>=30){
	    temp=columnChartData.slice(0,30);
	  }else{
	    temp=columnChartData;
	  }
	  var chartDataObj = getColumnUnit(temp, valField);
	  // SERIAL CHART
	  columnChart = new AmCharts.AmSerialChart();
	  columnChart.dataProvider = chartDataObj.chartData;
	  columnChart.categoryField = categoryField;
	  columnChart.startDuration = 1;
	  // AXES
	  var categoryAxis = columnChart.categoryAxis;
	  categoryAxis.labelRotation = 45; // this line makes category values to be
	  // rotated
	  categoryAxis.gridAlpha = 0;
	  categoryAxis.fillAlpha = 1;
	  categoryAxis.fillColor = graphBgColor;
	  categoryAxis.gridPosition = "start";

	  // value
	  valueAxis = new AmCharts.ValueAxis();
	  valueAxis.dashLength = 5;
	  valueAxis.title = "单位：" + chartDataObj.unit;
	  valueAxis.axisAlpha = 0;
	  // /valueAxis.unit=unit;
	  columnChart.addValueAxis(valueAxis);
	  // GRAPH
	  graph = new AmCharts.AmGraph();
	  graph.valueField = valField;
	  graph.title = "[[category]]";
	//  graph.balloonText = "[[category]] "+ $("#select-norm").find("option:selected").text() + ": [[value]]";
	    
	  graph.type = "column";
	  graph.lineAlpha = 0;
	  graph.fillAlphas = 1;
	  graph.fillColors = graphColor;
	  columnChart.addGraph(graph);
	  // WRITE
	  columnChart.write(chartdiv_columnID);
	}

function createLineChart(chartdiv_columnID, columnChartData,categoryField,valField,unit) {
	$("#" + chartdiv_columnID).empty();
	if(null==columnChartData||""==columnChartData){
		return;
	}
	
	var chartDataObj = getUnit(columnChartData,valField, unit);
	chartDataObj.chartData.sort(function(a,b){return a[""+categoryField+""]>b[""+categoryField+""] ? 1 : -1 ;});
	
	//1.排序
	var linechart = new AmCharts.AmSerialChart();
	linechart.dataProvider = chartDataObj.chartData;
	linechart.categoryField = categoryField;
	linechart.marginTop = 0;
	linechart.startDuration = 1;
	
	  // AXES
	  var categoryAxis = linechart.categoryAxis;
	  categoryAxis.labelRotation = 45; // this line makes category values to be
	  // rotated
	  categoryAxis.gridAlpha = 0;
	  categoryAxis.fillAlpha = 1;
	  categoryAxis.fillColor = graphBgColor;
	  categoryAxis.gridPosition = "start";

	var distanceAxis = new AmCharts.ValueAxis();
	distanceAxis.title = "单位：" + chartDataObj.unit;
	distanceAxis.gridAlpha = 0;
	distanceAxis.position = "left";
	distanceAxis.inside = true;
	distanceAxis.axisThickness = 2;
	distanceAxis.axisColor = "#72B054";
	linechart.addValueAxis(distanceAxis);

	for(var i=0;i<valField.length;i++){
			var f=valField[i].split(",");
			var distanceGraph = new AmCharts.AmGraph();
			distanceGraph.valueField = f[0];
			distanceGraph.title = f[1];
			distanceGraph.type = "line";
			distanceGraph.lineThickness = 1;
			distanceGraph.valueAxis = distanceAxis; // indicate which axis should be
			distanceGraph.balloonText = "[["+categoryField+"]]"+ " : "+"[["+f[0]+"]]";
			distanceGraph.legendValueText =  "[["+categoryField+"]]"+ " : "+"[["+f[0]+"]]";
			distanceGraph.bullet = "square";
			linechart.addGraph(distanceGraph);
		}
	 var legend = new AmCharts.AmLegend();
     legend.bulletType = "round";
     legend.equalWidths = false;
     legend.valueWidth = 120;
     legend.color = "#000000";
     legend.switchType = "v";
     linechart.addLegend(legend);
	// WRITE
	linechart.write(chartdiv_columnID);
}
//自定义单位名称的线性趋势图
function createLineDefinedUnitChart(chartdiv_columnID, columnChartData,categoryField,valField,unit) {
	$("#" + chartdiv_columnID).empty();
	if(null==columnChartData||""==columnChartData){
		return;
	}
	
	columnChartData.sort(function(a,b){return a[""+categoryField+""]>b[""+categoryField+""] ? 1 : -1 ;});
	
	//1.排序
	var linechart = new AmCharts.AmSerialChart();
	linechart.dataProvider = columnChartData;
	linechart.categoryField = categoryField;
	linechart.marginTop = 0;
	linechart.startDuration = 1;
	
	  // AXES
	  var categoryAxis = linechart.categoryAxis;
	  categoryAxis.labelRotation = 45; // this line makes category values to be
	  // rotated
	  categoryAxis.gridAlpha = 0;
	  categoryAxis.fillAlpha = 1;
	  categoryAxis.fillColor = graphBgColor;
	  categoryAxis.gridPosition = "start";

	var distanceAxis = new AmCharts.ValueAxis();
	distanceAxis.title = "单位：" + unit;
	distanceAxis.gridAlpha = 0;
	distanceAxis.position = "left";
	distanceAxis.inside = true;
	distanceAxis.axisThickness = 2;
	distanceAxis.axisColor = "#72B054";
	linechart.addValueAxis(distanceAxis);

	for(var i=0;i<valField.length;i++){
			var f=valField[i].split(",");
			var distanceGraph = new AmCharts.AmGraph();
			distanceGraph.valueField = f[0];
			distanceGraph.title = f[1];
			distanceGraph.type = "line";
			distanceGraph.lineThickness = 1;
			distanceGraph.valueAxis = distanceAxis; // indicate which axis should be
			distanceGraph.balloonText = "[["+categoryField+"]]"+ " : "+"[["+f[0]+"]]";
			distanceGraph.legendValueText =  "[["+categoryField+"]]"+ " : "+"[["+f[0]+"]]";
			distanceGraph.bullet = "square";
			linechart.addGraph(distanceGraph);
		}
	 var legend = new AmCharts.AmLegend();
     legend.bulletType = "round";
     legend.equalWidths = false;
     legend.valueWidth = 120;
     legend.color = "#000000";
     legend.switchType = "v";
     linechart.addLegend(legend);
	// WRITE
	linechart.write(chartdiv_columnID);
}

//横向对比图
function createColumnBarChart(chartdiv_columnID, columnChartData,categoryField,valField) {
	$("#" + chartdiv_columnID).empty();
	if(null==columnChartData||""==columnChartData){
		return;
	}
	var colors = new Array("#ADD981","#81acd9","#FF0F00", "#04D215", "#FFFF00", "#B0DE09", "#754DEB");
	var chart = new AmCharts.AmSerialChart();
    chart.dataProvider = columnChartData;
    chart.colors=colors;
    chart.categoryField = categoryField;
    chart.startDuration = 1;
    chart.plotAreaBorderColor = "#DADADA";
    chart.plotAreaBorderAlpha = 1;
    // this single line makes the chart a bar chart          
    chart.rotate = true;
	// AXES
    // Category
    var categoryAxis = chart.categoryAxis;
    categoryAxis.fillColor = graphBgColor;
    categoryAxis.gridPosition = "start";
    categoryAxis.gridAlpha = 0.1;
    categoryAxis.axisAlpha = 0;

    // Value
    var valueAxis = new AmCharts.ValueAxis();
    valueAxis.axisAlpha = 0;
    valueAxis.gridAlpha = 0.1;
    valueAxis.position = "top";
    chart.addValueAxis(valueAxis);

	for(var i=0;i<valField.length;i++){
		var f=valField[i].split(",");
		var graph = new AmCharts.AmGraph();
	    graph.type = "column";
	    graph.title = f[1];
	    graph.valueField = f[0];
	    graph.balloonText = "[["+categoryField+"]]"+ " : "+"[["+f[0]+"]]";
	    graph.legendValueText =  "[["+categoryField+"]]"+ " : "+"[["+f[0]+"]]";
	    graph.lineAlpha = 0;
	    graph.fillAlphas = 1;
	    chart.addGraph(graph);
	}
	 var legend = new AmCharts.AmLegend();
     legend.equalWidths = false;
     legend.valueWidth = 120;
     legend.color = "#000000";
     legend.switchType = "v";
     legend.position = "bottom";
     chart.addLegend(legend);
	// WRITE
	 chart.write(chartdiv_columnID);
}
//生成饼图，右边表格数据显示
function createPieChartWithTable(chartdiv_pieID, columnChartData, categoryField,valueField) {
	//排序
	columnChartData.sort(function(a,b){return a[""+valueField+""]>b[""+valueField+""] ? 1 : -1 ;}); 
	// PIE CHART
	var chart = new AmCharts.AmPieChart();
    chart.dataProvider = columnChartData;
    chart.titleField = categoryField;
    chart.valueField = valueField;
	chart.labelRadius = -30;
	//饼图上不显示，避免太挤
	//chart.labelText = "[[percents]]%";
    chart.labelText = "";
    //设置颜色
    var colors = new Array("#A99BBD", "#4572A7", "#AA4643", "#89A54E", "#71588F",
    		"#4198AF", "#DB843D", "#93A9CF", "#D19392", "#B9CD96", "#0066ff",
    		"#660033", "#FF0F00", "#754DEB", "#CD0D74", "#8A0CCF", "#2A0CD0",
    		"#FF0F00", "#04D215", "#FFFF00", "#B0DE09", "#754DEB", "#04D215",
    		"#FFFF00", "#B0DE09");
    chart.colors = colors;

	// LEGEND
    legend = new AmCharts.AmLegend();
    legend.align = "center";
    legend.position="right";
    legend.markerType = "square";
    legend.reversedOrder=true;
    legend.switchType = "v";
    chart.balloonText = "[[title]]:[[percents]]%";
    chart.addLegend(legend);
	// WRITE
    chart.write(chartdiv_pieID);

}

//chartdiv_columnID, columnChartData,categoryField,valField
function createUserGenerate_LineChart(chartdiv_columnID, columnChartData,categoryField,valField) {
	$("#" + chartdiv_columnID).empty();
	if(null==columnChartData||""==columnChartData){
		return;
	}
	
	var chartDataObj = getUserActivateColumnUnit(columnChartData, 'newActivateCount');
	chartDataObj.chartData.sort(function(a,b){return a['generatedTime']>b['generatedTime'] ? 1 : -1 ;});
	
	//1.排序
	var linechart = new AmCharts.AmSerialChart();
	linechart.dataProvider = chartDataObj.chartData;
	linechart.categoryField = categoryField;
	linechart.marginTop = 0;
	linechart.startDuration = 1;

	var distanceAxis = new AmCharts.ValueAxis();
	distanceAxis.title = "单位：" + chartDataObj.unit;
	distanceAxis.gridAlpha = 0;
	distanceAxis.position = "left";
	distanceAxis.inside = true;
	distanceAxis.axisThickness = 2;
	distanceAxis.axisColor = "#72B054";
	linechart.addValueAxis(distanceAxis);

	var distanceGraph = new AmCharts.AmGraph();
	distanceGraph.valueField = "newActivateCount";
	distanceGraph.title = "新增激活数";
	distanceGraph.type = "line";
	distanceGraph.lineThickness = 1;
	distanceGraph.valueAxis = distanceAxis; // indicate which axis should be
	distanceGraph.balloonText = "[[generatedTime]]"+ " : "+"[[newActivateCount]]";
	distanceGraph.legendValueText =  "[[generatedTime]]"+ " : "+ "[[newActivateCount]]";
	distanceGraph.bullet = "square";
	linechart.addGraph(distanceGraph);
	
	 var legend = new AmCharts.AmLegend();
     legend.bulletType = "round";
     legend.equalWidths = false;
     legend.valueWidth = 120;
     legend.color = "#000000";
     legend.switchType = "v";
     linechart.addLegend(legend);
	// WRITE
	linechart.write(chartdiv_columnID);
}

function getUnit(chartDataTemp,valField, itemName) {
	 var chartData = cloneOpr.cloneArr(chartDataTemp);
	 chartData=chartData.sort(function(a,b){return a[itemName]>b[itemName]?-1:a[itemName]==b[itemName]?0:1});
	 if(chartData[0]){
		 var size = chartData.length;
		 var midseize = parseInt(size/2);
		 var midData = eval('chartData[midseize].' + itemName);
		 midData=(midData+"").replace(/\,/g,'');
		 var midLength = (midData+"").length;
		 unit = "";
		 var unitNum=1000;
		 if(midLength<=4){
			 unit="千";
			 unitNum=1000;
		 }
		 if(midLength==5){
			 unit="万";
			 unitNum=10000;
		 }
		 if(midLength==6){
			 unit="十万";
			 unitNum=100000;
		 }
		 if(midLength==7){
			 unit="百万";
			 unitNum=1000000;
		 }
		 if(midLength==8){
			 unit="千万";
			 unitNum=10000000;
		 }
		 if(midLength>=9){
			 unit="亿";
			 unitNum=100000000;
		 }
		 for (i = 0; i < size; i++) {
			 for(var j=0;j<valField.length;j++){
					var f=valField[j].split(",");
					  var valuepv = (chartData[i][""+f[0]+""]+"").replace(/\,/g,'');
				        chartData[i][""+f[0]+""] = (valuepv / unitNum).toFixed(2);
			 }
		 }
	 }
	  return new chartDataObj(chartData, null, unit);
  }

function getUserActivateColumnUnit(chartDataTemp, itemName) {
	 var chartData = cloneOpr.cloneArr(chartDataTemp);
	 chartData=chartData.sort(function(a,b){return a[itemName]>b[itemName]?-1:a[itemName]==b[itemName]?0:1});
	 var size = chartData.length;
	 var midseize = parseInt(size/2);
	 var midData = chartData[midseize].newActivateCount;
	 var midLength = (midData+"").length;
	 unit = "";
	 var unitNum=1000;
	 if(midLength<=4){
		 unit="千";
		 unitNum=1000;
	 }
	 if(midLength==5){
		 unit="万";
		 unitNum=10000;
	 }
	 if(midLength==6){
		 unit="十万";
		 unitNum=100000;
	 }
	 if(midLength==7){
		 unit="白万";
		 unitNum=1000000;
	 }
	 if(midLength==8){
		 unit="千万";
		 unitNum=10000000;
	 }
	 if(midLength>=9){
		 unit="亿";
		 unitNum=100000000;
	 }
	 for (i = 0; i < size; i++) {
	        var valuepv = chartData[i]["newActivateCount"];
	        chartData[i]["newActivateCount"] = (valuepv / unitNum).toFixed(2);
	//        var valueuv = chartData[i]["newActivateCount"];
	  //      chartData[i]["newActivateCount"] = (valueuv / unitNum).toFixed(2);
	 }
	  return new chartDataObj(chartData, null, unit);
  }



function getFormatDate(date, dateformat)
{
date = new Date(date);
    if (isNaN(date)) return null;
    var format = dateformat||"yyyy-MM-dd";
    var o = {
        "M+": date.getMonth() + 1,
        "d+": date.getDate(),
        "h+": date.getHours(),
        "m+": date.getMinutes(),
        "s+": date.getSeconds(),
        "q+": Math.floor((date.getMonth() + 3) / 3),
        "S": date.getMilliseconds()
    }
    if (/(y+)/.test(format))
    {
        format = format.replace(RegExp.$1, (date.getFullYear() + "")
    .substr(4 - RegExp.$1.length));
    }
    for (var k in o)
    {
        if (new RegExp("(" + k + ")").test(format))
        {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
        : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}
function getTimeBetween(begin,end){
	if(begin && end){
		begin = begin.replace(/\-/g,'\/');
		end = end.replace(/\-/g,'\/');
		var b= parseInt(new Date(begin+" 00:00:00").getTime()/1000/60/60/24);
		var e=parseInt(new Date(end+" 00:00:00").getTime()/1000/60/60/24);
		return  parseInt(e-b);
	}
	return 0;
}

function loadSelInfo(){
}

function FunnelCanvas(funnel,title,labelArray,dataArray){
	  this.funnelWidth = parseInt($("#"+funnel).css("width"));//获取画布div的宽度
	  this.funnelHeight = parseInt($("#"+funnel).css("height"));//获取画布div的高度
	//  this.title = "转换率漏斗图";
	 // this.labelArray = new Array("剔除跳出","单品页","已发货");
	//  this.dataArray  = new Array(283059,4806,3569);

	  //画图的标题
	  this.drawTitle = function(){   
	   var jgTitle = new jsGraphics(funnel);//标题对象
	   var translation = this.funnelHeight*0.02;//向下平移距离   
	   jgTitle.setFont("arial","18px",Font.BOLD); 
	   jgTitle.drawString(title,50,translation-3);
	   jgTitle.paint();
	  }

	  //画漏斗图
	  this.drawFunnel = function(){
	   var jg = new jsGraphics(funnel);
	   var translation = this.funnelHeight*0.02;//向下平移距离
	   var width = this.funnelWidth * 0.8;
	   var max = dataArray[0];
	   for(i=0;i<dataArray.length;i++){
	    jg.setColor("#92d03c");
	    var factWidth =dataArray[i]*width/max; 
	    var totalBi = Math.round(dataArray[i]/max*10000)/100.0;
	    var x1 = (this.funnelWidth - factWidth)/2;   
	    var factHeight = this.funnelHeight/dataArray.length - 20;
	    var y0 = translation + 20;
	    var y1 = y0 + factHeight * i + 20*i;  
	    
	    if(factWidth<1){
	     factWidth = 1;
	    }
	    jg.drawImage("../img/green_back.png", x1,y1,factWidth,34);
	    jg.setColor("#000000");
	    jg.drawString(labelArray[i]+"  "+addCommas(dataArray[i])+"",width+30,y1+10);
	    
	    if(i>=1){
	     var beforeBi = Math.round(dataArray[i]/dataArray[i-1]*10000)/100.0;
	     jg.drawString(beforeBi+"%",this.funnelWidth/2-20,y1-10);
	     jg.setColor("#CCCCCC");
		    jg.setStroke(Stroke.DOTTED);
		    jg.drawLine(x1+factWidth,y1+29,this.funnelWidth+80,y1+29);
		    
		    jg.setColor("#999999");
		    jg.setStroke(3);
		    y1_a = y0 + factHeight * (i-1) + 20*(i-1); 
		   var x1_a = (this.funnelWidth - (dataArray[i-1]*width/max))/2;
		    jg.drawLine(x1+factWidth-5,y1,x1_a+(dataArray[i-1]*width/max)-5,y1_a+33);
		    
		    jg.drawLine(x1,y1,x1_a,y1_a+33);
	    }
	   
	   }
	   jg.paint();
	  }

	  //全部画出来
	  this.paint = function(){   
	   this.drawTitle();
	   this.drawFunnel();
	  }
	 }

function addCommas(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = (x.length > 1)?('.' + x[1]): '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}
function checkParamters(){
	var boo=false;
	var ar=false;
	if(!($("#onChannelInput")[0].disabled) && ($("#onChannelInput").val()!="")){
		ar=true;;
	}else if(!($("#fourChannelInput")[0].disabled) && ($("#fourChannelInput").val()!="")){
		ar=true;
	}else if(!($("#fromChannelInput")[0].disabled) && ($("#fromChannelInput").val()!="") ){
		ar=true;
	}
	
	/* 用户属性与设备、平台、appid、版本不互斥
	if($("#appidsel").val()!="-1" || $("#device_id").val()!="-1" || $("#os_id").val()!="-1" ){
		ar=true;
	}
	if($("#client_version").val()!=null && $("#client_version").val()!="-1"){
		ar=true;
	}
	if($("#app_id").val()!=null && $("#app_id").val()!="-1"){
		ar=true;
	}
	if($("#isautos").val()!=null && $("#isautos").val()!="0"){
		ar=true;
	}*/
	if($("#user_attr").val()!=null && $("#user_attr").val()!="0"){
		boo=true;
	}
	if(boo && ar){
		alert("暂不支持用户属性和渠道同时选择！");
		return false;
	}
	return true;
}




