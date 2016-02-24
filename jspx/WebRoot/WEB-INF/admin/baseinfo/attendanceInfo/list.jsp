<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/artificialAttendance.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	var treeoptions = {id:"treeID",url:"../classTime/tree.do",onClick:treeClick};
		  		$.initTree(treeoptions);
		 	});
		 	function  treeClick(node){
		 		var  parameter = {};
				if(typeof(node.classTeacher)=="undefined"){//上课时间
					/* var classDate=node.text;
					parameter["classDate"]=classDate;
					$("#classDate","#qform").val(classDate);//上课时间 */
					 var classTimeId=node.id;
					parameter["classTimeId"]=classTimeId;
					$("#classTimeId","#qform").val(classTimeId);//上课时间ID
					
					var pnode=$('#treeID').tree('getParent',node.target);//字典类型
					var classId=pnode.id;
					parameter["classId"]=classId;
					$("#classId","#qform").val(classId);//班级ID
				}else{//班级
					var classId=node.id;
					parameter["classId"]=classId;
					$("#classId","#qform").val(classId);//班级ID
					
					$("#classTimeId","#qform").val("");
				}
				dataGrid.datagrid('load',parameter);
		 	}
/**
*考勤统计
*/
function attendanceStatistics(){
	var  node = $("#treeID").tree('getSelected');
	if(node==null){
		parent.$.messager.alert("提示窗口","请选择班级或者上课时间进行统计。");
		return;
	}
	var studentName=$("#studentName","#qform").val();
	var classId=$("#classId","#qform").val();
	var classTimeId=$("#classTimeId","#qform").val();
	var beginDate=$("#beginDate","#qform").val();
	var endDate=$("#endDate","#qform").val();
	var options={};
	/* if(typeof(node.classTeacher)=="undefined"){
		options = {id:"d4",urls:"../baseinfo/attendanceInfo/statistics.do?classId="+classId+"&studentName="+studentName+"&classTimeId="+classTimeId+"&beginDate="+beginDate+"&endDate="+endDate,title:"考勤统计",width:"100%",height:"100%"};
	}else{
		options = {id:"d4",urls:"../baseinfo/attendanceInfo/summaryStatistics.do?classId="+classId+"&studentName="+studentName+"&classTimeId="+classTimeId+"&beginDate="+beginDate+"&endDate="+endDate,title:"考勤统计",width:"100%",height:"100%"};
	} */
	options = {id:"d4",urls:"../baseinfo/attendanceInfo/statisticsZDY.do?classId="+classId+"&studentName="+studentName+"&classTimeId="+classTimeId+"&beginDate="+beginDate+"&endDate="+endDate,title:"考勤统计",width:"100%",height:"100%"};
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}

/**
* 
*/
function xls(){
	var  node = $("#treeID").tree('getSelected');
	if(node==null){
		parent.$.messager.alert("提示窗口","请选择班级或者上课时间进行统计。");
		return;
	}
	/* if(typeof(node.classTeacher)=="undefined"){
		$("#qform").attr("action","statisticsXLS.do");
	}else{
		$("#qform").attr("action","summaryStatisticsXLS.do");
	} */
	$("#qform").attr("action","statisticsZDYXLS.do");
	$("#qform").submit();
}
</script>
		
	</head>
<body>
	<div class="easyui-layout" data-options="fit:'true'">
		<div data-options="region:'west',split:true,title:'单位树',collapsible:true" style="width:200px;">
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
									<td>名称:</td>
									<td>
										<input type="text" class="easyui-validatebox" id="studentName" name="studentName"   value=""> 
										<input type="hidden" class="easyui-validatebox" id="classId"  name="classId"  value="">
										<input type="hidden" class="easyui-validatebox" id="classTimeId" name="classTimeId"   value="">
									</td>
									<td>上课日期:</td>
									<td>
										<input type="text" class="easyui-datebox" data-options="editable:false" id="beginDate" name="beginDate"   value=""> ~
										<input type="text" class="easyui-datebox" data-options="editable:false" id="endDate"  name="endDate" value=""> 
									</td>
									<td>
										<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
										<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;&nbsp; 
										<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="attendanceStatistics();">考勤统计</a> &nbsp;&nbsp;
										<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="xls();">生成表格</a> &nbsp;&nbsp;  
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
								<th data-options="field:'studentName'" width="80">姓名</th>
								<th data-options="field:'idcard'" width="100" >身份证</th>
								<th data-options="field:'attendanceDate'" width="100" >考勤时间</th>
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
