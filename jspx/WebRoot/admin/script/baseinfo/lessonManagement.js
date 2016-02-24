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
 * 打开数据窗口参数
 */
var loadOpt = {id:"d3",title:"课时管理编辑",width:"600px;",height:"600px;",buttons:dbuttons};
//添加函数
function  addF(){
	var urls = "../baseinfo/lessonManagement/add.do";
	loadOpt.urls = urls;
	parent.$.createDialog(loadOpt);
	parent.$.createDialog.open_grid = dataGrid;
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../baseinfo/lessonManagement/load.do?id="+row.id;
	loadOpt.urls = urls;
	parent.$.createDialog(loadOpt);
	parent.$.createDialog.open_grid = dataGrid;
}
