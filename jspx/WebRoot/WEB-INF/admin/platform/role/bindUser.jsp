<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/platform/role.js"></script>
		<script type="text/javascript">
			var dataGrid;
			var cbutton = parent.$("#cbutton");
			var sbutton = parent.$("#sbutton");
		 	$(document).ready(function(){
			  	var gridoption = {url:"userList.do?roleId=${vo.roleId}",id:"grid",onLoadSuccess:function(data){selectCheckbox(data);}};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
		 	function selectCheckbox(data){
		 		if(data){
					$.each(data.rows, function(index, item){
						if(item.checked){
							$('#grid').datagrid('checkRow', index);
						}
					});
				}
		 	}
		 	
		 	//绑定保存事件
			$(sbutton).bind('click',function() {
				var id = [];
				id.push(getCheckeds1("grid","id"));
				/* if (id == "") {
					parent.$.messager.alert('提示', "至少选择一个登陆信息！",'info');
					return;
				}  */
				parent.$.messager.progress({
					title : '提示',
					text : '数据处理中，请稍后....'
				});
					$.post('saveUser.do?roleId=${vo.roleId}',{userId : id.join(',')},
						function(result) {
									parent.$.messager.progress('close');
									if (result.message) {
										parent.$.messager.alert('提示',result.message,'info');
										if (parent.dialogMap["d3"] != undefined
												&& parent.dialogMap["d3"] != null) {
											parent.$.createDialog.open_grid
													.datagrid('reload');
											parent.dialogMap["d3"]
													.dialog('close');
										}
									} else if (result.other) {
										//做其他回调函数
									}
									parent.$.messager
											.progress('close');
								}, 'JSON');
					});
			//绑定关闭事件
			$(cbutton).bind('click', function() {
				parent.dialogMap["d3"].dialog('close');
			});
		</script>
		
	</head>
	<body >
		   <div class="easyui-panel" style="padding:5px;"  data-options="fit:true,border:false">
		   	<div class="easyui-layout" data-options="fit:true" >
		    <div data-options="region:'north'" style="height:35px;">
		       <div style="width:100%;height:100%">
		          <form id="qform">
		          <table>
		          <tr>
		            <td>账号:</td>
		            <td>
		            	<input type="text" class="easyui-validatebox" id="text" name="text" value="">
		            </td>
		            <td>
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查  询</a>&nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全  部</a>&nbsp;&nbsp;
		            </td>
		          </tr>
		          </table>
		          </form>
		       </div>
		     </div>
		   <div data-options="region:'center'">
		    <table id="grid">
        <thead>
            <tr>
            	<th data-options="field:'ck'" width="10" checkbox=true ></th>
                <th data-options="field:'text'" width="80">账号</th>
            </tr>
        </thead>
    </table>
    </div>
    </div>
    </div>
	</body>
</html>
