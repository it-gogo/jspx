<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/homework.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/ajaxfileupload.js"></script>
    <script type="text/javascript">
	var cbutton = parent.$("#cbutton");
	var sbutton = parent.$("#sbutton");
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"upload_homwork.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $(sbutton).bind('click',function(){
			 $("#dform").submit();
		 });
		 //绑定关闭事件
		 $(cbutton).bind('click',function(){
			parent.dialogMap["d5"].dialog('close');
		 });
	});
	
	/**作业上传**/
	function upload(){
		$("#homework").click();
	}
	
	/**
		异步提交作业数据
	**/
	function ajaxFileUpload(){
				$.ajaxFileUpload({  
			        url:"upload.do?path=reupload",  
			        secureuri:false,  
			        fileElementId:"homework",
			        dataType: "text",
			        success: function (data) { 
			        	var json=eval("("+data+")");
			        	if(json.message){
				        	$('#url').val(json.message);
			        		parent.$.messager.alert("提示窗口",'上传成功','info');
			        		$("#error").html('');
			        		$("#error").hide();
			        		$("#success").html('上传成功');
			        		$("#success").show();
				        }else{
				        	parent.$.messager.alert("提示窗口",json.error,'waring');
				        	$("#success").html('');
				        	$("#success").hide();
			        		$("#error").html(json.error);
			        		$("#error").show();
				        }
			        }, error: function (data) {  
			            alert(data);  
			        }  
			    });
				return false;  
			}
	function customRefresh(){
		parent.dialogMap["d5"].dialog('close');
	}
</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
         	<input type="hidden" name="homeworkId" value="${vo.id }"/> 
            <input type="file" id="homework" style="display:none;" name="homework" onchange="ajaxFileUpload();" />
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>作业名称</th>
					<td>${vo.title }</td>
				</tr>
				<tr>
					<th>作业上传</th>
					<td>
						<input type="hidden" name="uploadUrl" id="url" />
						<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="upload();">作业上传</a>&nbsp;&nbsp; 
						<span id="success" style="color:green;display:none;">上传成功</span>
						<span id="error" style="color:red;display:none;"></span>
					</td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>


