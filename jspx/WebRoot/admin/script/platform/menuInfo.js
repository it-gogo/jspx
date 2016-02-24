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
var options = {id:"d3",urls:"../platform/menuInfo/add.do",title:"菜单编辑管理",width:"600px;",height:"500px;",buttons:dbuttons};
/**
 * 打开修改数据窗口参数
 */
var loadOpt = {id:"d3",title:"菜单编辑管理",width:"600px;",height:"500px;",buttons:dbuttons};
//添加函数
function  addF(){
	var  node = $("#treeID").tree('getSelected');
	if(node!=null){
		options["urls"]="../platform/menuInfo/add.do?id="+node.id
	}
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../platform/menuInfo/load.do?id="+row.id;
	loadOpt.urls = urls;
	parent.$.createDialog(loadOpt);
	parent.$.createDialog.open_grid = dataGrid;
}
