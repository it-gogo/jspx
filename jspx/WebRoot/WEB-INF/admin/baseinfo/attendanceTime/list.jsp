<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/attendanceTime.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
		 		var classTimeId=$("#classTimeId","#qform").val();
			  	var gridoption = {url:"list.do?classTimeId="+classTimeId,id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
/**
*操作
*/
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='loadF("+json+")';>[修 改]</a> <a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-cancel' plain='true' onclick='deleteF("+json+")';>[删 除]</a> ";
     return  handstr;
}
function showType(value,row,index){
	if(value==1){
		return "上课考勤";
	}else if(value==2){
		return "下课考勤";
	}
}
</script>
		
	</head>
<body>
	<div class="easyui-panel" style="padding:0px;" data-options="fit:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north'" style="height:35px;">
				<div style="width:100%;height:100%">
					<form id="qform">
						<input type="hidden" class="easyui-validatebox" id="classTimeId"   value="${vo.classTimeId }">
						<input type="hidden" class="easyui-validatebox" id="index"   value="${vo.index }">    
						<table>
							<tr>
								<!-- <td>学员姓名:</td>
								<td>
									<input type="text" class="easyui-validatebox" id="studentName"   value="">
								</td>
								<td>学校名称:</td>
								<td>
									<input type="text" class="easyui-validatebox" id="schoolName"   value="">
								</td> -->
								<td>
									<!-- <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;&nbsp; 
									 --><a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新 增</a> &nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="deleteAllF();">删 除</a> &nbsp;&nbsp; 
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
							<th data-options="field:'attendanceTime'" width="100">考勤时间</th>
							<th data-options="field:'type'" width="100" formatter="showType">考勤类型</th>
							<th data-options="field:'beforeAttendance'" width="50">考勤时间前</th>
							<th data-options="field:'afterAttendance'" width="50">考勤时间后</th>
							<th data-options="field:'absenteeism'" width="50">旷课</th>
							<th data-options="field:'handler'" width="150" formatter="handlerstr">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
