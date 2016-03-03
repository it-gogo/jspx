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
var options = {id:"d3",width:"600px;",height:"500px;",buttons:dbuttons};
/**
 * 打开修改数据窗口参数
 */
var loadOpt = {id:"d3",title:"单位组织编辑",width:"600px;",height:"500px;",buttons:dbuttons};
//添加函数
function  addF(){
	var  node = $("#treeID").tree('getSelected');
	if(node!=null && typeof(node.isEdb)=="undefined"){//添加学校
		if($('#treeID').tree('isLeaf',node.target)){//最后节点
			var pnode=$('#treeID').tree('getParent',node.target);
			var ppnode=$('#treeID').tree('getParent',pnode.target);
			var typeId=node.id;
			var categoryId=pnode.id;
			var pid=ppnode.id;
			options["urls"]="../baseinfo/unitInfo/addSchool.do?pid="+pid+"&typeId="+typeId+"&categoryId="+categoryId;
			options["title"]="学校信息编辑";
		}else{
			parent.$.messager.alert("提示窗口","添加学校必须选择子节点。");
			return false;
		}
	}else{
		options["urls"]="../baseinfo/unitInfo/add.do";
		options["title"]="单位组织编辑";
	}
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../baseinfo/unitInfo/load.do?id="+row.id;
	loadOpt.urls = urls;
	parent.$.createDialog(loadOpt);
	parent.$.createDialog.open_grid = dataGrid;
}

/**
 * 操作信息
 * @param value
 * @param row
 * @param index
 * @returns {String}
 */
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-reload'  plain='true' onclick='modifyPassword("+json+")';>密码重置</a> " +
     						"<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='loadF("+json+")';>修 改</a> ";
     return  handstr;
}

function  modifyPassword(row){
	var optionsPassword = {id:"d3",urls:"../platform/userInfo/toModifyPW.do?id="+row.userId,title:"密码重置",width:"400px;",height:"300px;",buttons:dbuttons};
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(optionsPassword);
}