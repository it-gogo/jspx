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
var options = {id:"d3",urls:"../baseinfo/homework/add.do",title:"新增作业上传",width:"650px;",height:"450px;",buttons:dbuttons};
/**
 * 打开修改数据窗口参数
 */
var loadOpt = {id:"d3",title:"上传作业编辑",width:"650px;",height:"450px;",buttons:dbuttons};
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
	var urls = "../baseinfo/homework/add.do?id="+row.id;
	loadOpt.urls = urls;
	parent.$.createDialog(loadOpt);
}
