<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/assessTheme.js"></script>
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
		 
		 var treeoptions = {id:"treeID",url:"../../platform/loginInfo/tree.do",checkbox:true,onClick:treeClick,onLoadSuccess:setTree};
 		 $.initTree(treeoptions);
	});
	
/**
*点击树方法
*/
function  treeClick(node){
	if(node.checked){
		$("#treeID").tree("uncheck", node.target);
	}else{
		$("#treeID").tree("check", node.target);
	}
}
//提交前操作
function beforeSubmit(dform){
	var node=$("#treeID").tree("getChecked");
	if(node==null || node==""){
		parent.$.messager.alert("提示窗口","至少选择一个栏目。");
		return false;
	}
	var html="";
	for(var i=0;i<node.length;i++){
		var n=node[i];
		if(!$("#treeID").tree("isLeaf",n.target)){
			continue;
		}
		html+="<input name=\"loginId\"  type=\"hidden\"      value=\""+n.id+"\">"
	}
	$("#dform").prepend(html);
	return true;
}
//设置选中栏目
function setTree(/* sectionIds */){
	var loginIds="${vo.loginIds}";
	if(loginIds==""){
		return;
	}
	var arr=loginIds.split(",");
	for(var i=0;i<arr.length;i++){
		 var node=$("#treeID").tree("find",arr[i]);
		 $("#treeID").tree("check", node.target);
	}
}
	</script>
  </head>
  <body ><!-- layout="easyui-layout" -->
  	<div class="easyui-layout" data-options="fit:'true',border:false" >
		<div data-options="region:'east',split:true,title:'负责人树',collapsible:true" style="width:280px;">
			<%@include file="/WEB-INF/admin/common/tree.jsp"%>
		</div>
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
            <input name="topFileId"  type="hidden"  id="topFileId"    value="${vo.topFileId }">
            <input name="absoluteId"  type="hidden"  id="absoluteId"    value="${vo.absoluteId }">
            <input name="type"  type="hidden"  id="type"    value="评估文档">
			<table width="100%" class="table table-hover table-condensed" >
				<tr>
					<th width="85px;">标题</th>
					<td><input name="title" type="text" class="easyui-validatebox textbox" required="required"  style="width:300px;" value="${vo.title }"></td>
				</tr>
				<tr>
					<th >文件存储路径</th>
					<td><input name="absoluteUrl" type="text" class="easyui-validatebox textbox" required="required"  style="width:300px;" value="${vo.absoluteUrl }"></td>
				</tr>
				<tr>
					<th  >开始时间</th>
					<td><input name="beginDate" type="text" class="easyui-datebox textbox" data-options="editable:false" required="required"   style="width:300px;" value="${vo.beginDate }"></td>
				</tr>
				<tr>
					<th  >结束时间</th>
					<td><input name="endDate" type="text" class="easyui-datebox textbox" data-options="editable:false"  required="required"  style="width:300px;" value="${vo.endDate }"></td>
				</tr>
				<tr>
					<th >主题模板</th>
					<td>
						<input class="easyui-combobox"  style="width: 300px;"  name="templateId" required="required" value="${vo.templateId }"  data-options="url:'../themeTemplate/tree.do',
		                    method:'get',
		                    valueField:'id',
		                    textField:'title',
		                    editable:false
		            	">
					</td>
				</tr>
				<tr>
			</table>
		</form>
     </div>
     </div>
  </body>
</html>

