<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/train/noticeInfo.js"></script>
<script type="text/javascript">
var dataGrid;
$(document).ready(function(){
  	var gridoption = {url:"list.do",id:"grid",pagination:true};
  	dataGrid = $.initBasicGrid(gridoption); 
});
/**
*操作
*/
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='loadF("+json+")';>修 改</a> "+
     						"<a class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-cancel' plain='true' onclick='deleteF("+json+")';>删 除</a> "+
     						"<a class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-search' plain='true' onclick='lookF("+json+")';>查 看</a> ";
     return  handstr;
}
/**
*显示类型
*/
function showType(value,row,index){
	if(value==1){
		return "全网通知";
	}else if(value==2){
		return "班级通知";
	}
}
/**
*查看通知公告
*/
function lookF(row){
	var options = {id:"d3",urls:"../train/noticeInfo/look.do?id="+row.id,title:"查看通知"};
	parent.$.createDialog(options);
}
</script>
		
	</head>
<body>
	<div class="easyui-panel" style="padding:5px;" data-options="fit:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north'" style="height:35px;">
				<div style="width:100%;height:100%">
					<form id="qform">
						<table>
							<tr>
								<td>标题:</td>
								<td>
									<input type="text" class="easyui-validatebox" id="title"   value=""> 
								<td>
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新 增</a> &nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="deleteAllF();">删 除</a> &nbsp;&nbsp; 
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
							<th data-options="field:'id',checkbox:true"  ></th>
							<th data-options="field:'title'" width="220">标题</th>
							<th data-options="field:'type'" formatter="showType" width="100">类型</th>
							<th data-options="field:'createName'" width="100">创建人</th>
							<th data-options="field:'createdate'" width="150" >创建时间</th>
							<th data-options="field:'handler'" width="150" formatter="handlerstr">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
