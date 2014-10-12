<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<html>
<head>
<title>图片管理</title>
<%@ include file="/include/script.jsp"%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
</head>
<!--header-->
<body>
	<div class="row span12">
		<form class="form-inline" action="" id="form">
				<label for="search_date">日期：</label> <input type="text"
					id="date" name="date" class="form-control" value="${param.date}"
					placeholder="日期" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
			<button type="submit" class="btn btn-default pull-right">查询</button>
		</form>
	</div>
	<div class="row span12">
		<table
			class="table table-striped table-bordered table-condensed table-hover">
			<thead>
				<tr>
					<th>标题</th>
					<th>日期</th>
					<th>图片详细</th>
					<th>管理</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${photoList }" var="photo">
					<tr>
						<td width="20%">${photo.name}</td>
						<td width="10%"><fmt:formatDate value="${photo.date}" pattern="yyyy-MM-dd"/></td>
						<td width="60%"><img alt="${photo.name}" src="${ctx}/tmp/${photo.path}" width="200" height="200"/></td>
						<td width="10%">
							<a href="${ctx}/photo/delete?id=${photo.id}">删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="row span12"><a class="btn btn-default" href="${ctx}/photo/add">添加图片</a></div>
</body>
<script>
	//页面加载完执行
	$(function() {
		
	});
</script>
</html>