var dbuttons = [{ 
		text:'保 存',
		iconCls:'icon-ok',
		id:'sbutton'
	},{
		text:'关 闭',
		iconCls:'icon-cancel',
		id:'cbutton'
	}];
/**
 * 打开修改数据窗口参数
 */
var loadOpt = {id:"d5",title:"考勤时间",width:"500px;",height:"450px;",buttons:dbuttons};
//添加函数
function  addF(){
	var classTimeId=$("#classTimeId","#qform").val();
	var index=$("#index","#qform").val();
	var urls = "../baseinfo/attendanceTime/add.do?classTimeId="+classTimeId+"&index="+index;
	loadOpt.urls=urls;
	parent.parent.$.createDialog(loadOpt);
	parent.parent.$.createDialog.open_grid = dataGrid; 
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	/*var classTimeId=$("#classTimeId","#qform").val();
	var index=$("#index","#qform").val();
	var urls = "../baseinfo/attendanceTime/load.do?id="+row.id+"&classTimeId="+classTimeId+"&index="+index;
	loadOpt.urls = urls;
	parent.$.createDialog(loadOpt);
	parent.$.createDialog.open_grid = dataGrid;*/
	var classTimeId=$("#classTimeId","#qform").val();
	var index=$("#index","#qform").val();
	var urls = "../baseinfo/attendanceTime/load.do?classTimeId="+classTimeId+"&index="+index+"&id="+row.id;
	loadOpt.urls=urls;
	parent.parent.$.createDialog(loadOpt);
	parent.parent.$.createDialog.open_grid = dataGrid; 
}
