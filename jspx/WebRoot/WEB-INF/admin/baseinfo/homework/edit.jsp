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
			        url:"upload.do",  
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
	
	/**格式化时间**/	
	   function formatDate(date){
	     var month = date.getMonth()+1;
    	if( "" != date ){
        if( date.getMonth() +1 < 10 ){
            month = '0' + (date.getMonth() +1);
        }
        var day = date.getDate();
        if( date.getDate() < 10 ){
            day = '0' + date.getDate();
        }
        var minute=date.getMinutes();
        if(minute<=9){
        	minute="0"+minute;
        }
	   	//返回格式化后的时间
        return date.getFullYear()+'-'+month+'-'+day+" "+date.getHours()+":00";
        }else{
        	return "";
        }
	   }

</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post" >
         	<input type="hidden" name="id" id="id" value="${vo.id }"/>
         	<input type="hidden" name="uploader" id="uploader" value="${vo.uploader }"/>
         	<input type="hidden" name="uploadTime" id="uploadTime" value="${vo.uploadTime }"/>
            <input type="file" id="homework" style="display:none;" name="homework" onchange="ajaxFileUpload();" />
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>文件名称</th>
					<td><input name="title" type="text" class="easyui-validatebox textbox" required="required"  style="width:350px;" value="${vo.title }"></td>
				</tr>
				<tr>
			        <th>班级</th>
					<td>
						<input class="easyui-combobox" style="width:350px;"  name="classId"  required="required"  value="${vo.classId }"  data-options="url:'../classInfo/all.do',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    editable:false
		            	">
					</td>
				</tr>
				
				<tr>
					<th>截止提交时间</th>
					<td><input name="endUploadTime" type="text" class="easyui-datetimebox textbox" data-options="formatter:formatDate"    required="required"  style="width:350px;" value="${vo.endUploadTime }"></td>
				</tr>
				<tr>
					<th>作业上传</th>
					<td>
						<input type="hidden" name="homeworkUrl" id="url" value="${vo.homeworkUrl }"/>
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


