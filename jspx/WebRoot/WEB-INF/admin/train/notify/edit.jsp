<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/train/notify.js"></script>
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
		var  formOptions = {id:"dform",urls:"saveOA.do"};
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
	});
	
function beforeSubmit(dform){
	/* if(ue.getContent()==""){
		parent.$.messager.alert("提示窗口","通知内容必须填写！");
		return false;
	} */
	$("#content").val(ue.getContent());
	return true;
}
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post"  enctype="multipart/form-data"  >
         	<input name="content" type="hidden" id="content"   value="">
         	<input name="isInStation" type="hidden" id="isInStation"   value="oa通知">
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th width="100px;">标题</th>
					<td><input name="title" type="text" class="easyui-validatebox textbox" required="required"  style="width:80%;"  value="${vo.title }"></td>
				</tr>
				<tr>
				<tr>
					<th >通知内容</th>
					<td>
						<textarea id="editor"   name="editor"  style="width:80%;"   >${vo.content }</textarea>
					</td>
				</tr>
				<tr>
					<th>附件</th>
					<td>
						<input class="easyui-filebox" name="accessoryFile" id="accessoryFile" data-options="prompt:'选择图片',buttonText:'选择文件'" style="width:80%;" >
						<input id="accessoryUrl" name="accessoryUrl" type="hidden" value="${vo.accessoryUrl }" />
					</td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

