<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-用户管理</title>
<%@ include file="/include/script.jsp"%>
<script src="${ctx}/js/ligerUI/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="${ctx}/js/ligerUI/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="${ctx}/js/json2.js" type="text/javascript"></script>
</head>
<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
	<input type="hidden" id="roleType" value="${roleType}"/>
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">用户管理</span>
				<form id="formsearch" class="l-form" name="caForm">
					<ul id="tablist" class="tablist clearfix" style="margin-right: -150px;float: left;">
						<li class="curtab">
							<dd>
								用户工号：<input id="userName" type="text" name="userName" />
							</dd>
						</li>
						<li class="curtab">
							<dd>
								用户姓名：<input id="objName" type="text" name="objName" />
							</dd>
						</li>
					</ul>
					<span class="check-comp"> 
					<input type="button" value="查询" onclick="return f_search_action()" class="button button2 buttonnoicon" style="width: 60px; float: left; margin-left: 10px"> </span>
				</form>
			</div>

 			<div class="subtitle">
		   	     <span class="subtitlefont">1、用户列表</span>
		   	 </div>
			<div id="maingrid" style="margin: 0; padding: 0"></div>
			<div style="display: none;">
				<!-- g data total ttt -->
			</div>
			
			<div class="subtitle" style="margin-top: 20px">
		   	     <span class="subtitlefont">2、权限分配流程 </span>
		   	</div>
			<div >
			   &nbsp; 第一步：进入【角色管理】，增加角色<br>
			   &nbsp; 第二步：进入【用户管理】，增加或编辑用户，分配该角色即可<br>
			</div>
		</div>
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
	<script type="text/javascript">
		var roleType= $("#roleType").val();
		var manager;
		$(function() {
			manager = $("#maingrid").ligerGrid({
				columns : [ 
	           {
					display : '用户工号',
					name : 'userName',
					align : 'center',
					width : 100,
					minWidth : 50,
				},
				            {
					display : '用户姓名',
					name : 'objName',
					align : 'center',
					width : 100,
					minWidth : 50,
				}, 
				 {
					display : '用户部门',
					name : 'department',
					align : 'center',
					width : 200,
					minWidth : 50,
				},
				{
					display : '上级领导',
					name : 'leaderName',
					align : 'center',
					width : 100,
					minWidth : 50,
				}
				, {
					display : '用户手机号',
					name : 'phone',
					align : 'center',
					width : 150,
					minWidth : 50,
				}, {
					display : '用户邮箱',
					name : 'email',
					align : 'center',
					width : 250,
					minWidth : 50,
				}, {
					display : '用户分机',
					name : 'tel',
					align : 'center',
					width : 100,
					minWidth : 50,
				}
				],
				autoCheckChildren : false,
				alternatingRow : false,
				checkbox : true,
				rownumbers : true,
				width : '100%',
				height : '90%',
				heightDiff : -2,
				showTitle : true,
				colDraggable : true,
				isScroll : true, 
				frozen : true,
				pageSize : 20,
				pageSizeOptions : [ 20, 30, 40, 50, 100 ],
				url : "${ctx}/security/userRoleList.action",
				toolbar : {
					items : [ {
						text : '刷新',
						disable : true,
						click : f_reload,
						icon : 'refresh'
					}, {
						line : true
					}
					<c:if test="${roleType!='user'}">
					, {
						text : '新增',
						disable : false,
						click : addUserRole,
						icon : 'add'
					}, {
						line : true
					}, {
						text : '编辑',
						disable : false,
						click : editUserRole,
						icon : 'edit'
					}, {
						line : true
					}
					, {
						text : '删除',
						disable : false,
						click : delUserRole,
						icon : 'delete'
					}, {
						line : true
					},
					 {
						text : '详细信息',
						disable : true,
						click : enterUser,
						icon : 'edit'
					},{
						line : true
					} 
					</c:if>
					]
				},
			});
			
			f_reload();
		});

		
		function editUserRole() {
			var userName="";
			var data = manager.getCheckedRows();
			if(data.length!=1){	
				LG.showError("请选择一个用户进行编辑.");
				return;
			}
			userName = data[0].userName;
			window.location.href = "${ctx}/security/enterAddOrEditUserRole.action?userName="+userName;
		}
		
		function enterUser() {
			var userName="";
			var data = manager.getCheckedRows();
			if(data.length!=1){	
				LG.showError("请选择一个用户进行查看.");
				return;
			}
			userName = data[0].userName;
			window.location.href = "${ctx}/security/enterUser.action?userName="+userName;
		}
		
		
		function addUserRole() {
			window.location.href = "${ctx}/security/enterAddOrEditUserRole.action";
		}
		
		

		function delUserRole() {
			var userNames = "";
			var data = manager.getCheckedRows();
			if (data.length <= 0) {
				LG.showError("请选择要删除的记录.");
				return;
			}
			for ( var i = 0; i < data.length; i++) {
				userNames = userNames + data[i].userName + ",";
			}
			$.ligerDialog.confirm("您确认删除该数据吗?", function(yes) {
				if (yes) {
					$.ajax({
						type : 'post',
						cache : false,
						dataType : 'json',
						async : false,
						url : '${ctx}/security/delUser.action?userNames='+ userNames,
						success : function(data) {
							var jsonData = toJsonObject(data);
							if (jsonData.success) {
								LG.showSuccess(jsonData.msg);
								f_reload();
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
		function f_reload() {
			var operators = new Array();
			operators[0] = true;
			if(roleType!="user"){
				operators[1] = true;
				operators[2] = true;
				operators[3] = true;
				operators[4] = true;
			} else {
				operators[1] = false;
				operators[2] = false;
				operators[3] = false;
				operators[4] = false;
			}
			manager.toolbarManager.updateItem(operators);
			manager.loadData();
		}

		function f_search_action() {
			$("#form").trigger("checkInput");
			var form = $("#formsearch");
			LG.searchForm(form, manager);
		}
		function toJsonObject(jsonString) {
			if (typeof jsonString == 'object')
				return jsonString;
			jsonString = jsonString.replace(
					/^(?:\<pre[^\>]*\>)?(\{.*\})(?:\<\/pre\>)?$/ig, "$1");
			return eval('(' + jsonString + ')');
		}
	</script>
</body>
</html>
