<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/accepte.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	//var gridoption = {url:"list.do",id:"grid",pagination:true, view: detailview,detailFormatter:function(index,row){return detailHtml(index,row);},onExpandRow: function(index,row){return openDetail(index,row);}};
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
/**
*操作
*/
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)' plain='true' iconCls='icon-search'  onclick='lookStudent("+json+")';>查看学生</a> " ;
     return  handstr;
}

</script>
		
	</head>
<body>
	<div class="easyui-panel" style="padding:5px;" data-options="fit:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north'" style="height:35px;">
				<div style="width:100%;height:100%">
					<form class="bjaa" id="qform">
						<table>
							<tr>
								<td>班级名称:</td>
								<td>
									<input type="text" class="easyui-validatebox" id="className"   value=""> 
								<td>
								<td>学校名称:</td>
								<td>
									<input type="text" class="easyui-validatebox" id="schoolName"   value=""> 
								<td>
								<td>
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;&nbsp;
									
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
							<th data-options="field:'className'" width="220">班级名称</th>
							<th data-options="field:'unitName'" width="100">学校名称</th>
							<th data-options="field:'number'" width="150" >分配名额</th>
							<th data-options="field:'unassigned'" width="150" >未分配名额</th>
							<th data-options="field:'handler'" width="150" formatter="handlerstr">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
