<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/site/articleTitleColor.js"></script>
    <script type="text/javascript">
	var formobj;
	var cbutton = parent.$("#cbutton");
	var sbutton = parent.$("#sbutton");
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"save.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $(sbutton).bind("click",function(){
			 $("#dform").submit();
		 });
		 //绑定关闭事件
		 $(cbutton).bind("click",function(){
			parent.dialogMap["d3"].dialog("close");
		 });
	});
	
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post"  >
         	<input name="content" type="hidden" id="content"   value="">
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;"  value="${vo.name }"></td>
				</tr>
				<tr>
				<tr>
					<th>颜色</th>
					<td>
						<c:choose>
							<c:when test="${vo!=null}">
								<input name="color" id="color" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;"  value="${vo.color }">
							</c:when>
							<c:otherwise>
								<input name="color" id="color" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;"  value="#fff">
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>排序</th>
					<td><input name="seq" type="text" class="easyui-numberbox textbox"   style="width:350px;"  value="${vo.seq }"></td>
				</tr>
			</table>
		</form>
     </div>
  </body>
<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/jsColorPicker/colors.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/jsColorPicker/colorPicker.data.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/jsColorPicker/colorPicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/jsColorPicker/jqColor.js"></script>
<script type="text/javascript">
	var $colors = $("#color").colorPicker({
    customBG: "#222",
    readOnly: false,
    init: function(elm, colors) { 
      elm.style.backgroundColor = elm.value;
      elm.style.color = colors.rgbaMixCustom.luminance > 0.22 ? "#222" : "#ddd";
    }
  }).each(function(idx, elm) {
	});
</script>
</html>
