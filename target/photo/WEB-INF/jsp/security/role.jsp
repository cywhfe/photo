<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-角色管理-用户列表</title>
<%@ include file="/include/script.jsp"%>
<script src="${ctx}/js/ligerUI/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="${ctx}/js/json2.js" type="text/javascript"></script>
 <script type="text/javascript">
function delUserRole(userRoleID) {
		$.ligerDialog.confirm("您确认删除该数据吗?", function(yes) {
			if (yes) {
				$.ajax({
					type : 'post',
					cache : false,
					dataType : 'json',
					async : false,
					url : '${ctx}/security/delUserRole.action?userRoleID='+ userRoleID,
					success : function(data) {
						var jsonData = toJsonObject(data);
						if (jsonData.success) {
							LG.showSuccess(jsonData.msg);
							window.location.reload();
						} else {
							LG.showError(jsonData.msg);
						}
					},
					error : function(xhr, status, errMsg) {
						LG.showAjaxError(xhr, status, errMsg);
					},
					complete : function() {
						LG.hideLoading();
					}
				});
			}
		});

}
</script>
</head>
<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
 	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">角色详细信息</span>
				<div style="float: right;"> <span class="anas-type" style=""><a href="${ctx}/security/roleIndex.action">返回</a></span></div>
			</div>
			<!--1.编辑基本信息 begin   -->
			<div class="subtitle" >
		        <span class="subtitlefont">一、角色基本信息</span>
		    </div>
		    <div class="clearfix" style="margin-top: 10px;">
	 			<table style="width:50%;cellspacing:0;cellpadding:0;border:1" class="tblsite table_left table_left_small">
				<tbody class="tbldt-bd">
					<tr>
						<td style="width:200px" align="right" class="txtl_table">角色名称：</td>
						<td style="width:550px" align="left">
						${role.title}
						</td>
					</tr>
					<tr>
						<td style="width:200px" align="right" class="txtl_table">角色类型：</td>
						<td style="width:550px" align="left">
						 ${role.typeName}
						</td>
					</tr>
					<tr>
						<td style="width:200px" align="right" class="txtl_table">创建人工号：</td>
						<td style="width:550px" align="left">
						 ${role.createUserName}
						</td>
					</tr>
					<tr>
						<td style="width:200px" align="right" class="txtl_table">创建人姓名：</td>
						<td style="width:550px" align="left">
						 ${role.createUserObjName}
						</td>
					</tr>
					<tr>
						<td style="width:200px" align="right" class="txtl_table">创建人部门：</td>
						<td style="width:550px" align="left">
						 ${role.department}
						</td>
					</tr>
					<tr>
						<td style="width:200px" align="right" class="txtl_table">角色描述：</td>
						<td style="width:550px" align="left">
							${role.description} 
						</td>
					</tr>
				</tbody>
				</table>
			</div>
			<div >
				<div style="width: 100%; height: 50px;"></div>
			</div>
			<!--1.编辑基本信息 end     -->
			
			
			<!-- --------- -->
			<!--2.编辑权限信息 begin   -->
			<div class="subtitle">
		        <span class="subtitlefont">二、权限信息</span>
		    </div>
		   <div class="clearfix">
 	 		<table style="width:100%;cellspacing:0;cellpadding:0;border:1" class="tblsite table_left table_left_small">
				<thead class="tblsite-head">
					<tr height="5px">
								<th class="txtl_table" width="20%">
									 一级菜单
								</th>
								<th class="txtl_table">
									 二级菜单
								</th>
					</tr>
				</thead>
				<tbody class="tbldt-bd">
					<c:forEach items="${listRoleMenu}" var="menu">
					  <c:if test="${menu.pid==0}">
						<tr >
							<td style="padding: 5px" >
									【<c:out value="${menu.title}" />】
							</td>
							<td style="padding: 5px">
							<c:forEach items="${listRoleMenu}" var="childmenu">
							  	<c:if test="${menu.id==childmenu.pid}">
											<c:out value="${childmenu.title}" />&nbsp;&nbsp;
								 </c:if>
							</c:forEach>
							</td>
						</tr>
						
 					   </c:if>
					</c:forEach>
					</tbody>
				</table>
		      </div>
			<!--2.编辑权限信息 end     -->
			
			<div >
				<div style="width: 100%; height: 50px;"></div>
			</div>
			
			<!--3.已授权用户信息 begin   -->
			<div class="subtitle">
		        <span class="subtitlefont">三、已授权用户信息</span>
		    </div>
		   <div class="clearfix">
			 <table id="rowed1"  width="100%" cellspacing="1" class="tablesorter table-00" >
			  <thead class="tblsite-head">
					<tr>
						<th align="left"  width="60px">用户工号</th>
						<th  width="80px">用户姓名</th>
						<th  width="80px">用户手机</th>
						<th  width="80px">用户座机</th>
						<th  width="80px">用户邮箱</th>
						<th  width="80px">上级领导</th>
						<th  width="80px">用户部门</th>
						<th  width="40px">操作</th>
					</tr>
				</thead>
				<tbody class="tbldt-bd">
				    <c:forEach items="${userList}" var="user">
					<tr>
						<td align="left"  width="60px">${user.userName}</td>
						<td  width="80px">${user.objName}</td>
						<td  width="80px">${user.phone}</td>
						<td  width="80px">${user.tel}</td>
						<td  width="80px">${user.email}</td>
						<td  width="80px">${user.leaderName}</td>
						<td  width="80px">${user.department}</td>
						<td  width="40px"><a href="javascript:void(0);" onclick="delUserRole(${user.userRoleID});">删除</a></td>
					</tr>
					</c:forEach>
				</tobdy>
			</table>
			</div>
			</div>
		</div>
			
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>
