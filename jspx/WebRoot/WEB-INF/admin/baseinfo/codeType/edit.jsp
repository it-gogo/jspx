<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/codeType.js"></script>
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
/**
*账号检验
*/
$.extend($.fn.validatebox.defaults.rules, {
	checkCode: { validator: function(value, param){
		var id=$("#id").val();
		var ok=true;
		$.ajax({
			url:"checkCode.do",
			data:"code="+value+"&id="+id,
			async: false,
			success:function(data){
				var json=eval("("+data+")");
				if(json.message){
					ok=true;
				}else{
					ok=false; 
				}
			}
		});
		return ok;
	},
	message: "编码已存在，请重新输入."
	}
});
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
			        <th>名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" value="${vo.name }" data-options="required:true" placeholder="请输入名称"  value="">&nbsp;<span>*</span></td>
				</tr>
				<tr>
			        <th>编码</th>
					<td><input name="code" type="text" class="easyui-validatebox textbox" value="${vo.code }" data-options="required:true,validType:'checkCode'" placeholder="请输入唯一编码"  value="">&nbsp;<span>*</span></td>
				</tr>
				<tr>
				 <th>
				    是否启用
				 </th>
				 <td>
					<input type="radio" name="isActives"    checked="checked" value="1"/>启用
	              	<input type="radio" name="isActives"   <c:if test="${vo.isActives==0 }">checked</c:if>   value="0" />禁用
				</td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

