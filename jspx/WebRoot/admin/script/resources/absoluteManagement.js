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
var options = {id:"d3",title:"路径编辑",width:"600px;",height:"500px;",buttons:dbuttons};
//添加函数
function  addF(){
	var urls = "../resources/absoluteManagement/add.do";
	options.urls = urls;
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../resources/absoluteManagement/load.do?id="+row.id;
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
     var  handstr = "";
      if(row.status=="启用"){
    	   handstr += "<a class=\"grid_button\"  href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-clear' plain='true' onclick='changestatus("+json+");'>禁用</a>&nbsp;&nbsp;";
      }else{
    	   handstr += "<a class=\"grid_button\" href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-ok' plain='true' onclick='changestatus("+json+");'>启用</a>&nbsp;&nbsp;";
      }
     return  handstr;
}