<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/platform/userInfo.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
		</script>
		
	</head>
	<body >
		   <div class="easyui-panel" style="padding:5px;"  data-options="fit:true,border:false">
		   	<div class="easyui-layout" data-options="fit:true" >
		     <div data-options="region:'north'" style="height:35px;">
		       <div style="width:100%;height:100%">
		          <form class="bjaa" id="qform">
		          <table>
		          <tr>
		            <td>账号:</td>
		            <td>
		            	<input type="text" class="easyui-validatebox" id="text" name="text" value="">
		            </td>
		            <td>
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查  询</a>
		              &nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全  部</a>
		              &nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新  增</a>
		               &nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="deleteAllF();">删 除</a>
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
                <th data-options="field:'text'" width="80">账号</th>
                <!-- <th data-options="field:'unitName'" width="80">单位</th>
                <th data-options="field:'schoolName'" width="100">学校</th> -->
                <th data-options="field:'isActives'" width="50" formatter="handlerisactives">状态</th>
                <th data-options="field:'handler'" width="70" formatter="handlerstr" align="center">操作</th>
            </tr>
        </thead>
    </table>
    </div>
    </div>
    </div>
	</body>
</html>
