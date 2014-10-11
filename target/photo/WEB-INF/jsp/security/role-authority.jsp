<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-角色授权</title>
<%@ include file="/include/script.jsp"%>
<link type="text/css" rel="stylesheet" href="${ctx}/js/formValidator/style/validator.css"></link>
<script src="${ctx}/js/jquery.form.js" type="text/javascript"></script>
<script src="${ctx}/js/formValidator/formValidator-4.0.1.min.js" type="text/javascript"></script>
<script src="${ctx}/js/formValidator/formValidatorRegex.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	 
	$.formValidator.initConfig({formid:"dataForm",onerror:function(msg){ },onsuccess:function(data){ 
		 return true;
	}});
	
	$("#dataFormSubmit").click(function(){
		if(jQuery.formValidator.pageIsValid()){
			$("#dataForm").ajaxSubmit({
				success : function(data) {
					var jsonData = toJsonObject(data);
					if (jsonData.success) {
						alert("操作成功");
						window.location.href="${ctx}/security/roleIndex.action";
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
	
	$("#dataFormSubmitEnterAddOrEditUserRole").click(function(){
		if(jQuery.formValidator.pageIsValid()){
			$("#dataForm").ajaxSubmit({
				success : function(data) {
					var jsonData = toJsonObject(data);
					if (jsonData.success) {
						alert("操作成功");
				        window.location.href="${ctx}/security/enterAddOrEditUserRole.action";
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
	
	
	
	
	
	
	$("#roleTitle").formValidator({onShow:"请输入角色名称",onFocus:"角色名称不能为空",onCorrect:"输入正确"}).inputValidator({min:2,max:40,onError:"角色名称至少要输入2至40个字符,请确认"});
	$("#roleDescription").formValidator({onShow:"请输入角色描述",onFocus:"角色描述不能为空",onCorrect:"输入正确"}).inputValidator({min:2,max:200,onError:"角色描述至少要输入2至200个字符,请确认"});
	
	<c:if  test="${loginUserRoleType=='superadmin'}">
		$(":radio[name='roleType']").formValidator({tipID:"roleTypeTip",onShow:"请选择角色类型",onFocus:"管理员可进行权限分配，普通用户可进行权限查询",onCorrect:"输入正确"}).inputValidator({min:1,max:1,onError:"角色类型不能为空,请确认"});//.defaultPassed();
	</c:if>
	
	displayFunction();
});

//普通用户隐藏掉权限管理菜单



function displayMenu(){
	var roleType=$('input:radio[name="roleType"]:checked').val();
	if(roleType==3){
		$("#menu_6").prop("disabled","disabled");
		$("input[pid=menu_6]:checkbox").each(function() {
			  $(this).prop("disabled","disabled");
		});
	}else {
		$("#menu_6").prop("disabled","");
		$("input[pid=menu_6]:checkbox").each(function() {
			  $(this).prop("disabled","");
		});
	}
 
	
}



function checkAllMenu() {
	  if ($("#allMenu").prop("checked")) { 
		 $("input[name=menuIDS]:checkbox").each(function() {
			  $(this).prop("checked",true);
		  });
	  } else {
		  $("input[name=menuIDS]:checkbox").each(function() {
			  $(this).prop("checked",false);
		  });
	  }
	  displayFunction();
}

function menu(cid) {
	  var childMenuID = "child_"+cid;
	  var pid = $("#"+childMenuID).attr("pid");
	  if ($("#"+childMenuID).prop("checked")) { 
	    $("#"+pid).each(function() {
	    	$(this).prop("checked",true);
	   	});
	 }  
	 displayFunction();
} 

  function checkChildMenu(pid){
	  if ($("#menu_"+pid).prop("checked")) { 
		  $("input[pid=menu_"+pid+"]:checkbox").each(function() {
			  $(this).prop("checked",true);
		  });
	  } else {
		  $("input[pid=menu_"+pid+"]:checkbox").each(function() {
			  $(this).prop("checked",false);
		  });
	  }
	  displayFunction();
  }
  
function displayFunction(){
	 var functiontitleShow = false;
	 
	 $("input[name=menuIDS]:checkbox").each(function() {
		  var functionID = "function_"+$(this).attr("id")+"_id";
		  var functionTitle = "function_"+$(this).attr("id")+"_title"; 
		  if($(this).prop("checked")){
			  $("#"+functionTitle).html("请选择【"+$(this).attr("menuTitle")+"】子功能：");
			  $("#"+functionID).show();
			  if($("#"+functionID).length>0){ 
			 	 functiontitleShow = true;
			  }
		  } else {
			  $("#"+functionID).hide();
			  //取消选择
			   $("input[menuID="+functionID+"]:checkbox").each(function(){
		    		var id =  $(this).attr("id");
		    		$("#"+id).prop("checked",false);
		     });
			  
		  }
	 });
	 
	 if(functiontitleShow){ 
	 	  $("#functiontitle").show();
	  } else {
		  $("#functiontitle").hide();  
	  }
}
  
function authority() {
		//校验至少选择一个菜单，才可以进行提交
		 $("#dataForm").ajaxSubmit({
				success:function(data){
					
				},
				error:function(msg){
					LG.showAjaxError(xhr, status, errMsg);
				}
			});
	}
	
function toJsonObject(jsonString) {
	if (typeof jsonString == 'object')
		return jsonString;
	jsonString = jsonString.replace(/^(?:\<pre[^\>]*\>)?(\{.*\})(?:\<\/pre\>)?$/ig, "$1");
	return eval('(' + jsonString + ')');
}

function setFunctionValues() {
	var functionValues="";
	////3=undefined|,@4=undefined|,@
	 $("input[name=functionIDs]:checkbox").each(function() {
		 //fid=key|value,key|value@
		 if ($(this).attr("checked") == "checked") { 
			 var fValueID = $(this).attr("value")+"_fvalue";
			 functionValues = functionValues+$(this).attr("value")+"=";
			 //获取多选框值
			 var valueStr="";
			 var keyStr="";
		     $("#"+fValueID+" option:selected").each(function() {
		    	 valueStr = valueStr+ $(this).text().trim()+',';
	         });
	        // 所有option被选中项的值
	        if(null!=$("#"+fValueID).val()) {
	       		 keyStr = keyStr+$("#"+fValueID).val();
	        }
	        if(null!=keyStr&&""!=keyStr) {
	      		var value=valueStr.split(",");
				var key=keyStr.split(",");
		        for ( var i = 0; i < key.length; i++) {
		        	functionValues= functionValues +key[i]+","
				}
	        }
	        functionValues = functionValues+"@";
		 }
   	});
	 $("#functionValues").val(functionValues);
}
</script>		
</head>
	<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<form action="${ctx}/security/authority.action" method="post" id="dataForm" onkeydown="if(event.keyCode==13){return false;}">
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">
				<c:choose> 
						<c:when test="${empty role}">
							新增角色
						</c:when>
						<c:otherwise>
							编辑角色
						</c:otherwise>
					</c:choose>
				</span>
			</div>
			
			<!--1.编辑基本信息 begin   -->
			<div class="subtitle">
		        <span class="subtitlefont">第一步、编辑基本信息</span>
		    </div>
		    <input type="hidden" value="${role.name}"  name="roleName" id="roleName"/> 
		    
 			<table  style="width:650px;cellspacing:0;cellpadding:0;border:0"  class="tblsite table_left table_left_small">
			<tbody class="tbldt-bd">
				<tr>
					<td style="width:150px;border-bottom: 0 solid #CCCCCC; border-right: 0 solid #CCCCCC;padding: 10px;text-align: left;" align="right" class="txtl_table" >角色名称：</td>
					<td style="width:200px;border-bottom: 0 solid #CCCCCC; border-right: 0 solid #CCCCCC;padding: 10px;text-align: left;" align="left">
					<input id="roleTitle"  type="text" class="ex-searchinput" style="width: 200px" name="title" value="${role.title}"/></td>
					<td style="width:150px;border-bottom: 0 solid #CCCCCC; border-right: 0 solid #CCCCCC;padding: 10px;text-align: left;"><div id="roleTitleTip" style="width:280px" align="left"></div></td>
				</tr>
				<tr>
					<td style="width:150px;border-bottom: 0 solid #CCCCCC; border-right: 0 solid #CCCCCC;padding: 10px;text-align: left;" align="right" class="txtl_table">角色描述：</td>
					<td style="width:200px;border-bottom: 0 solid #CCCCCC; border-right: 0 solid #CCCCCC;padding: 10px;text-align: left;" align="left">
						<textarea cols="10"
							rows="4" class="l-textarea" id="roleDescription" name="description" style="width: 200px;border: 1px solid #CEE1EE">${role.description}</textarea>
					</td>
					<td style="width:150px;border-bottom: 0 solid #CCCCCC; border-right: 0 solid #CCCCCC;padding: 10px;text-align: left;"><div id="roleDescriptionTip" style="width:280px" align="left"></div></td>
				</tr>
				<c:if  test="${loginUserRoleType=='superadmin'}">
				<tr>
					<td style="width:150px;border-bottom: 0 solid #CCCCCC; border-right: 0 solid #CCCCCC;padding: 10px;text-align: left;" align="right" class="txtl_table">角色类型：</td>
					<td style="width:200px;border-bottom: 0 solid #CCCCCC; border-right: 0 solid #CCCCCC;padding: 10px;text-align: left;" align="left">
					<input type="radio" id="roleType1"   name="roleType" value="1" <c:if  test="${role.type==1}"> checked="checked" </c:if> onclick="displayMenu();" />
					<label for="roleType"  >超级管理员</label>
					<input type="radio" id="roleType2"   name="roleType" value="2" <c:if  test="${role.type==2}"> checked="checked" </c:if> onclick="displayMenu();"  />
					<label for="roleType"  >管理员</label>
					<input type="radio" id="roleType3"    name="roleType" value="3" <c:if  test="${role.type==3}"> checked="checked" </c:if> onclick="displayMenu();"  />
					<label for="roleType"  >普通用户</label>
					</td>
					<td style="width:150px;border-bottom: 0 solid #CCCCCC; border-right: 0 solid #CCCCCC;padding: 10px;text-align: left;"><div id="roleTypeTip" style="width:280px" align="left"></div></td>
				</tr>
				</c:if>
			</tbody>
			</table>
			<!--1.编辑基本信息 end     -->
			<div >
				<div style="width: 100%; height: 50px;"></div>
			</div>
			
			
			<!--2.编辑权限信息 begin   -->
			<div class="subtitle">
		        <span class="subtitlefont">第二步、编辑权限信息</span>
		    </div>
			<div class="clearfix">
			   <div class="sub2title">
			          <span class="sub2titlefont">1.菜单</span>
			   </div>
		   
		    <!-- -----菜单------ -->
			<!--fid=key|value,key|value@fid=key|value,key|value-->
			<input type="hidden" value="${functionValues}"  name="functionValues" id="functionValues"/>
			<div style="height: 500px; width: 100%; overflow-y: scroll; OVERFLOW-x: none;">
			<table style="width:95%;cellspacing:0;cellpadding:0;border:1" class="tblsite table_left table_left_small">
				<thead class="tblsite-head">
				<tr>
							<th class="txtl_table" width="20%">
								 一级菜单
							</th>
							<th class="txtl_table">
								 二级菜单
							</th>
							<th class="txtl_table">
								 授权:
								 <input type="checkbox" id="allMenu" onclick="checkAllMenu()"/>
							</th>
					</tr>
				</thead>
				<tbody class="tbldt-bd">
					<c:forEach items="${listMenu}" var="menu">
					  <c:if test="${menu.pid==0}">
						<tr>
							<td style="padding: 5px">
									【<c:out value="${menu.title}" />】
							</td>
							<td style="padding: 5px"></td>
							<td style="padding: 5px">
							&nbsp;&nbsp;
							<input type="checkbox" name="menuIDS"  value="${menu.id}" id="menu_${menu.id}" onclick="checkChildMenu(${menu.id})"
								<c:forEach items="${listRoleMenu}" var="roleMenu">
								 <c:if test="${roleMenu.id==menu.id}">
									 checked="true"
								 </c:if>
								</c:forEach>
							/>
							</td>
						</tr>
						<c:forEach items="${listMenu}" var="childmenu">
						  <c:if test="${menu.id==childmenu.pid}">
							<tr>
								<td style="padding: 5px"></td>
								<td style="padding: 5px">
										<c:out value="${childmenu.title}" />
								</td>
								<td style="padding: 5px">
								&nbsp;&nbsp;
								<input type="checkbox" name="menuIDS"  value="${childmenu.id}" id="child_${childmenu.id}" pid="menu_${menu.id}" menuTitle="${childmenu.title}" onclick="menu(${childmenu.id})"
									<c:forEach items="${listRoleMenu}" var="roleMenu">
									 <c:if test="${roleMenu.id==childmenu.id}">
										 checked="true"
									 </c:if>
									</c:forEach>
								/>
								</td>
							</tr>
							 </c:if>
							</c:forEach>
 					   </c:if>
					</c:forEach>
					</tbody>
				</table>
				</div>
		      </div>
		      <!-- -----菜单------ -->
		      
		      <!-- -----功能------ -->
		      <div class="clearfix" style="margin-top: 10px">
			    <div class="sub2title" id="functiontitle" hidden="true" >
			          <span class="sub2titlefont">2.功能</span>
			    </div>
		        <c:forEach items="${functionMap}" var="map" step="1" begin="0" varStatus="index">
		        
		        <div id="function_child_${map.key}_id" hidden="true" style="margin-top: 20px">
		        		<ul>
						<li class="header">
							<label for="${map.key}" id="function_child_${map.key}_title"></label>
						 
							<c:forEach items="${map.value}" var="function">
								<span class="label"  >
									<input type="checkbox" onclick="setFunctionValues()" id="${function.id}_fid" menuID="function_child_${map.key}_id" name="functionIDs" value="${function.id}"
									<c:forEach items="${listRoleFunction}" var="roleFunction">
									 <c:if test="${roleFunction.id==function.id}">
										    checked="true"
											<c:set value="${roleFunction}" var="cRoleFunction" scope="page"/>
									 </c:if>
									</c:forEach>
									/>
									<label class="for" for="${function.id}">${function.title}</label>
									&nbsp;&nbsp;
								</span>
							   <c:if test="${!empty function.sourceValues}">
									　<select id="${function.id}_fvalue" multiple="multiple" style="width:80px;height:80px;" onchange="setFunctionValues()">
												<c:forEach items="${function.sourceValues}" var="sourceValues">
													<option value="${sourceValues.id}"
													 		  <c:forEach items="${cRoleFunction.sourceValues}" var="roleValues">
													 		  <c:if test="${roleValues.functionID==sourceValues.functionID&&sourceValues.id==roleValues.id}">
													 		 	 selected="selected"
													 		 </c:if>
															</c:forEach>
													> 
													${sourceValues.sValue}
													</option>
											 </c:forEach>
									</select>
								</c:if>
							</c:forEach>
						 </li>
						 </ul>
				</div>
			   </c:forEach>
		      </div>
		    <!-- -----功能------ -->
			<!--2.编辑权限信息 end     -->
			
			<div >
				<div style="width: 100%; height: 50px;"></div>
				<div style="margin-left: 10px;margin-top: 0px">
					<c:choose> 
						<c:when test="${empty role}">
							<input type="button" value="创建角色" id="dataFormSubmit"  class="l-button l-button-submit" />
						</c:when>
						<c:otherwise>
							<input type="button" value="保存角色" id="dataFormSubmit"  class="l-button l-button-submit" />
						</c:otherwise>
					</c:choose>
				</div>
			<div style="margin-left: 200px;margin-top: -32px">
					<c:choose> 
						<c:when test="${empty role}">
							<input type="button" value="创建角色并添加用户" id="dataFormSubmitEnterAddOrEditUserRole"  class="l-button l-button-submit"/> 
						</c:when>
						<c:otherwise>
							<input type="button" value="保存角色并添加用户" id="dataFormSubmitEnterAddOrEditUserRole"  class="l-button l-button-submit"/> 
						</c:otherwise>
					</c:choose>
			</div>
			</div>
			 
		</div>
	</form>
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>