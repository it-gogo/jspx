<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/fileManagement.js"></script>
    <script type="text/javascript">
	var formobj;
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"serverImport.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $("#import").bind('click',function(){
			 $("#dform").submit();
		 });
		 //绑定关闭事件
		 $("#close").bind('click',function(){
			parent.dialogMap["d3"].dialog('close');
		 });
	});
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="topFileId"  type="hidden"  id="topFileId"    value="${vo.topFileId }">
            <input name="parentId"  type="hidden"  id="parentId"    value="${vo.parentId }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>服务器文件夹路径</th>
					<td>
						<input name="serverPath" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;"><span style="color:red;font-size:14px;">如(E:\test)</span>
					</td>
				</tr>
				<tr>
					<th>温馨提醒</th>
					<td>
						<span style="color:red;font-size:14px;font-weight: bold;">目标文件夹是服务器上的文件夹绝对路径，不是客户端的文件夹！</span>
					</td>
				</tr>
			</table>
			<center>
				<a class="easyui-linkbutton" id="import" href="javascript:void(0);" data-options="iconCls:'icon-ok'">提交导入</a> | 
				<a href="javascript:void(0);" id="close" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">关闭窗口</a>
			</center>
		</form>
     </div>
  </body>
</html>

