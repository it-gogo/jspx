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
var options = {id:"d3",title:"图片链接编辑",width:"630px;",height:"500px;",buttons:dbuttons};
//添加函数
function  addF(){
	var urls = "../site/picLink/add.do";
	options.urls = urls;
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../site/picLink/load.do?id="+row.id;
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
     var  handstr ="<a class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true'  onclick='loadF("+json+")';>修改</a> "+
     				"<a class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-cancel' plain='true'    onclick='deleteF("+json+")';>删除</a> ";
     if(row.status=='启用'){
    	   handstr += "<a class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-clear' plain='true'   onclick='changestatus("+json+");'>禁用</a>";
      }else{
    	   handstr += "<a class=\"grid_button\" href='javascript:void(0)' class='easyui-ok' iconCls='icon-edit' plain='true' onclick='changestatus("+json+");'>启用</a>";
      }
     return  handstr;
}

	


function handlerstatus(value,row,index){
	if(value=='启用'){
		return "<span style='color:green;'>"+value+"</span>";
	}else if(value=="禁用"){
		return "<span style='color:red;'>"+value+"</span>";
	}else{
		return "";
	}
}
