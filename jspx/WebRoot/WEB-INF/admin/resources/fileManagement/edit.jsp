<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/fileManagement.js"></script>
    <script type="text/javascript">
	var formobj;
	var cbutton = parent.$("#cbutton");
	var sbutton = parent.$("#sbutton");
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"save.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $(sbutton).bind('click',function(){
			// var curTab = parent.$("#main").tabs('getSelected');  
            //获取tab的iframe对象  
            //alert(curTab.find('iframe')[0].contentWindow)
            //alert($(curTab.find('iframe')[0].contentWindow.document.body).find("#treeID").size())
            //alert(tbIframe.contentWindow.document.body)
			 $("#dform").submit();
		 });
		 //绑定关闭事件
		 $(cbutton).bind('click',function(){
			parent.dialogMap["d3"].dialog('close');
		 });
	});
	
/**
*检验唯一表达式
*/
$.extend($.fn.validatebox.defaults.rules, {
	checkName: { validator: function(value, param){
		var id=$("#id").val();
		var parentId=$("#parentId").val();
		var ok=true;
		$.ajax({
			url:"checkName.do",
			data:"name="+value+"&id="+id+"&parentId="+parentId,
			async: false,
			success:function(data){
				var json=eval("("+data+")");
				if(json.message){
					ok=true;
				}else{
					ok=false; 
				}
			}
		});
		return ok;
	},
	message: "名称已存在,请重新输入"
	}
});
function customRefresh(){
 	var curTab = parent.$("#main").tabs("getSelected");  
	var treeObj=curTab.find("iframe")[0].contentWindow.$("#treeID");
	//alert(treeObj.html())
	var node=treeObj.tree("getSelected");
	if(node==null){
		treeObj.tree("reload");
	}else{
		if(treeObj.tree("isLeaf",node.target)){//是否叶子节点
			/* var pnode=treeObj.tree("getParent",node.target);
			if(pnode!=null){
				treeObj.tree("reload",pnode.target);
			}else{
				treeObj.tree("reload");
			} */
			//treeObj.tree("reload");
			//treeObj.tree("expandTo",node.target);//打开节点
			//treeObj.tree("update", {target: node.target,state:'open'});
			
			treeObj.tree("select",node.target);
			//treeObj.tree("expand",node.target);
		}else{
			treeObj.tree("reload",node.target);
		}
	}
	//刷新表格
	if(parent.dialogMap["d3"]!=undefined&&parent.dialogMap["d3"]!=null){
		parent.$.createDialog.open_grid.datagrid("reload");
		parent.dialogMap["d3"].dialog("close");
	}
}
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
            <input name="topFileId"  type="hidden"  id="topFileId"    value="${vo.topFileId }">
            <input name="parentId"  type="hidden"  id="parentId"    value="${vo.parentId }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th width="80px;">文件夹名称</th>
					<td>
						<input name="name" type="text" class="easyui-validatebox textbox"  data-options="required:true,validType:'checkName'"  style="width:350px;" value="${vo.name }">
					</td>
				</tr>
				<tr>
					<th>备注</th>
					<td><input name="remark" type="text" class="easyui-textbox textbox" data-options="multiline:true"   style="width:350px;height: 100px;" value="${vo.remark }"></td>
				</tr>
				<tr>
			</table>
		</form>
     </div>
  </body>
</html>

