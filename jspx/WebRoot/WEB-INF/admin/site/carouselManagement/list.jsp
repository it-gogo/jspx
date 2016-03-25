<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/site/carouselManagement.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
		 		var type=encodeURI("oa轮播");
			  	var gridoption = {url:"list.do?type="+type+"&noBranchId=1",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
/**
*点击树方法
*/
/* function  treeClick(node){
	var  parameter = {};
	var branchId=node.id;
	parameter["branchId"]=branchId;
	$("#branchId","#qform").val(branchId);
	dataGrid.datagrid('load',parameter);
} */

/**格式化图片**/
function handlerUrl(value,row,index){
	  var json = $.toJSON(row);
	  var handstr="";
	  if(row.picUrl!=null&&row.picUrl!=''&&row.picUrl!=undefined){
	  	var base="<%=request.getContextPath() %>/";
	  	base+=row.picUrl;
	  	handstr = "<a href=\""+base+"\" target=\"_back\"><img src=\""+base+"\" width=\"100\" height=\"25\"/></a>";   
	  }
       
     return  handstr;
}


		</script>
			
	</head>
	<body >
	   <div class="easyui-panel" style="padding:5px;"  data-options="fit:true,border:false">
	   	<div class="easyui-layout" data-options="fit:true,fitColumns:true" >
	     <div class="jb_bj" data-options="region:'north'" style="height:75px;/* background-color: #d2e0f2; */">
	       <fieldset style="margin-top: 10px;/* border: 1px solid #9c9c9c; */">
                    <legend>数据查询</legend>
	       <div style="width:100%;height:100%">
	          <form id="qform">
	          <table>
	          <tr>
	            <td>名称:</td>
	            <td>
	            	<input type="text" class="easyui-validatebox" id="name" name="name" value="">
	            	<input type="hidden" class="easyui-validatebox" id="branchId" name="branchId" value="">
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
								<th data-options="field:'id'" width="10"  checkbox=true></th>
								<th data-options="field:'name'" width="30">名称</th>
								<th data-options="field:'status'"  width="30">状态</th>
								<th data-options="field:'picUrl'" formatter="handlerUrl" width="50">图片地址</th>
								<th data-options="field:'handler'" width="70" formatter="handlerstatus" align="center">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
   		</div>
	</body>
</html>
