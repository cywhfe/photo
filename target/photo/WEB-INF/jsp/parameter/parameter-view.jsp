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
					<span class="anas-type">参数列表-查看-${tbname }</span>
				 </div>
			    
					<form class="form-horizontal" action="${ctx }/parameter/updateParamter.action" id="updatepage" method="post" style="margin-top:10px" >
							<input type="hidden" name="tbname" value="${tbname }" />
							<input type="hidden" name="key" value="${key }" />
							<input type="hidden" name="${key }" value="${priKey }" />
							<fieldset>
							 <s:iterator value="paramterList" var="pl">
							 <div class="control-group" style="width:100%">
							 	<label class="control-label">${key }</label>
							 	<div class="controls">
							 		<span class="input-xlarge uneditable-input"  >${priKey }</span>
							 	</div>
							 </div>
								 <s:if test='#pl.type!="datetime"'>
								 	 <div class="control-group" style="width:100%">
										<label class="control-label">${pl.name}</label>
										<div class="controls">
										<s:if test='#pl.type=="tinyint(1) unsigned"'>
											<select name="${pl.name}" id="${pl.name}" disabled="disabled">
												<option value="1">true</option>
												<option value="0">false</option>
											</select>
										</s:if>
										<s:else>
										<span class="input-xlarge uneditable-input" id="${pl.name}" >${pl.defaultVal }</span>
										</s:else>
										</div>
								   </div>
								   </s:if>
							 </s:iterator>
							</fieldset>
							</form>
	</div>				
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>

<script>
$.ajax({
    cache: false,
    async: true,
    url: "${ctx}/parameter/findRow.action?tbname=${tbname}&priKey=${priKey}",
    dataType: 'json',type: 'post',
    success: function (res){
    	$.each(res,function(index,con){
    		if(con!=null && con!="null"){
    			if($("#"+index).is("select")){
    				if(con==true){
    					$("#"+index).val("1");
    				}else if(con==false){
    					$("#"+index).val("0");
    				}else{
    					$("#"+index).val(con);
    				}
    			}else{
    				$("#"+index).val(con);
    			}
    		}
    		
    	});
    }
});
</script>