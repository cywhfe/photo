<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-用户信息</title>
<%@ include file="/include/script.jsp"%>
</head>
	<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">用户详细信息</span>
				<div style="float: right;"> <span class="anas-type" style=""><a href="${ctx}/security/userIndex.action">返回</a></span></div>
			</div>
			
			<!--1.编辑基本信息 begin   -->
			<div class="subtitle">
		        <span class="subtitlefont">一、用户基本资料</span>
		    </div>
 			<table style="width:50%;" class="tblsite table_left table_left_small">
			<tbody class="tbldt-bd">
				
					<tr>
						<td style="width:200px" align="right" class="txtl_table">用户工号：</td>
						<td style="width:450px" align="left">
						 ${user.userName}
						</td>
					</tr>
				
				<tr>
					<td style="width:200px" align="right" class="txtl_table">用户姓名：</td>
					<td style="width:450px" align="left">
					 ${user.objName}
					</td>
				</tr>
				<tr>
					<td style="width:200px" align="right" class="txtl_table">用户手机：</td>
					<td style="width:450px" align="left">
					 ${user.phone} 
					</td>
				</tr>
				<tr>
					<td style="width:200px" align="right" class="txtl_table">用户邮箱：</td>
					<td style="width:450px" align="left">
					 ${user.email}
					</td>
				</tr>
				<tr>
					<td style="width:200px" align="right" class="txtl_table">用户分机：</td>
					<td style="width:450px" align="left">
					 ${user.tel} 
					</td>
				</tr>
			
				<tr>
					<td style="width:200px" align="right" class="txtl_table" >用户部门：</td>
					<td style="width:450px" align="left">
					 ${user.department} 
					</td>
				</tr>
				<tr>
					<td style="width:200px" align="right" class="txtl_table">上级领导：</td>
					<td style="width:450px" align="left">
					 ${user.leaderName} 
					</td>
				</tr>
				<tr>
				<td style="width:200px" align="right" class="txtl_table">职能描述：</td>
				<td style="width:450px" align="left">
					${user.description}
				</td>
			</tr>
 			</tbody>
			</table>
			<!--1.编辑基本信息 end     -->
			
			
			<!--2.编辑权限信息 begin   -->
			<div class="subtitle" style="margin-top: 20px">
		        <span class="subtitlefont">二、角色信息</span>
		    </div>
		   <div class="clearfix" style="margin-top: 20px">
		    <table style="width:50%;" class="tblsite table_left table_left_small">
			<tbody class="tbldt-bd">
			<tr>
				<td style="width:200px" align="right" class="txtl_table">角色名称：</td>
				<td style="width:450px" align="left" >
					<c:forEach items="${user.userRoleList}" var="entry" step="1" begin="0" varStatus="index" >
							<c:if test="${index.count%5==0}">
								<br/>
							</c:if>
							<label class="for" for="roleNames">
								<a href="${ctx}/security/enterRole.action?roleName=${entry.roleName}">
									${entry.roleTitle}
								</a>
							</label>
					 </c:forEach>
				</td>
			</tr>
			</tbody>
			</table>
		    </div>
			<!--2.编辑权限信息 end     -->
		</div>
	</div>
 
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>
