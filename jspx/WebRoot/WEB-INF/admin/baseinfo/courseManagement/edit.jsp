<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
	<script src="<%=request.getContextPath()%>/admin/script/jquery.easyui.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/admin/script/easyui-lang-zh_CN.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/courseManagement.js"></script>
    <script type="text/javascript">
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
		 var dataUrl = $("#dataUrl").val();
		 $("#dataFile").filebox('setValue',dataUrl);
		 
		 $(document).ready(function(){
				var gridoption;
		 		var id=$("#id").val();
		 		if(id==""){
		 			gridoption = {url:"",id:"grid",pagination:true,fit:false};
		 		}else{
				  	gridoption = {url:"../lessonManagement/list.do?courseId="+id,id:"grid",pagination:true,fit:false};
		 		}
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
	});
	/**
	*查询授课老师
	*/
	function findInstructor(value){
		var loadOpt = {id:"d4",urls:"../baseinfo/classInfo/findClassTeacher.do?id=instructorId&name=instructorName",title:"授课教师列表"};
		parent.$.createDialog(loadOpt);
	}
	/**
	*保存之前操作
	*/
	function beforeSubmit(formId){
		var id=$("#id").val();
		if(id==""){
			var json=$("#grid").datagrid("getData");
			var data=$.toJSON(json);
			$("#data").val(data);
		}
		return true;
	}
	
	
	
	
	
	
	/* 课时管理 */
	var ksButton = [{ 
		text:'保 存',
		iconCls:'icon-ok',
		id:'kssbutton'
	},{
		text:'关 闭',
		iconCls:'icon-cancel',
		id:'kscbutton'
	}];
/**
 * 打开添加数据窗口参数
 */
var ksoptions = {id:"d5",title:"课时编辑",width:"600px;",height:"450px;",buttons:ksButton};
//添加函数
function  addLesson(){
	var id=$("#id").val();
	var urls = "../baseinfo/lessonManagement/add.do?courseId="+id;
	ksoptions.urls = urls;
	parent.$.createDialog(ksoptions);
}
/**
 * 导出数据
 * @param row
 */
function  loadLesson(row,index){
	var id=$("#id").val();
	var urls = "../baseinfo/lessonManagement/load.do?id="+row.id+"&courseId="+id+"&subjectId="+row.subjectId+"&subjectName="+row.subjectName+"&lesson="+row.lesson+"&index="+index;
	ksoptions.urls = urls;
	parent.$.createDialog(ksoptions);
}
/**
*操作
*/
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='loadLesson("+json+","+index+")';>[修 改]</a> "+
     						"<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='deleteLesson("+json+","+index+")';>[删 除]</a> ";
     return  handstr;
}

	/**
 * 删除单条数据
 * @param row
 */
function deleteLesson(row,index){
	  var id = [];
	  id.push(row.id);
	  parent.$.messager.confirm('询问', '您是否要删除当前记录？', function(b) {
			if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('../lessonManagement/delete.do',{id:id.join(',')}, function(result) {
						if (result.message) {
							parent.$.messager.alert('提示', result.message, 'info');
							$("#grid").datagrid("deleteRow",index);
						}else if(result.other){
							//做其他回调函数
						}
						parent.$.messager.progress('close');
					}, 'JSON');
				}
		});
}
function ajaxFileUpload(name,dform){
		var obj=$("input[name='"+name+"F']");
		var fileElementId=obj.attr("id");
		$.ajaxFileUpload({  
	        url:"../../common/upload.do",  
	        secureuri:false,  
	        fileElementId:fileElementId,  
	        dataType: "text",
	        success: function (data,status) { 
	        	var inp=$("input[name='"+name+"']");
	        	if(inp.size()==0){
	        		$("#"+dform).prepend("<input name=\""+name+"\" value=\""+data+"\" type=\"hidden\" />");
	        	}else{
	        		inp.val(data);
	        	}
	        	$("#"+name+"F").filebox({onChange:function(){ajaxFileUpload(name,dform);}});
	        	$("#"+name+"F").filebox("setText",data);
	        }, error: function (data) {  
	            alert(data);  
	        }  
	    });
		return false;  
	}  

</script>
  </head>
  <body layout="easyui-layout">
 	<div class="easyui-layout" data-options="fit:'false'"  >
         <div data-options="region:'center'" >
         <form id="dform" method="post" enctype="multipart/form-data" >
            <input name="id" type="hidden" id="id"   value="${vo.id }">
			<input name="data" type="hidden"  id="data">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>课程名称</th>
					<td><input name="name" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;" value="${vo.name }"></td>
				</tr>
				<%-- <tr>
			        <th>授课教师</th>
					<td>
						<input class="easyui-searchbox" id="instructorName" value="${vo.instructorName }" data-options="editable:false,searcher:findInstructor" required="required" style="width:350px"></input>
						<input type="hidden" name="instructorId" id="instructorId"  value="${vo.instructorId }"  />
					</td>
				</tr> --%>
				<tr>
					<th>课程资料</th>
					<td>
						<input class="easyui-filebox" name="dataFile" id="dataFile" data-options="prompt:'选择课程资料',buttonText:'选择文件'" style="width:350px">
						<input id="dataUrl" name="dataUrl" type="hidden" value="${vo.dataUrl }" />
					</td>
				</tr>
				<tr>
					<th>课程简介</th>
					<td><input name="introduction" type="text" data-options="multiline:true"   class="easyui-textbox textbox" style="width:350px;height:100px;"  value="${vo.introduction }"></td>
				</tr>
			</table>
		</form>
     </div>
     
     <div data-options="region:'south'" style="height:270px;">
     <div class="easyui-panel" style="padding:5px;" data-options="fit:true,border:false"  >
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north'" style="height:35px;">
				<div style="width:100%;height:100%">
					<form id="qform">
						<table>
							<tr>
								<td>科目名称:</td>
								<td>
									<input type="text" class="easyui-validatebox" id="subjectName"   value=""> 
								<td>
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查 询</a>&nbsp;&nbsp; 
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全 部</a>&nbsp;&nbsp;
									<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addLesson();">新 增</a>&nbsp;&nbsp; 
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
							<th data-options="field:'subjectName',editor:'text'" width="220">科目名称</th>
							<th data-options="field:'lesson'" width="150" >课时数量</th>
							<th data-options="field:'instructor'" width="150" >授课老师</th>
							<th data-options="field:'subjectId'" width="150" formatter="handlerstr">操作</th>
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

