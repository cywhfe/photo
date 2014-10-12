<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<html>
<head>
<title>图片添加</title>
<%@ include file="/include/script.jsp"%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
</head>
<!--header-->
<body>
	<div class="row span12">
		<form id="inputForm" action="${ctx}/photo/add" method="post" class="form-horizontal" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${photo.id}"/>
			<fieldset>
				<legend><small>图片信息</small></legend>
				<div class="form-group">
					<label for="name" class="col-sm-2 control-label">标题:</label>
					<div class="col-sm-10">
						<input type="text" id="name" name="name"  value="${photo.name}" class="form-control required"/>
					</div>
				</div>	
				<div class="form-group">
					<label for="date" class="col-sm-2 control-label">日期:</label>
					<div class="col-sm-10">
						<input type="text" id="date" name="date"  value="${photo.date}" class="form-control required" readonly="readonly" style="cursor: auto;"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</div>
				</div>
	            <div class="form-group">
	                <label for="path" class="col-sm-2 control-label">图片:</label>
	                <div class="col-sm-10">
	                    <input type="file" id="path" name="path"  value="${photo.path}" class="form-control required"/>
	                </div>
	            </div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button id="submit_btn" class="btn btn-primary" type="submit">提交</button>&nbsp;	
						<button id="cancel_btn" class="btn btn-default" type="button" onclick="history.back()">返回</button>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
</body>
<script>
	//页面加载完执行
	$(function() {
		//聚焦第一个输入框
		$("#name").focus();
		//为inputForm注册validate函数
		$("#inputForm").validate();
	});
</script>
</html>