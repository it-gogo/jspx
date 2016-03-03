<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/classInfo.js"></script>
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
			  	var gridoption = {url:"../quotaAllocation/list.do?classId="+id,id:"grid",pagination:true,fit:false};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
	});
	function findClassTeacher(value){
		var loadOpt = {id:"d4",urls:"../baseinfo/classInfo/findClassTeacher.do",title:"班主任列表"};
		parent.$.createDialog(loadOpt);
		//parent.$.createDialog.open_grid = dataGrid; 
	}


var qaButton = [{ 
		text:'保 存',
		iconCls:'icon-ok',
		id:'qasbutton'
	},{
		text:'关 闭',
		iconCls:'icon-cancel',
		id:'qacbutton'
	}];
/**
 * 打开添加数据窗口参数
 */
var qaoptions = {id:"d5",title:"名额分配编辑",width:"600px;",height:"400px;",buttons:qaButton};
//添加函数
function  addQuotaAllocation(){
	var id=$("#id").val();
	var urls = "../baseinfo/quotaAllocation/add.do?classId="+id;
	qaoptions.urls = urls;
	//parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(qaoptions);
}
/**
 * 导出数据
 * @param row
 */
function  loadQuotaAllocation(row){
	var urls = "../baseinfo/quotaAllocation/load.do?id="+row.id;
	qaoptions.urls = urls;
	parent.$.createDialog(qaoptions);
	//parent.$.createDialog.open_grid = dataGrid;
}
/**
*操作
*/
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='loadQuotaAllocation("+json+")';>修 改</a> "+
     						"<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-cancel' plain='true' onclick='deleteQuotaAllocation("+json+")';>删 除</a> ";
     return  handstr;
}

	/**
 * 删除单条数据
 * @param row
 */
function deleteQuotaAllocation(row){
	  var id = [];
	  id.push(row.id);
	  parent.$.messager.confirm('询问', '您是否要删除当前记录？', function(b) {
			if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('../quotaAllocation/delete.do',{id:id.join(',')}, function(result) {
						if (result.message) {
							parent.$.messager.alert('提示', result.message, 'info');
							dataGrid.datagrid('reload');
						}else if(result.other){
							//做其他回调函数
						}
						parent.$.messager.progress('close');
					}, 'JSON');
				}
			
		});
}
/**
 * 批量删除数据
 */
function deleteAllQuotaAllocation(){
	  var id=[];
	  id.push(getCheckeds1("grid","id"));
	  if(id==""){
		  parent.$.messager.alert('提示', "至少选择一条数据删除！", 'info');
		  return;
	  }
	  parent.$.messager.confirm('询问', '您是否要删除当前记录？', function(b) {
			if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('../quotaAllocation/delete.do', {
						id : id.join(',')
					}, function(result) {
						if (result.message) {
							parent.$.messager.alert('提示', result.message, 'info');
							dataGrid.datagrid('reload');
						}else if(result.other){
							//做其他回调函数
						}
						parent.$.messager.progress('close');
					}, 'JSON');
				}
			
		});
}

</script>
  </head>
  <body layout="easyui-layout">
  		<div class="easyui-layout" data-options="fit:'false'"  >
         <div data-options="region:'center'" >
         <form id="dform" method="post" >
            <input name="id" type="hidden" id="id"   value="${vo.id }">
			<input name="creator" type="hidden"  value="${vo.creator }">
			<input name="createdate" type="hidden"   value="${vo.createdate }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>姓名</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;" value="${vo.name }"></td>
				</tr>
				<tr>
			        <th>班主任</th>
					<td>
						<input class="easyui-searchbox" id="classTeacherName" value="${vo.classTeacherName }" data-options="editable:false,searcher:findClassTeacher" required="required" style="width:350px"></input>
						<input type="hidden" name="classTeacher" id="classTeacherId"  value="${vo.classTeacher }"  />
					</td>
				</tr>
				<tr>
					<th>班级类别</th>
					<td>
						<input class="easyui-combotree" style="width:350px;"  name="categoryId" value="${vo.categoryId }"  data-options="url:'../codeData/all.do?code=BJLB',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    editable:false
		            	">
					</td>
				</tr>
				<tr>
					<th>班级课程</th>
					<td>
						<input class="easyui-combotree" style="width:350px;"  name="courseId" required="required" value="${vo.courseId }"  data-options="url:'../courseManagement/all.do',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    editable:false
		            	">
					</td>
				</tr>
				<tr>
					<th>适用学段</th>
					<td>
						<input class="easyui-combobox" style="width:350px;"  name="xdId" value="${vo.xdId }"  data-options="url:'../codeData/all.do?code=XD',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    editable:false,
		                    multiple:true
		            	">
					</td>
				</tr>
				<tr>
					<th>适用学科</th>
					<td>
						<input class="easyui-combobox"  style="width:350px;"  name="xkId" value="${vo.xkId }"  data-options="url:'../codeData/all.do?code=XK',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    editable:false,
		                    multiple:true
		            	">
					</td>
				</tr>
				<tr>
					<th>班级简介</th>
					<td><input name="introduction" type="text" data-options="multiline:true"   class="easyui-textbox textbox" style="width:350px;height:100px;"  value="${vo.introduction }"></td>
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
								<td>学校名称:</td>
								<td>
									<input type="text" class="easyui-validatebox" id="schoolName"   value=""> 
								<td>
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a>&nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a>&nbsp;&nbsp;
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addQuotaAllocation();">新 增</a>&nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="deleteAllQuotaAllocation();">删 除</a>
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
							<th data-options="field:'schoolName'" width="220">学校名称</th>
							<th data-options="field:'number'" width="150" >学员数量</th>
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

