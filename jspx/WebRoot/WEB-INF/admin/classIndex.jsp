<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/admin/common/head.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/baseinfo/accreditation.js"></script>
<script type="text/javascript">
$(document).ready(function(){
  	//var gridoption = {url:"../train/noticeInfo/list.do?classIds=${vo.classIds}",id:"qwGrid",pagination:true};
  	var gridoption = {url:"../train/noticeInfo/list.do?type=1",id:"qwGrid",pagination:true};
  	$.initBasicGrid(gridoption); 
  	
  	gridoption = {url:"../train/noticeInfo/list.do?classId=${vo.classId}&type=2",id:"bjGrid",pagination:true};
  	$.initBasicGrid(gridoption);
  	 
  	gridoption = {url:"../baseinfo/homework/downLoadList.do",id:"homeworkGrid",pagination:true};
  	$.initBasicGrid(gridoption); 
  	
  	gridoption = {url:"../baseinfo/accreditation/list.do?classId=${vo.classId}",id:"accreditationGrid",pagination:true};
	dataGrid = $.initBasicGrid(gridoption); 
	
	gridoption = {url:"../baseinfo/courseData/list.do?classId=${vo.classId}",id:"courseDataGrid",pagination:true};
	dataGrid = $.initBasicGrid(gridoption); 
});
/**
*操作
*/
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='lookF("+json+")';>[查 看]</a> ";
     return  handstr;
}
/**
 作业下载上传操作 
**/
function homeworkHandler(value,row,index){
	var json=$.toJSON(row);
	var handstr = "<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='download_("+json+");'>[下载]</a>&nbsp;|&nbsp;"+
					"<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='upload("+json+");'>[上传]</a>";
					return handstr;
}
/**
*资料下载
*/
function courseDataHandler(value,row,index){
	var json=$.toJSON(row);
	var handstr = "<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='downloadData("+json+");'>[下载]</a>";
					return handstr;
}
/**
*查看通知公告
*/
function lookF(row){
	var options = {id:"d3",urls:"../train/noticeInfo/look.do?id="+row.id,title:"查看通知"};
	parent.$.createDialog(options);
}
/**
*下载资料
*/
function downloadData(row){
	var fileUrl=row.dataUrl;
	if(fileUrl==""){
		parent.$.messager.alert("提示窗口","没有上传课程资料。");
		return;
	}
	$.ajax({
		url:"../common/exists.do",
		data:"fileUrl="+fileUrl,
		success:function(data){
			var json=eval("("+data+")");
			if(json.message){
				var fileName=encodeURI(row.name);
				location.href="../common/downloadData.do?fileName="+fileName+"&fileUrl="+fileUrl;
			}else{
				parent.$.messager.alert("提示窗口",json.error);
			}
		}
	});
}
function download_(row){
	//alert(row.id);
	var href_='../baseinfo/homework/download.do?id='+row.id;
	window.open(href_);
}
var dbuttons = [{ 
		text:'保 存',
		iconCls:'icon-ok',
		id:'sbutton'
	},{
		text:'关 闭',
		iconCls:'icon-cancel',
		id:'cbutton'
	}];
var loadOpt = {id:"d5",title:"作业提交",width:"650px;",height:"350px;",buttons:dbuttons};
function upload(row){
	var urls = "../baseinfo/homework/toUpload.do?id="+row.id;
	loadOpt.urls = urls;
	parent.$.createDialog(loadOpt);
}



/**
*操作
*/
function  accreditationHandler(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='attendance("+json+")';>[出勤情况]</a> "+
     						"<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='homework("+json+")';>[作业列表]</a> ";
    var isPass=row.isPass;
    /*  if(typeof(isPass)=="undefined" || isPass==""){
     	handstr+="<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='pass("+json+")';>[通过]</a> <a href='javascript:void(0)'  iconCls='icon-edit'  onclick='unpass("+json+")';>[未通过]</a>";
     }else if(isPass=="1"){
     	handstr+="<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='print("+json+")';>[打印证书]</a>";
     } */
     return  handstr;
}
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
/**
*显示是否通过
*/
function showPass(value,row,index){
	 if(typeof(value)=="undefined" || value==""){
	 	return "未确认";
     }else if(value=="1"){
     	return "通过";
     }else if(value=="0"){
     	return "未通过";
     }
}
//考勤列表
/* function  attendance(row){
	var loadOpt = {id:"d3",title:"出勤情况表",width:"600px;",height:"450px;",urls:"../baseinfo/accreditation/attendance.do?classId="+row.classId+"&studentId="+row.studentId};
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(loadOpt);
} */
</script>
<style type="text/css">
li{float: left;margin-right: 20px;margin-top: 20px;}

</style>
</head>

<body>
	<ul>
		<c:if test="${!isStudent }">
		<li>
			<div class="easyui-panel" title="资格认定情况" style="width: 1020px;height: 300px;" >
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center'">
						<table id="accreditationGrid">
							<thead>
								<tr>
									<th data-options="field:'id',checkbox:true"  ></th>
									<th data-options="field:'studentName'" width="100">学员姓名</th>
									<th data-options="field:'sex'" width="50"  formatter="showSex">性别</th>
									<th data-options="field:'schoolName'" width="100">学校</th>
									<th data-options="field:'scores'" width="100">考试分数</th>
									<th data-options="field:'isPass'" width="100" formatter="showPass">培训资格确认</th>
									<th data-options="field:'handler'" width="150" formatter="accreditationHandler">操作</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</li>
		</c:if>
		<li>
			<div class="easyui-panel" title="全网公告" style="width: 500px;height: 300px;" >
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center'">
						<table id="qwGrid">
							<thead>
								<tr>
									<th data-options="field:'title'" width="200">标题</th>
									<th data-options="field:'createName'" width="100">创建人</th>
									<th data-options="field:'createdate'" width="150" >创建时间</th>
									<th data-options="field:'handler'" width="80" formatter="handlerstr">操作</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</li>
		<li>
			<div class="easyui-panel" title="班级公告" style="width: 500px;height: 300px;" >
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center'">
						<table id="bjGrid">
							<thead>
								<tr>
									<th data-options="field:'title'" width="200">标题</th>
									<th data-options="field:'createName'" width="100">创建人</th>
									<th data-options="field:'createdate'" width="150" >创建时间</th>
									<th data-options="field:'handler'" width="80" formatter="handlerstr">操作</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</li>
		<li>
	<div class="easyui-panel" title="作业下载" style="width: 500px;height: 300px;" >
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center'">
				<table id="homeworkGrid">
					<thead>
						<tr>
							<th data-options="field:'title'" width="100">作业名称</th>
							<!-- <th data-options="field:'uploadTime'" width="100">上传时间</th> -->
							<th data-options="field:'endUploadTime'" width="100" >截止上传时间</th>
							<th data-options="field:'handler'" width="100" formatter="homeworkHandler">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
		</li>
		<li>
	<div class="easyui-panel" title="资料下载" style="width: 500px;height: 300px;" >
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center'">
				<table id="courseDataGrid">
					<thead>
						<tr>
							<th data-options="field:'id',checkbox:true"  ></th>
							<th data-options="field:'name'" width="40">名称</th>
							<!-- <th data-options="field:'dataUrl'" width="50"  >资料地址</th> -->
							<th data-options="field:'remark'" width="120">备注</th>
							<th data-options="field:'handler'" width="100" formatter="courseDataHandler">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
		</li>
	</ul>
	
</body>
</html>
