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
	});
/**
*导入信息
*/
var projectId="";
var type="";
function importFile(id,str){
	projectId=id;
	type=str;
	$("#fileId").click();
}
function ajaxFileUpload(){
	var unitId=$("#unitId").val();
	var superviseId=$("#id").val();
	$.ajaxFileUpload({  
        url:"saveMaterial.do?unitId="+unitId+"&superviseId="+superviseId+"&projectId="+projectId+"&type="+type,  
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
        	//parent.dialogMap["d3"].dialog('refresh');
        	history.go(0);
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
/**
*删除资料
*/
function deleteFile(fileUrl,id){
	if(fileUrl==""){
		parent.$.messager.alert("提示窗口","没有上传资料。");
		return;
	}
	$.ajax({
		url:"deleteMaterial.do",
		data:"fileUrl="+fileUrl+"&id="+id,
		success:function(data){
			var json=eval("("+data+")");
			if(json.message){
	        	parent.$.messager.alert("提示窗口",json.message);
        	}else{
        		parent.$.messager.alert("提示窗口",json.error);
        	}
			history.go(0);
		}
	});
}
function modifyFile(projectId,type,fileUrl,id){
	if(fileUrl==""){
		parent.$.messager.alert("提示窗口","没有上传资料。");
		return;
	}
	$.ajax({
		url:"deleteMaterial.do",
		data:"fileUrl="+fileUrl+"&id="+id,
		success:function(data){
		}
	});
	importFile(projectId,type);
}
/**
*审批
*/
function approvalFile(id,status){
	var step=$("#step").val();
	$.messager.confirm("询问", "您确定"+status+"该材料吗？", function(r){
		if (r){
			$.ajax({
				url:"approvalMaterial.do",
				data:"id="+id+"&status=校长"+status+"&step="+step,
				success:function(data){
					var json=eval("("+data+")");
					if(json.message){
			        	parent.$.messager.alert("提示窗口",json.message);
		        	}else{
		        		parent.$.messager.alert("提示窗口",json.error);
		        	}
					history.go(0);
				}
			});
		}
	});
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
		<table width="100%" class="table table-hover table-condensed">
		    <tr>
		        <th>项目名</th>
		        <th>项目说明</th>
		        <th>学校材料</th>
		        <th>督学下校检查</th>
		        <th>整改处理</th>
			</tr>
			<c:forEach items="${projectList }" var="project" varStatus="i">
				<tr>
					<td>${project.name }</td>
					<td>${project.remark }</td>
					<td>
						<%-- <c:choose>
							<c:when test="${empty  project.schoolMaterials}"></c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose> --%>
						<c:if test="${isDXZS && (superviseUnit.step==2 || superviseUnit.step==3)}">
							<div><a href="javascript:void(0);" onclick="importFile('${project.id}','学校材料')">上传</a></div>
						</c:if>
						<c:forEach items="${project.schoolMaterials}" var="material">
							<div>
								<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
								<c:if test="${isDXZS && (superviseUnit.step==2 || superviseUnit.step==3)}">
									<a href="javascript:void(0);" onclick="modifyFile('${project.id}','学校材料','${material.url}','${material.id}')">修改</a>
									<a href="javascript:void(0);" onclick="deleteFile('${material.url}','${material.id}')">删除</a>
								</c:if>
								<c:choose>
									<c:when test="${isXZS && superviseUnit.step==3 && material.status=='待审批'}">
										<a href="javascript:void(0);" onclick="approvalFile('${material.id}','通过')">通过</a>
										<a href="javascript:void(0);" onclick="approvalFile('${material.id}','不通过')">不通过</a>
									</c:when>
									<c:otherwise>${material.status }</c:otherwise>
								</c:choose>
							</div>
						</c:forEach>
					</td>
					<c:if test="${i.index==0 }">
						<td rowspan="${projectList.size() }" >
							<c:forEach items="${vo.checkMaterials}" var="material">
							<div>
								<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
							</div>
						</c:forEach>
						</td>
					</c:if>
					<c:if test="${i.index==0 }">
						<td rowspan="${projectList.size() }" >${project.modifyMaterials }
							<c:if test="${isDXZS && (superviseUnit.step==6 || superviseUnit.step==7)}">
								<div><a href="javascript:void(0);" onclick="importFile('','整改材料')">上传</a></div>
							</c:if>
						<c:forEach items="${vo.modifyMaterials}" var="material">
							<div>
								<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
								<c:if test="${isDXZS && (superviseUnit.step==6 || superviseUnit.step==7)}">
									<a href="javascript:void(0);" onclick="modifyFile('${project.id}','整改材料','${material.url}','${material.id}')">修改</a>
									<a href="javascript:void(0);" onclick="deleteFile('${material.url}','${material.id}')">删除</a>
								</c:if>
								<c:choose>
									<c:when test="${isXZS && superviseUnit.step==7 && material.status=='待审批'}">
										<a href="javascript:void(0);" onclick="approvalFile('${material.id}','通过')">通过</a>
										<a href="javascript:void(0);" onclick="approvalFile('${material.id}','不通过')">不通过</a>
									</c:when>
									<c:otherwise>${material.status }</c:otherwise>
								</c:choose>
							</div>
						</c:forEach>
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</table>

     </div>
     </form>
     </div>
  </body>
</html>



