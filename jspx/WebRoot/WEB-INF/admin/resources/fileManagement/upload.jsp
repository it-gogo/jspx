<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/fileManagement.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/uploadify/jquery.uploadify.js"></script>
  	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/uploadify/uploadify.css">
    <script type="text/javascript">
	$(document).ready(function(){
	var success=0,failed=0,count=0;//声明获取选择的文件数量
		 //绑定关闭事件
		 $("#close").bind('click',function(){
		 	parent.$.createDialog.open_grid.datagrid('reload');
			parent.dialogMap["d3"].dialog('close');
		 });
	//初始化上传控件	 
	$("#file_upload").uploadify({
			  height        : 20,/**按钮高度**/
			  width         : 80,/**按钮宽度**/
			  'buttonClass'   : 'btn',//按钮辅助class
			  'checkExisting' : '',//是否检测图片存在,不检测:false    
			  auto:false,/**是否自动提交**/
			  multi:true,/**设置为true时可以上传多个文件**/
              buttonText : '选择文件',
              removeTimeout:0,
              swf         : '<%=request.getContextPath() %>/uploadify/uploadify.swf',
              formData      : {'parentId' : '${vo.parentId }', 'topFileId' : '${vo.topFileId }'},
              uploader    : '<%=request.getContextPath() %>/common/upload/upload.do',
              'onUploadSuccess': function(file,result,response) {  
                    //vC-=1;  
                    //vT+=1;  
                   /*  $('#uCount').text('共'+vS+'个文件，成功上传'+vT+'个');  
                    if(vC==0){  
                        result = $.parseJSON(result);  
                        if(result.message){  
                          parent.$.messager.alert('提示', '上传成功!', 'info'); 
                        }else{  
                            parent.$.messager.alert('错误提示', '上传失败!', 'error'); 
                        }  
                    }   */
                   
                    result = $.parseJSON(result);
                    if(result.message){
                    	success+=1;
                    	$('#success').text(success);
                    }else{
                    	failed+=1; 
                    	$('#error').text(failed);
                    }
                    
                 },  
              'onSelect':function(file){  
                    count+=1;   
                    $('#uTotal').text(count);  
                 },  
              onFallback:function(){  
                    parent.$.messager.alert('提示', '您的电脑必须安装flash插件,请先安装插件', 'info'); 
              }
                
    }); 
	});
	
	
	</script>
<style type="text/css">  
body {  
    font: 13px Arial, Helvetica, Sans-serif;  
}  
.btn{  
   color:#FFFFFF;  
}  
</style>  
	
	
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
            <input name="topFileId"  type="hidden"  id="topFileId"    value="${vo.topFileId }">
            <input name="parentId"  type="hidden"  id="parentId"    value="${vo.parentId }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>操作</th>
					<td>
						<input type="file" name="file_upload" id="file_upload" />
					</td>
				</tr>
				<tr>
					<th>显示结果</th>
					<td>
						已选择<span id="uTotal" style="color:gray;font-size:14px;">0</span>个<br/>
						成功<span id="success" style="color:green;font-size:14px;">0</span>个<br/>
						失败<span id="error" style="color:red;font-size:14px;">0</span>个
					</td>
				</tr>
			</table>
			<center>
				<a class="easyui-linkbutton" href="javascript:$('#file_upload').uploadify('upload', '*')" data-options="iconCls:'icon-ok'">开始上传</a> | 
				<a href="javascript:void(0);" id="close" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">关闭窗口</a>
			</center>
			<div id="fileQueue" class="fileQueue"></div>
     </div>
  </body>
</html>

