<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/unitInfo.js"></script>
    <script type="text/javascript">
	var formobj;
	var cbutton = parent.$("#cbutton");
	var sbutton = parent.$("#sbutton");
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"saveSchool.do"};
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
            <input name="id" type="hidden"   value="${vo.id }">
            <input name="pid" type="hidden"   value="${vo.pid }">
            <input name="userId" type="hidden"  id="userId"  value="${vo.userId }">
			<input name="creator" type="hidden"  value="${vo.creator }">
			<input name="createdate" type="hidden"   value="${vo.createdate }">
			<input name="type" type="hidden"   value="${vo.type }">
			<input name="typeId" type="hidden"   value="${vo.typeId }">
			<input name="categoryId" type="hidden"   value="${vo.categoryId }">
			<input name="flag" type="hidden"   value="${vo.flag }">
			<input name="pflag" type="hidden"   value="${vo.pflag }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>学校名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" required="required" placeholder="请输入单位名称"  style="width:350px;" value="${vo.name }"></td>
				</tr>
				<tr>
					<th>学校代码</th>
					<td><input name="code" type="text" class="easyui-validatebox textbox" required="required" placeholder="请输入单位代码"  style="width:350px;" value="${vo.code }"></td>
				</tr>
				<tr>
					<th>排序</th>
					<td><input name="seq" type="text"   class="easyui-numberbox textbox" style="width:350px;"  value="${vo.seq }"></td>
				</tr>
				<tr>
					<th>账号</th>
					<td><input name="text" type="text" class="easyui-validatebox textbox"  data-options="required:true,validType:'checkText'" placeholder="请输入管理账号"  style="width:350px;" value="${vo.text }"></td>
				</tr>
				<c:if test="${vo.id==null }">
					<tr>
						<th>密码</th>
						<td><input name="password" id="password" type="password" class="easyui-validatebox textbox" data-options="required:true,validType:'checkPassword'" placeholder="请输入管理密码"  style="width:350px;" value="${vo.password }"></td>
					</tr>
					<tr>
						<th>确认密码</th>
						<td><input  type="password" id="rpw" class="easyui-validatebox textbox" data-options="required:true,validType:'checkPassword'"  style="width:350px;" ></td>
					</tr>
				</c:if>
			</table>
		</form>
     </div>
  </body>
</html>

