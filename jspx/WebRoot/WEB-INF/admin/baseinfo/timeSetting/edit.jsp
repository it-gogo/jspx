<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript">
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"save.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $("#sbutton").bind('click',function(){
			 $("#dform").submit();
		 });
	});

</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="id" type="hidden" id="id"   value="${vo.id }">
			<input name="creator" type="hidden"  value="${vo.creator }">
			<input name="createdate" type="hidden"   value="${vo.createdate }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>上课时间提前</th>
					<td><input name="beforeClass" type="text" class="easyui-numberbox textbox"  required="required"  style="width:350px;" value="${vo.beforeClass }"><span>分钟</span></td>
				</tr>
				<tr>
					<th>上课时间延后</th>
					<td><input name="afterClass" type="text" class="easyui-numberbox textbox"  required="required"  style="width:350px;" value="${vo.afterClass }"><span>分钟</span></td>
				</tr>
				<tr>
					<th>下课课时间提前</th>
					<td><input name="beforeFinishClass" type="text" class="easyui-numberbox textbox"  required="required"  style="width:350px;" value="${vo.beforeFinishClass }"><span>分钟</span></td>
				</tr>
				<tr>
					<th>下课课时间延后</th>
					<td><input name="afterFinishClass" type="text" class="easyui-numberbox textbox"  required="required"  style="width:350px;" value="${vo.afterFinishClass }"><span>分钟</span></td>
				</tr>
				<tr>
					<th>旷课</th>
					<td><input name="absenteeism" type="text" class="easyui-numberbox textbox"  required="required"  style="width:350px;" value="${vo.absenteeism }"><span>分钟</span></td>
				</tr>
				<tr>
					<th>是否下课打卡</th>
					<td><input name="isAfterClassPunch" type="checkbox" value="1" <c:if test="${vo.isAfterClassPunch==1 }">checked="checked"</c:if> ><span>是</span></td>
				</tr>
				<tr>
					<th>操作</th>
					<td>
						<a id="sbutton" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="height:40px;width:100px;" onclick="deleteAllF();">保存</a>&nbsp;&nbsp;  
					</td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

