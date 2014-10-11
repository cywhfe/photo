<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME%>-${ugcModelName}</title>
<%@ include file="/include/script.jsp"%>
<script src="${ctx}/js/export/export.js" type="text/javascript"></script>
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
		<div class="c-right fl">
			     <div class="tablistbox">
					<span class="anas-type">通讯平台_小时明细</span>
					<a id="kpiLink" href="#" onfocus="this.blur();"  class="help-tip"></a><span id="kpiSpan"></span>
						<div style="float:right;width:100px;">
							<button type="button" style="padding:2px 5px 2px;font-size:13px;" onclick="search()" class="btn btn-primary">查询</button>
							<button type="button" style="padding: 2px 5px 2px; font-size: 13px;float:right" onclick="exportData()" class="btn btn-primary">导出</button>
						</div>
				</div>
				<div class="subtitle" style="float:left">
				     <form  class="form-horizontal" action="" id="tef" name="tef" method="post">
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
					     </fieldset>
					     <fieldset style="height:auto">
							   <div class="control-group">
								<label class="control-label" for="focusedInput">聊天类型</label>
								<div class="controls">
								<select multiple="multiple" name="clientQueryVo.chat_type" size="5" id="chat_type" class="input-medium focused" >
									<option value="1">单聊</option>
									<option value="2">群聊</option>
								</select>
								</div>
							  </div>
							  <div class="control-group">
							  	<label class="control-label" for="focusedInput">发送终端</label>
								<div class="controls">
									<select multiple="multiple" name="clientQueryVo.plat_form" size="5" id="plat_form" class="input-medium focused" >
										<option value="1">客户端</option>
										<option value="2">webpager</option>
										<option value="3">人人桌面</option>
									</select>
								</div>
							  </div>
							  <div class="control-group">
							    <label class="control-label" for="focusedInput">消息类型</label>
								<div class="controls">
									<select multiple="multiple" name="clientQueryVo.msg_type" size="5" id="msg_type" class="input-medium focused" >
										<option value="1">文本</option>
										<option value="2">图像</option>
										<option value="3">音频</option>
										<option value="4">表情</option>
									</select>	
								</div>
							  </div>
					     </fieldset>
		 			 </form>
			    </div>
			    
			<div id="chartdiv_column" style="width: 100%; height: 400px;float:left"></div>
			<div id="maingrid" style="margin: 0; padding: 0;float:left;width:100%;margin-top:5px">
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
var oTable;
$(function(){
    $("#chat_type").multiselect({
 		 checkAllText : "全选",
 		 uncheckAllText :"取消",
 		 noneSelectedText : "",
 		 minWidth : 80,
 		 selectedList: 10 // 0-based index 
    });
    $("#plat_form").multiselect({
		 checkAllText : "全选",
		 uncheckAllText :"取消",
		 noneSelectedText : "",
		 minWidth : 80,
		 selectedList: 10 // 0-based index 
    });
    $("#msg_type").multiselect({
		 checkAllText : "全选",
		 uncheckAllText :"取消",
		 noneSelectedText : "",
		 minWidth : 80,
		 selectedList: 10 // 0-based index 
    });
	 
	var yDay = getFormatDate(new Date().getTime());
	$("#d4311").val(yDay);
	$("#d4312").val(yDay);
	options.sAjaxSource="${ctx}/tx/loadTxPlatClientData.action";
	options.bServerSide=false;
	options.aoColumns=[
	                   { "sTitle": "日期", "sClass": "center" ,"mDataProp": "date","bSortable":true,"sWidth":"100px"},
	                   { "sTitle": "使用用户数", "sClass": "center" ,"mDataProp": "user_num","bSortable":false},
	                   { "sTitle": "发送量", "sClass": "center" ,"mDataProp": "send_num","bSortable":false}
	                   ];
	options.fnInitComplete=tableInitCallback;
	oTable=SP.loadTableInfo($("#contentlist"),options,$("#tef"));
	//显示指标定义
	$("#kpiLink").hover(
			function(){
				var kpiContent="";
				kpiContent+="<pre style=\"font-size: 13px; color: #333; font-family: '微软雅黑', '宋体', Arial, sans-serif;background-color:transparent;border: 0px;\">"
				kpiContent+="提供0-24时各时段内使用聊天的人数及消息发送量.\n支持区分聊天类型、发送终端类型、消息类型的查询.";
				kpiContent+="</pre>"
				$("#kpiSpan").ligerTip({
			        content:kpiContent,
			        width:350}
				);
			},
			function(){
				$("#kpiSpan").ligerHideTip();
			}
	);
 });
/**
 * 查询
 */
function search(){
	if(!SP.checker($("#tef"))){
		return false;
	}
	if(!$("input[name='begin_date']").val() || $("input[name='begin_date']").val() == ""
			|| !$("input[name='end_date']").val() || $("input[name='end_date']").val() == ""){
		alert("必须输入时间查询！");
	}
	options.aoColumns=[
	                   { "sTitle": "日期", "sClass": "center" ,"mDataProp": "date","bSortable":true,"sWidth":"100px"}
	                ];
	//聊天类型
	if($("[name='clientQueryVo.chat_type']").val()!=null){
		options.aoColumns.push({ "sTitle": "聊天类型", "sClass": "center" ,"mDataProp": "chat_type","fnRender": function (obj) {
     	   if(obj){
    		   if(obj.aData.chat_type==1) return "单聊";
    		   if(obj.aData.chat_type==2) return "群聊";
    	   }else{
    		   return "";
    	   }
     	  }
	});
	}
	//发送终端
	if($("[name='clientQueryVo.plat_form']").val()!=null){
		options.aoColumns.push({ "sTitle": "发送终端", "sClass": "center" ,"mDataProp": "plat_form","fnRender": function (obj) {
	     	   if(obj){
	    		   if(obj.aData.plat_form==1) return "客户端";
	    		   if(obj.aData.plat_form==2) return "webpager";
	    		   if(obj.aData.plat_form==3) return "人人桌面";
	    	   }else{
	    		   return "";
	    	   }
	     	  }
		});
	}
	//消息类型
	if($("[name='clientQueryVo.msg_type']").val()!=null){
		options.aoColumns.push({ "sTitle": "消息类型", "sClass": "center" ,"mDataProp": "msg_type","fnRender": function (obj) {
	     	   if(obj){
	    		   if(obj.aData.msg_type==1) return "文本";
	    		   if(obj.aData.msg_type==2) return "图像";
	    		   if(obj.aData.msg_type==3) return "音频";
	    		   if(obj.aData.msg_type==4) return "表情";
	    	   }else{
	    		   return "";
	    	   }
	     	  }
		});
	}
	options.aoColumns.push({ "sTitle": "使用用户数", "sClass": "center" ,"mDataProp": "user_num","bSortable":false});
	options.aoColumns.push({ "sTitle": "发送量", "sClass": "center" ,"mDataProp": "send_num","bSortable":false});
	
	oTable.fnDestroy();
	$("#contentlist").empty();
    SP.loadTableInfo($("#contentlist"),options,$("#tef"));
    options.fnInitComplete();
}
/**
 * 导出表格
 */
 function exportData(){
		$("#tef").attr("action","${ctx}/tx/exportClientReport.action");
		$("#tef").submit();
	}

/*
 *表格初始化完成回调函数 
 */
function tableInitCallback(){
	$.ajax({
	    url: "${ctx}/tx/loadTxPlatClientChartData.action?"+$("#tef").serialize(),
	    dataType: 'json',type: 'post',
	    success: function (res){
	    	var options4={}
	    	options4.chartData=res;
	        options4.chartId="chartdiv_column";
	        options4.categoryField="date";
	        options4.valField=[];
	        options4.draw=createLineChart;
	        $("#chartdiv_column").empty();
	        var chatArray=[0];
	        var platArray=[0];
	        var msgArray=[0];
	      //聊天类型
	    	if($("[name='clientQueryVo.chat_type']").val()!=null){
	    		chatArray=($("[name='clientQueryVo.chat_type']").val()+"").split(",");
	    	}
	    	//发送终端
	    	if($("[name='clientQueryVo.plat_form']").val()!=null){
	    		platArray=($("[name='clientQueryVo.plat_form']").val()+"").split(",");
	    	}
	    	//消息类型
	    	if($("[name='clientQueryVo.msg_type']").val()!=null){
	    		msgArray=($("[name='clientQueryVo.msg_type']").val()+"").split(",");
	    	}
	    	//拼装valField  start
	    	if(chatArray[0]==0 && platArray[0]==0 && msgArray[0]==0){
	    		options4.valField=["user_num,汇总使用人数","send_num,汇总发送量"];
	    		options4.unit="user_num";
	    	}else{
	    		//选择了维度，则按选择的维度组合拼接valField
		        for(var i=0;i<chatArray.length;i++){
		        	for(var j=0;j<platArray.length;j++){
		        		for(var k=0;k<msgArray.length;k++){
		        			var valField="";
		        			var valFieldDesc="";
		        			if(chatArray[i]!=0){
		        				valField=valField+("chat"+chatArray[i]);
		        				if(valFieldDesc==""){
			        				valFieldDesc=(chatArray[i]==1?"单聊":(chatArray[i]==2?"群聊":""));
		        				}else{
		        					valFieldDesc=valFieldDesc+"-"+(chatArray[i]==1?"单聊":(chatArray[i]==2?"群聊":""));
		        				}
		        			}
		        			if(platArray[j]!=0){
		        				valField=valField+("plat"+platArray[j]);
		        				if(valFieldDesc==""){
		        					valFieldDesc=(platArray[j]==1?"客户端":(platArray[j]==2?"webpager":(platArray[j]==3?"人人桌面":"")));
		        				}else{
		        					valFieldDesc=valFieldDesc+"-"+(platArray[j]==1?"客户端":(platArray[j]==2?"webpager":(platArray[j]==3?"人人桌面":"")));
		        				}
		        			}
		        			if(msgArray[k]!=0){
		        				valField=valField+("msg"+msgArray[k]);
		        				if(valFieldDesc==""){
		        					valFieldDesc=(msgArray[k]==1?"文本":(msgArray[k]==2?"图像":(msgArray[k]==3?"音频":(msgArray[k]==4?"表情":""))));
		        				}else{
		        					valFieldDesc=valFieldDesc+"-"+(msgArray[k]==1?"文本":(msgArray[k]==2?"图像":(msgArray[k]==3?"音频":(msgArray[k]==4?"表情":""))));
		        				}
		        			}
		        			if(!options4.unit){
			        			options4.unit=valField+"user_num";
		        			}
		        			options4.valField.push(valField+"send_num,"+valFieldDesc+"-发送量");
		        			options4.valField.push(valField+"user_num,"+valFieldDesc+"-使用人数");
		        		}
		        	}
		        }
	    	}
	      	//拼装valField  end
	    	SP.loadChart(options4);
	    	}
	    });
}

</script>
