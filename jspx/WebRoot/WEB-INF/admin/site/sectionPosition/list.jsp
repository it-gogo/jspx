<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/site/sectionPosition.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
		 		var type=encodeURI("前台网站");
			  	var gridoption = {url:"list.do?type="+type,id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
	
/**
 * 操作信息
 * @param value
 * @param row
 * @param index
 * @returns {String}
 */
function  showname(value,row,index){
	if( value==null || value=="undefined" || value==""){
		return row.positionName;
	}else{
		return value;
	}
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
	            <td>
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新  增</a>&nbsp;&nbsp;
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
								<th data-options="field:'name'" width="80" formatter="showname">名称</th>
								<th data-options="field:'handler'" width="70" formatter="handlerstr" align="center">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
   		</div>
	</body>
</html>
