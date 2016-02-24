<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/train/noticeInfo.js"></script>
    <script >
		window.UEDITOR_HOME_URL = "<%=request.getContextPath()%>/ueditor/";
	</script>
	<script language="javascript" src="<%=request.getContextPath() %>/ueditor/ueditor.config.js" ></script>
	<script language="javascript" src="<%=request.getContextPath() %>/ueditor/ueditor.all.min.js" ></script>
	<script >
		var ue;
		$(function(){
		     ue  = UE.getEditor('editor',{
		     });
		}); 
	</script>
	
    <script type="text/javascript">
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
		  showClass();
	});
function beforeSubmit(dform){
	if(ue.getContent()==""){
		parent.$.messager.alert("提示窗口","通知内容必须填写！");
		return false;
	}
	$("#content").val(ue.getContent());
	return true;
}

function showClass(){
	var type=$("#type").val();
	if(type==2){//班级公告
		$("#classTrId").show();
	}else{
		$("#classTrId").hide();
		$("#classId").combobox("setValues","");
	}
}
</script>
  </head>
  <body layout="easyui-layout">
   	<div data-options="region:'center'" >
         <form id="dform" method="post" >
            <input name="id" type="hidden" id="id"    value="${vo.id }">
            <input name="content" type="hidden" id="content"   value="">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th width="100px;">标题</th>
					<td>
						<input name="title" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;" value="${vo.title }">
					</td>
				</tr>
				<tr>
					<th width="100px;">类型</th>
					<td>
						<select name="type" id="type"  style="width:350px;" onchange="showClass()" >
							<option value="1"  selected="selected">全网通知</option>
							<option value="2" <c:if test="${vo.type==2 }">selected="selected"</c:if>>班级通知</option>
						</select>
					</td>
				</tr>
				<tr id="classTrId" style="display: none;">
					<th>班级</th>
					<td>
						<input class="easyui-combobox" style="width:350px;"  name="classId" id="classId" value="${vo.classId }"  data-options="url:'../../baseinfo/classInfo/all.do',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    editable:false
		            	">
					</td>
				</tr>
				<tr>
					<th  width="100px;">通知内容</th>
					<td>
						<%-- <input name="introduction" type="text" data-options="multiline:true"   class="easyui-textbox textbox" style="width:350px;height:100px;"  value="${vo.introduction }"> --%>
						<textarea id="editor"   name="editor"  style="width:80%;"   >${vo.content }</textarea>
					</td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

