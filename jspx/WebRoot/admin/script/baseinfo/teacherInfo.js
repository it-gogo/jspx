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
var options = {id:"d3",urls:"../baseinfo/teacherInfo/add.do",title:"老师信息编辑",width:"600px;",height:"620px;",buttons:dbuttons};
/**
 * 打开修改数据窗口参数
 */
var loadOpt = {id:"d3",title:"老师信息编辑",width:"600px;",height:"620px;",buttons:dbuttons};
//添加函数
function  addF(){
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../baseinfo/teacherInfo/load.do?id="+row.id;
	loadOpt.urls = urls;
	parent.$.createDialog(loadOpt);
	parent.$.createDialog.open_grid = dataGrid;
}
