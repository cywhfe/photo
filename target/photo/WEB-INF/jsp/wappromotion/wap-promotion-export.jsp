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
					<th style="text-align: center">日期</th>
					<th style="text-align: center">星期</th>
					<s:if test='channelFlag==1'>
					<th style="text-align: center">渠道Id</th>
					<th style="text-align: center">渠道名称</th>
					</s:if>
					<th style="text-align: center">点击人数</th>
					<th style="text-align: center">点击次数</th>
				</tr>
		   </thead>
		   <s:iterator value="dataList" >
			<tr>
				<td>${date}</td>
				<td>${day}</td>
				<s:if test='channelFlag==1'>
				<td>${channelId}</td>
				<td>${channelName}</td>
				</s:if>
				<td>${uv}</td>
				<td>${pv}</td>
			</tr>
		</s:iterator>
		   
		</table>
</body>
</html>
