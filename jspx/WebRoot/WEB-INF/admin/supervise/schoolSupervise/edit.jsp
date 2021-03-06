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
        url:"saveMaterial.do?unitId="+unitId+"&superviseId="+superviseId+"&projectId="+projectId+"&type="+type,  
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
/**
*修改
*/
function modifyFile(projectId,type,fileUrl,id){
	deleteFileNoReload(fileUrl,id);
	importFile(projectId,type);
}
/**
*删除文件不刷新
*/
function deleteFileNoReload(fileUrl,id){
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
				url:"oneKeyPass.do",
				data:"superviseId="+superviseId+"&unitId="+unitId+"&step="+step+"&type="+type+"&status="+status,
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

function handlermaterial(vlaue,row,index){
	var json = $.toJSON(row);
	var type="${user.type}";
	var step="${vo.step}";
	var isDXZS=${isDXZS};
	var isXZS=${isXZS};
	var html="";
	if(isDXZS && (step=="2" || step=="3") ){
		if(window.ActiveXObject) {//IE浏览器
			html+="<a href=\"javascript:void(0);\" onclick=\"setParameter('"+row.projectId+"','学校材料')\" style=\"position:relative;\">上传<input style=\"position:absolute;left:0;top:0;width:100%;height:100%;z-index:999;filter:Alpha(opacity=0);\" onchange=\"ajaxFileUpload('fileId2"+row.id +"')\" type=\"file\" id=\"fileId2"+row.id +"\"  name=\"fileId\"/></a>";
	    }else {
			html+="<a href=\"javascript:void(0);\" onclick=\"importFile('"+row.projectId+"','学校材料')\">上传</a>";
	    }
	}
	if(row.schoolMaterials!=null){
		for(var i=0,j=row.schoolMaterials.length;i<j;i++){
			var material=row.schoolMaterials[i];
			html+="<div><a href=\"javascript:void(0);\" onclick=\"downFile('"+material.url+"','"+material.name+"')\">"+material.name+"</a> ";
			if(isDXZS && (step=="2" || step=="3")){
				html+="<a href=\"javascript:void(0);\" onclick=\"deleteFile('"+material.url+"','"+material.id+"')\"> 删除 </a>";
			}
			if(isXZS && "3"==step && "待审批"==material.status){
				html+="<a href=\"javascript:void(0);\" onclick=\"approvalFile('"+material.id+"','通过')\"> 通过 </a><a href=\"javascript:void(0);\" onclick=\"approvalFile('"+material.id+"','不通过')\"> 不通过 </a>";
			}else{
				html+=material.status;
			}
			html+="</div>";
		}
	}
	return html;
}
function handlerscore(value,row,index){
	var type="${user.type}";
	var step="${vo.step}";
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
  		<input type="file" id="fileId1" style="display:none;" name="fileId" onchange="ajaxFileUpload('fileId1');" />
           <input name="id"  type="hidden"  id="id"    value="${vo.id }">
           <input name="unitId"  type="hidden"  id="unitId"    value="${vo.unitId }">
           <input name="step"  type="hidden"  id="step"    value="${vo.step }">
         <div data-options="region:'north'"  style="height:52px;font-size:25px;font-weight: bold;text-align: center;line-height: 50px;">${vo.name }</div>
     	<div data-options="region:'center'"  >
     	<table id="treegrid" class="easyui-treegrid"  >   
		    <thead>   
		        <tr>   
		            <th data-options="field:'name',width:100">项目名</th>   
		            <th data-options="field:'remark',width:150">项目说明</th>   
		            <th data-options="field:'material',width:150" formatter="handlermaterial">
		            	学校材料
		            	<c:if test="${isXZS && vo.step==3}"> 
		        		<a href="javascript:void(0);" onclick="oneKeyPass('校长通过','学校材料')">一键通过</a> 
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
		        <th>
		        	学校材料
		        	<c:if test="${isXZS && vo.step==3}"> 
		        		<a href="javascript:void(0);" onclick="oneKeyPass('校长通过','学校材料')">一键通过</a> 
		        	</c:if>
		        </th>
		        <th>项目评分</th>
			</tr>
			<c:forEach items="${projectList }" var="project" varStatus="i">
				<tr>
					<td>${project.name }</td>
					<td>${project.remark }</td>
					<td>
						<c:if test="${isDXZS && (superviseUnit.step==2 || superviseUnit.step==3)}">
							<div class="upload_google" style="display: none;">
								<a href="javascript:void(0);" onclick="importFile('${project.projectId}','学校材料')">上传</a>
							</div>
							<div   class="upload_ie" style="display: none;">
								<a href="javascript:void(0);" onclick="setParameter('${project.projectId}','学校材料')" style="position:relative;">
									上传
									<input style="position:absolute;left:0;top:0;width:100%;height:100%;z-index:999;filter:Alpha(opacity=0);" onchange="ajaxFileUpload('fileId2${project.id }')" type="file" id="fileId2${project.id }"  name="fileId"/>
								</a>
							</div>
						</c:if>
						<c:forEach items="${project.schoolMaterials}" var="material">
							<div>
								<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
								<c:if test="${isDXZS && (superviseUnit.step==2 || superviseUnit.step==3)}">
									<a href="javascript:void(0);" onclick="modifyFile('${project.projectId}','学校材料','${material.url}','${material.id}')"  class="upload_google" style="display: none;" >修改</a>
									<a href="javascript:void(0);" onclick="setParameter('${project.projectId}','学校材料');deleteFileNoReload('${material.url}','${material.id}');"  class="upload_ie" style="display: none;position:relative;" >
										修改
										<input style="position:absolute;left:0;top:0;width:100%;height:100%;z-index:999;filter:Alpha(opacity=0);" onchange="ajaxFileUpload('fileId3${material.id }')" type="file" id="fileId3${material.id }"  name="fileId"/>
									</a>
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
					<td>
						${project.assessScore }/${project.totalScore }
					</td>
				</tr>
			</c:forEach>
		</table> --%>
		</div>
		<div data-options="region:'south'" style="height: 200px;"  >
		<table width="100%" class="table table-hover table-condensed">
		    <tr>
		        <th>
		        	自查报告
		        	<c:if test="${isXZS && vo.step==6}"> 
		        		<a href="javascript:void(0);" onclick="oneKeyPass('校长通过','自查报告')">一键通过</a> 
		        	</c:if>
		        </th>
		        <th>督学下校检查</th>
		        <th>
		        	整改处理
		        	<c:if test="${isXZS && vo.step==10}"> 
		        		<a href="javascript:void(0);" onclick="oneKeyPass('校长通过','整改材料')">一键通过</a> 
		        	</c:if>
		        </th>
		        <th>督导报告</th>
			</tr>
				<tr>
					<td>
						<c:if test="${isDXZS &&  (vo.step==5 || vo.step==6)}">
							<div class="upload_google" style="display: none;">
								<a href="javascript:void(0);" onclick="importFile('','自查报告');">上传</a>
							</div>
							<div   class="upload_ie" style="display: none;">
								<a href="javascript:void(0);" onclick="setParameter('','自查报告');" style="position:relative;">
									上传
									<input style="position:absolute;left:0;top:0;width:100%;height:100%;z-index:999;filter:Alpha(opacity=0);" onchange="ajaxFileUpload('fileId6${vo.id }')" type="file" id="fileId6${vo.id }"  name="fileId"/>
								</a>
							</div>
							
						</c:if>
						<c:forEach items="${vo.zcMaterials}" var="material">
						<div>
							<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
							<c:if test="${isDXZS &&  (vo.step==5 || vo.step==6)}">
								<a href="javascript:void(0);" onclick="deleteFile('${material.url}','${material.id}')">删除</a>
							</c:if>
							
							<c:choose>
								<c:when test="${isXZS && vo.step==6 && material.status=='待审批'}">
									<a href="javascript:void(0);" onclick="approvalFile('${material.id}','通过')">通过</a>
									<a href="javascript:void(0);" onclick="approvalFile('${material.id}','不通过')">不通过</a>
								</c:when>
								<c:otherwise>${material.status }</c:otherwise>
							</c:choose>
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
							<c:if test="${isDXZS && (superviseUnit.step==9 || superviseUnit.step==10)}">
								<div class="upload_google" style="display: none;">
									<a href="javascript:void(0);" onclick="importFile('','整改材料');">上传</a>
								</div>
								<div   class="upload_ie" style="display: none;">
									<a href="javascript:void(0);" onclick="setParameter('','整改材料');" style="position:relative;">
										上传
										<input style="position:absolute;left:0;top:0;width:100%;height:100%;z-index:999;filter:Alpha(opacity=0);" onchange="ajaxFileUpload('fileId4${project.id }')" type="file" id="fileId4${project.id }"  name="fileId"/>
									</a>
								</div>
							</c:if>
						<c:forEach items="${vo.modifyMaterials}" var="material">
							<div>
								<a href="javascript:void(0);" onclick="downFile('${material.url}','${material.name }')">${material.name }</a> 
								<c:if test="${isDXZS && (vo.step==9 || vo.step==10)}">
									<%-- <a href="javascript:void(0);" onclick="modifyFile('${project.id}','整改材料','${material.url}','${material.id}')"  class="upload_google" style="display: none;" >修改</a>
									<a href="javascript:void(0);" onclick="setParameter('${project.id}','整改材料');deleteFileNoReload('${material.url}','${material.id}');"  class="upload_ie" style="display: none;position:relative;" >
										修改
										<input style="position:absolute;left:0;top:0;width:100%;height:100%;z-index:999;filter:Alpha(opacity=0);" onchange="ajaxFileUpload('fileId5${material.id }')" type="file" id="fileId5${material.id }"  name="fileId"/>
									</a> --%>
									
									<a href="javascript:void(0);" onclick="deleteFile('${material.url}','${material.id}')">删除</a>
								</c:if>
								<c:choose>
									<c:when test="${isXZS && vo.step==10 && material.status=='待审批'}">
										<a href="javascript:void(0);" onclick="approvalFile('${material.id}','通过')">通过</a>
										<a href="javascript:void(0);" onclick="approvalFile('${material.id}','不通过')">不通过</a>
									</c:when>
									<c:otherwise>${material.status }</c:otherwise>
								</c:choose>
							</div>
						</c:forEach>
					</td>
					<td>
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



