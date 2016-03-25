<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/site/sectionManagement.js"></script>
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
		 
		 var type=encodeURI("oa栏目");
		 $("#parentId").combotree({url:"tree.do?notCode=${vo.code }&noBranchId=1&type="+type+"&ck="+Math.random()});
		 
		 $("#clear").click(function(){
		 	$('#parentId').combotree("clear");
		 });
	});
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post"  enctype="multipart/form-data"  >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
            <input name="code" type="hidden"   value="${vo.code }">
			<input name="parentCode" type="hidden"   value="${vo.parentCode }">
			<input name="type" type="hidden"   value="oa栏目">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
			        <th>上级栏目</th>
					<td>
						<input class="easyui-combotree" style="width:350px;"  name="parentId" id="parentId" value="${vo.parentId }"  data-options="url:'',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    editable:false
		            	">
		            	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" id="clear">重置</a>
					</td>
				</tr>
				<tr>
					<th>栏目名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;" value="${vo.name }"></td>
				</tr>
				<tr>
					<th>绝对地址</th>
					<td><input name="absoluteUrl"  placeholder="存在绝对地址时，直接跳转绝对地址。(http://开头)" type="text" class="easyui-validatebox textbox"  style="width:350px;" value="${vo.absoluteUrl }"></td>
				</tr>
				<tr>
				<tr>
					<th>排序</th>
					<td><input name="seq" type="text" class="easyui-numberbox textbox"   style="width:350px;" value="${vo.seq }"></td>
				</tr>
				<tr>
					<th>二级页面logo</th>
					<td>
						<input class="easyui-filebox" name="picFile" id="picFile" data-options="prompt:'选择图片',buttonText:'选择文件'" style="width:350px">
						<input id="picUrl" name="picUrl" type="hidden" value="${vo.picUrl }" />
					</td>
				</tr>
				<tr>
					<th>是否导航显示</th>
					<td>
						<input name="isNavShow" checked="checked" type="radio" value="是"  id="isNavShow_shi" /><label for="isNavShow_shi">是</label>
						<input name="isNavShow" <c:if test="${vo.isNavShow=='否' }">checked="checked"</c:if> type="radio" value="否"  id="isNavShow_fou" /><label for="isNavShow_fou">否</label>
					</td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

