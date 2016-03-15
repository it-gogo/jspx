<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/themeDirectory.js"></script>
    <script type="text/javascript">
	var formobj;
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
	
//自定义刷新
function customRefresh(){
	var pf=parent.$("#uframe_d4")[0].contentWindow;
	var node=pf.$("#treeID").tree("getSelected");
	if(node!=null){
		pf.$("#treeID").tree("reload");
	}
	//pf.$("#treeID").tree("select",node.target);
	//pf.$("#treeID").tree("reload",pf.$("#treeID").tree("getSelected").target);
	//刷新表格
	if(parent.dialogMap["d3"]!=undefined&&parent.dialogMap["d3"]!=null){
		parent.$.createDialog.open_grid.datagrid('reload');
		parent.dialogMap["d3"].dialog('close');
	}
}
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
            <input name="topFileId"  type="hidden"  id="topFileId"    value="${vo.topFileId }">
            <input name="templateId"  type="hidden"  id="templateId"    value="${vo.topFileId }">
            <input name="parentId"  type="hidden"  id="parentId"    value="${vo.parentId }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th width="75px;">父结构名称</th>
					<td>${vo.parentName }</td>
				</tr>
				<tr>
					<th width="75px;">标题</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" required="required"  style="width:300px;" value="${vo.name }"></td>
				</tr>
				<tr>
					<th>备注</th>
					<td><input name="remark" type="text" class="easyui-textbox textbox" data-options="multiline:true"   style="width:300px;height: 100px;" value="${vo.remark }"></td>
				</tr>
				<tr>
			</table>
		</form>
     </div>
  </body>
</html>

