<!DOCTYPE HTML>
<%@ page contentType="application/msexcel" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    response.setHeader("Content-disposition","inline; filename=exportData.xls");
%>
<html>
<head>
</head>
<body>
	  <table border="1">
		   <thead>
		   		<tr>
					<th rowspan="2" style="text-align: center">时间</th>
					<th colspan="3" style="text-align: center">汇总</th>
					<th colspan="3" style="text-align: center">分平台新增激活数</th>
					<th  colspan="6" style="text-align: center">主要渠道新增激活数</th>
				</tr>
				<tr>
					<th style="text-align: center">新增激活数</th>
					<th style="text-align: center">当前激活数</th>
					<th style="text-align: center">当月累计激活数</th>
					<th style="text-align: center">IOS</th>
					<th style="text-align: center">Android</th>
					<th style="text-align: center">Windows</th>
					<th style="text-align: center">站内渠道</th>
					<th style="text-align: center">站外线上渠道</th>
					<th style="text-align: center">站外线上渠道付费</th>
					<th style="text-align: center">终端商合作</th>
					<th style="text-align: center">运营商合作</th>
					<th style="text-align: center">站外线下渠道付费</th>
				</tr>
		   </thead>
		   <s:iterator value="exportData" >
			<tr>
				<td>${date}</td>
				<td>${newActivateCountAll}</td>
				<td>${currentCount}</td>
				<td>${accumulativeCountAll}</td>
				<td>${newIOS}</td>
				<td>${newAndroid}</td>
				<td>${newWindows}</td>
				<td>${newFrom2069}</td>
				<td>${newFrom2070}</td>
				<td>${newFrom2071}</td>
				<td>${newFrom5}</td>
				<td>${newFrom1}</td>
				<td>${newFrom2072}</td>
			</tr>
		</s:iterator>
		   
		</table>
</body>
</html>
