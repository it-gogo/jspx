<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/supervise/inspectorApproval.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/ajaxfileupload.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
	

function  handlerstatus(value,row,index){
	  var json = $.toJSON(row);
   var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='loadF("+json+")';>查 看</a>";
   return  handstr;
}
/**
*督导报告显示
*/
function handImportFile(value,row,index){
	var json = $.toJSON(row);
	var handstr="<a href=\"javascript:void(0);\" onclick='importFile("+json+")'>上传</a>";
	try{
		for(var i=0,j=row.superviseMaterials.length;i<j;i++){
			var material=row.superviseMaterials[i];
			handstr="<a href=\"javascript:void(0);\" onclick=\"downFile('"+material.url+"','"+material.name+"')\">"+material.name+"</a> ";
			handstr+=" <a href=\"javascript:void(0);\" onclick='modifyFile("+json+",\""+material.url+"\",\""+material.id+"\")'>更改</a>";
		}
	}catch (e) {
	}
	if(row.step==9){
		return handstr;
	}
	return "";
}
var projectId="";
var unitId="";
var superviseId="";
var type="督导报告";
function importFile(row){
	unitId=row.unitId;
	superviseId=row.id;
	$("#fileId").click();
}
function modifyFile(row,fileUrl,id){
	if(fileUrl==""){
		parent.$.messager.alert("提示窗口","没有上传资料。");
		return;
	}
	$.ajax({
		url:"../schoolSupervise/deleteMaterial.do",
		data:"fileUrl="+fileUrl+"&id="+id,
		success:function(data){
		}
	});
	importFile(row);
}
function ajaxFileUpload(){
	$.ajaxFileUpload({  
        url:"../schoolSupervise/saveMaterial.do?unitId="+unitId+"&superviseId="+superviseId+"&projectId="+projectId+"&type="+type,  
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
        	dataGrid.datagrid('reload');
        }, error: function (data) {  
            alert(data);  
        }  
    });
	return false;  
}

/**
*上传资料
*/
function downFile(fileUrl,fileName){
	if(fileUrl==""){
		parent.$.messager.alert("提示窗口","没有上传资料。");
		return;
	}
	$.ajax({
		url:"../../common/exists.do",
		data:"fileUrl="+fileUrl,
		success:function(data){
			var json=eval("("+data+")");
			if(json.message){
				fileName=fileName.split(".")[0];
				fileName=encodeURI(fileName);
				location.href="../../common/downloadData.do?fileName="+fileName+"&fileUrl="+fileUrl;
			}else{
				parent.$.messager.alert("提示窗口",json.error);
			}
		}
	});
}
		</script>
		
	</head>
	<body >
		   <div class="easyui-panel" style="padding:5px;"  data-options="fit:true,border:false">
		   	<div class="easyui-layout" data-options="fit:true" >
		     <div data-options="region:'north'" style="height:35px;">
		       <div style="width:100%;height:100%">
		          <form id="qform">
		          <span  id="upload_google" >
		          	<input type="file" id="fileId" style="display:none;" name="fileId" onchange="ajaxFileUpload();" />
		          </span>
		          <span   id="upload_ie" style="display: none;">
		              <input style="position:absolute;left:0;top:0;width:100%;height:100%;z-index:999;filter:Alpha(opacity=0);" onchange="ajaxFileUpload()" type="file" id="fileId"  name="fileId"/>
	              </span>
		          <table>
		          <tr>
		            <td>时间选择:</td>
		            <td>
		            	<input type="text" class="easyui-datebox" id="beginDate" data-options="editable:false" >——
		            	<input type="text" class="easyui-datebox" id="endDate" data-options="editable:false" >
		            </td>
		            <td>
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查  询</a>
		              &nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全  部</a>
		              &nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新  增</a>
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
            	<th data-options="field:'id'" width="10" checkbox=true ></th>
                <th data-options="field:'name'" width="40">督导项目名称</th>
                <th data-options="field:'superviseDate'" width="30">时间</th>
                <th data-options="field:'type'" width="30" >类型</th>
                <th data-options="field:'flowStatus'" width="30" >状态</th>
                <th data-options="field:'schoolName'" width="30" >学校</th>
                <th data-options="field:'checkMaterials'" width="100" formatter="handImportFile" >督导报告</th>
                <th data-options="field:'handler'" width="30" formatter="handlerstatus" align="center">操作</th>
            </tr>
        </thead>
    </table>
    </div>
    </div>
    </div>
	</body>
</html>
