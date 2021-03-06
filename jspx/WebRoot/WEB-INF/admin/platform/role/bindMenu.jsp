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
		 		var treeoptions = {id:"treeID",url:"../role/menuTree.do?roleId=${vo.roleId}",checkbox:true,cascadeCheck :true};
		  		$.initTree(treeoptions);
		 	});
		 	
		 	
		 	
			//绑定保存事件
			$(sbutton).bind('click',function() {
				var id = [];
				id.push(getChecked("treeID"));
				if (id == "") {
					parent.$.messager.alert('提示', "至少选择一个菜单！",'info');
					return;
				}
				parent.$.messager.progress({
					title : '提示',
					text : '数据处理中，请稍后....'
				});
					$.post('saveAuthority.do?roleId=${vo.roleId}',{menuId : id.join(',')},
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
		<div class="easyui-layout" data-options="fit:'true'">
			<div data-options="region:'west',split:true,title:'菜单树',collapsible:true" style="width:100%">
				<%@include file="/WEB-INF/admin/common/tree.jsp"%>
			</div>
		</div>
	</body>
</html>
