<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/train/noticeSMS.js"></script>
    <script >
		window.UEDITOR_HOME_URL = "<%=request.getContextPath()%>/ueditor/";
	</script>
	<script language="javascript" src="<%=request.getContextPath() %>/ueditor/ueditor.config.js" ></script>
	<script language="javascript" src="<%=request.getContextPath() %>/ueditor/ueditor.all.min.js" ></script>
	<script >
		var ue;
		$(function(){
		     ue  = UE.getEditor('editor',{
		     });
		}); 
	</script>
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
		 
		 //设置图片的URL
		 var dataUrl = $("#accessoryUrl").val();
		 $("#accessoryFile").filebox('setValue',dataUrl);
		 
		  var treeoptions = {id:"treeID",url:"tree.do",checkbox:true ,onClick:treeClick,onLoadSuccess:setTree};
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
		if(!$("#treeID").tree("isLeaf",n.target)){//是否父节点
			continue;
		}
		var teacher=n.teacher;
		if(teacher==1){
			html+="<input name=\"teacherIds\"  type=\"hidden\"      value=\""+n.id+"\">"
		}else{
			continue
		}	
	}
	$("#dform").prepend(html);
	
	$("#content").val(ue.getContent());
	return true;
}
//设置选中栏目
function setTree(/* teacherIds */){
	var teacherIds="${vo.teacherIds}";
	if(teacherIds==""){
		return;
	}
	var arr=teacherIds.split(",");
	for(var i=0;i<arr.length;i++){
		 var node=$("#treeID").tree("find",arr[i]);
		 $("#treeID").tree("check", node.target);
	}
}
	</script>
  </head>
  <body ><!-- layout="easyui-layout" -->
  		<div class="easyui-layout" data-options="fit:'true',border:false" >
			<div data-options="region:'east',split:true,title:'接收人员',collapsible:true" style="width:350px;">
				<%@include file="/WEB-INF/admin/common/tree.jsp"%>
			</div>
         <div data-options="region:'center'">
         <form id="dform" method="post"  enctype="multipart/form-data"  >
         	<input name="content" type="hidden" id="content"   value="">
         	<input name="isInStation" type="hidden" id="isInStation"   value="站内短信">
         	<input type="hidden" id="teacherIdStr"   value='${vo.teacherIds }'>
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>标题</th>
					<td><input name="title" type="text" class="easyui-validatebox textbox" required="required"  style="width:80%;"  value="${vo.title }"></td>
				</tr>
				<tr>
				<tr>
					<th >短信内容</th>
					<td>
						<textarea id="editor"   name="editor"  style="width:80%;"   >${vo.content }</textarea>
					</td>
				</tr>
				<tr>
					<th>附件</th>
					<td>
						<input class="easyui-filebox" name="accessoryFile" id="accessoryFile" data-options="prompt:'选择附件',buttonText:'选择文件'" style="width:80%;" >
						<input id="accessoryUrl" name="accessoryUrl" type="hidden" value="${vo.accessoryUrl }" />
					</td>
				</tr>
			</table>
		</form>
     </div>
     </div>
  </body>
</html>

