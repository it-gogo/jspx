<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/classTime.js"></script>
    <script type="text/javascript">
	var cbutton = parent.$("#cbutton");
	var sbutton = parent.$("#sbutton");
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"save.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $(sbutton).bind('click',function(){
			 $("#dform").submit();
		 });
		 //绑定关闭事件
		 $(cbutton).bind('click',function(){
			parent.dialogMap["d3"].dialog('close');
		 });
		 
		 $(document).ready(function(){
		 		var id=$("#id").val();
		 		var url="";
		 		var classId=$("#classId").combobox("getValue");
		 		if(classId!=""){
		 			url="../useLesson/selectLesson.do?classId="+classId+"&classTimeId="+id;
		 		}
			  	var gridoption = {url:url,id:"grid",pagination:false,fit:false};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	//dataGrid.datagrid('enableCellEditing');
			  	dataGrid.datagrid('enableCellEditing');
		 	});
	});
/**
*导出使用课时
*/
function loadUseLesson(res){
	var id=$("#id").val();
	var url="";
	var classId=$("#classId").combobox("getValue");
	if(classId!=""){
		url="../useLesson/selectLesson.do?classId="+classId+"&classTimeId="+id;
	}
	var gridoption = {url:url,id:"grid",pagination:false,fit:false};
	dataGrid = $.initBasicGrid(gridoption); 
	//dataGrid.datagrid('enableCellEditing');
	/* dataGrid.datagrid('enableCellEditing').datagrid('gotoCell', {
        field: 'useLesson'
    }); */
}

/**
*保存之前操作
*/
function beforeSubmit(formId){
	var row=$('#grid').datagrid('getSelected');
	var index=$('#grid').datagrid('getRowIndex',row);//最后输入的那一行
	if(index!=-1){
		$('#grid').datagrid('endEdit',index);//保存最后输入的数据
	}
	$('#grid').datagrid('endEdit');
	var json=$("#grid").datagrid("getData");
	var data=$.toJSON(json);
	$("#data").val(data);
	return true;
}
</script>
  </head>
  <body layout="easyui-layout">
  	<div class="easyui-layout" data-options="fit:'false'"  >
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="id" type="hidden" id="id"   value="${vo.id }">
			<input name="data" type="hidden" id="data" >
			<table width="100%" class="table table-hover table-condensed">
				<tr>
			        <th>班级</th>
					<td>
						<input class="easyui-combobox" style="width:350px;"  name="classId" id="classId" required="required"  value="${vo.classId }"  data-options="url:'../classInfo/all.do',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    editable:false,
		                    onSelect:function(res){loadUseLesson(res);}
		            	">
					</td>
				</tr>
				<tr>
					<th>上课日期</th>
					<td><input name="classDate" type="text" class="easyui-datebox textbox" data-options="editable:false" required="required"  style="width:350px;" value="${vo.classDate }"></td>
				</tr>
				<tr>
					<th>开始时间</th>
					<td><input name="beginTime" type="text" class="easyui-timespinner textbox"  required="required"  style="width:350px;" value="${vo.beginTime }"></td>
				</tr>
				<tr>
					<th>结束时间</th>
					<td><input name="endTime" type="text" class="easyui-timespinner textbox"  required="required"  style="width:350px;" value="${vo.endTime }"></td>
				</tr>
				<tr>
					<th>上课地点</th>
					<td><input name="address" type="text" data-options="multiline:true"   class="easyui-textbox textbox" style="width:350px;height:50px;"  value="${vo.address }"></td>
				</tr>
				<tr>
					<th>上课内容</th>
					<td><input name="content" type="text" data-options="multiline:true"   class="easyui-textbox textbox" style="width:350px;height:100px;"  value="${vo.content }"></td>
				</tr>
			</table>
		</form>
     </div>
     
     
     <div data-options="region:'south'" style="height:270px;">
     <div class="easyui-panel" style="padding:5px;" data-options="fit:true,border:false"  >
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north'" style="height:35px;">
				<div style="width:100%;height:100%">
					<form id="qform">
						<table>
							<tr>
								<td>科目名称:</td>
								<td>
									<input type="text" class="easyui-validatebox" id="subjectName"   value=""> 
								<td>
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a>&nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a>&nbsp;&nbsp;
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
							<th data-options="field:'subjectName'" width="220">科目名称</th>
							<th data-options="field:'lesson'" width="150" >课时数量</th>
							<th data-options="field:'totalLesson'" width="150" >已排课时</th>
							<th data-options="field:'useLesson',editor:{type:'numberbox',options:{precision:0,min:0}}" width="150" >现排课时<span style="color: red;font-weight: bold;">(输入)</span></th>
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

