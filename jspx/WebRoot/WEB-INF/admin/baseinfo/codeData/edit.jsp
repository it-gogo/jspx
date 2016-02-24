<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/platform/userInfo.js"></script>
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
            <input name="id" type="hidden"   value="${vo.id }">
			<input name="creator" type="hidden"  value="${vo.creator }">
			<input name="createdate" type="hidden"   value="${vo.createdate }">
			<input name="typeId" type="hidden"  value="${vo.typeId }">
			<table width="100%" class="table table-hover table-condensed">
			    <tr>
					<th>类型</th>
					<td>${vo.typeName }</td>
				</tr>
				<tr>
					<th>名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" required="required" placeholder="请输入名称"  style="width:350px;" value="${vo.name }"></td>
				</tr>
				<tr>
					<th>启用禁用</th>
					<td >
					   <input name="isActives"  type="radio" checked="checked"  value="1">启用
					   <input name="isActives"  type="radio"  <c:if test="${vo.isActives==0 }">checked="checked"</c:if>     value="0">禁用
					</td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

