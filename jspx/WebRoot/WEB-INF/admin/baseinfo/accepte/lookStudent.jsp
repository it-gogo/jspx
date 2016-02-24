<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/accepte.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"../accepte/studentList.do?classId=${vo.classId}&schoolId=${vo.schoolId}&status=1",id:"grid",pagination:false};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
/**
*显示性别
*/
function showSex(value,row,index){
	if(value==1){
		return "男";
	}else{
		return "女";
	}
}
/**
*显示状态
*/
function showStatus(value,row,index){
	if(value==1){
		return "申请";
	}else if(value==2){
		return "通过";
	}else if(value==3){
		return "不通过";
	}
}


</script>
		
	</head>
<body>
	<div class="easyui-layout" data-options="fit:'true'">
		<div data-options="region:'center'">
			<div class="easyui-panel" style="padding:5px;" data-options="fit:true,border:false">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north'" style="height:35px;">
						<div style="width:100%;height:100%">
							<form id="qform">
								<table>
									<tr>
										<td>姓名:</td>
										<td>
											<input type="text" class="easyui-validatebox" id="studentName"   value=""> 
										</td>
										<td>学校名称:</td>
										<td>
											<input type="text" class="easyui-validatebox" id="schoolName"   value=""> 
										</td>
										<td>
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="deleteAllF();">删 除</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="acceptedList();">通过</a> &nbsp;&nbsp;&nbsp;  
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="unAceptedList();">不通过</a> &nbsp;&nbsp;&nbsp;  
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
									<th data-options="field:'id',checkbox:true"></th>
									<th data-options="field:'studentName'" width="100">姓名</th>
									<th data-options="field:'schoolName'" width="150">附属学校</th>
									<th data-options="field:'sex'" width="50" formatter="showSex"  >性别</th>
									<th data-options="field:'status'" width="50" formatter="showStatus"  >状态</th>
									<th data-options="field:'reason'" width="200"   >原因</th>
									<th data-options="field:'handler'" width="100" formatter="accepteStr">操作</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
