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
	checkText: { validator: function(value, param){
		var userId=$("#userId").val();
		var ok=true;
		$.ajax({
			url:"../../platform/userInfo/checkText.do",
			data:"text="+value+"&id="+userId,
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
	},
	checkPassword: { validator: function(value, param){
		var password=$("#password").val();//第一次密码
		var rpw=$("#rpw").val();//确认密码
		if(password=="" || rpw==""){
			return true;
		}
		if(password==rpw){
			return true
		}
		return false;
	},
	message: "两次密码不一样."
	}
});
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
            <input name="userId" type="hidden" id="userId"  value="${vo.userId }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
			        <th width="60px;">名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" value="${vo.name }" data-options="required:true" placeholder="请输入名称" style="width:300px;">&nbsp;<span>*</span></td>
				</tr>
				<tr>
					<th>身份证</th>
					<td><input name="idcard" type="text"   class="easyui-validatebox textbox" required="required" style="width:300px;"  value="${vo.idcard }"></td>
				</tr>
				<tr>
					<th>账号</th>
					<td><input name="text" type="text" class="easyui-validatebox textbox"  data-options="required:true,validType:'checkText'" placeholder="请输入管理账号"  style="width:300px;" value="${vo.text }"></td>
				</tr>
				<c:if test="${vo.id==null }">
				<tr>
					<th>密码</th>
					<td><input name="password" id="password" type="password" class="easyui-validatebox textbox" data-options="required:true,validType:'checkPassword'" placeholder="请输入管理密码"  style="width:300px;" value="${vo.password }"></td>
				</tr>
				<tr>
					<th>确认密码</th>
					<td><input  type="password" id="rpw" class="easyui-validatebox textbox" data-options="required:true,validType:'checkPassword'"  style="width:300px;" ></td>
				</tr>
				</c:if>
			</table>
		</form>
     </div>
  </body>
</html>

