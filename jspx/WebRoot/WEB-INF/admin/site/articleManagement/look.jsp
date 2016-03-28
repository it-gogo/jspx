<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
	<script type="text/javascript">
		//下载文件
function download1(id,url){
	window.open("../articleManagement/download.do?id="+id+"&url="+url);
}
	</script>
  </head>
  <body layout="easyui-layout">
      <div>
	   	<h2 style="text-align: center;">${vo.title }</h2>
	   	<h5 style="text-align: center;color: #1C9999;">
	   	文章来源：${vo.source }，
        发布时间 : ${vo.pubishDate }，
        发布人：${vo.userName }，
        发布部门：${vo.departName }，
        关键字：${vo.keyword }，
        阅读数：${vo.readCount }
	   	<c:if test="${vo.accessoryUrl!=null }">
   		，附件：<a id="btn" href="javascript:void(0);"  class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="download1('${vo.id }','${vo.accessoryUrl }')">点击下载</a>
   		</c:if>
	   	</h5>
  		<div class="content" >${vo.content }</div>
  	</div>
  </body>
</html>

