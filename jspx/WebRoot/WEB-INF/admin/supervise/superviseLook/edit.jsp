<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/supervise/schoolSupervise.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/ajaxfileupload.js"></script>
    <script type="text/javascript">
    var pid=1;
	var formobj;
	var cbutton = parent.$("#cbutton");
	var sbutton = parent.$("#sbutton");
	var supplierList;
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
		 
		  var gridoption = {url:"../schoolSupervise/projectList.do?superviseId=${vo.id}&unitId=${vo.unitId}",id:"treegrid",idField:"id",treeField:"name",fitColumns:true};
		  $.initTreeGrid(gridoption); 
	});

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

function handlermaterial(vlaue,row,index){
	var json = $.toJSON(row);
	var type="${user.type}";
	var step="${vo.step}";
	var html="";
	if(row.schoolMaterials!=null){
		for(var i=0,j=row.schoolMaterials.length;i<j;i++){
			var material=row.schoolMaterials[i];
			html+="<div><a href=\"javascript:void(0);\" onclick=\"downFile('"+material.url+"','"+material.name+"')\">"+material.name+"</a> ";
			html+="</div>";
		}
	}
	return html;
}
function handlerscore(value,row,index){
	var html="";
	html+=""+row.assessScore+"/"+row.totalScore+"";	
	return html;
}
	</script>
	<style type="text/css">
	.table tbody th,.table tbody td{
		text-align: center;
	}
	</style>
  </head>
  <body >
  	<div class="easyui-layout" data-options="fit:'true',border:false" >
  	<form id="dform" method="post" >
  	<input type="file" id="fileId" style="display:none;" name="fileId" onchange="ajaxFileUpload();" />
           <input name="id"  type="hidden"  id="id"    value="${vo.id }">
           <input name="unitId"  type="hidden"  id="unitId"    value="${vo.unitId }">
           <input name="step"  type="hidden"  id="step"    value="${vo.step }">
         <div data-options="region:'north'"  style="height:52px;font-size:25px;font-weight: bold;text-align: center;line-height: 50px;">${vo.name }</div>
     <div data-options="region:'center'"  >
     	<table id="treegrid" class="easyui-treegrid"  >   
		    <thead>   
		        <tr>   
		            <th data-options="field:'name',width:180">项目名</th>   
		            <th data-options="field:'remark',width:200">项目说明</th>   
		            <th data-options="field:'material',width:100" formatter="handlermaterial">
		            	学校材料
		            	<c:if test="${user.type=='督学账号' && vo.step==4}"> 
			        		<a href="javascript:void(0);" onclick="oneKeyPass('督学通过','学校材料')">一键通过</a> 
			        	</c:if>
		            </th>   
		            <th data-options="field:'sScore',width:80" formatter="handlerscore">项目评分</th>   
		        </tr>   
		    </thead>   
		</table>
		<%-- <table width="100%" class="table table-hover table-condensed">
		    <tr>
		        <th>项目名</th>
		        <th>项目说明</th>
		        <th>学校材料</th>
			</tr>
			<c:forEach items="${projectList }" var="project" varStatus="i">
				<tr>
					<td>${project.name }</td>
					<td>${project.remark }</td>
					<td>
						<c:forEach items="${project.schoolMaterials}" var="material">
							<div>
								<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
							</div>
						</c:forEach>
					</td>
				</tr>
			</c:forEach>
		</table> --%>
		</div>
		<div data-options="region:'south'" style="height: 200px;"  >
		<table width="100%" class="table table-hover table-condensed">
		    <tr>
		        <th>自查报告</th>
		        <th>督学下校检查</th>
		        <th>整改处理</th>
		        <th>督导报告</th>
			</tr>
			<tr>
				<td>
					<c:forEach items="${vo.zcMaterials}" var="material">
						<div>
							<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
						</div>
					</c:forEach>
				</td>
				<td>
					<c:forEach items="${vo.checkMaterials}" var="material">
					<div>
						<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
					</div>
					</c:forEach>
				</td>
				<td >
					<c:forEach items="${vo.modifyMaterials}" var="material">
						<div>
							<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
						</div>
					</c:forEach>
				</td>
				<td >
					<c:forEach items="${vo.superviseMaterials}" var="material">
					<div>
						<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
					</div>
					</c:forEach>
				</td>
			</tr>
		</table>
     </div>
     </form>
     </div>
  </body>
</html>



