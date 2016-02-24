<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/artificialAttendance.js"></script>
    <script type="text/javascript">
	var cbutton = parent.$("#cbutton");
	var sbutton = parent.$("#sbutton");
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"modify.do"};
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
	<div data-options="region:'south'" style="height:200px;">
         <form id="dform" method="post" >
            <input name="id" type="hidden" id="id"   value="${vo.id }">
			<input name="creator" type="hidden"  value="${vo.creator }">
			<input name="createdate" type="hidden"   value="${vo.createdate }">
			<input name="studentId" type="hidden" id="studentId"  value="${vo.studentId }">
			<input name="attendanceId" type="hidden"   value="${vo.attendanceId }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
			        <th style="width:285px;">学员</th>
					<td>
						${vo.studentName }
					</td>
				</tr>
				<tr>
			        <th style="width:285px;">登记类别</th>
					<td>
						<select class="easyui-combobox" style="width:350px;" data-options="editable:false" name="categoryId" value="${vo.categoryId }" >
							<option value="1" selected="selected">请假</option>
							<option value="2" <c:if test="${vo.categoryId==2 }">selected="selected"</c:if> >忘带卡</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>登记时间</th>
					<td><input name="date" type="text" class="easyui-datetimebox textbox" data-options="editable:false" required="required"  style="width:350px;" value="${vo.date }"></td>
				</tr>
				<tr>
					<th>备注</th>
					<td><input name="remark" type="text" data-options="multiline:true"   class="easyui-textbox textbox" style="width:350px;height:50px;"  value="${vo.remark }"></td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

