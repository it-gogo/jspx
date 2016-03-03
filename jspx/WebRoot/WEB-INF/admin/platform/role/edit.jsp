<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/platform/role.js"></script>
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
            <input name="password"  type="hidden"      value="${vo.password }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
			        <th>名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" value="${vo.name }" data-options="required:true"   >&nbsp;<span>*</span></td>
				</tr>
				<tr>
			        <th>类别</th>
					<td>
						<select name="type" class="easyui-combobox" style="width: 300px;" data-options="editable:false">
							<option value="私有" <c:if test="${vo.type=='私有' }">selected="selected"</c:if>>私有</option>
							<option value="公开" <c:if test="${vo.type=='公开' }">selected="selected"</c:if>>公开</option>
						</select>
					</td>
				</tr>
				<tr>
				 <th>
				    是否启用
				 </th>
				 <td>
					<input type="radio" name="status"    checked="checked" value="启用"/>启用
	              	<input type="radio" name="status"   <c:if test="${vo.isActives=='禁用' }">checked</c:if>   value="禁用" />禁用
				</td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

