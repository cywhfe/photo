<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-用户授权</title>
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
				       		 window.location.href="${ctx}/parameter/clientDefineIndex.action";
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
 
	$("#app_id").formValidator({onShow:"请输入app_id",onFocus:"app_id不能为空",onCorrect:"输入正确"}).inputValidator({min:2,max:40,onError:"app_id最多输入40个字符,请确认"});
	$("#name").formValidator({onShow:"请输入name",onFocus:"请输入name",onCorrect:"输入正确"}).inputValidator({min:0,max:40,onError:"name最多输入40个字符,请确认"});
	$("#ugc_data").formValidator({onShow:"请输入ugc_data",onFocus:"请输入ugc_data",onCorrect:"输入正确"}).inputValidator({min:0,max:40,onError:"ugc_data最多输入40个字符,请确认"});
	$("#status").formValidator({onShow:"请输入status",onFocus:"请输入status",onCorrect:"输入正确"}).inputValidator({min:0,max:40,onError:"status最多输入40个字符,请确认"});
	$("#type").formValidator({onShow:"请输入type",onFocus:"请输入type",onCorrect:"输入正确"}).inputValidator({min:0,max:40,onError:"type最多输入40个字符,请确认"});
	$("#show_active").formValidator({onShow:"请输入show_active",onFocus:"请输入show_active",onCorrect:"输入正确"}).inputValidator({min:0,max:40,onError:"show_active最多输入40个字符,请确认"});
	$("#os_id").formValidator({onShow:"请输入os_id",onFocus:"请输入os_id",onCorrect:"输入正确"}).inputValidator({min:0,max:40,onError:"os_id最多输入40个字符,请确认"});
	$("#is_tool").formValidator({onShow:"请输入is_tool",onFocus:"请输入is_tool",onCorrect:"输入正确"}).inputValidator({min:0,max:40,onError:"is_tool最多输入40个字符,请确认"});
	$("#source").formValidator({onShow:"请输入source",onFocus:"请输入source",onCorrect:"输入正确"}).inputValidator({min:0,max:40,onError:"source最多输入40个字符,请确认"});
	$("#device_id").formValidator({onShow:"请输入device_id",onFocus:"请输入device_id",onCorrect:"输入正确"}).inputValidator({min:0,max:40,onError:"device_id最多输入40个字符,请确认"});
	$("#project_id").formValidator({onShow:"请输入project_id",onFocus:"请输入project_id",onCorrect:"输入正确"}).inputValidator({min:0,max:40,onError:"project_id最多输入40个字符,请确认"});

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
		<form action="${ctx}/parameter/clientDefineAdd.action" method="post" id="dataForm" onkeydown="if(event.keyCode==13){return false;}">
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">增加-客户端定义</span>
				<div style="float: right;"> <span class="anas-type" style=""><a href="${ctx}/parameter/clientDefineIndex.action">返回</a></span></div>
			</div>
			
			<!--1.编辑基本信息 begin   -->
			<div class="subtitle">
		        <span class="subtitlefont">第一步、填写基本资料</span>
		    </div>
  			<table style="width:670px;cellspacing:0;cellpadding:0;border:0" class="tblsite table_left table_left_small">
			<tbody class="tbldt-bd">
					<tr>
						<td style="width:150px" align="right" class="txtl_table">app_id：</td>
						<td style="width:200px" align="left">
						<input id="app_id"  type="text" class="ex-searchinput" style="width: 200px" name="clientDefine.app_id"/>
						</td>
						<td style="width:200px"><div id="app_idTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr>
						<td style="width:150px" align="right" class="txtl_table">name：</td>
						<td style="width:200px" align="left">
						<input id="name"  type="text" class="ex-searchinput" style="width: 200px" name="clientDefine.name"/>
						</td>
						<td style="width:200px"><div id="nameTip" style="width:280px" align="left"></div></td>
					</tr>
					<!-- <tr>
						<td style="width:150px" align="right" class="txtl_table">ugc_data：</td>
						<td style="width:200px" align="left">
						<input id="ugc_data"  type="text" class="ex-searchinput" style="width: 200px" name="clientDefine.ugc_data"/>
						</td>
						<td style="width:200px"><div id="ugc_dataTip" style="width:280px" align="left"></div></td>
					</tr> -->
					<tr>
						<td style="width:150px" align="right" class="txtl_table">status：</td>
						<td style="width:200px" align="left">
							<input id="status2"  type="radio" class="ex-searchinput" style="width: 200px" name="clientDefine.status" value="1" checked="checked"/>有效
							<input id="status1"  type="radio" class="ex-searchinput" style="width: 200px" name="clientDefine.status" value="0"/>无效
						</td>
						<td style="width:200px"><div id="statusTip" style="width:280px" align="left"></div></td>
					</tr>
					<!-- <tr>
						<td style="width:150px" align="right" class="txtl_table">type：</td>
						<td style="width:200px" align="left">
						<input id="type"  type="text" class="ex-searchinput" style="width: 200px" name="clientDefine.type"/>
						</td>
						<td style="width:200px"><div id="typeTip" style="width:280px" align="left"></div></td>
					</tr> -->
					<!-- <tr>
						<td style="width:150px" align="right" class="txtl_table">show_active：</td>
						<td style="width:200px" align="left">
						<input id="show_active"  type="text" class="ex-searchinput" style="width: 200px" name="clientDefine.show_active"/>
						</td>
						<td style="width:200px"><div id="show_activeTip" style="width:280px" align="left"></div></td>
					</tr> -->
					<tr>
						<td style="width:150px" align="right" class="txtl_table">os_id：</td>
						<td style="width:200px" align="left">
							<select name="clientDefine.os_id"   style="width: 120px" id="os_id">
								<c:if test="${!empty platfromList}">
									<c:forEach items="${platfromList}" var="entity">
										<option value="${entity.id}">${entity.name}</option>
									</c:forEach>
								</c:if>
							</select>
						</td>
						<td style="width:200px"><div id="os_idTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr>
						<td style="width:150px" align="right" class="txtl_table">is_tool：</td>
						<td style="width:200px" align="left">
 							<input id="is_tool_1"  type="radio" class="ex-searchinput" style="width: 200px" name="clientDefine.is_tool" value="1"/>是
							<input id="is_tool_2"  type="radio" class="ex-searchinput" style="width: 200px" name="clientDefine.is_tool" value="0" checked="checked"/>否
						</td>
						<td style="width:200px"><div id="is_toolTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr>
						<td style="width:150px" align="right" class="txtl_table">source：</td>
						<td style="width:200px" align="left">
						<input id="source"  type="text" class="ex-searchinput" style="width: 200px" name="clientDefine.source"/>
						</td>
						<td style="width:200px"><div id="sourceTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr>
						<td style="width:150px" align="right" class="txtl_table">device_id：</td>
						<td style="width:200px" align="left">
							<select name="clientDefine.device_id"   id="device_id" style="width: 120px">
								<c:if test="${!empty deviceList}">
									<c:forEach items="${deviceList}" var="entity">
										<option value="${entity.id}">${entity.name}</option>
									</c:forEach>
								</c:if>
							</select>
 						</td>
						<td style="width:200px"><div id="device_idTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr>
						<td style="width:150px" align="right" class="txtl_table">project_id：</td>
						<td style="width:200px" align="left">
							<select name="clientDefine.project_id"   id="project_id" style="width: 120px">
								<c:if test="${!empty clientProjectDefineVoList}">
									<c:forEach items="${clientProjectDefineVoList}" var="entity">
										<option value="${entity.id}">${entity.name}</option>
									</c:forEach>
								</c:if>
							</select>
						</td>
						<td style="width:200px"><div id="project_idTip" style="width:280px" align="left"></div></td>
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
