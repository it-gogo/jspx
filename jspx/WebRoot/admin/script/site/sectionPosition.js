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
var options = {id:"d3",title:"栏目位置编辑",width:"600px;",height:"500px;",buttons:dbuttons};
//添加函数
function  addF(){
	var urls = "../site/sectionPosition/add.do";
	options.urls = urls;
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../site/sectionPosition/load.do?id="+row.id;
	options.urls = urls;
	parent.$.createDialog(options);
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
     var  handstr = "<a class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true'   onclick='loadF("+json+")';>修 改</a> "+
     						"<a class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-cancel' plain='true'  onclick='deleteF("+json+")';>删 除</a> ";
     return  handstr;
}