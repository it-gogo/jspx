<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/codeData.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	var treeoptions = {id:"treeID",url:"../codeType/tree.do",onClick:treeClick};
		  		$.initTree(treeoptions);
		 	});
		 	function  treeClick(node){
				var typeId = node.id;
				var  parameter = {};
				parameter["typeId"]=typeId;
				$("#typeId","#qform").val(typeId);
				dataGrid.datagrid('load',parameter);
			}
		</script>
		
	</head>
<body>
	<div class="easyui-layout" data-options="fit:'true'">
		<div data-options="region:'west',split:true,title:'类型树',collapsible:true" style="width:200px;">
			<%@include file="/WEB-INF/admin/common/tree.jsp"%>
		</div>
		<div data-options="region:'center'">
			<div class="easyui-panel" style="padding:5px;"
				data-options="fit:true,border:false">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north'" style="height:35px;">
						<div style="width:100%;height:100%">
							<form class="bjaa" id="qform">
								<table>
									<tr>
										<td>名称:</td>
										<td>
											<input type="text" class="easyui-validatebox" id="name"   value=""> 
											<input type="hidden" class="easyui-validatebox" id="typeId"   value=""></td>
										<td>
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新 增</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="deleteAllF();">删 除</a>
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
									<th data-options="field:'id',checkbox:true"></th>
									<th data-options="field:'name'" width="220">名称</th>
									<th data-options="field:'typeName'" width="100">类型</th>
									<th data-options="field:'isActives'" width="150" formatter="handlerisactives">状态</th>
									<th data-options="field:'handler'" width="150" formatter="handlerstr">操作</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
</body>
</html>
