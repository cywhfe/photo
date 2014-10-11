<!DOCTYPE HTML>
<%@ page contentType="application/msexcel" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    response.setHeader("Content-disposition",
        "inline; filename=txExportData.xls");
%>
<html>
<head>
</head>
<body>
	<table border="1">
		<thead>
			<tr align="center">
				<th rowspan="3" align="center">时间</th>
				<th rowspan="3" align="center">消息类型</th>
				<th rowspan="2" colspan="2" align="center">总量</th>
				<th colspan="6" align="center">单聊</th>
				<th colspan="6" align="center">群聊</th>
			</tr>
			<tr align="center">
				<th colspan="2" align="center">客户端</th>
				<th colspan="2" align="center">webpager</th>
				<th colspan="2" align="center">人人桌面</th>
				<th colspan="2" align="center">客户端</th>
				<th colspan="2" align="center">webpager</th>
				<th colspan="2" align="center">人人桌面</th>
			</tr>
			<tr>
				<th align="center">使用人数</th>
				<th align="center">发送量</th>
				<th align="center">使用人数</th>
				<th align="center">发送量</th>
				<th align="center">使用人数</th>
				<th align="center">发送量</th>
				<th align="center">使用人数</th>
				<th align="center">发送量</th>
				<th align="center">使用人数</th>
				<th align="center">发送量</th>
				<th align="center">使用人数</th>
				<th align="center">发送量</th>
				<th align="center">使用人数</th>
				<th align="center">发送量</th>
			</tr>
		</thead>
		<s:iterator value="exportData" >
			<tr>
				<td>${date}</td>
				<td>${msgType}</td>
				<td>${userNumAll}</td>
				<td>${sendNumAll}</td>
				<td>${userNumAllChar1Plat1}</td>
				<td>${sendNumAllChar1Plat1}</td>
				<td>${userNumAllChar1Plat2}</td>
				<td>${sendNumAllChar1Plat2}</td>
				<td>${userNumAllChar1Plat3}</td>
				<td>${sendNumAllChar1Plat3}</td>
				<td>${userNumAllChar2Plat1}</td>
				<td>${sendNumAllChar2Plat1}</td>
				<td>${userNumAllChar2Plat2}</td>
				<td>${sendNumAllChar2Plat2}</td>
				<td>${userNumAllChar2Plat3}</td>
				<td>${sendNumAllChar2Plat3}</td>
			</tr>
		</s:iterator>
		
	</table>
</body>
</html>
