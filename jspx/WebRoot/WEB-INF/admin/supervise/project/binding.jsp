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
         <form id="dform" method="post"  enctype="multipart/form-data">
            <input name="id" type="hidden"  value="${vo.id }">
            <input name="type" type="hidden"  value="${vo.type }">
            <input name="bindingTime" type="hidden"  value="${vo.bindingTime }">
			<table width="100%" class="table table-hover table-condensed">
			    <tr>
			        <th width="60px;">上级项目</th>
					<td>
						<input class="easyui-combotree" style="width:300px;"  name="pid" value="${vo.pid }"  data-options="url:'tree.do?isSelect=1&notCode=${vo.code }',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    editable:false
		            	">
		            	
					</td>
				</tr>
				<tr>
					<th>名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" required="required"    style="width:300px;" value="${vo.name }"></td>
				</tr>
				<tr>
					<th >说明</th>
					<td>
						<input name="remark" type="text" data-options="multiline:true"   class="easyui-textbox textbox" style="width:300px;height:100px;"  value="${vo.remark }">
					</td>
				</tr>
				<tr>
					<th>排序</th>
					<td><input name="seq" type="text"   class="easyui-numberbox textbox" style="width:300px;"  value="${vo.seq }"></td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

