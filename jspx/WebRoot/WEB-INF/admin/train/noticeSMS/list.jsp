<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/train/noticeSMS.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
		 		var isInStation=encodeURI("站内短信");//站内
			  	var gridoption = {url:"list.do?isInstation="+isInStation,id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	
			  	var treeoptions = {id:"treeID",url:"tree.do",onClick:treeClick};
 				$.initTree(treeoptions);
		 	});
/**
*点击树方法
*/
function  treeClick(node){
	var  parameter = {};
	if(node.isTeacher==1){//是老师
		var teacherId=node.id;
		parameter["teacherId"]=teacherId;
		$("#teacherId","#qform").val(teacherId);
		$("#code","#qform").val("");
	}else{
		var code=node.code;
		parameter["code"]=code;
		$("#code","#qform").val(code);
		$("#teacherId","#qform").val("");
	}
	dataGrid.datagrid('load',parameter);
}
		</script>

	<link rel="stylesheet" href="<%=request.getContextPath()%>/admin/new-css/liebiao.css" type="text/css"></link>	
	
	</head>
	<body >
		<div class="easyui-layout" data-options="fit:'true'">
			<div data-options="region:'west',split:true,title:'人员树',collapsible:true" style="width:300px;">
				<%@include file="/WEB-INF/admin/common/tree.jsp"%>
			</div>
			<div data-options="region:'center'">
	   <div class="easyui-panel" style="padding:5px;"  data-options="fit:true,border:false">
	   	<div class="easyui-layout" data-options="fit:true" >
	     <div class="jb_bj" data-options="region:'north'" style="height:75px;/* background-color: #d2e0f2; */">
	     <fieldset class="gd_sise">
                    <legend>数据查询</legend>
	       <div style="width:100%;height:100%">
	          <form id="qform">
	          <table>
	          <tr>
	            <td style="font-size: 14px;">标题:</td>
	            <td>
	            	<input type="text" class="easyui-validatebox" id="title" name="title" value="" style="border-radius: 3px;border-bottom: none;">
	            	<input type="hidden" class="easyui-validatebox" id="code" name="code" value="">
	            	<input type="hidden" class="easyui-validatebox" id="teacherId" name="teacherId" value="">
	            </td>
	            <td>
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查  询</a>&nbsp;&nbsp;
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全  部</a>&nbsp;&nbsp;
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新  增</a>&nbsp;&nbsp;
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="deleteAllF();">删 除</a>
	            </td>
	          </tr>
	          </table>
	          </form>
	       </div>
	       </fieldset>
	     </div>
				<div data-options="region:'center'">
					<table id="grid">
						<thead>
							<tr>
								<th data-options="field:'id'" width="10" checkbox=true></th>
								<th data-options="field:'title'" width="80">标题</th>
								<th data-options="field:'creatorName'" width="20">创建账号</th>
								<th data-options="field:'createdate'" width="20">创建时间</th>
								<th data-options="field:'handler'" width="30" formatter="handlerstr" align="center">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
   		</div>
   		</div>
   	</div>
	</body>
</html>
