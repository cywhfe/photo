<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<html>
<head>
<title>人人网数据平台-Dolphin数据分析系统-访问排行</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/top/detail.css" media="all" /> 
<%@ include file="/include/script.jsp"%>
<script src="${ctx}/js/export/export.js" type="text/javascript"></script> 
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
</head>
<body>
	<jsp:include page="/include/header.jsp" flush="true" />
	<div class="page-content clearfix">
		<jsp:include page="/include/left.jsp" flush="true" />
		<!--con-right-->
		<div class="c-right fl">
			<div class="tablistbox">
				<span class="anas-type">系统访问排行榜</span>
				<div style="float:right;width:100px;">
					<button type="button" style="padding:2px 5px 2px;font-size:13px;float:right" onclick="javaScript:history.back();" class="btn btn-primary">返回</button>
				</div>
			</div>
			<div class="bt_page">
        <div class="col-con">
            <div class="line_box c0708_03">

                <div  class="gz_cs" style="z-index: 10; ">
                    <h4>[<span id="totalRank"><strong>${accessVo.userName}</strong></span>]访问模块明细<span id="totalRank">(访问模块总数：<strong>${size }</strong>)</span></h4>
                    <div class="c0712">
                        <ul id="sortListUL">
                            <li class="t">
                            	<span class="t01">模块</span>
                            	<span class="t02">访问次数</span>
                            </li>
                            <s:iterator value="userDetail" var="module" status="ix">
							<li>
								<span <s:if test='#ix.index<=4'>class="t1" </s:if><s:else> class="t2" </s:else> >${ix.index + 1}</span><span class="n">${module.moduleName }</span>
								<span class="count">${module.accessNum } </span>
								<span class="scale"><div style="width: ${module.rate + 1 }%;"></div></span>
							</li>
							</s:iterator>
							</ul>
                        <div class="clear">
                        </div>
                    </div>
                </div>
            </div>
        </div>
</div>
			
	</div>
</div>
	<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
</body>
</html>



