<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/site/articleManagement.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
		 		var type=encodeURI("oa栏目");
			  	var gridoption = {url:"list.do?sectionType="+type+"&sectionId=${vo.sectionId}",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	
			  	var treeoptions = {id:"treeID",url:"../sectionManagement/tree.do?type="+type+"&parentId=${vo.parentSectionId}",onClick:treeClick};
 				$.initTree(treeoptions);
		 	});
/**
*点击树方法
*/
function  treeClick(node){
	var  parameter = {};
	var code=node.code;
	parameter["code"]=code;
	$("#code","#qform").val(code);
	dataGrid.datagrid('load',parameter);
}

/**
 * 操作信息
 * @param value
 * @param row
 * @param index
 * @returns {String}
 */
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-search'  plain='true'  onclick='look("+json+")';>查看</a> ";
     return  handstr;
}
//查看文章
function look(row){
	var options = {id:"d3",urls:"../site/articleManagement/look.do?id="+row.id,title:"查看"+row.title};
	parent.$.createDialog(options);
}
		</script>
			
	</head>
	<body >
		<div class="easyui-layout" data-options="fit:'true'">
			<div data-options="region:'west',split:true,title:'栏目树',collapsible:true" style="width:200px;">
				<%@include file="/WEB-INF/admin/common/tree.jsp"%>
			</div>
			<div data-options="region:'center'">
	   <div class="easyui-panel" style="padding:5px;"  data-options="fit:true,border:false">
	   	<div class="easyui-layout" data-options="fit:true" >
	     <div class="jb_bj" data-options="region:'north'" style="height:75px;/* background-color: #d2e0f2; */">
	     <fieldset style="margin-top: 10px;/* border: 1px solid #9c9c9c; */">
                    <legend>数据查询</legend>
	       <div style="width:100%;height:100%">
	          <form id="qform">
	          <table>
	          <tr>
	            <td>标题:</td>
	            <td>
	            	<input type="text" class="easyui-validatebox" id="title" name="title" value="">
	            	<input type="hidden" class="easyui-validatebox" id="code" name="code" value="">
	            </td>
	            <td>
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查  询</a>&nbsp;&nbsp;
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全  部</a>&nbsp;&nbsp;
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新  增</a>&nbsp;&nbsp;
	              <!-- <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="deleteAllF();">删 除</a> -->
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
								<th data-options="field:'sectionName'" width="20">栏目</th>
								<th data-options="field:'title'" width="100">标题</th>
								<th data-options="field:'handler'" width="70" formatter="handlerstr" align="center">操作</th>
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
