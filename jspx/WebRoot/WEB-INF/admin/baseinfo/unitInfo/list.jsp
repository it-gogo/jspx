<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/unitInfo.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/ajaxfileupload.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	var treeoptions = {id:"treeID",url:"tree.do",onClick:treeClick};
		  		$.initTree(treeoptions);
		 	});
		 	
		 	function  treeClick(node){
		 		var  parameter = {};
				if(node!=null && typeof(node.isEdb)=="undefined"){//添加学校
					if($('#treeID').tree('isLeaf',node.target)){//最后节点
						var pnode=$('#treeID').tree('getParent',node.target);
						var ppnode=$('#treeID').tree('getParent',pnode.target);
						var typeId=node.id;
						var categoryId=pnode.id;
						var pid=ppnode.id;
						parameter["pid"]=pid;
						$("#pid","#qform").val(pid);//上级ID
						
						parameter["typeId"]=typeId;
						$("#typeId","#qform").val(typeId);//类型ID
						
						parameter["categoryId"]=categoryId;
						$("#categoryId","#qform").val(categoryId);//类别ID
					}else{//类别
						var pnode=$('#treeID').tree('getParent',node.target);
						var pid=pnode.id;
						parameter["categoryId"]=categoryId;
						var categoryId=node.id;
						
						parameter["pid"]=pid;
						$("#pid","#qform").val(pid);//类别ID
						
						parameter["categoryId"]=categoryId;
						$("#categoryId","#qform").val(categoryId);//类别ID
						
					}
					parameter["type"]="2";
					$("#type","#qform").val("2");
					$("#flag","#qform").val("");
				}else{//查询单位
					var flag = node.flag;
					parameter["flag"]=flag;
					$("#flag","#qform").val(flag);
					
					$("#type","#qform").val("1");
					$("#pid","#qform").val("");
					$("#typeId","#qform").val("");
					$("#categoryId","#qform").val("");
				}
				dataGrid.datagrid('load',parameter);
			}
			
			/**
		 	*导出模板
		 	*/
		 	function downloadTemp(){
		 		location.href="../../common/downloadTemp.do?tempName=schoolInfo.xls"
		 	}
		 	/**
		 	*异步上传文件
		 	*/
		 	function ajaxFileUpload(){
				$.ajaxFileUpload({  
			        url:"importInfo.do",  
			        secureuri:false,  
			        fileElementId:"fileId",  
			        dataType: "text",
			        success: function (data) { 
			        	var json=eval("("+data+")");
			        	if(json.message){
				        	parent.$.messager.alert("提示窗口",json.message);
			        	}else{
			        		parent.$.messager.alert("提示窗口",json.error);
			        	}
			        	$("#grid").datagrid("reload");
			        }, error: function (data) {  
			            alert(data);  
			        }  
			    });
				return false;  
			}
			/**
		 	*导入信息
		 	*/
		 	function importInfo(){
		 		$("#fileId").click();
		 	}
		 	
		 	/**
		 	* 批量生成密码
		 	*/
			function batchPassword(){
				var type=$("#type","#qform").val();
				if(type==1){
					parent.$.messager.alert("提示", "只能对学校信息进行批量生成密码！", "info");
					return ;
				}
			  	parent.$.messager.confirm("询问", "您是否确定批量生成密码，确定后密码将重置？", function(b) {
					if (b) {
						$("#qform").attr("action","batchPassword.do");
						$("#qform").submit();
						/* var  parameter = $.getQueryParameter("qform");
						alert($.toJSON(parameter))
						return;
						//window.open("../baseinfo/unitInfo/batchPassword.do",parameter)
						//location.href="batchPassword.do?tempName=schoolInfo.xls"
						 $.post("batchPassword.do",parameter, function(data) {
							/* if (result.message) {
								parent.$.messager.alert('提示', result.message, 'info');
								dataGrid.datagrid('reload');
							}else if(result.other){
								//做其他回调函数
							}  
					}, 'JSON'); */
					}
				});
			}
		</script>
		
	</head>
<body>
	<div class="easyui-layout" data-options="fit:'true'">
		<div data-options="region:'west',split:true,title:'单位树',collapsible:true" style="width:200px;">
			<%@include file="/WEB-INF/admin/common/tree.jsp"%>
		</div>
		<div data-options="region:'center'">
			<div class="easyui-panel" style="padding:5px;" data-options="fit:true,border:false">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north'" style="height:35px;">
						<div style="width:100%;height:100%">
							<form id="qform">
								<input type="file" id="fileId" style="display:none;" name="fileId" onchange="ajaxFileUpload();" />
								<table>
									<tr>
										<td>名称:</td>
										<td>
											<input type="text" class="easyui-validatebox" id="name" name="name"  value=""> 
											<input type="hidden" class="easyui-validatebox" id="flag" name="flag"  value=""></td>
											<input type="hidden" class="easyui-validatebox" id="type" name="type"  value="1"></td>
											<input type="hidden" class="easyui-validatebox" id="pid" name="pid"  value=""></td>
											<input type="hidden" class="easyui-validatebox" id="typeId" name="typeId"   value=""></td>
											<input type="hidden" class="easyui-validatebox" id="categoryId" name="categoryId"  value=""></td>
										<td>
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新 增</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="deleteAllF();">删 除</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="batchPassword();">批量生成密码</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="importInfo();">导入学校信息</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="downloadTemp();">下载学校信息模板</a>
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
									<th data-options="field:'name'" width="220">名称</th>
									<th data-options="field:'pname'" width="100">上级名称</th>
									<th data-options="field:'code'" width="150" >编码</th>
									<th data-options="field:'text'" width="150" >管理账号</th>
									<th data-options="field:'handler'" width="150" formatter="handlerstr">操作</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
</body>
</html>
