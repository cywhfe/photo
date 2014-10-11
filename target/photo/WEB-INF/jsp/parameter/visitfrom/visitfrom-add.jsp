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
				       		 window.location.href="${ctx}/parameter/visitFromIndex.action";
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
 
	$("#flag").formValidator({onShow:"请输入flag",onFocus:"flag不能为空",onCorrect:"输入正确"}).inputValidator({min:1,max:50,onError:"flag最多输入50个字符,最少1个,请确认"});
	$("#info").formValidator({onShow:"请输入info",onFocus:"请输入info",onCorrect:"输入正确"}).inputValidator({min:0,max:255,onError:"info最多输入255个字符,请确认"});
	$("#back_url").formValidator({onShow:"请输入back_url",onFocus:"请输入back_url",onCorrect:"输入正确"}).inputValidator({min:0,max:255,onError:"back_url最多输入255个字符,请确认"});
	$("#parent_id").formValidator({onShow:"请输入parent_id,限制数字",onFocus:"请输入parent_id,限制数字",onCorrect:"输入正确"}).inputValidator({min:1,max:6,onError:"parent_id最多输入6个字符,最少一个,请确认"}).regexValidator({regExp:"[0-9]{1,6}$",onError:"只能输入数字"});
	$("#radio").formValidator({onShow:"请输入radio,限制数字",onFocus:"请输入radio,限制数字",onCorrect:"输入正确"}).inputValidator({min:1,max:10,onError:"radio最多输入10个字符,最少一个,请确认"}).regexValidator({regExp:"[0-9]{1,10}$",onError:"只能输入数字"});
	$("#show_order").formValidator({onShow:"请输入show_order,限制数字",onFocus:"请输入show_order,限制数字",onCorrect:"输入正确"}).inputValidator({min:1,max:10,onError:"show_order最多输入10个字符,最少1个,请确认"}).regexValidator({regExp:"[0-9]{1,10}$",onError:"只能输入数字"});
	$("#status").formValidator({onShow:"请输入status",onFocus:"请输入status",onCorrect:"输入正确"}).inputValidator({min:0,max:1,onError:"status最多输入1个字符,请确认"}).regexValidator({ regExp:"[0-9]{1}$", onError:"只能输入数字"});
	$("#start").formValidator({onShow:"请输入start,限制数字",onFocus:"请输入start,限制数字",onCorrect:"输入正确"}).inputValidator({min:1,max:2,onError:"start最多输入2个字符,最少一个,请确认"}).regexValidator({ regExp:"[0-9]{1,2}$", onError:"只能输入数字"});
  });
function toJsonObject(jsonString) {
	if (typeof jsonString == 'object')
		return jsonString;
	jsonString = jsonString.replace(/^(?:\<pre[^\>]*\>)?(\{.*\})(?:\<\/pre\>)?$/ig, "$1");
	return eval('(' + jsonString + ')');
}	

function checkFlagExist() {
	var flag = $("#flag").val();
	$.getJSON("${ctx}/parameter/visitFromIsExistFlag.action",{"flag" : flag},
		function(data){
		if(data.isHave) {
			$("#flag").focus();
			$("#flagTip").attr("class","onError");
			$("#flagTip").text("flag已存在，请更改");
		} else {
			$("#flagTip").text("请输入flag");
		}
	});	
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
		<form action="${ctx}/parameter/visitFromAdd.action" method="post" id="dataForm" onkeydown="if(event.keyCode==13){return false;}">
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">编辑-访问来源定义</span>
				<div style="float: right;"> <span class="anas-type" style=""><a href="${ctx}/parameter/visitFromIndex.action">返回</a></span></div>
			</div>
			
			<!--1.编辑基本信息 begin   -->
			<div class="subtitle">
		        <span class="subtitlefont">第一步、填写基本资料</span>
		    </div>
  			<table style="width:670px;cellspacing:0;cellpadding:0;border:0" class="tblsite table_left table_left_small">
			<tbody class="tbldt-bd">
					<tr>
						<td style="width:150px" align="right" class="txtl_table">flag：</td>
						<td style="width:200px" align="left">
						<input  id="flag" type="text"  name="visitFrom.flag" class="ex-searchinput" style="width: 200px" onblur="checkFlagExist()"   value="${visitFrom.flag}"/>
						</td>
						<td style="width:200px"><div id="flagTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr>
						<td style="width:150px" align="right" class="txtl_table">info：</td>
						<td style="width:200px" align="left">
						<input id="info"  type="text"  name="visitFrom.info" class="ex-searchinput" style="width: 200px"   value="${visitFrom.info}"/>
						</td>
						<td style="width:200px"><div id="infoTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr>
						<td style="width:150px" align="right" class="txtl_table">back_url：</td>
						<td style="width:200px" align="left">
						<input id="back_url"  type="text" class="ex-searchinput" style="width: 200px" name="visitFrom.back_url" value="${visitFrom.back_url}"/>
						</td>
						<td style="width:200px"><div id="back_urlTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr>
						<td style="width:150px" align="right" class="txtl_table">parent_id：</td>
						<td style="width:200px" align="left">
						<input  id="parent_id" type="text"  onkeyup= "value=value.replace(/[^\d]/g, '') " name="visitFrom.parent_id" class="ex-searchinput" style="width: 200px"   value="${visitFrom.parent_id}"/>
						</td>
						<td style="width:200px"><div id="parent_idTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr>
						<td style="width:150px" align="right" class="txtl_table">radio：</td>
						<td style="width:200px" align="left">
						<input id="radio"  type="text"  onkeyup= "value=value.replace(/[^\d]/g, '') "  name="visitFrom.radio" class="ex-searchinput"  class="input-mlarge focused [0-9]{0,10}" style="width: 200px"   value="${visitFrom.radio}"/>
						</td>
						<td style="width:200px"><div id="radioTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr>
						<td style="width:150px" align="right" class="txtl_table">show_order：</td>
						<td style="width:200px" align="left">
						<input  id="show_order" type="text"  onkeyup= "value=value.replace(/[^\d]/g, '') "  name="visitFrom.show_order" class="ex-searchinput" style="width: 200px"   value="${visitFrom.show_order}"/>
						</td>
						<td style="width:200px"><div id="show_orderTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr>
						<td style="width:150px" align="right" class="txtl_table">status：</td>
						<td style="width:300px" align="left">
							有效<input id="status2"  type="radio" class="ex-searchinput" style="width: 20px;margin-top:-3px" name="visitFrom.status" value="1" checked="checked"/> 
							无效<input id="status1"  type="radio" class="ex-searchinput" style="width: 20px;margin-top:-3px" name="visitFrom.status" value="0" />
						</td>
						<td style="width:200px"><div id="statusTip" style="width:280px" align="left"></div></td>
					</tr>
					<tr>
						<td style="width:150px" align="right" class="txtl_table">start：</td>
						<td style="width:200px" align="left">
						<input   id="start" type="text"  onkeyup= "value=value.replace(/[^\d]/g, '') " name="visitFrom.start" class="ex-searchinput" style="width: 200px"   value="${visitFrom.start}"/>
						</td>
						<td style="width:200px"><div id="startTip" style="width:280px" align="left"></div></td>
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
