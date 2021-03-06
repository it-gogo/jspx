<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/supervise/supervise.js"></script>
    <script type="text/javascript">
    var pid=0;
	var formobj;
	var cbutton = parent.$("#cbutton");
	var sbutton = parent.$("#sbutton");
	var supplierList;
	var storeOpen=true;
	var schoolOpen=true;
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
		 
		 var id="${vo.id}";
		 var treeoptions = {id:"treeID",url:"../project/tree.do",onDblClick:treeClick};
 		 $.initTree(treeoptions);
 		 
 		 var treeoptions1 = {id:"tree_ID",url:"../../baseinfo/unitInfo/school.do?superviseId="+id,checkbox:true,cascadeCheck :true};
		  $.initTree(treeoptions1);
 		 
 		 
 		 if(id!=""){
 		 $('#mxList').treegrid({    
		    url:"projectList.do?superviseId="+id,
		    onLoadSuccess:function(row,data){
		    	$(".grid_text").textbox().validatebox();
				$(".grid_button").linkbutton();
				$(".grid_num").numberbox();
		    }    
		});
		} 
	});
/**
*点击树方法
*/
function  treeClick(node){
	var nodes=$(this).tree('getData',node.target);
	
	var arr=new Array();
	arr[0]=nodes;
	var jsonStr=JSON.stringify(arr);
	var node = $('#mxList').treegrid('getChecked');
	$('#mxList').treegrid('append',{
			parent:node[0]==null?'':node[0].id, 
			data:eval('(' + jsonStr + ')')	
		});
	$(".grid_text").textbox().validatebox();
				$(".grid_button").linkbutton();
				$(".grid_num").numberbox();	
	
	
}
function loadSuccess(data){
	$(".grid_text").textbox().validatebox();
	$(".grid_button").linkbutton();
	$(".grid_num").numberbox();
}


/*
*删除
*/
function deleteF(json){
	$("#mxList").treegrid("remove",json.id);
}
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a href='javascript:void(0)' class='grid_button' iconCls='icon-cancel' plain='true' onclick='deleteF("+json+")';>删除</a>";
     return  handstr;
}

/**格式化项目说明**/
function  showRemark(value,row,index){
	  var json = $.toJSON(row);
	   if(json=="{}"){
	  	return;
	  }
	  if(value==undefined){
	  	value="";
	  }
     var  handstr = "<input type=\"text\" class=\"grid_text\" data-options=\"multiline:true\"  name=\"remark\" style=\"width:500px; height:30px;\"   value=\""+value+"\"  />";
     return  handstr;
}

function  showName(value,row,index){
	  var json = $.toJSON(row);
	  if(json=="{}"){
	  	return;
	  }
     var  handstr = "<input type=\"text\" class=\"grid_text\" name=\"text\" style=\"width:250px;\"   value=\""+value+"\"  /><input type=\"hidden\" name=\"projectId\" value=\""+row.id+"\" />"+
     "<input type=\"hidden\" name=\"parentId\" value=\""+row._parentId+"\" />";
     return  handstr;
}

function  showScore(value,row,index){
	  var json = $.toJSON(row);
	  if(json=="{}"){
	  	return;
	  }
	  if(value==undefined){
	  	value="";
	  }
     var  handstr = "<input type=\"text\" class=\"grid_num\" name=\"totalScore\" style=\"width:250px;\"   value=\""+value+"\"  />";
     return  handstr;
}

/**项目库打开关闭控制**/
function openStore(){
    
    if(storeOpen){
		$("#layout_").layout('expand','west');
		storeOpen=false;
    }else{
    	$("#layout_").layout('collapse','west');
    	storeOpen=true;
    }
}


function openSchool(){
	 if(schoolOpen){
		$("#layout_").layout('expand','east');
		schoolOpen=false;
    }else{
    	$("#layout_").layout('collapse','east');
    	schoolOpen=true;
    }
	
}

function addRow(){
	var pid=generatePid();
		var node = $('#mxList').treegrid('getChecked');
		$('#mxList').treegrid('append',{
			parent:node[0]==null?'':node[0].id, 
			data: [{
				id: pid,
				text: '',
				remark:'',
				totalScore:''
			}]
		});
		$(".grid_text").textbox().validatebox();
		$(".grid_button").linkbutton();
		$(".grid_num").numberbox();
}

function generatePid(){
  pid=parseInt(pid)+1;
  return "pid_"+pid;
}


function beforeSubmit(){
	var id = [];
				var nodes = $("#tree_ID").tree("getChecked");
			    var s = "";
			    for(var i=0; i<nodes.length; i++){
			    	var node=nodes[i];
			    	if(node!=null && node.type=="2"){//学校类
				        if (s != "") s += ",";
				        s += nodes[i].id;
			    	}
			    }
				id.push(s);
	$("#unitId").val(id.join(","));
}


	</script>
  </head>
  <body >
  	<div id="layout_" class="easyui-layout" data-options="fit:'true',border:false" >

  	<form id="dform" method="post" enctype="multipart/form-data" >
		<div  data-options="region:'west',split:true,title:'项目库列表',collapsible:false,collapsed:true" style="width:200px;">
			<%@include file="/WEB-INF/admin/common/tree.jsp"%>
		</div>
		<div  data-options="region:'east',split:true,title:'学校列表',collapsible:true,collapsed:true" style="width:300px;">
			<%@include file="/WEB-INF/admin/common/tree_.jsp"%>
		</div>
         <div data-options="region:'north'"  style="height:160px;">
         
            <input name="aid"  type="hidden"  id="aid"    value="${vo.id }">
            <input name="unitId"  type="hidden"  id="unitId"    value="${vo.unitId }">
            <input name="type"  type="hidden"  id="type"    value="自定义">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th width="100px">名称</th>
					<td width="130px"><input name="name" class="easyui-textbox validatebox" required="required"  type="text" value="${vo.name }" style="width: 350px;"></td>
				</tr>
				<tr>

					<th>时间</th>
					<td><input name="superviseDate" type="text" class="easyui-datebox textbox" data-options="editable:false"  style="width: 350px;"   value="${vo.superviseDate }"></td>
				</tr>
				<tr>
					<th>督导方案</th>
					<td>
						<input class="easyui-filebox" name="accessoryFile" id="accessoryFile" data-options="prompt:'选择方案',buttonText:'选择方案'" style="width:350px;" >
						<input id="accessoryUrl" name="accessoryUrl" type="hidden" value="${vo.accessoryUrl }" />
					</td>
				</tr>
				<tr>
					<th>督导项目</th>
					<td>
						<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-tip'" onclick="openStore();">项目库</a>
						&nbsp;&nbsp;<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addRow();">新增</a>
					</td>
				</tr>
				<tr>
					<th>学校设置</th>
					<td>
						<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="openSchool();">学校列表</a>
						<span style="font-weight:bold;color:red;text-align: center">(若没有设置,默认为全区的学校名单)</span>
					</td>
				</tr>
			</table>
		
     </div>
     <div data-options="region:'center'"  >
     	<table id="mxList" class="easyui-treegrid"  data-options="border:false,singleSelect:true,
			         fitColumns:true,
			         selectOnCheck:false,
			         checkOnSelect:false,
			         rownumbers:false,
			         showHeader:true,showFooter:true,fit:'true',idField:'id',treeField:'text',rowStyler:function(index,row){
			         			return  'height:50px'
							}
						" style="height:90%">   
		    <thead>   
		        <tr>   
		        	<th data-options="field:'cid'"   checkbox=true></th>   
		            <th data-options="field:'text'"  formatter="showName"  width="15">项目名称</th>   
		            <th data-options="field:'remark'" formatter="showRemark"   width="30">项目说明</th>
		            <th data-options="field:'totalScore'" formatter="showScore"   width="30">项目分数</th>
		            <th data-options="field:'handle'" formatter="handlerstr" width="10">操作</th>
		        </tr>   
		    </thead>   
		    <tbody>   
		    </tbody>   
		</table>  

     </div>
     </form>
     </div>
  </body>
</html>




