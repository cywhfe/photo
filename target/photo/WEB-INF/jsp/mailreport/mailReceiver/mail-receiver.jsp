<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-邮件报表-收件人管理</title>
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
				<span class="anas-type">邮件报表_收件人管理</span>
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
		$(function() {
			manager = $("#maingrid").ligerGrid({
				columns : [  {
					display : 'ID',
					name : 'id',
					align : 'center',
					width : 50,
					minWidth : 50,
				}, 
				{
					display : '报表名称',
					name : 'name',
					align : 'center',
					width : 150,
					minWidth : 100,
				}, 
				{
					display : '收件人',
					name : 'mailAddress',
					align : 'center',
					width : 500
				}],
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
				url : "${ctx}/mailreport/mailReceiverList.action",
				toolbar : {
					items : [ {
						text : '刷新',
						click : f_reload,
						disable : false,
						icon : 'refresh'
					}, {line : true},
					{
						text : '增加',
						disable : false,
						click : add,
						icon : 'add'
					},{ line : true },
					{
						text : '编辑',
						disable : false,
						click : edit,
						icon : 'edit'
					},{ line : true },
					{
						text : '删除',
						disable : false,
						click : del,
						icon : 'delete'
					}, { line : true } 
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
			window.location.href = "${ctx}/mailreport/toMailReceiverEdit.action?mailReceiverId="+id;
		}
		
		function add() {
			window.location.href = "${ctx}/mailreport/toMailReceiverAdd.action";
		}
		
		function del() {
				var ids="";
				var data = manager.getCheckedRows();
				if(data.length<=0){
					LG.showError("请选择要删除的记录.");
					return;
				}
				for ( var i = 0; i < data.length; i++) {
					if(i==0){
						ids= ids+data[i].id;
					}else{
						ids= ids+","+data[i].id;
					}
				}
			    $.ligerDialog.confirm("您确认删除该数据吗?", function(yes){
					if(yes){
						$.ajax({
							type : 'post',
							cache : false,
							dataType : 'json',
							async : false,
							data : "ids="+ ids,
							url : '${ctx}/mailreport/delMailReceiver.action',
							success : function(data) {
								f_reload();
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
	</script>
</body>
</html>