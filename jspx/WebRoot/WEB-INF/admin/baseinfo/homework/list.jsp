<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/datagrid-detailview.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/homework.js"></script>
		<script type="text/javascript">
				var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"list.do",id:"grid",pagination:true, view: detailview,detailFormatter:function(index,row){return detailHtml(index,row);},onExpandRow: function(index,row){return openDetail(index,row);}};
			  	//var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
		 	 function detailHtml(index,row){
		 		var titles="作业提交列表";
		 		var res =  
			       " <div id=\"cc_"+index+"  style=\"padding:1px;\">"+
		           " <div id=\"subTabs_"+index+"\" style=\"width:10px;height:400px;padding:1px;\" >";
		              res += "<div title=\""+titles+"\"  style=\"padding:1px;\">"+
		                        "<iframe id=\"iframe_"+index+"\" scrollng=\"yes\" frameborder=\"0\"  src=\"\"  style=\"width:100%;height:100%;\"></iframe>"+
		                     "</div>";
		          res+=  "</div>" +
		          		 "</div>";
		          return  res;
		 	}
		 	
		 	function openDetail(index,row){
		 		$("#subTabs_"+index).tabs({
            		fit:true,
            		id:"s_"+index,
            		onSelect:function(title,tindex){
            			$("#iframe_"+index).attr("src","log_redirect.do?id="+row.id);
            			setTimeout(function(){
            				 $('#grid').datagrid('fixDetailRowHeight',index);
                        },0);
            		}
            	});
		 	} 
/**
*操作
*/
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='loadF("+json+")';>修 改</a> "+
     						"<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-cancel' plain='true' onclick='deleteF("+json+")';>删 除</a> ";
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
								<td>作业名称:</td>
								<td>
									<input type="text" class="easyui-validatebox" id="title"   value=""> 
								</td>
								
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
							<th data-options="field:'title'" width="120">作业名称</th>
							<th data-options="field:'classId'" width="120" >班级</th>
							<th data-options="field:'uploader'" width="100">上传者</th>
							<th data-options="field:'endUploadTime'" width="100">截止提交时间</th>
							<th data-options="field:'uploadTime'" width="80" >上传时间</th>
							<th data-options="field:'handler'" width="150" formatter="handlerstr">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
