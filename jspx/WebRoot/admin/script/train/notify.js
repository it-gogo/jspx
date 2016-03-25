var dbuttons = [{ 
		text:'保 存',
		iconCls:'icon-ok',
		id:'sbutton'
	},'-',{
		text:'关 闭',
		iconCls:'icon-cancel',
		id:'cbutton'
	}];
/**
 * 打开添加数据窗口参数
 */
var options = {id:"d3",title:"通知编辑",width:"100%",height:"100%",toolbar:dbuttons};
//添加函数
function  addF(){
	var urls = "../train/noticeManagement/addOA.do";
	options.urls = urls;
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../train/noticeManagement/loadOA.do?id="+row.id;
	options.urls = urls;
	parent.$.createDialog(options);
	parent.$.createDialog.open_grid = dataGrid;
}
/**
 * 查看
 * @param row
 */
function  look(row){
	var parameter = {id:"d3",title:"通知公告",width:"100%",height:"100%"};
	var urls = "../train/noticeManagement/look.do?id="+row.id;
	parameter.urls = urls;
	parent.$.createDialog(parameter);
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
     var  handstr ="<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-search'  plain='true'  onclick='look("+json+")';>查看</a> " +
     							"<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit'  plain='true'  onclick='loadF("+json+")';>修改</a> "+
     							"<a class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-cancel'  plain='true'   onclick='deleteF("+json+")';>删除</a> ";
     return  handstr;
}