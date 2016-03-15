<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/fileManagement.js"></script>
    <script type="text/javascript">
	var formobj;
	var cbutton = parent.$("#cbutton");
	var sbutton = parent.$("#sbutton");
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"saveShare.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $(sbutton).bind('click',function(){
			 $("#dform").submit();
		 });
		 //绑定关闭事件
		 $(cbutton).bind('click',function(){
			parent.dialogMap["d3"].dialog('close');
		 });
		 
		 $("input[name='status']").change(function(){//共享权限
		 	showXz();
		 });
		 $("input[name='type']").change(function(){//
		 	if(this.checked){
		 		$(this).parent().find(".btn").linkbutton("enable");
		 		$(this).parent().find(".easyui-combotree").combotree("enable");
		 	}else{
		 		$(this).parent().find(".btn").linkbutton("disable");
		 		$(this).parent().find(".easyui-combotree").combotree("disable");
		 	}
		 });
		 
		 $.ajax({
		 	url:"../../platform/role/roleTree.do",
		 	success:function(data){
		 		$("#read").combotree("loadData", eval("("+data+")"));
		 		$("#add").combotree("loadData", eval("("+data+")"));
				$("#addFolder").combotree("loadData", eval("("+data+")"));
		 		$("#modify").combotree("loadData", eval("("+data+")"));
		 		$("#delete").combotree("loadData", eval("("+data+")"));
		 	}
		 });
	});
	function showXz(){
		var value=$("input[name='status']:checked").val();
		if(value=="所有人可见"){
			$("#xzqx").show();
			$(".xz").hide();
		}else if(value=="指定角色可见"){
			$("#xzqx").show();
			$(".xz").show();
		}else if(value=="不共享"){
			$("#xzqx").hide();
		}
	}
	
	function inheritRole(fid,id){
		$("#"+id).combotree("setValues",$("#"+fid).combotree("getValues"));
		$("input[name='roles_"+id+"']").attr("disabled",false); 
	}
	</script>
	<style type="text/css">
	.qx{
		float: left;
		margin-right:15px; 
	}
	</style>
  </head>
  <body layout="easyui-layout" onload="showXz();">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
            <input name="topFileId"  type="hidden"  id="topFileId"    value="${vo.topFileId }">
            <input name="fileId"  type="hidden"  id="fileId"    value="${vo.fileId }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th width="90px;">共享权限</th>
					<td>
						<input name="status" checked="checked" type="radio" id="所有人可见" value="所有人可见" ><label for="所有人可见">所有人可见</label>
						<input name="status" <c:if test="${vo.status=='指定角色可见' }">checked="checked"</c:if> type="radio" id="指定角色可见" value="指定角色可见" ><label for="指定角色可见">指定角色可见</label>
						<input name="status" <c:if test="${vo.status=='不共享' }">checked="checked"</c:if> type="radio" id="不共享" value="不共享" ><label for="不共享">不共享</label>
					</td>
				</tr>
				<tr id="xzqx">
					<th>指定访问权限</th>
					<td>
						<div class="qx">
						
							<input name="type" type="checkbox"  <c:if test="${shareRoleMap['只读'].size()>0 }">checked="checked"</c:if> id="只读" value="只读" ><label for="只读">只读</label>
							<div class="xz" style="display: none;">
								<input class="easyui-combotree "  name="roles_read" id="read"   style="width:200px;height: 100px;"  value="${vo.roles_read }"  data-options="<c:if test="${shareRoleMap==null || shareRoleMap['只读'].size()==0 }">disabled:true,</c:if>
									method:'get',
				                    valueField:'id',
				                    textField:'name',
				                    editable:false,
				                    multiline:true,
				                    multiple:true,
				                    onlyLeafCheck:true 
				            		">
								<%-- <div style="margin: 5px;">
									<a  href="#" class="easyui-linkbutton btn" data-options="iconCls:'icon-add',<c:if test="${shareRoleMap==null || shareRoleMap['只读'].size()==0 }">disabled:true</c:if>" onclick="inheritRole('modify','delete');">添加角色</a>
								</div> --%>
							</div>
						</div>
						<div class="qx">
							<input name="type" type="checkbox" <c:if test="${shareRoleMap['可添加'].size()>0 }">checked="checked"</c:if> id="可添加" value="可添加" ><label for="可添加">可添加</label>
							<div class="xz" style="display: none;">
								<input class="easyui-combotree "  name="roles_add" id="add"  style="width:200px;height: 100px;"  value="${vo.roles_add }"  data-options="<c:if test="${shareRoleMap==null || shareRoleMap['可添加'].size()==0 }">disabled:true,</c:if>
									method:'get',
				                    valueField:'id',
				                    textField:'name',
				                    editable:false,
				                    multiline:true,
				                    multiple:true,
				                    onlyLeafCheck:true 
				            		">
								<div style="margin: 5px;">
									<a  href="#" class="easyui-linkbutton btn" data-options="iconCls:'icon-add',<c:if test="${shareRoleMap==null || shareRoleMap['可添加'].size()==0 }">disabled:true</c:if>" onclick="inheritRole('read','add');">继承角色</a>
								</div>
							</div>
						</div>
						<div class="qx">
							<input name="type" type="checkbox" <c:if test="${shareRoleMap['可新建文件夹'].size()>0 }">checked="checked"</c:if> id="可新建文件夹" value="可新建文件夹" ><label for="可新建文件夹">可新建文件夹</label>
							<div class="xz" style="display: none;">
								<input class="easyui-combotree " id="addFolder" name="roles_addFolder"   style="width:200px;height: 100px;"  value="${vo.roles_addFolder }"  data-options="<c:if test="${shareRoleMap==null || shareRoleMap['可新建文件夹'].size()==0 }">disabled:true,</c:if>
									method:'get',
				                    valueField:'id',
				                    textField:'name',
				                    editable:false,
				                    multiline:true,
				                    multiple:true,
				                    onlyLeafCheck:true 
				            		">
								<div style="margin: 5px;">
									<a  href="#" class="easyui-linkbutton btn" data-options="iconCls:'icon-add',<c:if test="${shareRoleMap==null || shareRoleMap['可新建文件夹'].size()==0 }">disabled:true</c:if>" onclick="inheritRole('add','addFolder');">继承角色</a>
								</div>
							</div>
						</div>
						<div class="qx">
							<input name="type" type="checkbox" <c:if test="${shareRoleMap['可修改（覆盖）'].size()>0 }">checked="checked"</c:if> id="可修改（覆盖）" value="可修改（覆盖）" ><label for="可修改（覆盖）">可修改（覆盖）</label></br>
							<div class="xz" style="display: none;">
								<input class="easyui-combotree " id="modify" name="roles_modify"   style="width:200px;height: 100px;"  value="${vo.roles_modify }"  data-options="<c:if test="${shareRoleMap==null || shareRoleMap['可修改（覆盖）'].size()==0 }">disabled:true,</c:if>
									method:'get',
				                    valueField:'id',
				                    textField:'name',
				                    editable:false,
				                    multiline:true,
				                    multiple:true,
				                    onlyLeafCheck:true 
				            		">
								<div style="margin: 5px;">
									<a  href="#" class="easyui-linkbutton btn" data-options="iconCls:'icon-add',<c:if test="${shareRoleMap==null || shareRoleMap['可修改（覆盖）'].size()==0 }">disabled:true</c:if>" onclick="inheritRole('addFolder','modify');">继承角色</a>
								</div>
							</div>
						</div>
						<div class="qx">
							<input name="type" type="checkbox" <c:if test="${shareRoleMap['可删除'].size()>0 }">checked="checked"</c:if> id="可删除" value="可删除" ><label for="可删除">可删除</label></br>
							<div class="xz" style="display: none;"><!-- url:'../../platform/role/roleTree.do', -->
								<input class="easyui-combotree" id="delete" name="roles_delete"    style="width:200px;height: 100px;"  value="${vo.roles_delete }"  data-options="<c:if test="${shareRoleMap==null || shareRoleMap['可删除'].size()==0 }">disabled:true,</c:if>
				                    method:'get',
				                    valueField:'id',
				                    textField:'name',
				                    editable:false,
				                    multiline:true,
				                    multiple:true,
				                    onlyLeafCheck:true 
			            		">
								<div style="margin: 5px;">
									<a  href="#" class="easyui-linkbutton btn" data-options="iconCls:'icon-add',<c:if test="${shareRoleMap==null || shareRoleMap['可删除'].size()==0 }">disabled:true</c:if>" onclick="inheritRole('modify','delete');">继承角色</a>
								</div>
							</div>
						</div>
						
					</td>
				</tr>
				<tr>
			</table>
		</form>
     </div>
  </body>
</html>

