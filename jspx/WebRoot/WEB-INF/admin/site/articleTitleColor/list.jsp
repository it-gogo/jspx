<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/site/articleTitleColor.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});

//显示颜色
function showColor(value,row,index){
	return "<div style=\"width:20px;height:20px;background:"+value+"\"></div>";
}
		</script>
	
	</head>
	<body >
	   <div class="easyui-panel" style="padding:5px;"  data-options="fit:true,border:false">
	   	<div class="easyui-layout" data-options="fit:true" >
	     <div class="jb_bj" data-options="region:'north'" style="height:75px;/* background-color: #d2e0f2; */">
	     <fieldset style="margin-top: 10px;/* border: 1px solid #9c9c9c; */">
                    <legend>数据查询</legend>
	       <div style="width:100%;height:100%">
	          <form id="qform">
	          <table>
	          <tr>
	            <td>名称:</td>
	            <td>
	            	<input type="name" class="easyui-validatebox" id="title" name="name" value="">
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
								<th data-options="field:'name'" width="80">名称</th>
								<th data-options="field:'color'" width="80" formatter="showColor" >颜色</th>
								<th data-options="field:'handler'" width="70" formatter="handlerstr" align="center">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
   		</div>
	</body>
</html>
