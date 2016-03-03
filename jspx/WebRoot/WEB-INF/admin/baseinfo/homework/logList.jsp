<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/homework.js"></script>
		<script type="text/javascript">
				var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"log_list.do?homeworkId=${vo.id}",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
		 	
/**
*操作
*/
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-filter' plain='true' onclick='downhomework("+json+")';>下载</a>&nbsp;|&nbsp;"
     				+"<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-save' plain='true' onclick='assess("+json+")';>评分</a>";
     return  handstr;
}

/**下载学生上传作业数据**/
function downhomework(row){
	var href_='../homework/download.do?id='+row.id;
	window.open(href_);
}
/**作业评分**/
function assess(row){
	$.messager.prompt('作业评分', '请对当前作业进行分数录入', function(score){
                if (score){
                   // alert(r);
                   $.ajax({
                   	url:'../homework/assess.do',
                   	type:'post',
                   	data:{id:row.id,score:score},
                   	success:function(rs){
                   		var json=eval("("+rs+")");
                   		if(json.message){
                   			parent.$.messager.alert("提示窗口",json.message,'info');
                   			
                   		}else{
                   			parent.$.messager.alert("错误提示",json.error,'waring');
                   		}
                   		$("#grid").datagrid('reload');
                   	}
                   });
                }
            });
}

/**作业批量下载**/
function downloadZip(){
	var homeworkId="${vo.id}";
	//alert("${vo.id}");
	var href_="../homework/downLoadZip.do?homeworkId="+homeworkId;
	window.open(href_);
}

</script>
		
	</head>
<body>
	<div class="easyui-panel" style="padding:5px;" data-options="fit:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north'" style="height:35px;">
				<div style="width:100%;height:100%">
					<form id="qform">
						<table>
							<tr>
								<!-- <td>学生名称:</td>
								<td>
									<input type="text" class="easyui-validatebox" id=""   value=""> 
								</td>
								
								<td>
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;&nbsp; 
								</td> -->
								<td>
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="downloadZip();">批量下载</a> &nbsp;&nbsp; 
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
							<th data-options="field:'id',checkbox:true"></th>
							<th data-options="field:'homework',align:'center'" width="120">作业名称</th>
							<th data-options="field:'student',align:'center'" width="100">上传者</th>
							<th data-options="field:'uploadTime',align:'center'" width="80" >上传时间</th>
							<th data-options="field:'score',align:'center'" width="80" >作业评分</th>
							<th data-options="field:'assessTime',align:'center'" width="80" >评分时间</th>
							<th data-options="field:'handler',align:'center'" width="150" formatter="handlerstr">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
