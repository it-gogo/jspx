<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/absoluteManagement.js"></script>
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
            <input name="masterId"  type="hidden"  id="masterId"    value="${vo.masterId }">	
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>顶级文件</th>
					<td>
						<input class="easyui-combotree" style="width:350px;"   name="topFileId"  required="required" value="${vo.topFileId }"  data-options="url:'topFileTree.do',
		                    method:'get',
		                    valueField:'id',
		                    textField:'text',
		                    editable:false,
		                    onSelect:function(node){
		                    	var id=node.id;
		                    	if(typeof(id)=='undefined' ){
		                    		$(this).combotree('clear');
		                    	}else{
		                    		return true;
		                    	}
		                    }
		            	">
					</td>
				</tr>
				<tr>
					<th>路径</th>
					<td><input name="absoluteUrl" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;" value="${vo.absoluteUrl }"></td>
				</tr>
				<tr>
			</table>
		</form>
     </div>
  </body>
</html>

