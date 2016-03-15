<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/fileManagement.js"></script>
    <style type="text/css">
    	table{width: 100%;}
    	table tr td{border: 1px solid black;}
    </style>
  </head>
  <body layout="easyui-layout">
      <div data-options="region:'center'">
      	${content }
     </div>
  </body>
</html>

