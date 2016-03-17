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
	$("#fileId1").click();
}
function setParameter(id,str){
	projectId=id;
	type=str;
}
function ajaxFileUpload(fileId){
	var unitId=$("#unitId").val();
	var superviseId=$("#id").val();
	$.ajaxFileUpload({  
        url:"../schoolSupervise/saveMaterial.do?unitId="+unitId+"&superviseId="+superviseId+"&projectId="+projectId+"&type="+type,  
        secureuri:false,  
        fileElementId:fileId,  
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
		type:"post",
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
		url:"../schoolSupervise/deleteMaterial.do",
		data:"fileUrl="+fileUrl+"&id="+id,
		type:"post",
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
/**
*审批
*/
function approvalFile(id,status){
	var step=$("#step").val();
	$.messager.confirm("询问", "您确定"+status+"该材料吗？", function(r){
		if (r){
			$.ajax({
				url:"../schoolSupervise/approvalMaterial.do",
				data:"id="+id+"&status=督学"+status+"&step="+step,
				type:"post",
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
/**
*一键审批
*/
function oneKeyPass(status,type){
	var superviseId=$("#id").val();
	var unitId=$("#unitId").val();
	var step=$("#step").val();
	$.messager.confirm("询问", "您确定一键通过"+type+"吗？", function(r){
		if (r){
			$.ajax({
				url:"../schoolSupervise/oneKeyPass.do",
				data:"superviseId="+superviseId+"&unitId="+unitId+"&step="+step+"&type="+type+"&status="+status,
				type:"post",
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
/**
*评价
*/
function assess(newValue,oldValue){
	var superviseProjectId=$(this).attr("superviseProjectId");
	$.ajax({
		url:"assess.do",
		data:"superviseProjectId="+superviseProjectId+"&score="+newValue,
		type:"post",
		success:function(data){
			
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
  	<input type="file" id="fileId1" style="display:none;" name="fileId" onchange="ajaxFileUpload('fileId1');" />
           <input name="id"  type="hidden"  id="id"    value="${vo.id }">
           <input name="unitId"  type="hidden"  id="unitId"    value="${vo.unitId }">
           <input name="step"  type="hidden"  id="step"    value="${vo.step }">
         <div data-options="region:'north'"  style="height:52px;font-size:25px;font-weight: bold;text-align: center;line-height: 50px;">${vo.name }</div>
     <div data-options="region:'center'"  >
		<table width="100%" class="table table-hover table-condensed">
		    <tr>
		        <th>项目名</th>
		        <th>项目说明</th>
		        <th>
		        	学校材料
		        	<c:if test="${user.type=='督学账号' && vo.step==4}"> 
		        		<a href="javascript:void(0);" onclick="oneKeyPass('督学通过','学校材料')">一键通过</a> 
		        	</c:if>
		        </th>
		        <th>项目评分</th>
		        <!-- <th>督学下校检查</th>
		        <th>整改处理</th>
		        <th>督导报告</th> -->
			</tr>
			<c:forEach items="${projectList }" var="project" varStatus="i">
				<tr>
					<td>${project.name }</td>
					<td>${project.remark }</td>
					<td>
						<c:forEach items="${project.schoolMaterials}" var="material">
							<div>
								<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
								<c:choose>
									<c:when test="${user.type=='督学账号' && superviseUnit.step==4 && material.status=='校长通过'}">
										<a href="javascript:void(0);" onclick="approvalFile('${material.id}','通过')">通过</a>
										<a href="javascript:void(0);" onclick="approvalFile('${material.id}','不通过')">不通过</a>
									</c:when>
									<c:otherwise>${material.status }</c:otherwise>
								</c:choose>
							</div>
						</c:forEach>
					</td>
					<td>
						<c:choose>
							<c:when test="${user.type=='督学账号' &&  (vo.step==8 || vo.step==9)}">
								<input tye="text" class="easyui-numberbox text" name="score" value="${project.assessScore }" data-options="precision:1,onChange:assess,max:${project.totalScore }" superviseProjectId="${project.superviseProjectId }"  />
								总分:${project.totalScore }
							</c:when>
							<c:otherwise>${project.assessScore }/${project.totalScore }</c:otherwise>
						</c:choose>
						
					</td>
				</tr>
			</c:forEach>
		</table>
		<div style="height: 50px"></div>
		<table width="100%" class="table table-hover table-condensed">
		    <tr>
		        <th>
		        	自查报告
		        	<c:if test="${user.type=='督学账号' && vo.step==7}"> 
		        		<a href="javascript:void(0);" onclick="oneKeyPass('督学通过','自查报告')">一键通过</a> 
		        	</c:if>
		        </th>
		        <th>督学下校检查</th>
		        <th>
		        	整改处理
		        	<c:if test="${user.type=='督学账号' && vo.step==11}"> 
		        		<a href="javascript:void(0);" onclick="oneKeyPass('督学通过','整改材料')">一键通过</a> 
		        	</c:if>
		        </th>
		        <th>督导报告</th>
			</tr>
			<tr>
				<td>
					<c:forEach items="${vo.zcMaterials}" var="material">
						<div>
							<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
							<c:choose>
								<c:when test="${user.type=='督学账号' && vo.step==7 && material.status=='校长通过'}">
									<a href="javascript:void(0);" onclick="approvalFile('${material.id}','通过')">通过</a>
									<a href="javascript:void(0);" onclick="approvalFile('${material.id}','不通过')">不通过</a>
								</c:when>
								<c:otherwise>${material.status }</c:otherwise>
							</c:choose>
						</div>
					</c:forEach>
				</td>
				<td>
						<c:if test="${user.type=='督学账号' &&  (vo.step==8 || vo.step==9)}">
							<div>
								<div class="upload_google" style="display: none;">
									<a href="javascript:void(0);" onclick="importFile('','检查材料')">上传</a>
								</div>
								<div   class="upload_ie" style="display: none;">
									<a href="javascript:void(0);" onclick="setParameter('','检查材料')" style="position:relative;">
										上传
										<input style="position:absolute;left:0;top:0;width:100%;height:100%;z-index:999;filter:Alpha(opacity=0);" onchange="ajaxFileUpload('fileId1${vo.id }')" type="file" id="fileId1${vo.id }"  name="fileId"/>
									</a>
								</div>
							</div>
						</c:if>
						<c:forEach items="${vo.checkMaterials}" var="material">
						<div>
							<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
							<c:if test="${user.type=='督学账号' &&  (vo.step==8 || vo.step==9)}">
								<a href="javascript:void(0);" onclick="deleteFile('${material.url}','${material.id}')">删除</a>
							</c:if>
						</div>
					</c:forEach>
				</td>
				<td>
					<c:forEach items="${vo.modifyMaterials}" var="material">
						<div>
							<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
							<c:choose>
								<c:when test="${user.type=='督学账号' && vo.step==11 && material.status=='校长通过'}">
									<a href="javascript:void(0);" onclick="approvalFile('${material.id}','通过')">通过</a>
									<a href="javascript:void(0);" onclick="approvalFile('${material.id}','不通过')">不通过</a>
								</c:when>
								<c:otherwise>${material.status }</c:otherwise>
							</c:choose>
						</div>
					</c:forEach>
				</td>
				<td >
					<c:if test="${user.type=='督学账号' &&  (vo.step==12 || vo.step==13)}">
						<div>
							<div class="upload_google" style="display: none;">
								<a href="javascript:void(0);" onclick="importFile('','督导报告')">上传</a>
							</div>
							<div   class="upload_ie" style="display: none;">
								<a href="javascript:void(0);" onclick="setParameter('','督导报告')" style="position:relative;">
									上传
									<input style="position:absolute;left:0;top:0;width:100%;height:100%;z-index:999;filter:Alpha(opacity=0);" onchange="ajaxFileUpload('fileId2${vo.id }')" type="file" id="fileId2${vo.id }"  name="fileId"/>
								</a>
							</div>
						</div>
					</c:if>
					<c:forEach items="${vo.superviseMaterials}" var="material">
					<div>
						<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
						<c:if test="${user.type=='督学账号' &&  (vo.step==12 || vo.step==13)}">
							<a href="javascript:void(0);" onclick="deleteFile('${material.url}','${material.id}')">删除</a>
						</c:if>
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



