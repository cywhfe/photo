<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-资源管理-编辑资源</title>
<%@ include file="/include/script.jsp"%>
</head>
<script src="${ctx}/js/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#dataFormSubmit").click(function(){
		$("#dataForm").ajaxSubmit({
			success : function(data) {
				var jsonData = toJsonObject(data);
				if (jsonData.success) {
					$.ligerDialog.confirm("操作成功，是否返回？", function(yes) {
			       		 window.location.href="${ctx}/security/enterAddOrEditSource.action";
					});
				} else {
					LG.showError(jsonData.msg);
				}

			},
			error : function(errMsg) {
				LG.showAjaxError(xhr, status, errMsg);
			}
		});
	});
});

function changeMenuType() {
	var menuType=$('input:radio[name="menuType"]:checked').val();
	if(menuType==0){
		 $("#PMenu_tr").hide();
		 $("#url_tr").hide();
	}
	if(menuType==1){
		 $("#PMenu_tr").show();
		 $("#url_tr").show();
	}
}


</script>
<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
 	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">
				<c:choose> 
						<c:when test="${empty menu}">
							新增菜单
						</c:when>
						<c:otherwise>
							编辑菜单 
						</c:otherwise>
					</c:choose>
				</span>
				<div style="float: right;"> <span class="anas-type" style=""><a href="${ctx}/security/enterSource.action">返回</a></span></div>
			</div>
			<!--1.编辑基本信息 begin   -->
			<div class="subtitle" >
		        <span class="subtitlefont">菜单基本信息</span>
 		    </div>
		    <div class="clearfix" style="margin-top: 10px;">
		    	<form action="${ctx}/security/addOrUpdSource.action" method="post" id="dataForm" onkeydown="if(event.keyCode==13){return false;}">
		    	<input id="menuId"  type="hidden"  name="menuId" value="${menu.id}"/>
	 			<table style="width:50%;cellspacing:0;cellpadding:0;border:1" class="tblsite table_left table_left_small">
				<tbody class="tbldt-bd">
					<tr>
						<td style="width:200px" align="right" class="txtl_table">菜单类型：</td>
						<td style="width:550px" align="left">
						 	<input type="radio" id="menuType1"   name="menuType" value="0"  <c:if test="${0==menu.pid}"> checked="checked"  </c:if>  onclick="changeMenuType();" />
							<label for="menuType"  >一级菜单</label>
							<input type="radio" id="menuType2"   name="menuType" value="1"  <c:if test="${0!=menu.pid}"> checked="checked"  </c:if> onclick="changeMenuType();"  />
							<label for="menuType"  >二级菜单</label>
							
						</td>
					</tr>
					<tr id="PMenu_tr" <c:if test="${0==menu.pid}"> hidden="true" </c:if>>
							<td style="width:200px" align="right" class="txtl_table">上级菜单：</td>
							<td style="width:550px" align="left">
							  <select id="menuPId" name="menuPId">
							  	<c:forEach items="${listPMenu}" var="pmenu">
							 		 	<option value="${pmenu.id}"  <c:if test="${pmenu.id==menu.pid}"> selected="selected"  </c:if> >${pmenu.title}</option>
							    </c:forEach>
								</select>
							</td>
						</tr>
					<tr>
						<td style="width:200px" align="right" class="txtl_table">菜单名称：</td>
						<td style="width:550px" align="left">
						 <input id="menuTitle"  type="text" class="ex-searchinput" style="width: 200px" name="menuTitle" value="${menu.title}"/>
						</td>
					</tr>
					<tr>
						<td style="width:200px" align="right" class="txtl_table">优先级：</td>
						<td style="width:550px" align="left">
							<select id="menuPriority" name="menuPriority">
						   		<c:forEach var="index" begin="0" end="100" step="1">
		                  		<option value="${index}" <c:if test="${index==menu.priority}"> selected=selected </c:if> >${index}</option>
		                  		</c:forEach>
							</select>
						</td>
					</tr>
					
					<tr id="url_tr"  <c:if test="${0==menu.pid}"> hidden="true" </c:if>>
						<td style="width:200px" align="right" class="txtl_table">链接：</td>
						<td style="width:550px" align="left">
						  <input id="menuUrl"  type="text" class="ex-searchinput" style="width: 200px" name="menuUrl" value="${menu.url}"/>
						</td>
					</tr>
				</tbody>
				</table>
				</form>
			</div>
			<div >
				<div style="width: 100%; height: 50px;"></div>
			</div>
			<!--1.编辑基本信息 end     -->
			 	<input type="button" value="保存信息" id="dataFormSubmit"  class="l-button l-button-submit" style="margin-top: 20px" />
			</div>
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>
