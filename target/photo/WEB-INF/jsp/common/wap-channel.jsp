<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="control-group" id="wapchannelDiv" style="width:450px;display:none">
	<label class="control-label" for="appendedInputButton">渠道</label>
	<div class="controls">
		<input  style="width:200px;float:left" name="templateVo.wap_channel"  class="input-medium focused" id="wapChannelInput" size="16" type="text" >
		<button onclick="showWapChannelModal()"id="channelsel"  style="float:left" class="btn" type="button">选择</button>
	</div>
 </div>


<div class="modal hide fade" id="wapModalFrom">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">×</button>
		<h3>选择渠道</h3>
	</div>
	<div class="modal-body">
	   <table id="wapchannelTab" class="table table-striped table-bordered bootstrap-datatable datatable">
			   <thead>
			   </thead>
	   </table>
	</div>
	<div class="modal-footer">
		<a  data-dismiss="modal" onclick="sureWapChannel()" style="padding:4px 10px 4px;font-size:13px;" class="btn btn-primary">确定</a>
		<a  style="padding:4px 10px 4px;font-size:13px;margin-left:20px" class="btn" data-dismiss="modal">取消</a>
	</div>
</div>