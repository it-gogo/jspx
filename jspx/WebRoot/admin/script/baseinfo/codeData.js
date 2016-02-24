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
var options = {id:"d3",urls:"../baseinfo/codeData/add.do",title:"字典数据编辑",width:"600px;",height:"500px;",buttons:dbuttons};
/**
 * 打开修改数据窗口参数
 */
var loadOpt = {id:"d3",title:"字典数据编辑",width:"500px;",height:"400px;",buttons:dbuttons};
//添加函数
function  addF(){
	var  node = $("#treeID").tree('getSelected');
	if(node==null){
		parent.$.messager.alert("提示窗口","请先选择类型。");
		return false;
	}else{
		options["urls"]="../baseinfo/codeData/add.do?id="+node.id
	}
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../baseinfo/codeData/load.do?id="+row.id;
	loadOpt.urls = urls;
	parent.$.createDialog(loadOpt);
	parent.$.createDialog.open_grid = dataGrid;
}
