<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/accreditation.js"></script>
		<style type="text/css">
		.table,.table td,.table th{border-bottom: 0px;border-top: 0px;}
		</style>
	</head>
<body>
			<div class="easyui-panel" style="padding:5px;" data-options="fit:true,border:false">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north'" style="height:35px;">
						<div style="width:100%;height:100%">
							<table class="table" style="width: 100%;border: 0px;">
								<tr  height="33px;">
									<th>作业总数:</th>
									<td align="left">${map.total }</td>
									<th>提交总数:</th>
									<td>${map.uploadcount }</td>
								</tr>
							</table>
						</div>
					</div>
					<div data-options="region:'center'">
						<table class="easyui-datagrid" data-options="fitColumns:true">
						    <thead>
						        <tr>
						            <th data-options="field:'title',align:'center'"  width="40">作业名称</th>
						            <th data-options="field:'uploadTime',align:'center'"  width="40">提交时间</th>
						            <th data-options="field:'score',align:'center'"  width="40">作业评分</th>
						        </tr>
						    </thead>
						    <tbody>
						    	<c:forEach items="${map.list }" var="m">
							        <tr>
							            <td>${m.title }</td>
							            <td>${m.uploadTime }</td>
							            <td>${m.score }</td>
							        </tr>
						    	</c:forEach>
						    </tbody>
						</table>
						
					</div>
				</div>
			</div>
</body>
</html>
