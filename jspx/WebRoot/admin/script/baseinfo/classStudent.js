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
var loadOpt = {id:"d6",title:"选择班级学员"};
//添加函数
function  addF(){
	var classId=$("#classId","#qform").val();
	var index=$("#index","#qform").val();
	var xdIds=$("#xdIds").val();
	var xkIds=$("#xkIds").val();
	var urls = "../baseinfo/classStudent/add.do?classId="+classId+"&index="+index+"&xkIds="+xkIds+"&xdIds="+xdIds;
	loadOpt.urls=urls;
	parent.parent.$.createDialog(loadOpt);
	parent.parent.$.createDialog.open_grid = dataGrid; 
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../baseinfo/classStudent/load.do?id="+row.id;
	loadOpt.urls = urls;
	parent.$.createDialog(loadOpt);
	parent.$.createDialog.open_grid = dataGrid;
}
