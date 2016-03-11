<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/supervise/schoolSupervise.js"></script>
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
	if(row.step==9 || row.step==10){
		var json = $.toJSON(row);
		var handstr="";
		try{
			for(var i=0,j=row.superviseMaterials.length;i<j;i++){
				var material=row.superviseMaterials[i];
				handstr="<a href=\"javascript:void(0);\" onclick=\"downFile('"+material.url+"','"+material.name+"')\">"+material.name+"</a> ";
			}
		}catch (e) {
		}
		return handstr;
	}
	return "";
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
                <th data-options="field:'superviseName'" width="40">督导项目名称</th>
                <th data-options="field:'superviseDate'" width="30">时间</th>
                <th data-options="field:'superviseType'" width="30" >类型</th>
                <th data-options="field:'flowStatus'" width="30" >状态</th>
                <!-- <th data-options="field:'checkMaterials'" width="100"  formatter="handImportFile" >督导报告</th> -->
                <th data-options="field:'handler'" width="30" formatter="handlerstatus" align="center">操作</th>
            </tr>
        </thead>
    </table>
    </div>
    </div>
    </div>
	</body>
</html>
