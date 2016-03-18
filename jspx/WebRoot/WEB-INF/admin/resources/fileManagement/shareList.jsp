<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/fileManagement.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
		 		//var  parameter = {};
				//parameter["parentId"]="${vo.parentId}";
			  	var gridoption = {url:"shareList.do",id:"grid",pagination:true/* ,queryParams:parameter */};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	
			  	
				//$("#grid").datagrid('load',parameter);
		 	});

//后退
function retreat(){
	var folderId=$("#folderId").val();
	if(folderId=="undefined" || folderId==""){//跳转文档管理
		var parentTitle="${vo.parentTitle }";
		var tab = parent.$("#main").tabs("getSelected");  // 获取选择的面板
		var url="../resources/fileManagement/redirect.do";
		parent.$("#main").tabs("update", {
			tab: tab,
			options: {
				title: parentTitle,
				content:"<iframe  scrolling=\"auto\" frameborder=\"0\"   src=\""+url+"\" style=\"width:100%;height:100%;\" ></iframe>"
			}
		});
	}else{
		$.ajax({
			url:"loadByAjax.do",
			data:"id="+folderId,
			success:function(data){
				var json=eval("("+data+")");
				$("#parentId").val(json.id);
				$("#parentName").val(json.name);
				$("#folderId").val(json.parentId);
				var  parameter = {};
				parameter["parentId"]=folderId;
				$("#grid").datagrid('load',parameter);
			}
		});
	}
}
function seq(type){
	var options = {id:"d3",title:type+"排序",width:"600px;",height:"500px;",buttons:dbuttons};
	var topFileId=$("#topFileId").val();
	var parentId=$("#parentId").val();
	var urls = "../resources/fileManagement/seq.do?parentId="+parentId+"&type="+type;
	options.urls = urls;
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
		</script>
		
	</head>
	<body >
		<input type="hidden" id="topFileId" value="${vo.topFileId }"/><!-- 顶级文件id -->
		<input type="hidden" id="parentId" value="${vo.parentId }"/><!-- 当前文件id -->
		<input type="hidden" id="parentName" value="${pvo.name }"/><!-- 当前文件名称 -->
		<input type="hidden" id="folderId" value="${folderId.parentId }"/><!-- 当前文件父Id -->
		   <div class="easyui-panel" style="padding:5px;"  data-options="fit:true,border:false">
		   	<div class="easyui-layout" data-options="fit:true" >
		    <div class="jb_bj" data-options="region:'north'" style="height:120px;/* background-color: #d2e0f2; */">
		     <fieldset style="margin-top: 10px;/* border: 1px solid #9c9c9c; */">
	           <legend>数据操作</legend>
		       <div style="width:100%;height:100%">
		          <form id="qform">
		          <table>
		          <tr>
		            <td>
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-l-back',size:'large'" plain='true' onclick="retreat();">后 退</a>&nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-l-delete',size:'large'" plain="true" onclick="deleteAllF();">删 除</a>&nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-l-up-file',size:'large'" plain="true" onclick="uploadF();">上 传</a>&nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-l-new-file',size:'large'" plain="true" onclick="addF();">新建文件夹</a>&nbsp;&nbsp;
		            </td>
		          </tr>
		          </table>
		          </form>
		       </div>
		       </fieldset>
		       <div style="height: 30px;line-height: 30px;background-color: #EBDFDF;text-indent: 20px;">
		          当前位置：<span class="dqwz">${pvo.name }</span>
		       </div>
		     </div>
		     
			<div data-options="region:'center'">
				<table id="grid">
					<thead>
						<tr>
							<th data-options="field:'id'" width="10" checkbox=true></th>
							<th data-options="field:'name'" width="80" formatter="showName">名称</th>
							<th data-options="field:'fileSize'" width="30">大小</th>
							<th data-options="field:'suffix'" width="30">文件类型</th>
							<th data-options="field:'modifydate'" width="30">修改时间</th>
							<th data-options="field:'modifyName'" width="30">修改人</th>
							<th data-options="field:'creatorName'" width="30">上传人</th>
							<!-- <th data-options="field:'handler'" width="50" formatter="handlerstr" align="center">操作</th> -->
						</tr>
					</thead>
				</table>
			</div>
			</div>
  		</div>
	</body>
</html>
