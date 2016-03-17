<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/fileSubmit.js"></script>
    <script type="text/javascript">
	var formobj;
	var cbutton = parent.$("#cbutton");
	var sbutton = parent.$("#sbutton");
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"save.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $(sbutton).bind('click',function(){
			 $("#dform").submit();
		 });
		 //绑定关闭事件
		 $(cbutton).bind('click',function(){
			parent.dialogMap["d3"].dialog('close');
		 });
		 
		 //设置图片的URL
		 var dataUrl = $("#accessoryUrl").val();
		 $("#accessoryFile").filebox('setValue',dataUrl);
		 
		 //提交人员
		  var treeoptions = {id:"treeID",url:"../../train/noticeManagement/tree.do",checkbox:true ,onClick:treeClick,onLoadSuccess:setTree};
 		 $.initTree(treeoptions);
 		 //目录树
 		var treeoptions = {id:"treeFileId",url:"../fileManagement/topFileTree.do",onBeforeExpand: onBefore,onClick:treeFileClick,onLoadSuccess:loadSuccess};
 		$.initTree(treeoptions);
 		
 		//重写tree的loader
		$.extend($.fn.tree.defaults, {
		    loader: function (param, success, error) {
		        var opts = $(this).tree("options");
		        if (!opts.url) {
		            return false;
		        }
		        if (opts.queryParams) {
		            param = $.extend({}, opts.queryParams, param);
		        }
		        $.ajax({
		            type: opts.method,
		            url: opts.url,
		            data: JSON2.stringify(param),
		            dataType: "text",
		            contentType: "application/json; charset=utf-8", //application/json
		            success: function (data) {
		                success(JSON2.parse(data));
		            },
		            error: function () {
		                error.apply(this, arguments);
		            }
		        });
		    },
		    queryParams: {}
		});
		//设置参数
		$.extend($.fn.tree.methods, {
		    setQueryParams: function (jq, params) {
		        return jq.each(function () {
		            $(this).tree("options").queryParams = params;
		        });
		    }
		});
	});

function onBefore(node){
	$("#treeFileId").tree("setQueryParams", { "parentId": node.id });
    $("#treeFileId").tree("options").url = "../fileManagement/folderTree.do";
}
/**
*目录树加载成功时间
*/
function loadSuccess(){
	var fileId=$("#fileId").val();
	if(fileId!=""){
		var node=$("#treeFileId").tree("find",fileId);
		if(node!=null){
			$("#treeFileId").tree("select",node.target);
		}
	}
}
/**
*目录树点击事件
*/
function treeFileClick(node){
	$("#fileId").val(node.id);
	$("#fileName").val(node.name);
}
/**
*点击树方法
*/
function  treeClick(node){
	if(node.checked){
		$("#treeID").tree("uncheck", node.target);
	}else{
		$("#treeID").tree("check", node.target);
	}
}
//提交前操作
function beforeSubmit(dform){
	var node=$("#treeID").tree("getChecked");
	if(node==null || node==""){
		parent.$.messager.alert("提示窗口","至少选择一个栏目。");
		return false;
	}
	var html="";
	for(var i=0;i<node.length;i++){
		var n=node[i];
		if(!$("#treeID").tree("isLeaf",n.target)){//是否父节点
			continue;
		}
		var teacher=n.teacher;
		if(teacher==1){
			html+="<input name=\"teacherIds\"  type=\"hidden\"      value=\""+n.teacherId+"\">"
		}else{
			continue
		}	
	}
	$("#dform").prepend(html);
	return true;
}
//设置选中栏目
function setTree(/* teacherIds */){
	var teacherIds="${vo.teacherIds}";
	if(teacherIds==""){
		return;
	}
	var arr=teacherIds.split(",");
	for(var i=0;i<arr.length;i++){
		 var node=$("#treeID").tree("find",arr[i]);
		 $("#treeID").tree("check", node.target);
	}
}
	</script>
  </head>
  <body ><!-- layout="easyui-layout" -->
  	<div class="easyui-layout" data-options="fit:'true',border:false" >
			<div data-options="region:'east',split:true,title:'提交人员',collapsible:true" style="width:350px;">
				<%@include file="/WEB-INF/admin/common/tree.jsp"%>
			</div>
         <div data-options="region:'center'">
         	<div class="easyui-layout" data-options="fit:'true',border:false" >
         		<div data-options="region:'south',split:true,title:'目录树',collapsible:false" style="width:100%;height:410px;">
					 <ul id="treeFileId" >  
   					</ul>
				</div>
				<div data-options="region:'north'" style="height: 110px;">
		         	<form id="dform" method="post"  enctype="multipart/form-data"  >
			            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
						<table width="100%" class="table table-hover table-condensed">
							<tr>
								<th width="75px;">名称</th>
								<td><input name="title" type="text" class="easyui-validatebox textbox" required="required"  style="width:300px;" value="${vo.title }"></td>
							</tr>
							<tr>
								<th>截止时间</th>
								<td><input name="endDate" type="text" class="easyui-datebox textbox" required="required" data-options="editable:false"  style="width:300px;" value="${vo.endDate }"></td>
							</tr>
							<tr>
								<th>附件</th>
								<td>
									<input class="easyui-filebox" name="accessoryFile" id="accessoryFile" data-options="prompt:'选择文件',buttonText:'选择文件'" style="width:300px;" >
									<input id="accessoryUrl" name="accessoryUrl" type="hidden" value="${vo.accessoryUrl }" />
								</td>
							</tr>
							<tr>
								<th>指定目录</th>
								<td>
									<input   type="text" class="easyui-validatebox textbox" required="required" readonly="readonly" id="fileName"  style="width:300px;" value="${vo.fileName }">
									<input name="fileId"  type="hidden"  id="fileId"    value="${vo.fileId }">
								</td>
							</tr>
							<tr>
						</table>
					</form>
				</div>
     		</div>
     	</div>
     </div>
  </body>
</html>

