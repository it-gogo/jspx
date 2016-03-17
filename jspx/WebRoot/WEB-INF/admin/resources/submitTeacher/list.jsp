<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"list.do?submitId=${vo.submitId}",id:"grid",pagination:false};
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
     var  handstr = " ";
     if(row.isSubmit=="未提交"){
    	 handstr="<a>未上传文件</a>";
     }else{
    	 handstr="<a class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-filter'  plain='true'   onclick='download1("+json+")';>下载</a>";
     }
     return  handstr;
}
//下载文件
function download1(row){
	window.open("../submitTeacher/download.do?submitId="+row.id+"&url="+row.submitUrl+"&loginId="+row.loginId);
}
function downloadAll(submitId){
	window.open("../submitTeacher/downloadAll.do?submitId="+submitId);
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
	            <td>老师:</td>
	            <td>
	            	<input type="text" class="easyui-validatebox" id="teacherName" name="teacherName" value="">
	            </td>
	            <td>
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查  询</a>&nbsp;&nbsp;
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全  部</a>&nbsp;&nbsp;
	              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="downloadAll('${vo.submitId}');">一键下载</a>&nbsp;&nbsp;
	              <!-- <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="deleteAllF();">删 除</a> -->
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
								<th data-options="field:'teacherName'" width="10">老师</th>
								<th data-options="field:'isSubmit'" width="10">状态</th>
								<th data-options="field:'endDate'" width="20">结束时间</th>
								<th data-options="field:'creatorName'" width="20">发起人账号</th>
								<th data-options="field:'handler'" width="40" formatter="handlerstr" align="center">操作</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
   		</div>
	</body>
</html>
