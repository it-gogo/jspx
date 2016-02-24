<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/admin/common/head.jsp"%>
<script type="text/javascript">
/**
*下载资料
*/
function downloadData(id,dataUrl){
	var fileUrl=dataUrl;
	if(fileUrl==""){
		parent.$.messager.alert("提示窗口","该班级没有上传课程资料。");
		return;
	}
	$.ajax({
		url:"../common/exists.do",
		data:"fileUrl="+fileUrl,
		success:function(data){
			var json=eval("("+data+")");
			if(json.message){
				location.href="../baseinfo/courseManagement/downloadData.do?id="+id+"&dataUrl="+fileUrl;
			}else{
				parent.$.messager.alert("提示窗口",json.error);
			}
		}
	});
}
function enterClassIndex(classId,className){
	parent.bxunTabs.addTab(className+"首页","../main/classIndex.do?classId="+classId);
}
</script>
<style type="text/css">
li{float: left;margin-right: 20px;}
pre { 
white-space: pre-wrap; /* css-3 */ 
white-space: -moz-pre-wrap; /* Mozilla, since 1999 */ 
white-space: -pre-wrap; /* Opera 4-6 */ 
white-space: -o-pre-wrap; /* Opera 7 */ 
word-wrap: break-word; /* Internet Explorer 5.5+ */ 
} 
</style>
</head>

<body>
	<c:if test="${classList!=null }">
		<ul>
			<c:forEach items="${classList }" var="classInfo">
				<li>
					<div class="easyui-panel" title="${classInfo.name }" style="width: 500px;height: 300px;" data-options="footer:'#${classInfo.id }_ft'" >
						<table width="100%" class="table table-hover table-condensed"  >
						    <tr>
								<th width="80px;">班主任</th>
								<td>${classInfo.classTeacherName }</td>
							</tr>
							<tr>
								<th>班级简介</th>
								<td><pre >${classInfo.introduction }</pre></td>
							</tr>
						</table>
						<%-- <h3>班主任：${classInfo.classTeacherName }</h3>
						<h2 style="">班级简介:</h2>
						<span>${classInfo.introduction }</span> --%>
					</div>
					<div id="${classInfo.id }_ft" style="padding:13px;">
						<%-- 课程资料下载请点击<a href="javascript:void(0);" onclick="downloadData('${classInfo.courseId}','${classInfo.dataUrl}')">这里</a>, --%>
						进入班级页面请点击<a href="javascript:void(0);" onclick="enterClassIndex('${classInfo.id}','${classInfo.name }')">这里</a>
				    </div>
				</li>
			</c:forEach>
		</ul>
	</c:if>
</body>
</html>
