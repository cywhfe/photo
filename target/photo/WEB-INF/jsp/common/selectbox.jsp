<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/include/taglibs.jsp"%>


<%--  <div class="control-group"  id="third_app_id_div" style="display:none">
								<label class="control-label" for="selectError">Appid</label>
								<div class="controls">
								 <s:select disabled="true"  headerKey="-1" headerValue="请选择" 
								  listKey="id" cssStyle="width: 120px" listValue="name" name="templateVo.app_id" list="appThirdList" ></s:select>
								</div>
 </div> --%>
							  

<div class="control-group" id="third_app_id_div" style="display: none">
	<label class="control-label" for="selectError">Appid</label>
	<div class="controls">
		<select name="templateVo.app_id" disabled="true"  id="appidsel" style="width: 120px">
			<option value="-1">请选择</option>
			<c:if test="${!empty appThirdList}">
				<c:forEach items="${appThirdList}" var="entity">
					<option value="${entity.id}">${entity.name}</option>
				</c:forEach>
			</c:if>
		</select>
	</div>
</div>

<div class="control-group selcal" id="device_id_div">
	<label class="control-label" for="selectError">设&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;备</label>
	<div class="controls">
		<select name="templateVo.device_id" disabled="true" id="device_id" style="width: 120px">
			<option value="-1">请选择</option>
			<c:if test="${!empty deviceList}">
				<c:forEach items="${deviceList}" var="entity">
					<option value="${entity.id}">${entity.name}</option>
				</c:forEach>
			</c:if>
		</select>
	</div>
</div>

<div class="control-group selcal" id="os_id_div">
	<label class="control-label" for="selectError">平&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;台</label>
	<div class="controls">
		<select name="templateVo.os_id" disabled="true" style="width: 120px" id="os_id" onchange="loadAppidInfo(this.value);">
			<option value="-1">请选择</option>
			<c:if test="${!empty platfromList}">
				<c:forEach items="${platfromList}" var="entity">
					<option value="${entity.id}">${entity.name}</option>
				</c:forEach>
			</c:if>
		</select>
	</div>
</div>

<div class="control-group selcal" id="app_id_div">
	<label class="control-label" for="selectError">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AppID</label>
	<div class="controls">
		<select name="templateVo.app_id" disabled="true" style="width: 120px" id="app_id" onchange="loadAppidVersion(this.value);">
		</select>
	</div>
</div>

<div class="control-group selcal" id="client_version_div">
	<label class="control-label" for="selectError">版&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本</label>
	<div class="controls">
		<select disabled="true" id="client_version" name="templateVo.version" style="width: 120px"></select>
	</div>
</div>
