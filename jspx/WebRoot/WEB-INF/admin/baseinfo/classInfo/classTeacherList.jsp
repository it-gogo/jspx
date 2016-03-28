<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"../teacherInfo/list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	var treeoptions = {id:"treeID",url:"../unitInfo/school.do",onClick:treeClick};
		  		$.initTree(treeoptions);
		 	});
		 	/**
		 	*点击树节点操作
		 	*/
		 	function  treeClick(node){
		 		var  parameter = {};
				if(node!=null && typeof(node.type)=="undefined"){//点击学校类型跟类别
					var flag="";
					var pnode=$('#treeID').tree('getParent',node.target);//字典类型
					if(typeof(pnode.type)=="undefined"){//上一级不是单位，那就是点击学校类型
						var ppnode=$('#treeID').tree('getParent',pnode.target);//单位
						flag=ppnode.flag;
						
						var categoryId=pnode.id;
						parameter["categoryId"]=categoryId;
						$("#categoryId","#qform").val(categoryId);//类别ID
						
						var typeId=node.id;
						parameter["typeId"]=typeId;
						$("#typeId","#qform").val(typeId);//类别ID
					}else{//上一级是单位，那就是点击学校类别
						var categoryId=node.id;
						parameter["categoryId"]=categoryId;
						$("#categoryId","#qform").val(categoryId);//类别ID
						$("#typeId","#qform").val("");//类型ID
						flag=pnode.flag;
					}
					parameter["flag"]=flag;
					$("#flag","#qform").val(flag);
				}else{//查询单位
					var flag = node.flag;
					parameter["flag"]=flag;
					$("#flag","#qform").val(flag);
					$("#typeId","#qform").val("");
					$("#categoryId","#qform").val("");
				}
				dataGrid.datagrid('load',parameter);
			}
			/**
			 * 操作信息
			 * @param value
			 * @param row
			 * @param index
			 * @returns {String}
			 */
			function  handlerstr(value,row,index){
				  var json = $.toJSON(row);
			     var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='selectClassTeacher("+json+")';>选择</a> ";
			     return  handstr;
			}
			/**
			*选择班主任
			*/
			function selectClassTeacher(row){
			var showField="${vo.showField}";//显示字段
			if(typeof(showField)=="undefined" || showField==""){
				showField="name";
			}
			
			var saveField="${vo.saveField}";//保存字段
			if(typeof(saveField)=="undefined" || saveField==""){
				saveField="id";
			}
			
				var pf=parent.$("#uframe_d3")[0].contentWindow;
				pf.$("#${vo.name}","#dform").searchbox("setValue",row[showField]);
				pf.$("#${vo.id}","#dform").val(row[saveField]);
				parent.dialogMap["d4"].dialog('close');
			}
		</script>
		
	</head>
<body>
	<div class="easyui-layout" data-options="fit:'true'">
		<div data-options="region:'west',split:true,title:'单位树',collapsible:true" style="width:300px;">
			<%@include file="/WEB-INF/admin/common/tree.jsp"%>
		</div>
		<div data-options="region:'center'">
			<div class="easyui-panel" style="padding:5px;" data-options="fit:true,border:false">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north'" style="height:35px;">
						<div style="width:100%;height:100%">
							<form class="bjaa" id="qform">
								<table>
									<tr>
										<td>名称:</td>
										<td>
											<input type="text" class="easyui-validatebox" id="name"   value=""> 
											<input type="hidden" class="easyui-validatebox" id="flag" name="flag"  value=""></td>
											<input type="hidden" class="easyui-validatebox" id="typeId" name="typeId"   value=""></td>
											<input type="hidden" class="easyui-validatebox" id="categoryId" name="categoryId"  value=""></td>
										<td>
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;&nbsp; 
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
									<th data-options="field:'name'" width="100">姓名</th>
									<th data-options="field:'schoolName'" width="150">附属学校</th>
									<th data-options="field:'telephone'" width="100" >电话</th>
									<th data-options="field:'text'" width="150" >管理账号</th>
									<th data-options="field:'handler'" width="100" formatter="handlerstr">操作</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
