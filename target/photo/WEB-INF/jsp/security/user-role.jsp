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

	<c:if test="${empty roleList}">
	$.ligerDialog.confirm("目前无可分配的角色，是否【新增角色】？", function(yes) {
		if(yes){
		 window.location.href="${ctx}/security/enterAuthority.action";
		}
	});
	</c:if>
	
	
	$("#dataFormSubmit").click(function(){
		if(jQuery.formValidator.pageIsValid()){
			$("#dataForm").ajaxSubmit({
				success : function(data) {
					var jsonData = toJsonObject(data);
					if (jsonData.success) {
						$.ligerDialog.confirm("操作成功，是否返回？", function(yes) {
							if(yes){
				       		 window.location.href="${ctx}/security/userIndex.action";
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
	
	
	<c:choose> 
	<c:when test="${empty user}">
	$("#userName").formValidator({onShow:"请输入用户工号",onFocus:"用户工号不能为空,大写例如:CIAC123456",onCorrect:"输入正确"}).inputValidator({min:2,max:40,onError:"用户工号至少要输入2至40个字符,请确认"})
	  .functionValidator({
	    fun:function(val,elem){
	    	$.getJSON("${ctx}/security/queryUserByUserName.action",{"userName" :val},
					function(data){
						 if(null==data||""==data) {
							 return true;
						 }
						 alert("该用户信息已经存在，请编辑.");
						 window.location.href = "${ctx}/security/enterAddOrEditUserRole.action?userName="+data.userName; 
						 return true;
					}
			 );
		}
	});
	</c:when>
	<c:otherwise>
		$("#userName").formValidator({onShow:"请输入用户工号",onFocus:"用户工号不能为空,大写例如:CIAC123456",onCorrect:"输入正确"}).inputValidator({min:2,max:40,onError:"用户工号至少要输入2至40个字符,请确认"});
	</c:otherwise>
	</c:choose>
	
	$("#objName").formValidator({onShow:"请输入用户姓名",onFocus:"用户姓名不能为空",onCorrect:"输入正确"}).inputValidator({min:2,max:40,onError:"用户姓名至少要输入2至40个字符,请确认"});
	$("#phone").formValidator({onShow:"请输入用户手机",onFocus:"用户手机不能为空",onCorrect:"输入正确"}).inputValidator({min:11,max:11,onError:"用户手机必须是11位,请确认"});
	$("#email").formValidator({onShow:"请输入用户邮箱",onFocus:"用户邮箱不能为空",onCorrect:"输入正确"}).inputValidator({min:2,max:40,onError:"用户邮箱至少要输入2至40个字符,请确认"});
	$("#tel").formValidator({onShow:"请输入用户分机",onFocus:"用户分机可以为空",onCorrect:"输入正确"}).inputValidator({min:0,max:40,onError:"用户分机最多输入40个字符,请确认"});
	$("#department").formValidator({onShow:"请输入用户部门",onFocus:"用户部门不能为空",onCorrect:"输入正确"}).inputValidator({min:2,max:40,onError:"用户部门至少要输入2至40个字符,请确认"});
	$("#leaderName").formValidator({onShow:"请输入上级领导",onFocus:"上级领导不能为空",onCorrect:"输入正确"}).inputValidator({min:2,max:40,onError:"上级领导至少要输入2至40个字符,请确认"});
	$("#description").formValidator({onShow:"请输入用户职能描述",onFocus:"用户职能描述不能为空",onCorrect:"输入正确"}).inputValidator({min:2,max:40,onError:"用户职能描述至少要输入2至200个字符,请确认"});

 });
 
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
		<form action="${ctx}/security/addUserRole.action" method="post" id="dataForm" onkeydown="if(event.keyCode==13){return false;}">
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type"> 
					<c:choose> 
						<c:when test="${empty user.userName}">
							新增用户
						</c:when>
						<c:otherwise>
							编辑用户 
						</c:otherwise>
					</c:choose>
				 </span>
			</div>
			
			<!--1.编辑基本信息 begin   -->
			<div class="subtitle">
		        <span class="subtitlefont">第一步、编辑用户基本资料</span>
		    </div>
		     <c:if test="${!empty user.userName}">
		     <input id="userName" type="hidden" name="userName" value="${user.userName}"/>
		     </c:if>
 			<table style="width:670px;cellspacing:0;cellpadding:0;border:0" class="tblsite table_left table_left_small">
			<tbody class="tbldt-bd">
				
					<tr>
						<td style="width:150px" align="right" class="txtl_table">用户工号：</td>
						<td style="width:200px" align="left">
						<input id="userName"  type="text" class="ex-searchinput" style="width: 200px" name="userName" value="${user.userName}"
						 <c:if test="${!empty user.userName}"> disabled="disabled" </c:if> 
						 />
						</td>
						<td style="width:200px"><div id="userNameTip" style="width:280px" align="left"></div></td>
					</tr>
				
				<tr>
					<td style="width:150px" align="right" class="txtl_table">用户姓名：</td>
					<td style="width:200px" align="left">
					<input id="objName"  type="text" class="ex-searchinput" style="width: 200px" name="objName" value="${user.objName}"/>
					</td>
					<td style="width:200px"><div id="objNameTip" style="width:280px" align="left"></div></td>
				</tr>
				<tr>
					<td style="width:150px" align="right" class="txtl_table">用户手机：</td>
					<td style="width:200px" align="left">
					<input id="phone"  type="text" class="ex-searchinput" style="width: 200px" name="phone" value="${user.phone}"/>
					</td>
					<td style="width:200px"><div id="phoneTip" style="width:280px" align="left"></div></td>
				</tr>
				<tr>
					<td style="width:150px" align="right" class="txtl_table">用户邮箱：</td>
					<td style="width:200px" align="left">
					<input id="email"  type="text" class="ex-searchinput" style="width: 200px" name="email" value="${user.email}"/>
					</td>
					<td style="width:200px"><div id="emailTip" style="width:280px" align="left"></div></td>
				</tr>
				<tr>
					<td style="width:150px" align="right" class="txtl_table">用户分机：</td>
					<td style="width:200px" align="left">
					<input id="tel"  type="text" class="ex-searchinput" style="width: 200px" name="tel" value="${user.tel}"/>
					</td>
					<td style="width:200px"><div id="telTip" style="width:280px" align="left"></div></td>
				</tr>
			
				<tr>
					<td style="width:150px" align="right" class="txtl_table" >用户部门：</td>
					<td style="width:200px" align="left">
					<input id="department"  type="text" class="ex-searchinput" style="width: 200px" name="department" value="${user.department}"/>
					</td>
					<td style="width:200px"><div id="departmentTip" style="width:280px" align="left"></div></td>
				</tr>
				<tr>
					<td style="width:150px" align="right" class="txtl_table">上级领导：</td>
					<td style="width:200px" align="left">
					<input id="leaderName"  type="text" class="ex-searchinput" style="width: 200px" name="leaderName" value="${user.leaderName}"/>
					</td>
					<td style="width:200px"><div id="leaderNameTip" style="width:280px" align="left"></div></td>
				</tr>
				<tr>
				<td style="width:150px" align="right" class="txtl_table">用户职能描述：</td>
				<td style="width:200px" align="left">
				<textarea cols="10"
				rows="4" class="l-textarea" id="description" name="description" style="width: 200px;border: 1px solid #CEE1EE">${user.description}</textarea>
				</td>
				<td style="width:200px"> <div id="descriptionTip" style="width:280px" align="left"></div> </td>
			</tr>
 			</tbody>
			</table>
			<!--1.编辑基本信息 end     -->
			
			
			<!--2.编辑权限信息 begin   -->
			<div class="subtitle" style="margin-top: 20px">
		        <span class="subtitlefont">第二步、分配角色</span>
		        <span>[提示:该用户重新登录系统后生效]</span>
		    </div>
		   <div class="clearfix" style="margin-top: 20px">
		    <table style="width:870px;cellspacing:0;cellpadding:0;border:0" class="tblsite table_left table_left_small">
			<tbody class="tbldt-bd">
			<tr>
				<td style="width:150px" align="right" class="txtl_table">角色名称：</td>
				<td style="width:720px" align="left" colspan="2">
					<c:if test="${empty roleList}">
						 目前无可分配的角色，【新增角色】请
						 <a href="${ctx}/security/enterAuthority.action">点击</a>
					</c:if>
					 <table width=100%>
						<c:forEach items="${roleList}" var="entry" step="1" begin="0" varStatus="index" >
						    <c:if test="${index.count%5==1}">
								<tr>
							</c:if>
							<td style="padding-bottom: 1px">
									<input type="checkbox" id="role_${entry.name}_checkbox" name="roleNames" value="${entry.name}" 
									<c:forEach items="${user.userRoleList}" var="userRole">
										 <c:if test="${userRole.roleName==entry.name}">
											 checked="true"
										 </c:if>
										</c:forEach>
									/>
								 <label class="for" for="roleNames">${entry.title}</label>
							</td>
							 <c:if test="${index.count%5==0}">
							</tr>
							</c:if>  
						</c:forEach>
					</table>
				</td>
			</tr>
			</tbody>
			</table>
		    </div>
			<!--2.编辑权限信息 end     -->
			
			<input type="button" value="提交用户信息" id="dataFormSubmit"  class="l-button l-button-submit" style="margin-top: 20px" />
		</div>
		</form>
	</div>
 
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>
