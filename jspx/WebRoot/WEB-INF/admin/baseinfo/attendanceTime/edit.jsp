<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/attendanceTime.js"></script>
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
			parent.dialogMap["d5"].dialog('close');
		 });
	});
	/**
	*自定义刷新列表
	*/
	function customRefresh(){
		var index=$("#index").val();
		parent.$("#main").tabs("getSelected").find("iframe")[0].contentWindow.$("#iframe_"+index)[0].contentWindow.$("#grid").datagrid('load');
		parent.dialogMap["d5"].dialog('close');
	}
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
            <input name="index"  type="hidden"  id="index"    value="${vo.index }">
            <input name="classTimeId"  type="hidden"  id="classTimeId"    value="${vo.classTimeId }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
			        <th>考勤时间</th>
					<td><input name="attendanceTime" type="text" class="easyui-datetimebox textbox" value="${vo.attendanceTime }" data-options="required:true,editable:false"  style="width: 200px;"  ></td>
				</tr>
				<tr>
			        <th>考勤类型</th>
					<td>
						<select name="type" class="easyui-combobox" style="width: 200px;" data-options="editable:false">
							<option value="1" >上课考勤</option>
							<option value="2" <c:if test="${vo.type==2 }">selected="selected"</c:if>>下课考勤</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>考勤时间提前</th>
					<td><input name="beforeAttendance" type="text" class="easyui-numberbox textbox"  required="required"  style="width:200px;" value="${vo.beforeAttendance }"><span>分钟</span></td>
				</tr>
				<tr>
					<th>考勤时间延后</th>
					<td><input name="afterAttendance" type="text" class="easyui-numberbox textbox"  required="required"  style="width:200px;" value="${vo.afterAttendance }"><span>分钟</span></td>
				</tr>
				<tr>
					<th>旷课</th>
					<td><input name="absenteeism" type="text" class="easyui-numberbox textbox"  required="required"  style="width:200px;" value="${vo.absenteeism }"><span>分钟</span></td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

