<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-资源管理</title>
<%@ include file="/include/script.jsp"%>
<script type="text/javascript">
   function editSource() {
	   var ids="";
	   $("input[name=menuIDS]:checkbox").each(function() {
			if($(this).attr("checked")=="checked"){
			   ids=ids+$(this).val()+",";
			}
		});
	   
		if(""==ids){
			LG.showError("请选择一个菜单进行编辑.");
			return;
		}
		ids=ids.substr(0,ids.length-1);
		var idsArray = ids.split(",");
		if(idsArray.length!=1){	
			LG.showError("请选择一个菜单进行编辑.");
			return;
		}
		window.location.href = "${ctx}/security/enterAddOrEditSource.action?menuId="+ids;
	}
			
   function addSource() {
		window.location.href = "${ctx}/security/enterAddOrEditSource.action";
   }
		
	function delSource() {
		var ids="";
		$("input[name=menuIDS]:checkbox").each(function() {
			if($(this).attr("checked")=="checked"){
			   ids=ids+$(this).val()+",";
			   checkChildMenu($(this).val());
			}
		});
		if(""==ids){
			LG.showError("请选择一个菜单进行编辑.");
			return;
		}
		ids=ids.substr(0,ids.length-1);
		var idsArray = ids.split(",");
		
		
		$.ligerDialog.confirm("您确认删除该菜单吗?如果选择了一级菜单，则系统会自动删除该菜单所有的下属二级菜单。", function(yes) {
		if (yes) {
			$.ajax({
				type : 'post',
				cache : false,
				dataType : 'json',
				async : false,
				url : '${ctx}/security/delSource.action?menuIDS='+ ids,
				success : function(data) {
					var jsonData = toJsonObject(data);
					if (jsonData.success) {
						LG.showSuccess(jsonData.msg);
						window.location.href = "${ctx}/security/enterSource.action";
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
 	  }
</script>
</head>
	<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">
							资源管理
				</span>
			</div>
			<!--1.资源信息 begin   -->
			<div class="subtitle">
		        <span class="subtitlefont">资源信息列表</span>
		    </div>
			<div class="clearfix">
			
			
			<div style="width: 100%;">
								<div class="l-toolbar-item l-panel-btn l-toolbar-item-hasicon" onclick="addSource();">
								<span >增加</span>
								<div class="l-panel-btn-l"></div>
								<div class="l-panel-btn-r"></div>
								<div class="l-icon l-icon-add"></div>
								</div>
								<div class="l-bar-separator"></div>
								<div class="l-toolbar-item l-panel-btn l-toolbar-item-hasicon" onclick="editSource();">
								<span >编辑</span>
								<div class="l-panel-btn-l"></div>
								<div class="l-panel-btn-r"></div>
								<div class="l-icon l-icon-edit"></div>
								</div>
								<div class="l-bar-separator"></div>
								<div class="l-toolbar-item l-panel-btn l-toolbar-item-hasicon" onclick="delSource();">
								<span  >删除</span>
								<div class="l-panel-btn-l"></div>
								<div class="l-panel-btn-r"></div>
								<div class="l-icon l-icon-delete"></div>
								</div>
								</div>
			</div>
			
		    <!-- -----菜单------ -->
			<div style="height: 600px; width: 100%; overflow-y: scroll; OVERFLOW-x: none;margin-top: 5px">
			<table style="width:95%;cellspacing:0;cellpadding:0;border:1" class="tblsite table_left table_left_small">
				<thead class="tblsite-head">
				<tr>
							<th class="txtl_table" width="20%">
								 一级菜单
							</th>
							<th class="txtl_table">
								 二级菜单
							</th>
							<th class="txtl_table" style="padding: 5px">
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
							<input type="checkbox" name="menuIDS"  value="${menu.id}" id="menu_${menu.id}" />
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
								<input type="checkbox" name="menuIDS"  value="${childmenu.id}" id="child_${childmenu.id}" pid="menu_${menu.id}" menuTitle="${childmenu.title}"/>
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
			<!--2.编辑权限信息 end     -->
			<div >
		</div>
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>