<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/accreditation.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	
			  	var treeoptions = {id:"treeID",url:"../classInfo/all.do",onClick:treeClick};
		  		$.initTree(treeoptions);
		 	});
		 	
		 	
/**
*点击树事件
*/		 	
function  treeClick(node){
 		var  parameter = {};
		var classId=node.id;
		parameter["classId"]=classId;
		$("#classId","#qform").val(classId);//班级ID
		dataGrid.datagrid('load',parameter);
 }
/**
*操作
*/
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='attendance("+json+")';>[出勤情况]</a> "+
     						"<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='homework("+json+")';>[作业列表]</a> ";
    var isPass=row.isPass;
     if(typeof(isPass)=="undefined" || isPass==""){
     	handstr+="<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='pass("+json+")';>[通过]</a> <a href='javascript:void(0)'  iconCls='icon-edit'  onclick='unpass("+json+")';>[未通过]</a>";
     }else if(isPass=="1"){
     	handstr+="<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='print("+json+")';>[打印证书]</a>";
     }
     return  handstr;
}
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
function print(row){
	alert("功能正在开发。。。")
}
/**
*显示是否通过
*/
function showPass(value,row,index){
	 if(typeof(value)=="undefined" || value==""){
	 	return "未确认";
     }else if(value=="1"){
     	return "通过";
     }else if(value=="0"){
     	return "未通过";
     }
}

/**
*通过确认
*/
function pass(row){
	  var id = [];
	  id.push(row.id);
	  parent.$.messager.confirm("询问", "您是否确认"+row.studentName+"学员通过培训？", function(b) {
			if (b) {
					parent.$.messager.progress({
						title : "提示",
						text : "数据处理中，请稍后...."
					});
					$.post("isPass.do",{id:id.join(","),isPass:"1"}, function(result) {
						if (result.message) {
							parent.$.messager.alert("提示", result.message, "info");
							dataGrid.datagrid("reload");
						}else if(result.other){
							//做其他回调函数
						}
						parent.$.messager.progress("close");
					}, "JSON");
				}
			
		});
}
/**
*未通过确认
*/
function unpass(row){
	  var id = [];
	  id.push(row.id);
	  parent.$.messager.confirm("询问", "您是否确认"+row.studentName+"学员未通过培训？", function(b) {
			if (b) {
					parent.$.messager.progress({
						title : "提示",
						text : "数据处理中，请稍后...."
					});
					$.post("isPass.do",{id:id.join(","),isPass:"0"}, function(result) {
						if (result.message) {
							parent.$.messager.alert("提示", result.message, "info");
							dataGrid.datagrid("reload");
						}else if(result.other){
							//做其他回调函数
						}
						parent.$.messager.progress("close");
					}, "JSON");
				}
			
		});
}
</script>
		
	</head>
<body>
	<div class="easyui-layout" data-options="fit:'true'">
		<div data-options="region:'west',split:true,title:'班级树',collapsible:true" style="width:200px;">
			<%@include file="/WEB-INF/admin/common/tree.jsp"%>
		</div>
		<div data-options="region:'center'">
			<div class="easyui-panel" style="padding:5px;" data-options="fit:true,border:false">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north'" style="height:35px;">
						<div style="width:100%;height:100%">
							<form id="qform">
								<table>
									<tr>
										<td>学生名称:</td>
										<td>
											<input type="text" class="easyui-validatebox" id="studentName"   value=""> 
											<input type="hidden"  id="classId"   value=""> 
										</td>
										<td>
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;&nbsp; 
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
									<th data-options="field:'className'" width="120">班级名称</th>
									<th data-options="field:'studentName'" width="100">学员姓名</th>
									<th data-options="field:'sex'" width="50"  formatter="showSex">性别</th>
									<th data-options="field:'schoolName'" width="100">学校</th>
									<th data-options="field:'scores'" width="100">考试分数</th>
									<th data-options="field:'isPass'" width="100" formatter="showPass">培训资格确认</th>
									<th data-options="field:'handler'" width="150" formatter="handlerstr">操作</th>
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
