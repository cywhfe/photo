<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <div class="control-group channel" style="width:350px">
								<label class="control-label" for="appendedInputButton">一级渠道</label>
								<div class="controls">
									<input disabled="true" style="width:200px;float:left" onchange="oneChange(this.value)" name="templateVo.one_channel_id"  class="input-medium focused validate[custom[number]]" id="onChannelInput" size="16" type="text"  value="">
									<button onclick="showOneModal()"id="onesel"  style="float:left" class="btn" type="button">选择</button>
								</div>
							  </div>
							  <div class="control-group channel" style="width:350px">
								<label class="control-label" for="appendedInputButton">四级渠道</label>
								<div class="controls">
									<input disabled="true" style="width:200px;float:left" onchange="fourChange(this.value)" name="templateVo.four_channel_fromid"  class="input-medium focused validate[custom[number]]" id="fourChannelInput" size="16" type="text" value="">
									<button onclick="showFourModal()" id="foursel"  style="float:left" class="btn" type="button">选择</button>
								</div>
</div>

	<div class="control-group" id="visitform" style="width:350px;display:none">
								<label class="control-label" for="appendedInputButton">渠道</label>
								<div class="controls">
									<input disabled="true" style="width:200px;float:left" onchange="channelChange(this.value)" name="templateVo.from_id"  class="input-medium focused" id="fromChannelInput" size="16" type="text" onchange="channelChange()"  value="">
									<button onclick="showFromChannelModal()"id="channelsel"  style="float:left" class="btn" type="button">选择</button>
								</div>
							  </div>


	  <div class="modal hide fade" id="myModal">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>选择一级渠道</h3>
			</div>
			<div class="modal-body">
			   <table id="ochannel" class="table table-striped table-bordered bootstrap-datatable datatable">
						   <thead>
						   </thead>
			   </table>
			</div>
			<div class="modal-footer">
				<a  data-dismiss="modal" onclick="sureOne()" style="padding:4px 10px 4px;font-size:13px;" class="btn btn-primary">确定</a>
				<a  style="padding:4px 10px 4px;font-size:13px;margin-left:20px" class="btn" data-dismiss="modal">取消</a>
			</div>
		</div>
		
							  
		<div class="modal hide fade" id="myModalFour">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>选择四级渠道</h3>
			</div>
			<div class="modal-body">
				<div style="float:right">
				  <span style="float:left;margin-top:4px">输入渠道From_ID</span>
				  <input style="width:220px;float:left" class="input-medium focused" id="otherId" size="16" type="text">
				  <span style="width:120px;font-size:11px;color:#888888">多个以逗号分割</span>
				</div>
			   <table id="fourchannel" class="table table-striped table-bordered bootstrap-datatable datatable">
						   <thead>
						   </thead>
			   </table>
			</div>
			<div class="modal-footer">
				<a  data-dismiss="modal" onclick="sureFour()" style="padding:4px 10px 4px;font-size:13px;" class="btn btn-primary">确定</a>
				<a  style="padding:4px 10px 4px;font-size:13px;margin-left:20px" class="btn" data-dismiss="modal">取消</a>
			</div>
		</div>
		
		
		
		<div class="modal hide fade" id="myModalFrom">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>选择渠道</h3>
			</div>
			<div class="modal-body">
			   <table id="fromchannel" class="table table-striped table-bordered bootstrap-datatable datatable">
						   <thead>
						   </thead>
			   </table>
			</div>
			<div class="modal-footer">
				<a  data-dismiss="modal" onclick="sureFrom()" style="padding:4px 10px 4px;font-size:13px;" class="btn btn-primary">确定</a>
				<a  style="padding:4px 10px 4px;font-size:13px;margin-left:20px" class="btn" data-dismiss="modal">取消</a>
			</div>
		</div>