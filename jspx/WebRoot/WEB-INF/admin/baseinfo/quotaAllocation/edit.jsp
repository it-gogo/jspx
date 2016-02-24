<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript">
    var dbuttons =[{ 
		text:'保 存',
		iconCls:'icon-ok',
		id:'qasbutton'
	},{
		text:'关 闭',
		iconCls:'icon-cancel',
		id:'qacbutton'
	}];
	var cbutton = parent.$("#qacbutton");
	var sbutton = parent.$("#qasbutton");
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"save.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $(sbutton).bind('click',function(){
			 $("#dform").submit();
		 });
		 //绑定关闭事件
		 $(cbutton).bind('click',function(){
		 	var pf=parent.$("#uframe_d3")[0].contentWindow;
			pf.$("#grid").datagrid('reload');
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
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
            <input name="classId"  type="hidden"  id="classId"    value="${vo.classId }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
			        <th>学校</th>
					<td><%-- <input name="name" type="text" class="easyui-validatebox textbox" value="${vo.name }" data-options="required:true" style="width:350px" value="">&nbsp;<span>*</span> --%>
						<input class="easyui-combotree" style="width:350px;"  name="schoolId" value="${vo.schoolId }"  data-options="url:'../unitInfo/school.do?quotaAllcationId=${vo.id }&classId=${vo.classId }',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    editable:false,
		                    required:true,
		                    onSelect:function(node){
		                    	var type=node.type;
		                    	if(typeof(type)!='undefined' && type==2){
		                    		return true;
		                    	}else{
		                    		$(this).combotree('clear');
		                    	}
		                    }
		            	">
					</td>
				</tr>
				<tr>
			        <th>学员数量</th>
					<td><input name="number" type="text" class="easyui-numberbox textbox" value="${vo.number }" data-options="required:true" style="width:350px" value="">&nbsp;<span>*</span></td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

