<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-参数管理-客户端定义</title>
<%@ include file="/include/script.jsp"%>
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
				<span class="anas-type">参数管理-客户端定义</span>
			
			<form id="formsearch" class="l-form" name="caForm">
					<ul id="tablist" class="tablist clearfix" style="margin-right: -150px;float: left;">
						<li class="curtab" >
							<dd>
								app_id：<input id="app_id" type="text" name="app_id" />
							</dd>
						</li>	
					</ul>
					<span class="check-comp"> <input type="button" value="查询"
						onclick="return f_search_action()"
						class="button button2 buttonnoicon"
						style="width: 60px; float: left;"> </span>
			</form>
			</div>
			 
			<div id="maingrid" style="margin: 0; padding: 0"></div>
			<div style="display: none;">
			</div>
			 
		</div>
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
	<script type="text/javascript">
		var manager;
		var roleType= $("#roleType").val();
		$(function() {
			manager = $("#maingrid").ligerGrid({
				columns : [  {
					display : 'app_id',
					name : 'app_id',
					align : 'center',
					width : 50,
					minWidth : 50,
				}, 
				{
					display : 'name',
					name : 'name',
					align : 'center',
					width : 120,
					minWidth : 50,
				}, 
				{
					display : 'ugc_data',
					name : 'ugc_data',
					align : 'center',
					width : 150,
					minWidth : 50,
				},
				{
					display : 'status',
					name : 'status',
					align : 'center',
					width : 80,
					minWidth : 50,
				}
				,
				{
					display : 'type',
					name : 'type',
					align : 'center',
					width : 80,
					minWidth : 50,
				},
				{
					display : 'show_active',
					name : 'show_active',
					align : 'center',
					width : 80,
					minWidth : 50,
				},
				{
					display : 'is_tool',
					name : 'is_tool',
					align : 'center',
					width : 80,
					minWidth : 50,
				},
				{
					display : 'source',
					name : 'source',
					align : 'center',
					width : 80,
					minWidth : 50,
				},
				{
					display : 'device_id',
					name : 'device_id',
					align : 'center',
					width : 150,
					minWidth : 50,
				},
				{
					display : 'project_id',
					name : 'project_id',
					align : 'center',
					width : 80,
					minWidth : 50,
				},
				{
					display : 'insert_time',
					name : 'insert_time',
					align : 'center',
					width : 150,
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
				url : "${ctx}/parameter/clientDefineList.action",
				toolbar : {
					items : [ {
						text : '刷新',
						click : f_reload,
						disable : false,
						icon : 'refresh'
					}, {
						line : true
					},
					{
						text : '增加',
						disable : false,
						click : add,
						icon : 'add'
					},
					{
						line : true
					},
					{
						text : '编辑',
						disable : false,
						click : edit,
						icon : 'edit'
					},{
						line : true
					},
					{
						text : '删除',
						disable : false,
						click : del,
						icon : 'delete'
					}, {
						line : true
					} 
					
					]
				},
			});
			
			f_reload();
		});
 
		function edit() {
			var app_id="";
			var data = manager.getCheckedRows();
			if(data.length!=1){	
				LG.showError("请选择一条数据进行编辑.");
				return;
			}
			app_id = data[0].app_id;
			window.location.href = "${ctx}/parameter/clientDefineEnterEdit.action?clientDefine.app_id="+app_id;
		}
		
		function add() {
			window.location.href = "${ctx}/parameter/clientDefineEnterAdd.action";
		}
		
		function del() {
				var ids="";
				var data = manager.getCheckedRows();
				if(data.length<=0){
					LG.showError("请选择要删除的记录.");
					return;
				}
				for ( var i = 0; i < data.length; i++) {
					ids= ids+data[i].app_id+",";
				}
			    $.ligerDialog.confirm("您确认删除该数据吗?", function(yes){
					if(yes){
						$.ajax({
							type : 'post',
							cache : false,
							dataType : 'json',
							async : false,
							data : "ids="+ ids,
							url : '${ctx}/parameter/clientDefineDel.action',
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
						
					}});
		}
		
		
		function f_reload() {
			manager.loadData();
		}
		
		function toJsonObject(jsonString) {
			if (typeof jsonString == 'object')
				return jsonString;
			jsonString = jsonString.replace(/^(?:\<pre[^\>]*\>)?(\{.*\})(?:\<\/pre\>)?$/ig, "$1");
			return eval('(' + jsonString + ')');
		}	
		
		function f_search_action() {
			$("#form").trigger("checkInput");
			var form = $("#formsearch");
			LG.searchForm(form, manager);
		}
		
	</script>
</body>
</html>