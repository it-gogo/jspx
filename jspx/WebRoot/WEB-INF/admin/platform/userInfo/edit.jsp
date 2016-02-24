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
/**
*账号检验
*/
$.extend($.fn.validatebox.defaults.rules, {
	checkText: { validator: function(value, param){
		var id=$("#id").val();
		var ok=true;
		$.ajax({
			url:"checkText.do",
			data:"text="+value+"&id="+id,
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
	message: "账号已存在，请重新输入."
	}
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
			        <th>账号</th>
					<td><input name="text" type="text" class="easyui-validatebox textbox" value="${vo.text }" data-options="required:true,validType:'checkText'" placeholder="请输入账号"  value="">&nbsp;<span>*</span></td>
				</tr>
				<tr>
			        <th>密码</th>
					<td><input name="newpw" type="password" class="easyui-validatebox textbox"  ></td>
				</tr>
				<%-- <tr>
			        <th>单位</th>
					<td>
						<input class="easyui-combobox"   name="unitId" value="${vo.unitId }"  data-options="url:'../../business/clientinfo/findAll.do',
		                    method:'get',
		                    valueField:'ID',
		                    textField:'CNAME',
		                    editable:false
		            	">
					</td>
				</tr>
				<tr>
			        <th>学校</th>
					<td>
						<input class="easyui-combobox"   name="schoolId" value="${vo.schoolId }"  data-options="url:'../../business/clientinfo/findAll.do',
		                    method:'get',
		                    valueField:'ID',
		                    textField:'CNAME',
		                    editable:false
		            	">
					</td>
				</tr> --%>
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

