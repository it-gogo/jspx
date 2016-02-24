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
									<th>考勤总数:</th>
									<td align="left">${map.total }</td>
									<th>准到:</th>
									<td>${map.zhundao }</td>
									<th>迟到:</th>
									<td>${map.chidao }</td>
									<th>准退:</th>
									<td>${map.zhuntui }</td>
									<th>早退:</th>
									<td>${map.zaotui }</td>
									<th>旷课:</th>
									<td>${map.total-map.zhundao-map.chidao-map.zhuntui-map.zaotui }</td>
								</tr>
							</table>
						</div>
					</div>
					<div data-options="region:'center'">
						<table class="easyui-datagrid" data-options="fitColumns:true">
						    <thead>
						        <tr>
						            <th data-options="field:'attendanceTime'"  width="80">考勤时间</th>
						            <th data-options="field:'zhundao'"  width="20">准到</th>
						            <th data-options="field:'chidao'"  width="20">迟到</th>
						            <th data-options="field:'zhuntui'"  width="20">准退</th>
						            <th data-options="field:'zaotui'"  width="20">早退</th>
						            <th data-options="field:'kuangke'"  width="20">旷课</th>
						        </tr>
						    </thead>
						    <tbody>
						    	<c:forEach items="${map.list }" var="m">
							        <tr>
							            <td>${m.attendanceTime }</td>
							            <td>${m.zhundao }</td>
							            <td>${m.chidao }</td>
							            <td>${m.zhuntui }</td>
							            <td>${m.zaotui }</td>
							            <td>${m.total-m.zhundao-mm.chidao-m.zhuntui-m.zaotui }</td>
							        </tr>
						    	</c:forEach>
						    </tbody>
						</table>
						
					</div>
				</div>
			</div>
</body>
</html>
