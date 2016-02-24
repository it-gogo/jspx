<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"../teacherInfo/list.do?schoolId=${vo.schoolId}&notApplicationClassId=${vo.classId}&xkIds=${vo.xkIds}&xdIds=${vo.xdIds}",id:"grid",pagination:true,onCheck:function(index,row){checkNumber(index);},onCheckAll:function(row){checkAll(row);}};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
			/**
			*选择学生
			*/
			function selectStudent(){
				 var id=[];
				  id.push(getCheckeds1("grid","id"));
				  if(id==""){
					  parent.$.messager.alert("提示", "至少选择一个学生！", "info");
					  return;
				  }
				  parent.$.messager.confirm("询问", "您确定申请当前学生？", function(b) {
					if (b) {
							/* parent.$.messager.progress({
								title : "提示",
								text : "数据处理中，请稍后...."
							}); */
							$.post("saveApplication.do", {
								studentId : id.join(","),classId:$("#classId").val()
							}, function(result) {
								if (result.message) {
									parent.$.messager.alert("提示", result.message, "info");
									parent.$.createDialog.open_grid.datagrid('reload');
									parent.dialogMap["d3"].dialog('close');
								}else{
									parent.$.messager.alert("提示", result.error, "info");
								}
								/* parent.$.messager.progress("close"); */
							}, "JSON");
						}
				});
			}
function checkNumber(index){
	var number=$("#number").val();
	 var  r = $("#grid").datagrid('getChecked');
	 var selectNumber=r.length;
	 if(selectNumber>number){
	 	parent.$.messager.alert("提示","该学校只剩下"+number+"个名额。", "info");
	 	$("#grid").datagrid("uncheckRow",index);
	 }
}
function checkAll(row){
	var number=$("#number").val();
	 var  r = $("#grid").datagrid('getChecked');
	  var selectNumber=r.length;
	 if(selectNumber>number){
	 	parent.$.messager.alert("提示","该学校只有"+number+"个名额。", "info");
	 	$("#grid").datagrid("clearChecked");
	 }
}
		</script>
		
	</head>
<body>
	<input type="hidden" id="classId" value="${vo.classId}" />
	<input type="hidden" id="number" value="${vo.number}" />
	<div class="easyui-layout" data-options="fit:'true'">
		<div data-options="region:'center'">
			<div class="easyui-panel" style="padding:5px;" data-options="fit:true,border:false">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north'" style="height:35px;">
						<div style="width:100%;height:100%">
							<form id="qform">
								<table>
									<tr>
										<td>名称:</td>
										<td>
											<input type="text" class="easyui-validatebox" id="name"   value=""> 
										<td>
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="selectStudent();">选择</a> &nbsp;&nbsp;&nbsp; 
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
									<th data-options="field:'name'" width="100">姓名</th>
									<th data-options="field:'schoolName'" width="150">附属学校</th>
									<th data-options="field:'telephone'" width="100" >电话</th>
									<th data-options="field:'text'" width="150" >管理账号</th>
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
