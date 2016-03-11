<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/supervise/superviseLook.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/ajaxfileupload.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	
			  	var treeoptions = {id:"treeID",url:"../inspectorApproval/school.do",onClick:treeClick};
		  		$.initTree(treeoptions);
		 	});
	

function  handlerstatus(value,row,index){
	  var json = $.toJSON(row);
   var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='loadF("+json+")';>查 看</a>";
   return  handstr;
}

/**
 	*点击树节点操作
 	*/
 	function  treeClick(node){
 		var  parameter = {};
		if(node!=null && typeof(node.type)=="undefined"){//点击学校类型跟类别
			var flag="";
			var pnode=$('#treeID').tree('getParent',node.target);//字典类型
			if(typeof(pnode.type)=="undefined"){//上一级不是单位，那就是点击学校类型
				var ppnode=$('#treeID').tree('getParent',pnode.target);//单位
				flag=ppnode.flag;
				
				var categoryId=pnode.id;
				parameter["categoryId"]=categoryId;
				$("#categoryId","#qform").val(categoryId);//类别ID
				
				var typeId=node.id;
				parameter["typeId"]=typeId;
				$("#typeId","#qform").val(typeId);//类别ID
			}else{//上一级是单位，那就是点击学校类别
				var categoryId=node.id;
				parameter["categoryId"]=categoryId;
				$("#categoryId","#qform").val(categoryId);//类别ID
				$("#typeId","#qform").val("");//类型ID
				flag=pnode.flag;
			}
			parameter["flag"]=flag;
			$("#flag","#qform").val(flag);
		}else{//查询单位
			var flag = node.flag;
			parameter["flag"]=flag;
			$("#flag","#qform").val(flag);
			$("#typeId","#qform").val("");
			$("#categoryId","#qform").val("");
		}
		dataGrid.datagrid('load',parameter);
	}
		</script>
		
	</head>
	<body >
		<div class="easyui-layout" data-options="fit:'true'">
		<div data-options="region:'west',split:true,title:'单位树',collapsible:true" style="width:300px;">
			<%@include file="/WEB-INF/admin/common/tree.jsp"%>
		</div>
		<div data-options="region:'center'">
		   <div class="easyui-panel" style="padding:5px;"  data-options="fit:true,border:false">
		   	<div class="easyui-layout" data-options="fit:true" >
		     <div data-options="region:'north'" style="height:35px;">
		       <div style="width:100%;height:100%">
		          <form id="qform">
		          <span  id="upload_google" >
		          	<input type="file" id="fileId1" style="display:none;" name="fileId" onchange="ajaxFileUpload('fileId1');" />
		          </span>
		          <span   id="upload_ie" style="display: none;">
		              <input style="position:absolute;left:0;top:0;width:100%;height:100%;z-index:999;filter:Alpha(opacity=0);" onchange="ajaxFileUpload()" type="file" id="fileId"  name="fileId"/>
	              </span>
		          <table>
		          <tr>
		            <td>时间选择:</td>
		            <td>
		            	<input type="text" class="easyui-datebox" id="beginDate" data-options="editable:false" >——
		            	<input type="text" class="easyui-datebox" id="endDate" data-options="editable:false" >
		            </td>
		            <td>
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查  询</a>
		              &nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全  部</a>
		              &nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新  增</a>
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
            	<th data-options="field:'id'" width="10" checkbox=true ></th>
                <th data-options="field:'name'" width="40">督导项目名称</th>
                <th data-options="field:'superviseDate'" width="30">时间</th>
                <th data-options="field:'type'" width="20" >类型</th>
                <th data-options="field:'flowStatus'" width="30" >状态</th>
                <th data-options="field:'schoolName'" width="50" >学校</th>
                <th data-options="field:'handler'" width="30" formatter="handlerstatus" align="center">操作</th>
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
