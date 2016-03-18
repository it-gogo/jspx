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
var options = {id:"d3",title:"主题模板编辑",width:"600px;",height:"300px;",buttons:dbuttons};
//添加函数
function  addF(){
	var urls = "../resources/themeTemplate/add.do";
	options.urls = urls;
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../resources/themeTemplate/load.do?id="+row.id;
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
     var  handstr = "<a class=\"grid_button\"  href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-edit' plain='true' onclick='loadF("+json+");'>修改</a>" +
     		"<a class=\"grid_button\"  href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-add' plain='true' onclick='directory("+json+");'>目录结构</a>";
     /* if(row.status=="启用"){
    	   handstr += "<a class=\"grid_button\"  href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-clear' plain='true' onclick='changeStatus("+json+");'>禁用</a>&nbsp;&nbsp;";
      }else{
    	   handstr += "<a class=\"grid_button\" href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-ok' plain='true' onclick='changeStatus("+json+");'>启用</a>&nbsp;&nbsp;";
      }*/
     return  handstr;
}
/**
 * 打开目录
 * @param row
 */
function directory(row){
	var options = {id:"d4",title:"目录结构",width:"900px;",height:"700px;"};
	var urls = "../resources/themeDirectory/redirect.do?topFileId="+row.id;
	options.urls = urls;
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}