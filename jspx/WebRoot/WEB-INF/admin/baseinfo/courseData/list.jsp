<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/courseData.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
		 		var courseId=$("#courseId","#qform").val();
			  	var gridoption = {url:"list.do?courseId="+courseId,id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
/**
*操作
*/
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='loadF("+json+")';>修 改</a> <a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-cancel' plain='true' onclick='deleteF("+json+")';>删 除</a> <a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-filter' plain='true' onclick='downloadData("+json+")';>下 载</a> ";
     return  handstr;
}
/**
*下载资料
*/
function downloadData(row){
	
	var fileUrl=row.dataUrl;
	if(fileUrl==""){
		parent.$.messager.alert("提示窗口","没有上传课程资料。");
		return;
	}
	$.ajax({
		url:"../../common/exists.do",
		data:"fileUrl="+fileUrl,
		success:function(data){
			var json=eval("("+data+")");
			if(json.message){
				var fileName=encodeURI(row.name);
				location.href="../../common/downloadData.do?fileName="+fileName+"&fileUrl="+fileUrl;
			}else{
				parent.$.messager.alert("提示窗口",json.error);
			}
		}
	});
}

</script>
		
	</head>
<body>
	<div class="easyui-panel" style="padding:0px;" data-options="fit:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north'" style="height:35px;">
				<div style="width:100%;height:100%;">
					<form class="bjaa" id="qform">
						<input type="hidden" class="easyui-validatebox" id="courseId"   value="${vo.courseId }">
						<input type="hidden" class="easyui-validatebox" id="index"   value="${vo.index }">    
						<table>
							<tr>
								<td>
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新 增</a> &nbsp;&nbsp; 
									<!-- <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="deleteAllF();">删 除</a> &nbsp;&nbsp;  -->
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
			<div data-options="region:'center'">
				<table id="grid">
					<thead>
						<tr>
							<th data-options="field:'id',checkbox:true"  ></th>
							<th data-options="field:'name'" width="40">名称</th>
							<th data-options="field:'dataUrl'" width="50"  >资料地址</th>
							<th data-options="field:'remark'" width="120">备注</th>
							<th data-options="field:'handler'" width="100" formatter="handlerstr">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
