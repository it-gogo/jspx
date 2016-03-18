<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/fileSubmit.js"></script>
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
		 var dataUrl = $("#submitUrl").val();
		 $("#submitFile").filebox('setValue',dataUrl);
		 
	});
//下载文件
function download1(fileName,fileUrl){
	location.href="../../common/downloadData.do?fileName="+fileName+"&fileUrl="+fileUrl;
}
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post"  enctype="multipart/form-data"  >
            <input name="submitId"  type="hidden"  id="submitId"    value="${vo.id }">
            <input name="fileId"  type="hidden"  id="fileId"    value="${vo.fileId }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>截止时间</th>
					<td>
						${vo.endDate }
					</td>
				</tr>
				<tr>
					<th>标题</th>
					<td>${vo.title }</td>
				</tr>
				<tr>
				<tr>
					<th>附件</th>
					<td>
						<a id="btn" href="javascript:void(0);"  class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="download1('${vo.title }','${vo.accessoryUrl }')">点击下载</a>
					</td>
				</tr>
				<tr>
					<th >说明</th>
					<td>
						${vo.content }
					</td>
				</tr>
				<tr>
					<th>提交附件</th>
					<td>
						<input class="easyui-filebox" name="submitFile" required="required" id="submitFile" data-options="prompt:'选择图片',buttonText:'选择文件'" style="width:350px;" >
						<input id="submitUrl" name="submitUrl" type="hidden" value="${vo.submitUrl }" />
					</td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

