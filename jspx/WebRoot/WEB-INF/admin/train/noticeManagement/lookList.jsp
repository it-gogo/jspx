<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/train/noticeManagement.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
		 		var isInStation=encodeURI("站内通知");//站外
			  	var gridoption = {url:"lookList.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});

/**
 * 操作信息
 * @param value
 * @param row
 * @param index
 * @returns {String}
 */
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr ="<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-search'  plain='true'  onclick='look("+json+")';>查看</a>";
     return  handstr;
}
/**
 * 查看
 * @param row
 */
function  look(row){
	var parameter = {id:"d3",title:row.isInStation,width:"100%",height:"100%"};
	var urls = "../train/noticeManagement/look.do?id="+row.id;
	parameter.urls = urls;
	parent.$.createDialog(parameter);
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
	            <td>标题:</td>
	            <td>
	            	<input type="text" class="easyui-validatebox" id="title" name="title" value="">
	            	<input type="hidden" class="easyui-validatebox" id="code" name="code" value="">
	            	<input type="hidden" class="easyui-validatebox" id="teacherId" name="teacherId" value="">
	            </td>
	            <td>
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查  询</a>&nbsp;&nbsp;
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全  部</a>&nbsp;&nbsp;
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
								<th data-options="field:'isInStation'" width="20">通知类型</th>
								<th data-options="field:'creatorName'" width="20">创建账号</th>
								<th data-options="field:'createdate'" width="20">创建时间</th>
								<th data-options="field:'isRead'" width="20">是否阅读</th>
								<th data-options="field:'readDate'" width="20">阅读时间</th>
								<th data-options="field:'handler'" width="30" formatter="handlerstr" align="center">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
   		</div>
	</body>
</html>
