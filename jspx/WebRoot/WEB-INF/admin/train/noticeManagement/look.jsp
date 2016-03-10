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
  		<div class="content" >${vo.content }</div>
  	</div>
  </body>
</html>

