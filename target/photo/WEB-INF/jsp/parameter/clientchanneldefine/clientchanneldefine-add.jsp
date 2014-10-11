<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-访问渠道</title>
<%@ include file="/include/script.jsp"%>
 <link type="text/css" rel="stylesheet" href="${ctx}/js/formValidator/style/validator.css"></link>
<script src="${ctx}/js/jquery.form.js" type="text/javascript"></script>
<script src="${ctx}/js/formValidator/formValidator-4.0.1.min.js" type="text/javascript"></script>
<script src="${ctx}/js/formValidator/formValidatorRegex.js" type="text/javascript"></script>
 <script type="text/javascript">
$(document).ready(function(){
	changeChannelType();
	$.formValidator.initConfig({formid:"dataForm",onerror:function(msg){ },onsuccess:function(data){ return true}});
	$("#dataFormSubmit").click(function(){
		if(jQuery.formValidator.pageIsValid()){
			$("#dataForm").ajaxSubmit({
				success : function(data) {
					var jsonData = toJsonObject(data);
					if (jsonData.success) {
						$.ligerDialog.confirm("操作成功，是否返回？", function(yes) {
							if(yes){
				       		 window.location.href="${ctx}/parameter/clientChannelDefineIndex.action";
							}
						});
					} else {
						LG.showError(jsonData.msg);
					}

				},
				error : function(errMsg) { 
					LG.showAjaxError(xhr, status, errMsg);
				}
			});
		}  
	});
 
	$("#name").formValidator({onShow:"请输入渠道名称",onFocus:"渠道名称不能为空",onCorrect:"输入正确"}).inputValidator({min:2,max:40,onError:"渠道名称最多输入40个字符,请确认"});
	 
  });
function toJsonObject(jsonString) {
	if (typeof jsonString == 'object')
		return jsonString;
	jsonString = jsonString.replace(/^(?:\<pre[^\>]*\>)?(\{.*\})(?:\<\/pre\>)?$/ig, "$1");
	return eval('(' + jsonString + ')');
}	

//getDeviceId
function getClientChannelDefineByLevel(channelType){
		$.getJSON("${ctx}/parameter/getClientChannelDefineByLevel.action",{"channelType" :channelType},
			function(data){
			   if(data.list!=null){
				   $("#parent_id").empty();
					for ( var i = 0; i < data.list.length; i++) {
						$("#parent_id").append("<option value='"+data.list[i].id+"'>"+ data.list[i].name+ "</option>");
					}
				} 
			});
}

function checkFromIdExist() {
	if($("#from_id").val !== "undefined") {
	var from_id = $("#from_id").val();
	$.getJSON("${ctx}/parameter/clientChannelDefineIsExistFromId.action",{"from_id" : from_id},
		function(data){
		if(data.isHave) {
			$("#from_id").focus();
			$("#from_idTip").attr("class","onError");
			$("#from_idTip").text("from_id已存在，请更改");
		} else {
			$("#from_idTip").text("请输入from_id,限制整数");
		}
	});	
	}
} 


function changeChannelType(){
	if($("#channelType").val()=='level1'){
		$("#parent_id_tr").hide();
		$("#from_id_tr").hide();
		$("#descinfo_tr").hide();
		$("#parent_id").attr("disabled",true);
		$("#from_id").attr("disabled",true);
		$("#descinfo").attr("disabled",true);

	}
	if($("#channelType").val()=='level2'){
		$("#parent_id_tr").show();
		$("#from_id_tr").hide();
		$("#descinfo_tr").hide();
		
		$("#parent_id").attr("disabled",false);
		$("#from_id").attr("disabled",true);
		$("#descinfo").attr("disabled",true);
		getClientChannelDefineByLevel('level1');
	}
	if($("#channelType").val()=='level3'){
		$("#parent_id_tr").show();
		$("#from_id_tr").hide();
		$("#descinfo_tr").hide();
		$("#parent_id").attr("disabled",false);
		$("#from_id").attr("disabled",true);
		$("#descinfo").attr("disabled",true);
		getClientChannelDefineByLevel('level2');
	}
	if($("#channelType").val()=='level4'){
		$("#parent_id_tr").show();
		$("#from_id_tr").show();
		$("#descinfo_tr").show();
		
		$("#parent_id").attr("disabled",false);
		$("#from_id").attr("disabled",false);name
		$("#descinfo").attr("disabled",false);
		getClientChannelDefineByLevel('level3');
	}
}

</script>		
<style>
.tbldt-bd td {
    border-bottom: 0 solid #CCCCCC;
    border-right: 0 solid #CCCCCC;
    padding: 10px;
    text-align: left;
}
  
</style>
</head>
	<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<form action="${ctx}/parameter/clientChannelDefineAdd.action" method="post" id="dataForm" onkeydown="if(event.keyCode==13){return false;}">
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">增加-访问渠道定义</span>
				<div style="float: right;"> <span class="anas-type" style=""><a href="${ctx}/parameter/clientChannelDefineIndex.action">返回</a></span></div>
			</div>
			
			<!--1.编辑基本信息 begin   -->
			<div class="subtitle">
		        <span class="subtitlefont">第一步、填写基本资料</span>
		    </div>
  			<table style="width:670px;cellspacing:0;cellpadding:0;border:0" class="tblsite table_left table_left_small">
			<tbody class="tbldt-bd">
					<tr>
						<td style="width:150px" align="right" class="txtl_table">渠道类型：</td>
						<td style="width:200px" align="left">
				 		   <select id="channelType" name="clientChannelDefine.channelType" style="width:120px" onchange="changeChannelType();">
								<c:if test="${!empty channelTypeArray}">
									<c:forEach items="${channelTypeArray}" var="channelType" >
											 <option value="${channelType}" >${channelType.typeName}</option>
									</c:forEach>
								</c:if>
							</select> 
						</td>
						<td style="width:200px"><div id="app_idTip" style="width:280px" align="left"></div></td>
					</tr>
					
					<tr id="parent_id_tr">
						<td style="width:150px" align="right" class="txtl_table">所属渠道：</td>
						<td style="width:200px" align="left">
				 		   <select id="parent_id" name="clientChannelDefine.parent_id" style="width:120px">
								 
							</select> 
						</td>
						<td style="width:200px"><div id="parent_idTip" style="width:280px" align="left"></div></td>
					</tr>
					
					<tr>
						<td style="width:150px" align="right" class="txtl_table">渠道名称：</td>
						<td style="width:200px" align="left">
						<input id="name"  type="text" class="ex-searchinput" style="width: 200px" name="clientChannelDefine.name" value="${clientChannelDefine.name}"/>
						</td>
						<td style="width:200px"><div id="nameTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr id="from_id_tr">
						<td style="width:150px" align="right" class="txtl_table">from_id：</td>
						<td style="width:200px" align="left">
						<input id="from_id"  type="text" class="ex-searchinput" style="width: 200px" name="clientChannelDefine.from_id" onblur="checkFromIdExist()" value="${clientChannelDefine.from_id}"/>
						</td>
						<td style="width:200px"><div id="from_idTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr id="descinfo_tr">
						<td style="width:150px" align="right" class="txtl_table">说明：</td>
						<td style="width:200px" align="left">
						<input id="descinfo"  type="text" class="ex-searchinput" style="width: 200px" name="clientChannelDefine.descinfo" value="${clientChannelDefine.descinfo}"/>
						</td>
						<td style="width:200px"><div id="descinfoTip" style="width:280px" align="left"></div></td>
					</tr>
  			</tbody>
			</table>
			<!--1.编辑基本信息 end     -->
			<input type="button" value="提交信息" id="dataFormSubmit"  class="l-button l-button-submit" style="margin-top: 20px" />
		</div>
		</form>
	</div>
 
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>
