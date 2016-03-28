<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/classStudent.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/ajaxfileupload.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
		 		var classId=$("#classId","#qform").val();
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	
			  	var treeoptions = {id:"treeID",url:"../classInfo/all.do",onClick:treeClick};
		  		$.initTree(treeoptions);
		 	});
/**
*操作
*/
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='scores("+json+")';>考试分数</a> ";
     return  handstr;
}
/**
*分数录入
*/
function scores(row){
	$.messager.prompt("考试分数","请为<span style='color:red;font-weight: bold;'>"+row.studentName+"</span>学员的填写考试分数。", function(r){
	if (r){
		$.ajax({
			url:"scores.do",
			data:"id="+row.id+"&scores="+r,
			success:function(data){
				var json=eval("("+data+")");
				if(json.message){
					parent.$.messager.alert("提示窗口",json.message);
					dataGrid.datagrid('reload');
				}
			}
		});
	}
});
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

/**
	*点击树节点操作
	*/
function  treeClick(node){
	var  parameter = {};
	var classId = node.id;
	parameter["classId"]=classId;
	$("#classId","#qform").val(classId);
	dataGrid.datagrid('load',parameter);
}
/**
*导出模板
*/
function downloadTemp(){
	location.href="../../common/downloadTemp.do?tempName=scores.xls"
}
/**
*导入信息
*/
function importInfo(){
	$("#fileId").click();
}
	
function ajaxFileUpload(){
	$.ajaxFileUpload({  
        url:"importScores.do",  
        secureuri:false,  
        fileElementId:"fileId",  
        dataType: "text",
        success: function (data) { 
        	var json=eval("("+data+")");
        	parent.$.messager.alert("提示窗口",json.message);
        	$("#grid").datagrid("reload");
        }, error: function (data) {  
            alert(data);  
        }  
    });
	return false;  
}
</script>
		
	</head>
<body>
	<div class="easyui-layout" data-options="fit:'true'">
		<div data-options="region:'west',split:true,title:'单位树',collapsible:true" style="width:200px;">
			<%@include file="/WEB-INF/admin/common/tree.jsp"%>
		</div>
		<div data-options="region:'center'">
	<div class="easyui-panel" style="padding:0px;" data-options="fit:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north'" style="height:35px;">
				<div style="width:100%;height:100%;">
					<form class="bjaa" id="qform">
						<input type="file" id="fileId" style="display:none;" name="fileId" onchange="ajaxFileUpload();" />
						<input type="hidden"  class="easyui-validatebox" id="classId" value=""    >
						<table>
							<tr>
								<td>学员姓名:</td>
								<td>
									<input type="text" class="easyui-validatebox" id="studentName"   value="">
								</td>
								<td>学校名称:</td>
								<td>
									<input type="text" class="easyui-validatebox" id="schoolName"   value="">
								</td>
								<td>
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;&nbsp;
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="importInfo();">导入信息</a>&nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="downloadTemp();">导出模板</a> 
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
							<th data-options="field:'studentName'" width="100">学员姓名</th>
							<th data-options="field:'sex'" width="50"  formatter="showSex">性别</th>
							<th data-options="field:'schoolName'" width="100">学校</th>
							<th data-options="field:'className'" width="100">培训班</th>
							<th data-options="field:'scores'" width="100">考试分数</th>
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
