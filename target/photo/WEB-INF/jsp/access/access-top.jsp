<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>
<html>
<head>
<title>人人网数据平台-Dolphin数据分析系统-访问排行</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/top/top.css" media="all" /> 
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
					<button type="button" style="padding:2px 5px 2px;font-size:13px;float:right" onclick="search()" class="btn btn-primary">查询</button>
				</div>
			</div>
			<div class="subtitle" style="float:left">
				     <form  class="form-horizontal" action="${ctx}/access/toAccessTopPage.action" id="tef" name="tef">
					     <fieldset style="height:auto">
					     	 <div class="control-group">
								<label class="control-label" for="focusedInput">开始时间</label>
								<div class="controls">
								<input name="templateVo.start_time" value="${templateVo.start_time}" onfocus="timeFocusBegin()" type="text" class="input-medium focused Wdate"  id="d4311" /> 
								</div>
							  </div>
							   <div class="control-group">
								<label class="control-label" for="focusedInput">结束时间</label>
								<div class="controls">
								<input name="templateVo.end_time" value="${templateVo.end_time}" onfocus="timeFocusEnd()" type="text"  class="input-medium focused Wdate" id="d4312" />
								</div>
							  </div>
					     </fieldset>
		 			 </form>
			 </div>
			<div class="bt_page">
	        <div class="col-all " >
	            <div >
	            	<div class="line_box paihang_jdtbox">
	                  <h3><span><a href="javaScript:;">用户访问Top</a></span></h3>
	                  <ol class="jdt_ol">
	                  		<li>
								<a href="javaScript:;" >用户</a>
	        					<div class="jdt_box">
		        					<div class="jdt_weizhi"></div>
		        					<span class="jdt_num">访问次数</span>
	        					</div>
	        				</li>
	                    <s:iterator value="userTop" var="user" status="ix">
							<li>
								<a href="" target="_self" id="${user.userCard }" class="userLink">
									<span <s:if test='#ix.index<=4'>class="t1" </s:if><s:else> class="t2" </s:else> >${ix.index + 1}</span>${user.userName } 
								</a>
	        					<div class="jdt_box">
		        					<div class="jdt_weizhi"><p style="width:${user.rate + 1 }%"></p></div>
		        					<span class="jdt_num">${user.accessNum } </span>
	        					</div>
	        				</li>
						</s:iterator>
	                  </ol>
	                  <div class="clear">
                      </div>
	              	</div> 
	                <div class="line_box paihang_jdtbox">
	                    <h3><span><a href="javaScript:;">模块访问Top</a></span></h3>
						<ol class="jdt_ol" >
						    <li>
								<a href="javaScript:;" >模块</a>
	        					<div class="jdt_box">
		        					<div class="jdt_weizhi"></div>
		        					<span class="jdt_num">访问次数</span>
	        					</div>
	        				</li>
						<s:iterator value="moduleTop" var="module" status="ix">
							<li>
								<a href="" target="_self" id="${module.moduleId }" class="moduleLink">
									<span <s:if test='#ix.index<=4'>class="t1" </s:if><s:else> class="t2" </s:else> >${ix.index + 1}</span>${module.moduleName }
								</a>
	        					<div class="jdt_box">
		        					<div class="jdt_weizhi"><p style="width:${module.rate + 1 }%"></p></div>
		        					<span class="jdt_num">${module.accessNum } </span>
	        					</div>
	        				</li>
						</s:iterator>
	                    </ol>
	                    <div class="clear">
                        </div>
	              </div>
	            </div>
	        </div>
		</div>
	</div>
</div>
<!--footer-->
	<jsp:include page="/include/footer.jsp" flush="true" />
	<script>
	$(function (){
		$("#d4311").val('${templateVo.start_time}');
		$("#d4312").val('${templateVo.end_time}');
		
		$(".userLink").each(function(index,domEle){
			$("#"+domEle.id).attr("href","${ctx}/access/toAccessUserDetailPage.action?userCard=" + domEle.id +"&"+ $("#tef").serialize());
		});
		$(".moduleLink").each(function(index,domEle){
			$("#"+domEle.id).attr("href","${ctx}/access/toAccessModuleDetailPage.action?moduleId=" + domEle.id +"&"+ $("#tef").serialize());
		});
		
	});
		function search(){
			$("#tef").submit();
		}
	</script>
</body>
</html>



