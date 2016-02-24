<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/artificialAttendance.js"></script>
    <script type="text/javascript">
	
$(document).ready(function(){
	var classId=$("#classId","#qform").val();
	var studentName=$("#studentName","#qform").val();
	var classTimeId=$("#classTimeId","#qform").val();
	var beginDate=$("#beginDate","#qform").val();
	var endDate=$("#endDate","#qform").val();
  	var gridoption = {url:"statisticsZDYlist.do?classId="+classId+"&studentName="+studentName+"&classTimeId="+classTimeId+"&beginDate="+beginDate+"&endDate="+endDate,id:"grid",pagination:false};
  	var dataGrid = $.initBasicGrid(gridoption); 
});
/**
*显示性别
*/
function showSex(value,row,index){
	if(value==1){
		return "男";
	}else{
		return "女";
	}
}
function countKuangke(value,row,index){
	return row.total-row.zhundao-row.chidao-row.zaotui-row.zhuntui;
}
</script>
  </head>
  <body layout="easyui-layout">
	<div class="easyui-panel" style="padding:5px;" data-options="fit:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'north'" style="height:35px;">
				<div style="width:100%;height:100%">
					<form id="qform">
						<input type="hidden"   id="studentName"   value="${vo.studentName }"> 
						<input type="hidden"   id="classId"   value="${vo.classId }">
						<input type="hidden"  id="classTimeId"   value="${vo.classTimeId }">
						<input type="hidden"   id="beginDate"   value="${vo.beginDate }">
						<input type="hidden"  id="endDate"   value="${vo.endDate }"> 
						<div style="text-align: center;font-weight: bold;font-size:16px;line-height: 33px;">
							${classInfo.name }&nbsp;&nbsp;${classTime.classDate }出勤统计情况
						</div>
						
					</form>
				</div>
			</div>
			<div data-options="region:'center'">
				<table id="grid">
					<thead>
						<tr>
							<th data-options="field:'studentName'" width="80">姓名</th>
							<th data-options="field:'sex'" width="40" formatter="showSex" >性别</th>
							<th data-options="field:'schoolName'" width="150">附属学校</th>
							<th data-options="field:'total'" width="80" >总考勤</th>
							<th data-options="field:'zhundao'" width="80" >准到</th>
							<th data-options="field:'chidao'" width="80" >迟到</th>
							<th data-options="field:'kuangke'" width="80" formatter="countKuangke" >旷课</th>
							<th data-options="field:'zaotui'" width="80" >早退</th>
							<th data-options="field:'zhuntui'" width="80" >准退</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
		
  </body>
</html>

