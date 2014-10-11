<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-参数列表</title>
<%@ include file="/include/script.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/css/TableTools.css"/>
<script type="text/javascript" src="${ctx}/js/ZeroClipboard.js"></script>
<script type="text/javascript" src="${ctx}/js/TableTools.js"></script>
<style>
</style>
</head>
<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			     <div class="tablistbox">
					<span class="anas-type">参数列表-${tbname }</span>
					<div style="float:right;width:250px;"> 
					<a class="btn btn-success" href="#" onclick="add()"  style="margin-left:5px;color:#ffffff;"><i class="icon-plus icon-white"></i>添加</a>
					 <a class="btn btn-info" onclick="updateData()"  style="margin-left:5px;color:#ffffff;"><i class="icon-edit icon-white"></i>更新</a>
					 <a class="btn btn-primary" onclick="viewData()"  style="margin-left:5px;color:#ffffff;"><i class="icon-zoom-in icon-white"></i>查看</a>
					<a class="btn btn-danger"  href="#" onclick="delIt()" style="margin-left:5px;color:#ffffff;"><i class="icon-trash icon-white"></i>删除</a>
						</div>
				</div>
			    
			<div id="maingrid" style="margin: 0; padding: 0;float:left;width:100%;margin-top:0px">
			  <table id="contentlist" class="table table-striped table-bordered bootstrap-datatable datatable">
			  </table>
			</div>
		</div>
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
	<div id="myModal"></div>
</body>
</html>
<script>
var options={};
options.sAjaxSource="${ctx}/parameter/loadDataTable.action?tbname=${tbname}";
options.bServerSide=false;
options.aoColumns=[
	              ${tableHead}
	             ];
options.bFilter=true;
options.oTableTools={"sRowSelect": "single","aButtons":[]};
	            	    
oTable= SP.loadTableInfo($("#contentlist"),options);
//var oTableTools = new TableTools(oTable, {"sRowSelect": "single","aButtons":[]});
 //   aButtons: [],
 //   sRowSelect: "single"
//});	   
function add(){
	this.location.href="${ctx}/parameter/toAddPage.action?tbname=${tbname}";
}
function updateData(){
	var oTT = TableTools.fnGetInstance( 'contentlist' );
    var aData = oTT.fnGetSelectedData();
	   if(aData==null){
	    	alert("点击一行选中!");
	    	return;
	    }
    this.location.href="${ctx}/parameter/toUpdatePage.action?tbname=${tbname}&priKey="+aData[0]['${priKey}']+"&key=${priKey}";
}
function viewData(){
	var oTT = TableTools.fnGetInstance( 'contentlist' );
    var aData = oTT.fnGetSelectedData();
	   if(aData==null){
	    	alert("点击一行选中!");
	    	return;
	    }
    this.location.href="${ctx}/parameter/toViewPage.action?tbname=${tbname}&priKey="+aData[0]['${priKey}']+"&key=${priKey}";
}
function delIt(){
	var oTT = TableTools.fnGetInstance( 'contentlist' );
    var aData = oTT.fnGetSelectedData();
    if(aData==null){
    	alert("点击一行选中!");
    	return;
    }
    var options1={};
    options1.type="post";
    options1.url="${ctx}/parameter/delParamter.action?tbname=${tbname}&priKey="+aData[0]['${priKey}'];
    options1.data={};
    options1.success=function(){
    	noty($.parseJSON('{"text":"操作成功","layout":"bottomLeft","type":"success"}'));
    	oTable.fnDeleteRow($(".DTTT_selected")[0])}
    
	  $('#myModal', window.parent.document).confirmModal({
			heading: '删除参数id:'+aData[0]['${priKey}'],
			callback: function () {
				SP.ajax(null,options1,false);
			}
	  });
}
</script>
