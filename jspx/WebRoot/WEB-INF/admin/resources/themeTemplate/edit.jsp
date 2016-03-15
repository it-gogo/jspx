<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/themeTemplate.js"></script>
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
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th width="75px;">标题</th>
					<td><input name="title" type="text" class="easyui-validatebox textbox" required="required"  style="width:300px;" value="${vo.title }"></td>
				</tr>
				<tr>
					<th  >欢迎界面</th>
					<td><input name="welcome" type="text" class="easyui-validatebox textbox"    style="width:300px;" value="${vo.welcome }"></td>
				</tr>
				<tr>
					<th >展示界面</th>
					<td><input name="gallery" type="text" class="easyui-validatebox textbox"  style="width:300px;" value="${vo.gallery }"></td>
				</tr>
				<tr>
			</table>
		</form>
     </div>
  </body>
</html>

