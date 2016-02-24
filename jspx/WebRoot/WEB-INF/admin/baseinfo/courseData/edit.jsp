<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/lessonManagement.js"></script>
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
			parent.dialogMap["d6"].dialog('close');
		 });
		 
		 
		 //设置图片的URL
		 var dataUrl = $("#dataUrl").val();
		 $("#dataFile").filebox('setValue',dataUrl);
	});
	
	/**
	*自定义刷新列表
	*/
	function customRefresh(){
		var index=$("#index").val();
		parent.$("#main").tabs("getSelected").find("iframe")[0].contentWindow.$("#iframe_"+index)[0].contentWindow.$("#grid").datagrid("reload");
		parent.dialogMap["d6"].dialog('close');
	}
	
</script>
  </head>
  <body layout="easyui-layout"> 
         <div data-options="region:'center'" >
         <form id="dform" method="post" enctype="multipart/form-data" >
            <input name="id" type="hidden" id="id"   value="${vo.id }">
            <input name="courseId" type="hidden" id="courseId"   value="${vo.courseId }">
            <input name="index" type="hidden" id="index"   value="${vo.index }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;" value="${vo.name }"></td>
				</tr>
				<tr>
					<th>资料</th>
					<td>
						<input class="easyui-filebox" name="dataFile" id="dataFile" data-options="prompt:'选择资料',buttonText:'选择文件'" style="width:350px">
						<input id="dataUrl" name="dataUrl" type="hidden" value="${vo.dataUrl }" />
					</td>
				</tr>
				<tr>
					<th>备注</th>
					<td><input name="remark"   type="text" class="easyui-textbox textbox"  data-options="multiline:true"  style="width:350px;height:100px;" value="${vo.remark }"></td>
				</tr>
			</table>
		</form>
     </div>
     
  </body>
</html>

