<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-参数列表</title>
<%@ include file="/include/script.jsp"%>
<style>
.control-label{width:110px}
</style>
</head>
<!--header-->
<body>
<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			     <div class="tablistbox">
					<span class="anas-type">参数列表-添加-${tbname }</span>
				 </div>
			    
					<form class="form-horizontal" action="${ctx }/parameter/addParamter.action" id="addpage" method="post" style="margin-top:10px" >
							<input type="hidden" name="tbname" value="${tbname }" />
							<fieldset>
							 <s:iterator value="paramterList" var="pl">
								 <s:if test='#pl.type!="datetime"'>
								 	 <div class="control-group" style="width:100%">
										<label class="control-label" for="focusedInput">${pl.name}</label>
										<div class="controls">
										<s:if test='#pl.type=="tinyint(1) unsigned"'>
											<select name="${pl.name}" id="${pl.name}" >
												<option value="1">true</option>
												<option value="0">false</option>
											</select>
										</s:if>
										<s:else>
										  <input value="${pl.defaultVal }" name="${pl.name}"  class="input-mlarge focused ${pl.regexp }" id="${pl.name}" type="text" >
										  <s:if test='#pl.required=="NO"'>
										 	 <span class="mast" >*必填</span>
										  </s:if>
										  </s:else>
										</div>
								   </div>
								   </s:if>
							 </s:iterator>
							 
							  <div class="form-actions" style="border-top:none">
									<button type="button" style="padding:4px 10px 4px;font-size:13px" onclick="submitCategory()" class="btn btn-primary">保存</button>
									<button class="btn" style="padding:4px 10px 4px;font-size:13px;margin-left:20px" type="reset" style="margin-left:15px">重置</button>
							  </div>
							</fieldset>
							</form>
	</div>				
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>
<script>
function submitCategory(){
 SP.ajax($("#addpage"));
}
</script>