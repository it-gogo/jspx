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
		</table>
		<div style="height: 50px"></div>
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



