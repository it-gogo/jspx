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
            <input name="id" type="hidden"  value="${vo.id }">
			<input name="pid" type="hidden"  value="${vo.pid }">
			<input name="code" type="hidden"   value="${vo.code }">
			<input name="pcode" type="hidden"  value="${vo.pcode }">
			<input name="series" type="hidden"  value="${vo.series }">
			<table width="100%" class="table table-hover table-condensed">
			    <tr>
					<th>上级菜单</th>
					<td><input   type="text" class="easyui-validatebox textbox"  readonly="readonly" style="width:350px;" value="${vo.pname }"></td>
				</tr>
				<tr>
					<th>菜单名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" required="required" placeholder="请输入菜单名称"  style="width:350px;" value="${vo.name }"></td>
				</tr>
				<tr>
					<th>菜单url</th>
					<td><input name="urls" type="text" placeholder="请输入菜单URL" class="easyui-validatebox textbox" style="width:350px;" data-options="required:true" value="${vo.urls }"></td>
				</tr>
				<tr>
					<th>排序</th>
					<td><input name="seq" type="text"   class="easyui-numberbox textbox" style="width:350px;"  value="${vo.seq }"></td>
				</tr>
				<!-- <tr>
					<th>菜单图标</th>
					<td>
						<input class="easyui-filebox" name="img" data-options="buttonText:'选择图片'" style="width:350px">
					</td>
				</tr> -->
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

