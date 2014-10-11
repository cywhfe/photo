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
	$("#descinfo").formValidator({onShow:"请输入说明",onFocus:"说明不能为空",onCorrect:"输入正确"}).inputValidator({min:2,max:40,onError:"说明最多输入40个字符,请确认"});
});
function toJsonObject(jsonString) {
	if (typeof jsonString == 'object')
		return jsonString;
	jsonString = jsonString.replace(/^(?:\<pre[^\>]*\>)?(\{.*\})(?:\<\/pre\>)?$/ig, "$1");
	return eval('(' + jsonString + ')');
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
		
		<form action="${ctx}/parameter/clientChannelDefineEdit.action" method="post" id="dataForm" onkeydown="if(event.keyCode==13){return false;}">
		<input id="id"  type="hidden"   name="clientChannelDefine.id" value="${clientChannelDefine.id}"/>
		<input id="channelType"  type="hidden"   name="clientChannelDefine.channelType" value="${clientChannelDefine.channelType}"/>
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
				 		    <input  disabled="disabled"  type="text" class="ex-searchinput" style="width: 200px"  value="${clientChannelDefine.channelType.typeName}"/>
						</td>
						<td style="width:200px"><div id="app_idTip" style="width:280px" align="left"></div></td>
					</tr>
					
					<tr id="parent_id_tr">
						<td style="width:150px" align="right" class="txtl_table">所属渠道：</td>
						<td style="width:200px" align="left">
				 		    <select id="parent_id" name="clientChannelDefine.parent_id" style="width:120px">
							 	<c:if test="${!empty pClientChannelDefineList}">
										<c:forEach items="${pClientChannelDefineList}" var="obj" >
												 <option value="${obj.id}" <c:if test="${obj.id==clientChannelDefine.parent_id}"> selected="selected"</c:if> >${obj.name}</option>
										</c:forEach>
								</c:if>
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
						<input id="from_id"  readonly="readonly" type="text" class="ex-searchinput" style="width: 200px" name="clientChannelDefine.from_id"  value="${clientChannelDefine.from_id}"/>
						</td>
						<td style="width:200px"><div id="from_idTip" style="width:280px" align="left"><span style="color: red">不可编辑</span></div></td>
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
