<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/site/sectionPosition.js"></script>
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
		 
		var type=encodeURI("oa栏目");
		 var treeoptions = {id:"treeID",url:"../../site/sectionManagement/tree.do?type="+type+"",checkbox:false,cascadeCheck:true,onLoadSuccess:setTree};
 		 $.initTree(treeoptions);
	});
	
//提交前操作
function beforeSubmit(dform){
	var node=$("#treeID").tree("getSelected");
	if(node==null || node==""){
		parent.$.messager.alert("提示窗口","选择一个栏目。");
		return false;
	}
	$("#sectionId").val(node.id);
	return true;
}
var index=0;
//设置选中栏目
function setTree(/* sectionIds */){
	if(index==0){
		var selected = $("#treeID").tree("getRoot");
		 if (selected){
		 	index++;
			$("#treeID").tree("insert", {
				parent: selected.target,
				data: [{
					id: "最新导读",
					text: "最新导读"
				}]
			});
		}
	}else{
		var sectionId="${vo.sectionId}";
		if(sectionId==""){
			return;
		}
		 var node=$("#treeID").tree("find",sectionId);
		 $("#treeID").tree("select", node.target);
	}
}
	</script>
  </head>
  <body><!--  layout="easyui-layout" -->
  		<div class="easyui-layout" data-options="fit:'true',border:false" >
  		<div data-options="region:'south',split:true,title:'选择栏目树',collapsible:false" style="width:100%;height: 380px;">
			<%@include file="/WEB-INF/admin/common/tree.jsp"%>
		</div>
		<div data-options="region:'north'" style="height: 32px;">
         <form id="dform" method="post"    >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
            <input name="sectionId"  type="hidden"  id="sectionId"    value="${vo.sectionId }">
            <input name="type"  type="hidden"  id="type"    value="前台网站">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>文章数量</th>
					<td><input name="number" type="text" class="easyui-numberbox textbox"   style="width:350px;" value="${vo.number }"></td>
				</tr>
				<tr>
			</table>
		</form>
     </div>
		</div>
		 <%-- <form id="dform" method="post"    >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
            <input name="sectionId"  type="hidden"  id="sectionId"    value="${vo.sectionId }">
           </form> --%>
  </body>
</html>

