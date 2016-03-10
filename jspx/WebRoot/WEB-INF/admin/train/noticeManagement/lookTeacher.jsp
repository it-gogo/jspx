<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
	<script type="text/javascript">
	//下载文件
function download1(id,url){
	window.open("../noticeManagement/download.do?id="+id+"&url="+url);
}
	</script>
  </head>
  <body layout="easyui-layout">
      <div>
	   	<h2 style="text-align: center;">${vo.title }</h2>
	   	<h5 style="text-align: center;color: #1C9999;">
	   		创建人：${vo.creatorName }，
	   		创建时间：${vo.createdate }
	   		<c:if test="${vo.accessoryUrl!=null }">
	   		，附件：<a id="btn" href="javascript:void(0);"  class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="download1('${vo.id }','${vo.accessoryUrl }')">点击下载</a>
	   		</c:if>
	   	</h5>
		
	   	<table class="easyui-datagrid"   data-options="fitColumns:true,singleSelect:true">
			<thead>
				<tr>
					<th data-options="field:'week'" width="80">老师</th>
					<th data-options="field:'Mon'" width="50">是否阅读</th>
					<th data-options="field:'Tues'" width="80">阅读时间</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${teacherList }" var="teacher">
		        	<tr>
		        		
		            	<td ><span <c:if test="${teacher.isRead=='未阅读' }">style="color: red;"</c:if>>${teacher.teacherName }</span></td>
		            	<td>${teacher.isRead }</td>
		            	<td>${teacher.readDate }</td>
		        	</tr>
				</c:forEach>
	    	</tbody>
		</table>
  		<div class="content" >${vo.content }</div>
  	</div>
  </body>
</html>

