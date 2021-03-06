<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/supervise/project.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
		 		showunBinding();//显示未绑定
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	var treeoptions = {id:"treeID",url:"tree.do",onClick:treeClick};
		  		$.initTree(treeoptions);
		 	});
		 	function  treeClick(node){
				var code = node.code;
				var  parameter = {};
				parameter["code"]=code;
				$("#code","#qform").val(code);
				dataGrid.datagrid('load',parameter);
			}
/**
*显示未绑定
*/
function showunBinding(){
	$.ajax({
  			url:"findUnbinding.do",
  			success:function(data){
  				var index_binding=0;
  				var json=eval("("+data+")");
  				var html="<table style=\"\">";
  				for(var i=0,j=json.length;i<j;i++){
  					var obj=json[i];
  					html+="<tr><td>"+obj.name+"</td>"+
  					"<td><a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='binding(\""+obj.id+"\");';>绑 定</a>"+
  					"<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-cancel' plain='true' onclick='readF(\""+obj.id+"\")';>已 读</a></td></tr>";
  				}
  				html+="</table>"
  				$("#binding").tooltip({
					position : "bottom",
					content : html,
					onShow : function() {
						if(index_binding==0){
                  				index_binding=1;
								$(".grid_button").linkbutton();  
                  			}
						var t = $(this);
                 			t.tooltip("tip").unbind().bind("mouseenter", function(){
                     			t.tooltip("show");
                 			}).bind("mouseleave", function(){
                     			t.tooltip("hide");
                 			});
					}
				});
  			}
  		});
}
/**
 * 绑定数据
 * @param row
 */
function  binding(id){
	var urls = "../supervise/project/binding.do?id="+id;
	options.urls = urls;
	parent.$.createDialog(options);
	parent.$.createDialog.open_grid = dataGrid;
}

function  readF(id){
	parent.$.messager.confirm("询问", "您确定对该项目设置已读？", function(b) {
		if (b) {
				parent.$.messager.progress({
					title : "提示",
					text : "数据处理中，请稍后...."
				});
				$.post("readF.do",{id:id}, function(result) {
					if (result.message) {
						parent.$.messager.alert("提示", result.message, "info");
						$("#binding").tooltip("hide");
						index_binding=0;
						showunBinding();
					}else if(result.other){
						//做其他回调函数
					}
					parent.$.messager.progress("close");
				}, "JSON");
			}
		
	});
}

function  handlerstatus(value,row,index){
	  var json = $.toJSON(row);
   var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='loadF("+json+")';>修 改</a> ";
   if(row.status=="启用"){
  	   handstr += "<a  class=\"grid_button\" href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-clear'  plain='true' onclick='changestatus("+json+");'>禁 用</a>&nbsp;&nbsp;";
    }else{
  	   handstr += "<a  class=\"grid_button\" href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-ok' plain='true' onclick='changestatus("+json+");'>启 用</a>&nbsp;&nbsp;";
    }
   return  handstr;
}
		</script>
		
	</head>
<body>
	<div class="easyui-layout" data-options="fit:'true'">
		<div data-options="region:'west',split:true,title:'菜单树',collapsible:true" style="width:200px;">
			<%@include file="/WEB-INF/admin/common/tree.jsp"%>
		</div>
		<div data-options="region:'center'">
			<div class="easyui-panel" style="padding:5px;"
				data-options="fit:true,border:false">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north'" style="height:35px;">
						<div style="width:100%;height:100%">
							<form id="qform">
								<table>
									<tr>
										<td>名称:</td>
										<td>
											<input type="text" class="easyui-validatebox" id="name"   value=""> 
											<input type="hidden" class="easyui-validatebox" id="code"   value=""></td>
										<td>
											<a  href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
											<a  href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;&nbsp; 
											<a  href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新 增</a> &nbsp;&nbsp; 
											<!-- <a  href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="deleteAllF();">删 除</a>&nbsp;&nbsp;  -->
											<a id="binding" href="#" class="easyui-linkbutton easyui-tooltip"  data-options="iconCls:'icon-search'" onclick="deleteAllF();">绑 定</a>
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
									<th data-options="field:'parentName'" width="40">父名称</th>
									<th data-options="field:'name'" width="40">名称</th>
									<th data-options="field:'seq'" width="10">排序</th>
									<th data-options="field:'handler'" width="80" formatter="handlerstatus">操作</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
</body>
</html>
