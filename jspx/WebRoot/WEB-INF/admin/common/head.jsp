<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${webManagement.hTitle }</title>
<link href="<%=request.getContextPath()%>/admin/css/easyui.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/admin/css/icon.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/admin/css/mytable.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/admin/css/color.css" rel="stylesheet" type="text/css" />

<link href="<%=request.getContextPath()%>/admin/new-css/liebiao.css" rel="stylesheet" type="text/css" />

<script src="<%=request.getContextPath()%>/admin/script/jquery.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/admin/script/jquery.easyui.min1.4.2.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/admin/script/easyui-lang-zh_CN.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/admin/script/common.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/admin/script/basehandler.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/admin/script/goDialog.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/admin/script/goForm.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/admin/script/goTree.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/admin/script/json.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/admin/script/gogrid.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/admin/script/jquery.tabs.extend.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/admin/script/goTabs.js" type="text/javascript"></script>
<link type="image/vnd.microsoft.icon" rel="shortcut icon" href="<%=request.getContextPath()%>/${webManagement.iconUrl }">
<style>
<!--
.grid_button{
	margin:0px  8px;
	font-size: 10px;
}
img{
	border:0px;
}
a{
	text-decoration: inherit;
}
-->
</style>
<!-- 样式模板1 start-->
<link href="<%=request.getContextPath()%>/cssTemplate1/style.css" rel="stylesheet" type="text/css" />
<!-- 样式模板1 end-->
<script type="text/javascript">
var uri="<%=request.getContextPath()%>/";
</script>
