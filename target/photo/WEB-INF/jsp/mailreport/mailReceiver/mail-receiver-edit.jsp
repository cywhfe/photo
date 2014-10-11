<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<head>
<title><%=Constants.HTML_SYSTEM_NAME%>-${ugcModelName}</title>
<%@ include file="/include/script.jsp"%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
</head>
<!--header-->
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
	<!--page-content-->
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">邮件报表_收件人管理_修改</span>
			</div>
			<div id="maingrid" style="margin: 0; padding: 0; float: left; width: 100%; margin-top: 5px">
				<form id="tef">
				<input type="hidden"  value="${mailReceiver.id }" name="mailReceiver.id" /> 
				<table id="contentlist" class="table table-striped table-bordered bootstrap-datatable datatable">
					<tr>
						<td width="100px">报表名称:</td>
						<td ><input type="text"  id="mailReceiverName" value="${mailReceiver.name }" name="mailReceiver.name" style="width: 300px;"/></td>
					</tr>
					<tr>
						<td >收件人:</td>
						<td ><textarea rows="12" id="mailReceivermailAddress"name="mailReceiver.mailAddress" style="width: 600px;"> ${mailReceiver.mailAddress }</textarea> &nbsp;多个邮箱以","隔开</td>
					</tr>
					<tr><td colspan="2">
						<button type="button" style="padding:2px 5px 2px;font-size:13px;" onclick="save()" class="btn">保存</button>
						 &nbsp; &nbsp; &nbsp; &nbsp;
						<button type="button" style="padding:2px 5px 2px;font-size:13px;" onclick="goBack()" class="btn">取消</button>
					</td></tr>
				</table>
				</form>
			</div>
		</div>
	</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>
<script>
	function save(){
		if(!checkForm()){
			return ;
		}
		$.ajax({
		    url: "${ctx}/mailreport/updateMailReceiver.action?"+$("#tef").serialize(),
		    dataType: 'json',type: 'post',
		    success: function (res){
		    	if(res.success){
		    		alert('保存成功！');
		    		window.location.href="${ctx}/mailreport/toMailReceiverPage.action";
		    	}else{
		    		alert('保存失败！');
		    	}
		    } 	
		});
	}
	function checkForm(){
		if(!$("#mailReceiverName").val() || $("#mailReceiverName").val()=="" ){
			alert("报表名称不能为空！");
			return false;
		}
		if(!$("#mailReceivermailAddress").val() || $("#mailReceivermailAddress").val()=="" ){
			alert("收件人不能为空！");
			return false;
		}
		if($("#mailReceiverName").val().length>200){
			alert("报表名称不能超过200个字符！");
			return false;
		}
		if($("#mailReceivermailAddress").val().length>1000){
			alert("收件人不能超过1000个字符！");
			return false;
		}
		return true;
	}
	function goBack(){
		window.location.href="${ctx}/mailreport/toMailReceiverPage.action";
	}
</script>
