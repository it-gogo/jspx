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
var options = {id:"d3",urls:"../platform/role/add.do",title:"角色编辑管理",width:"600px;",height:"500px;",buttons:dbuttons};
/**
 * 打开修改数据窗口参数
 */
var loadOpt = {id:"d3",title:"角色编辑管理",width:"500px;",height:"400px;",buttons:dbuttons};
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
	var urls = "../platform/role/load.do?id="+row.id;
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
     var  handstr = "<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='bindMenu("+json+")';>[绑定模块]</a> " +
     							"<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='bindUser("+json+")';>[绑定用户]</a> "+
     						"<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='loadF("+json+")';>[修 改]</a> ";
     if(row.status=="启用"){
  	   handstr += "<a href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-edit' plain='true' onclick='changeStatus("+json+");'>[禁 用]</a>&nbsp;&nbsp;";
    }else{
  	   handstr += "<a href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-edit' plain='true' onclick='changeStatus("+json+");'>[启 用]</a>&nbsp;&nbsp;";
    }
     return  handstr;
}
/**
 * 绑定模块
 * @param row
 */
function bindMenu(row){
	var option = {id:"d3",urls:"../platform/role/bindMenu.do?roleId="+row.id,title:"绑定菜单管理",width:"300px;",height:"500px;",buttons:dbuttons};
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(option);
}
/**
 * 绑定模块
 * @param row
 */
function bindUser(row){
	var option = {id:"d3",urls:"../platform/role/bindUser.do?roleId="+row.id,title:"绑定用户管理",width:"500px;",height:"500px;",buttons:dbuttons};
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(option);
}