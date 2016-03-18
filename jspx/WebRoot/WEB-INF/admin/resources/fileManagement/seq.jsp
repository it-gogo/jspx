<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/fileManagement.js"></script>
    <script type="text/javascript">
	var formobj;
	var cbutton = parent.$("#cbutton");
	var sbutton = parent.$("#sbutton");
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"saveSeq.do"};
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

function up(obj){
	var $tr = $(obj).parents("tr");
	if ($tr.index() != 1) {
		$tr.prev().before($tr);
	}
	var text=$(".clickTr").find(".numText");
	for(var i=0;i<text.length;i++){
		text.eq(i).numberbox('setValue', i+1);
	}
}
function down(obj){
	var trLength = $(".clickTr").length; 
	var $tr = $(obj).parents("tr"); 
	if ($tr.index() != trLength) { 
		$tr.next().after($tr);
	}
	var text=$(".clickTr").find(".numText");
	for(var i=0;i<text.length;i++){
		text.eq(i).numberbox('setValue', i+1);
	}
}

	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
         	<%-- <input type="hidden" name="type" value="${vo.type }" /> --%>
			<table width="100%" class="table table-hover table-condensed" >
					<tr>
						<th>名称</th>
						<td>排序</td>
					</tr>
				<c:forEach items="${list }" var="vo" varStatus="i">
					<tr class="clickTr">
						<th>${vo.name }</th>
						<td>
							<input name="${vo.id }" type="text" class="easyui-numberbox textbox numText" required="required" id="${i.index+1 }" value="${i.index+1 }">
							<a id="up" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-up'" onclick="up(this)">上移</a>&nbsp;&nbsp;
							<a id="down" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-down'" onclick="down(this);">下移</a>&nbsp;&nbsp;
						</td>
					</tr>
				</c:forEach>
				<tr>
			</table>
		</form>
     </div>
  </body>
</html>

