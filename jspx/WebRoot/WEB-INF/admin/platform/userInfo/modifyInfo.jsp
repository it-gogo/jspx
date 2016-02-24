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
		var  formOptions = {id:"dform",urls:"modifyPassword.do"};
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
function customRefresh(){
	parent.dialogMap["d3"].dialog('close');
}
</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="id" type="hidden"   value="${teacherInfo.id }">
            <input name="userId" type="hidden"   value="${teacherInfo.userId }">
			<table width="100%" class="table table-hover table-condensed">
				<c:if test="${!empty teacherInfo }">
					<c:if test="${unitInfo==null || unitInfo.type!=2 }">
						<tr>
					        <th>单位</th>
							<td>
								<input class="easyui-combotree" style="width:350px;"  name="schoolId" readonly="readonly" value="${teacherInfo.schoolId }"  data-options="url:'../../baseinfo/unitInfo/school.do',
				                    method:'get',
				                    valueField:'id',
				                    textField:'name',
				                    editable:false,
				                    onSelect:function(node){
				                    	var type=node.type;
				                    	if(typeof(type)!='undefined'){
				                    		return true;
				                    	}else{
				                    		$(this).combotree('clear');
				                    	}
				                    }
				            	">
							</td>
						</tr>
					</c:if>
					<c:if test="${unitInfo!=null && unitInfo.type==2 }">
						<c:if test="${teacherInfo.id==null }">
							<input name="schoolId" type="hidden"   value="${unitInfo.id }">		
						</c:if>
						<c:if test="${teacherInfo.id!=null }">
							<input name="schoolId" type="hidden"   value="${teacherInfo.schoolId }">
						</c:if>
					</c:if>
					<tr>
						<th>姓名</th>
						<td><input name="name" type="text" class="easyui-validatebox textbox" required="required" placeholder="请输入老师姓名"  style="width:350px;" value="${teacherInfo.name }"></td>
					</tr>
					<tr>
						<th>性别</th>
						<td >
						   <input name="sex"  type="radio"  checked="checked"   value="0">女
						   <input name="sex"  type="radio"  <c:if test="${teacherInfo.sex==1 }">checked="checked"</c:if> value="1">男
						</td>
					</tr>
					<tr>
						<th>民族</th>
						<td>
							<input class="easyui-combotree" style="width:350px;"  name="raceId" value="${teacherInfo.raceId }"  data-options="url:'../../baseinfo/codeData/all.do?code=MZ',
			                    method:'get',
			                    valueField:'id',
			                    textField:'name',
			                    editable:false
			            	">
						</td>
					</tr>
					<tr>
						<th>党派</th>
						<td>
							<input class="easyui-combotree" style="width:350px;"  name="partisanId" value="${teacherInfo.partisanId }"  data-options="url:'../../baseinfo/codeData/all.do?code=DP',
			                    method:'get',
			                    valueField:'id',
			                    textField:'name',
			                    editable:false
			            	">
						</td>
					</tr>
					<tr>
						<th>身份证</th>
						<td><input name="idcard" type="text"   class="easyui-validatebox textbox" required="required" style="width:350px;"  value="${teacherInfo.idcard }"></td>
					</tr>
					<tr>
						<th>卡号</th>
						<td><input name="card" type="text"   class="easyui-validatebox textbox"  style="width:350px;"  value="${teacherInfo.card }"></td>
					</tr>
					<tr>
						<th>联系电话</th>
						<td><input name="telephone" type="text"   class="easyui-validatebox textbox"   style="width:350px;"  value="${teacherInfo.telephone }"></td>
					</tr>
					<tr>
						<th>QQ</th>
						<td><input name="qq" type="text"   class="easyui-validatebox textbox"   style="width:350px;"  value="${teacherInfo.qq }"></td>
					</tr>
					<tr>
						<th>家庭地址</th>
						<td><input name="address" type="text"   class="easyui-validatebox textbox"   style="width:350px;"  value="${teacherInfo.address }"></td>
					</tr>
					<tr>
						<th>主科学段</th>
						<td>
							<input class="easyui-combotree" style="width:350px;"  name="zkxdId" value="${teacherInfo.zkxdId }"  data-options="url:'../../baseinfo/codeData/all.do?code=XD',
			                    method:'get',
			                    valueField:'id',
			                    textField:'name',
			                    editable:false
			            	">
						</td>
					</tr>
					<tr>
						<th>主科学科</th>
						<td>
							<input class="easyui-combotree" style="width:350px;"  name="zkxkId" value="${teacherInfo.zkxkId }"  data-options="url:'../../baseinfo/codeData/all.do?code=XK',
			                    method:'get',
			                    valueField:'id',
			                    textField:'name',
			                    editable:false
			            	">
						</td>
					</tr>
					<tr>
						<th>副科学段</th>
						<td>
							<input class="easyui-combotree" style="width:350px;"  name="fkxdId" value="${teacherInfo.fkxdId }"  data-options="url:'../../baseinfo/codeData/all.do?code=XD',
			                    method:'get',
			                    valueField:'id',
			                    textField:'name',
			                    editable:false
			            	">
						</td>
					</tr>
					<tr>
						<th>副科学科</th>
						<td>
							<input class="easyui-combotree" style="width:350px;"  name="fkxkId" value="${teacherInfo.fkxkId }"  data-options="url:'../../baseinfo/codeData/all.do?code=XK',
			                    method:'get',
			                    valueField:'id',
			                    textField:'name',
			                    editable:false
			            	">
						</td>
					</tr>
					<tr>
						<th>账号</th>
						<td><input name="text" readonly="readonly" type="text" class="easyui-validatebox textbox"  data-options="required:true,validType:'checkText'" placeholder="请输入管理账号"  style="width:350px;" value="${user.text }"></td>
					</tr>
				</c:if>
				<tr>
					<th>密码</th>
					<td><input name="password" id="password" type="password" class="easyui-validatebox textbox" data-options="validType:'checkPassword'" placeholder="请输入管理密码"  style="width:350px;" value=""></td>
				</tr>
				<tr>
					<th>确认密码</th>
					<td><input  type="password" id="rpw" name="rpw" class="easyui-validatebox textbox" data-options="validType:'checkPassword'"  style="width:350px;" ></td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

