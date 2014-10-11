<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<html>
<head>
<title><%=Constants.HTML_SYSTEM_NAME %>-网站概况</title>
<%@ include file="include/script.jsp"%>
</head>
<body>
	<!--header-->
	<jsp:include page="include/header.jsp" flush="true" />
	<div class="page-content clearfix">
		<!--con-left-->
		<jsp:include page="include/left.jsp" flush="true" />
		<!--con-right-->
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">欢迎您访问 &nbsp;<%=Constants.HTML_SYSTEM_NAME %></span>
 			<div align="right"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
			window.location.href = "${ctx}/index.jsp";
	</script>
	 <c:if test="${!empty indexMenuUrl}">
		<script type="text/javascript">
			window.location.href = "${ctx}<%=request.getSession().getAttribute("indexMenuUrl")%>";
	     </script>
	</c:if>
	<c:if test="${empty indexMenuUrl}">
		<script type="text/javascript">
			window.location.href = "${ctx}/about.jsp";
	     </script>
	</c:if>  
</body>
</html>
