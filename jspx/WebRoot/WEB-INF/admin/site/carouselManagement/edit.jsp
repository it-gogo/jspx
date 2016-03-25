<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/site/carouselManagement.js"></script>
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
		 var dataUrl = $("#picUrl").val();
		 $("#picFile").filebox('setValue',dataUrl);
	});
	
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post"  enctype="multipart/form-data"  >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
            <input name="type"  type="hidden"  id="type"    value="oa轮播">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;" value="${vo.name }"></td>
				</tr>
				<tr>
				<tr>
					<th>轮播图片</th>
					<td>
						<input class="easyui-filebox" name="picFile" id="picFile" data-options="prompt:'选择图片',buttonText:'选择文件'" style="width:350px">
						<input id="picUrl" name="picUrl" type="hidden" value="${vo.picUrl }" />
					</td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

