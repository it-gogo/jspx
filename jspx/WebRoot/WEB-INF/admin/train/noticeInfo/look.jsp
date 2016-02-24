<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
  </head>
  <body >
  	<div>
	   	<h2 style="text-align: center;">${vo.title }</h2>
	   	<h5 style="text-align: center;color: #1C9999;">创建人：${vo.createName }，创建时间：${vo.createdate }</h5>
  		<div class="content" >${vo.content }</div>
  	</div>
  </body>
</html>

