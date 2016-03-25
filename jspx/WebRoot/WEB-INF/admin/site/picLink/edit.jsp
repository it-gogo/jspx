<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
	<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/site/picLink.js"></script>
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
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox"   style="width:350px;" value="${vo.name }"></td>
				</tr>
			
				<tr>
			        <th>类型</th>
					<td>
						<select class="easyui-combobox" data-options="editable:false" value="${vo.type }" name="type" style="width:350px;">
							<option value="行政办公" selected="selected" >行政办公</option>
							<option value="广告图片" <c:if test="${vo.type=='广告图片'}">selected="selected"</c:if> >广告图片</option>
							<option value="友情链接" <c:if test="${vo.type=='友情链接'}">selected="selected"</c:if> >友情链接</option>
							<option value="专题网站" <c:if test="${vo.type=='专题网站'}">selected="selected"</c:if>>专题网站</option>
							<option value="党建专栏" <c:if test="${vo.type=='党建专栏'}">selected="selected"</c:if>>党建专栏</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>链接地址</th>
					<td><input name="linkAddr" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;" value="${vo.linkAddr }"></td>
				</tr>
				<tr>
				<tr>
					<th>打开方式</th>
					<td>
							<input type="radio" name="openType" value="_self"  checked="checked"/>本窗口打开
							<input type="radio" name="openType" value="_blank"  <c:if test="${vo.openType=='_blank' }">checked</c:if>/>新窗口打开
					</td>
				</tr>
				<tr>
					<th>排序</th>
					<td><input name="seq" type="text" class="easyui-numberbox textbox"   style="width:350px;" value="${vo.seq }"></td>
				</tr>
				<tr>
					<th>上传图片</th>
					<td>
						<input class="easyui-filebox" name="picFile" id="picFile" data-options="prompt:'选择图片',buttonText:'选择文件'" style="width:350px">
						<input id="picUrl" name="picUrl" type="hidden" value="${vo.picUrl }" />
					</td>
				</tr>
				<tr>
				 <th>
				    状态
				 </th>
				 <td>
					<input type="radio" name="status"    checked="checked" value="启用"/>启用
	              	<input type="radio" name="status"   <c:if test="${vo.status=='禁用' }">checked</c:if>   value="禁用" />禁用
				</td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

