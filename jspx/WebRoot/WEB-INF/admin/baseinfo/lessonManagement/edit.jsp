<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/lessonManagement.js"></script>
    <script type="text/javascript">
	var cbutton = parent.$("#kscbutton");
	var sbutton = parent.$("#kssbutton");
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"save.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $(sbutton).bind('click',function(){
		 	var courseId=$("#courseId").val();
		 	if(courseId==""){
				 var isValid = $("#dform").form('validate');
				if (!isValid) {
					alert("请检查录入信息是否正确");
					return;
				}
				 var subjectName=$("#subjectId").combobox("getText");
				 var subjectId=$("#subjectId").combobox("getValue");
				 var lesson=$("#lesson").val();
				 var id=$("#id").val();
				 var index=$("#index").val();
				var instructor=$("#instructor").val();
				
				 var pf=parent.$("#uframe_d3")[0].contentWindow;
				  if(index!=""){//修改
				  	pf.$("#grid").datagrid('updateRow',{index: index,row:{
					  		subjectId: subjectId,
							subjectName:subjectName,
							lesson: lesson,
							id: id,
							instructor:instructor
						}});
				 }else{//新增
					  pf.$("#grid").datagrid('appendRow',{
					  		subjectId: subjectId,
							subjectName:subjectName,
							lesson: lesson,
							id: id,
							instructor:instructor
						});
				 }
				 parent.dialogMap["d5"].dialog('close');
		 	}else{
		 		$("#dform").submit();//courseId存在就提交后台
		 	}
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
		var pf=parent.$("#uframe_d3")[0].contentWindow;
		pf.$("#grid").datagrid("reload");
		parent.dialogMap["d5"].dialog('close');
	}
</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'" >
         <form id="dform" method="post" >
            <input name="id" type="hidden" id="id"   value="${vo.id }">
            <input name="courseId" type="hidden" id="courseId"   value="${vo.courseId }">
            <input name="index" type="hidden" id="index"   value="${vo.index }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>科目名称</th>
					<td>
						<input class="easyui-combobox" style="width:350px;"  name="subjectId" id="subjectId" value="${vo.subjectId }"  required="required"  data-options="url:'../codeData/all.do?code=KM',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    editable:false
		            	">
					</td>
				</tr>
				<tr>
					<th>课时</th>
					<td><input name="lesson" id="lesson" type="text" class="easyui-numberbox textbox"  data-options="min:0"  required="required"  style="width:350px;" value="${vo.lesson }"></td>
				</tr>
				<tr>
					<th>授课老师</th>
					<td><input name="instructor" id="instructor" type="text" class="easyui-validatebox textbox"   required="required"  style="width:350px;" value="${vo.instructor }"></td>
				</tr>
			</table>
		</form>
     </div>
     
  </body>
</html>

