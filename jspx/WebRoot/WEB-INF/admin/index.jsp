<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/admin/common/head.jsp"%>
   	<link href="<%=request.getContextPath()%>/admin/new-css/shouye.css" rel="stylesheet" type="text/css" />
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
	var url="admin/css/icons/陈铭轩.png";
	url="<%=request.getContextPath()%>/"+url;
	parent.bxunTabs.addTab("",className+"首页","../main/classIndex.do?classId="+classId,url);
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
.panel-header{
	    background: linear-gradient(to bottom,#FFFFFF 0,#6DBEFF 100%);
}
.main_bj{
	background: #ede8e6;
	overflow: hidden;
}
.sy_an{
	background: #fff;
}
</style>
</head>

<body style="margin: 0">
<div class="main_bj">
	<div class="sy_an">
		<div class="an_t">
			<ul>
				<li><a href="#">通知公告</a></li>				
				<li><a href="#">通知公告</a></li>
			</ul>			
		</div>
		<div class="an_jt"><img src="<%=request.getContextPath()%>/admin/css/images/anniu_jt_03.png"></div>	
	</div>
	
	<div class="main_bg">
		<c:if test="${classList!=null }">
			<ul style="margin: 0;">
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
	</div>

</div>
</body>
</html>
