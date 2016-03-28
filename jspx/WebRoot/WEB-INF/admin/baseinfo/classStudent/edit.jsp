<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
		 		var classId=$("#classId").val();
			  	var gridoption = {url:"../teacherInfo/list.do?classId="+classId+"&xdIds=${vo.xdIds}&xkIds=${vo.xkIds}",id:"grid",pagination:true};
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
					parameter["schoolId"]=node.id;
					$("#flag","#qform").val(flag);
					$("#typeId","#qform").val("");
					$("#categoryId","#qform").val("");
				}
				dataGrid.datagrid('load',parameter);
			}
			/**
			*选择班级学员
			*/
			function selectClassStudent(row){
				 var id=[];
				  id.push(getCheckeds1("grid","id"));
				  if(id==""){
					  parent.$.messager.alert("提示", "至少选择一条学员！", 'info');
					  return;
				  }
				 var classId=$("#classId").val();
				  var index=$("#index").val();
				$.ajax({
					url:"save.do",
					data:"studentId="+ id.join(",")+"&classId="+classId,
					success:function(data){
						var json=eval("("+data+")");
						if(json.message){
							parent.$("#main").tabs("getSelected").find("iframe")[0].contentWindow.$("#iframe_"+index)[0].contentWindow.$("#grid").datagrid('load');
							parent.$.messager.alert("提示窗口",json.message);
							parent.dialogMap["d6"].dialog('close');
						}else{
							parent.$.messager.alert("提示窗口",json.error);
						}
					}
				});
			}
		</script>
		
	</head>
<body>
	<input type="hidden" class="easyui-validatebox" id="classId"   value="${vo.classId }">
	<input type="hidden" class="easyui-validatebox" id="index"   value="${vo.index }">
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
											<input type="hidden" class="easyui-validatebox" id="flag" name="flag"  value="">
											<input type="hidden" class="easyui-validatebox" id="typeId" name="typeId"   value="">
											<input type="hidden" class="easyui-validatebox" id="categoryId" name="categoryId"  value="">
										</td>
										<td>
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a> &nbsp;&nbsp; 
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a> &nbsp;&nbsp;
											<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="selectClassStudent();">选择</a>
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
									<th data-options="field:'zkxkName'" width="100" >主科学科</th>
									<th data-options="field:'fkxkName'" width="100" >副科学科</th>
									<th data-options="field:'zkxdName'" width="100" >主科学段</th>
									<th data-options="field:'fkxdName'" width="100" >副科学段</th>
									<th data-options="field:'text'" width="150" >管理账号</th>
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
