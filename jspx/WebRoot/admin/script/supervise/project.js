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
 * 打开添加数据窗口参数
 */
var options = {id:"d3",title:"项目管理",width:"600px;",height:"500px;",buttons:dbuttons};
//添加函数
function  addF(){
	options["urls"]="../supervise/project/add.do";
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../supervise/project/load.do?id="+row.id;
	options.urls = urls;
	parent.$.createDialog(options);
	parent.$.createDialog.open_grid = dataGrid;
}
