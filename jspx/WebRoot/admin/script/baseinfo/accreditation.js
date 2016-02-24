/**
 * 打开修改数据窗口参数
 */
//考勤列表
function  attendance(row){
	var loadOpt = {id:"d3",title:"出勤情况表",width:"600px;",height:"450px;",urls:"../baseinfo/accreditation/attendance.do?classId="+row.classId+"&studentId="+row.studentId};
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(loadOpt);
}

/**作业列表**/
function homework(row){
	var loadOpt = {id:"d3",title:"作业情况表",width:"600px;",height:"450px;",urls:"../baseinfo/accreditation/homework.do?classId="+row.classId+"&userId="+row.userId};
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(loadOpt);
}