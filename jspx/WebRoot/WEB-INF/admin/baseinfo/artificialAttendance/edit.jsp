<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/artificialAttendance.js"></script>
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
	});
	
	function beforeSubmit(){
		 var id=[];
		  id.push(getCheckeds1("grid","id"));
		  if(id==""){
			  parent.$.messager.alert("提示", "至少选择一条数据删除！", "info");
			  return false;
		  }
		  $("#studentId").val(id.join(','));
		  return true;
	}
	
	
	
	var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"../teacherInfo/list.do?isStudent=1",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	//var treeoptions = {id:"treeID",url:"../unitInfo/school.do",onClick:treeClick};
			  	var treeoptions = {id:"treeID",url:"../classInfo/all.do",onClick:treeClick};
		  		$.initTree(treeoptions);
		 	});
		 	/**
		 	*点击树节点操作
		 	*/
		 	function  treeClick(node){
		 		var  parameter = {};
				/* if(node!=null && typeof(node.type)=="undefined"){//点击学校类型跟类别
					var flag="";
					var pnode=$('#treeID').tree('getParent',node.target);//字典类型
					if(typeof(pnode.type)=="undefined"){//上一级不是单位，那就是点击学校类型
						var ppnode=$('#treeID').tree('getParent',pnode.target);//单位
						flag=ppnode.flag;
						
						var categoryId=pnode.id;
						parameter["categoryId"]=categoryId;
						$("#categoryId","#qform").val(categoryId);//类别ID
						
						var typeId=node.id;
						parameter["typeId"]=typeId;
						$("#typeId","#qform").val(typeId);//类别ID
					}else{//上一级是单位，那就是点击学校类别
						var categoryId=node.id;
						parameter["categoryId"]=categoryId;
						$("#categoryId","#qform").val(categoryId);//类别ID
						$("#typeId","#qform").val("");//类型ID
						flag=pnode.flag;
					}
					parameter["flag"]=flag;
					$("#flag","#qform").val(flag);
				}else{//查询单位
					var flag = node.flag;
					parameter["flag"]=flag;
					$("#flag","#qform").val(flag);
					$("#typeId","#qform").val("");
					$("#categoryId","#qform").val("");
				} */
				var classId=node.id;
				parameter["classIdStr"]=classId;
				$("#classIdStr","#qform").val(classId);
				dataGrid.datagrid('load',parameter);
			}

</script>
  </head>
  <body layout="easyui-layout">
	<div class="easyui-layout" data-options="fit:'false'" style="height:500px;">
		<div data-options="region:'west',split:true,title:'班级树',collapsible:true" style="width:300px;">
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
											<input type="text" class="easyui-validatebox" id="name"   value=""> 
											<input type="hidden" class="easyui-validatebox" id="classIdStr" name="classIdStr"  value=""></td>
											<input type="hidden" class="easyui-validatebox" id="flag" name="flag"  value=""></td>
											<input type="hidden" class="easyui-validatebox" id="typeId" name="typeId"   value=""></td>
											<input type="hidden" class="easyui-validatebox" id="categoryId" name="categoryId"  value=""></td>
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
									<th data-options="field:'id',checkbox:true"></th>
									<th data-options="field:'name'" width="100">姓名</th>
									<th data-options="field:'schoolName'" width="150">附属学校</th>
									<th data-options="field:'text'" width="150" >管理账号</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
		
		<div data-options="region:'south'" style="height:200px;">
         <form id="dform" method="post" >
            <input name="id" type="hidden" id="id"   value="${vo.id }">
			<input name="creator" type="hidden"  value="${vo.creator }">
			<input name="createdate" type="hidden"   value="${vo.createdate }">
			<input name="studentId" type="hidden" id="studentId"  value="${vo.studentId }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
			        <th style="width:285px;">登记类别</th>
					<td>
						<select class="easyui-combobox" style="width:350px;" data-options="editable:false" name="categoryId" value="${vo.categoryId }" >
							<option value="1">请假</option>
							<option value="2">忘带卡</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>登记时间</th>
					<td><input name="date" type="text" class="easyui-datetimebox textbox" data-options="editable:false" required="required"  style="width:350px;" value="${vo.date }"></td>
				</tr>
				<tr>
					<th>备注</th>
					<td><input name="remark" type="text" data-options="multiline:true"   class="easyui-textbox textbox" style="width:350px;height:50px;"  value="${vo.remark }"></td>
				</tr>
			</table>
		</form>
     </div>
	</div>
  </body>
</html>

