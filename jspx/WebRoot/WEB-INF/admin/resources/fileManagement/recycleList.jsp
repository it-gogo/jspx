<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/fileManagement.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"recycleList.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});

		</script>
		
	</head>
	<body >
		<%-- <input type="hidden" id="topFileId" value="${vo.topFileId }"/><!-- 顶级文件id -->
		<input type="hidden" id="parentId" value="${vo.parentId }"/><!-- 当前文件id -->
		<input type="hidden" id="folderId" value="${folderId.parentId }"/><!-- 当前文件父Id --> --%>
		   <div class="easyui-panel" style="padding:5px;"  data-options="fit:true,border:false">
		   	<div class="easyui-layout" data-options="fit:true" >
		    <div class="jb_bj" data-options="region:'north'" style="height:90px;/* background-color: #d2e0f2; */">
		     <fieldset style="margin-top: 10px;/* border: 1px solid #9c9c9c; */">
	           <legend>数据操作</legend>
		       <div style="width:100%;height:100%">
		          <form id="qform">
		          <table>
		          <tr>
		            <td>
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',size:'large'" plain="true" onclick="remove_();">删 除</a>&nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-redo',size:'large'" plain="true" onclick="reduction();">还原</a>&nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-l-delete',size:'large'" plain="true" onclick="removeAll()">清空</a>&nbsp;&nbsp;
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
									<th data-options="field:'name'" width="80">名称</th>
									<th data-options="field:'type'" width="80">类型</th>
									<th data-options="field:'location'" width="80" formatter="showLocation">原位置</th>
									<th data-options="field:'modifydate'" width="30">删除时间</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
	   		</div>
	</body>
</html>
