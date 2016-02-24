/**
 * 打开添加数据窗口参数
 */
var options = {id:"d3",urls:"../baseinfo/application/application.do",title:"申请学生"};
/**
 * 打开修改数据窗口参数
 */
var loadOpt = {id:"d3",title:"查看学生"};
//申请学生
function  application(row){
	var xdIds=row.xdIds;
	var xkIds=row.xkIds;
	if(typeof(xdIds)=="undefined"){
		xdIds="";
	}
	if(typeof(xkIds)=="undefined"){
		xkIds="";
	}
	var urls = "../baseinfo/application/application.do?schoolId="+row.schoolId+"&classId="+row.classId+"&number="+row.unassigned+"&xkIds="+xkIds+"&xdIds="+xdIds;
	options.urls = urls;
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 查看学生
 * @param row
 */
function  lookStudent(row){
	var urls = "../baseinfo/application/lookStudent.do?classId="+row.classId+"&schoolId="+row.schoolId;
	loadOpt.urls = urls;
	var closeDialog=function(){parent.$.createDialog.open_grid.datagrid('reload');};
	loadOpt.onClose=closeDialog;
	parent.$.createDialog(loadOpt);
	parent.$.createDialog.open_grid = dataGrid;
}
