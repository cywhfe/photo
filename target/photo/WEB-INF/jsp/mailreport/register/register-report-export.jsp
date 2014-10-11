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
		   <thead >
		   		<tr>
					<th rowspan="2" style="text-align: center">时间</th>
					<th colspan="4" style="text-align: center">汇总</th>
					<th  colspan="6" style="text-align: center">客户端主要渠道注册数 </th>
					<th colspan="2" style="text-align: center">2014年客户端累计注册</th>
				</tr>
				<tr>
					<th style="text-align: center">总注册数</th>
					<th style="text-align: center">客户端</th>
					<th style="text-align: center">wap&tauch</th>
					<th style="text-align: center">其他</th>
					<th style="text-align: center">站内渠道</th>
					<th style="text-align: center">站外线上渠道</th>
					<th style="text-align: center">站外线上渠道付费</th>
					<th style="text-align: center">终端商合作</th>
					<th style="text-align: center">运营商合作</th>
					<th style="text-align: center">站外线下渠道付费</th>
					<th style="text-align: center">累计注册量</th>
					<th style="text-align: center">累计注册用户占当日客户端登录比</th>
				</tr>
		   </thead>
		   <s:iterator value="exportData" >
			<tr>
				<td>${date}</td>
				<td>${numAll}</td>
				<td>${numType1}</td>
				<td>${numType2}</td>
				<td>${numType4}</td>
				<td>${numFrom2069}</td>
				<td>${numFrom2070}</td>
				<td>${numFrom2071}</td>
				<td>${numFrom5}</td>
				<td>${numFrom1}</td>
				<td>${numFrom2072}</td>
				<td>${numRegister2014}</td>
				<td>${proportion}</td>
			</tr>
		</s:iterator>
		   
		</table>
</body>
</html>
