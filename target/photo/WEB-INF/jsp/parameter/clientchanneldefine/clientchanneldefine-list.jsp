<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-参数管理-访问渠道定义</title>
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
				<span class="anas-type">参数管理-访问渠道定义</span>
			
			<form id="formsearch" class="l-form" name="caForm">
					<ul id="tablist" class="tablist clearfix" style="margin-right: -100px;float: left;">
						<li class="curtab" >
							<dd>
								渠道名称：<input id="clientChannelDefine.name" type="text" name="clientChannelDefine.name" />
							</dd>
						</li>	
					</ul>
					<span class="check-comp"> 
					<input type="button" value="查询" onclick="return f_search_action()" class="button button2 buttonnoicon" style="width: 60px; float: left;"> 
					<input type="button" value="导出"  onclick="exportData()" class="button button2 buttonnoicon" style="width: 60px; float: left;"> 
					</span>
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
					display : '渠道ID',
					name : 'id',
					align : 'center',
					width : 100,
					minWidth : 50,
				}, 
				{
					display : 'from_id',
					name : 'from_id',
					align : 'center',
					width : 100,
					minWidth : 50,
				}, 
				{
					display : 'level1_name',
					name : 'level1_name',
					align : 'center',
					width : 150,
					minWidth : 50,
				},
				{
					display : 'level2_name',
					name : 'level2_name',
					align : 'center',
					width : 150,
					minWidth : 50,
				}
				,
				{
					display : 'level3_name',
					name : 'level3_name',
					align : 'center',
					width : 150,
					minWidth : 50,
				},
				{
					display : 'level4_name',
					name : 'level4_name',
					align : 'center',
					width : 150,
					minWidth : 50,
				},
				{
					display : '说明',
					name : 'descinfo',
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
				pageSizeOptions : [ 20, 30, 40, 50, 100, 100000 ],
				url : "${ctx}/parameter/clientChannelDefineList.action",
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
			var id="";
			var data = manager.getCheckedRows();
			if(data.length!=1){	
				LG.showError("请选择一条数据进行编辑.");
				return;
			}
			id = data[0].id;
			window.location.href = "${ctx}/parameter/clientChannelDefineEnterEdit.action?clientChannelDefine.id="+id;
		}
		
		function add() {
			window.location.href = "${ctx}/parameter/clientChannelDefineEnterAdd.action";
		}
		
		function del() {
				var ids="";
				var data = manager.getCheckedRows();
				if(data.length<=0){
					LG.showError("请选择要删除的记录.");
					return;
				}
				for ( var i = 0; i < data.length; i++) {
					ids= ids+data[i].id+",";
				}
			    $.ligerDialog.confirm("您确认删除该数据吗?", function(yes){
					if(yes){
						$.ajax({
							type : 'post',
							cache : false,
							dataType : 'json',
							async : false,
							data : "ids="+ ids,
							url : '${ctx}/parameter/clientChannelDefineDel.action',
							success : function(data) {
								var jsonData = toJsonObject(data);
								if (jsonData.success) {
									LG.showSucceclientChannelDefine.namess(jsonData.msg);
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
		
		function exportData(){
		    window.location.href="${ctx}/parameter/clientChanelDefineExport.action?page=1&pagesize=100000"+"";
			//SP.exportExcel("${ctx}/parameter/clientChanelDefineExport.action");;
		}
		
	</script>
</body>
</html>
