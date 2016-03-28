<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<title>${webManagement.qTitle }</title>
<link type="image/vnd.microsoft.icon" rel="shortcut icon" href="<%=request.getContextPath()%>/${webManagement.iconUrl }">
<link href="<%=path%>/client/portal/css/index.css" rel="stylesheet" type="text/css" />
<link href="<%=path %>/client/portal/css/carousel.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=path %>/client/portal/css/pagination.css"/>
<script src="<%=request.getContextPath() %>/client/portal/js/carousel.js"></script>
<script src="<%=request.getContextPath() %>/client/portal/js/DrawImg.js"></script>
<script src="<%=request.getContextPath() %>/client/portal/js/ScrollPic.js"></script>
<script src="<%=request.getContextPath() %>/admin/script/jquery.min.js"></script>
<script type="text/javascript">
<!--
	//下载文件
function downloadAccessory(id,accessoryUrl){
	location.href="../web/downloadAccessory.do?id="+id+"&url="+accessoryUrl;
}
$(function(){
		$(".link").change(function(){
			var urls=$(this).val();
			if(urls==null||urls==''||urls==undefined){
				return;
			}else{
				window.open(urls);
			}
		});
});
//-->
</script>
