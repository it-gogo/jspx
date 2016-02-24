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
var options = {id:"d3",urls:"../platform/userInfo/add.do",title:"用户编辑管理",width:"600px;",height:"500px;",buttons:dbuttons};
/**
 * 打开修改数据窗口参数
 */
var loadOpt = {id:"d3",title:"用户编辑管理",width:"500px;",height:"400px;",buttons:dbuttons};
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
	var urls = "../platform/userInfo/load.do?id="+row.id;
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
/*function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='associate("+json+")';>[关联绑定]</a> " +
     						"<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='loadF("+json+")';>[修 改]</a> "+
     						"<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='deleteF("+json+")';>[删 除]</a> ";
     if(row.ISACTIVES==1){
    	   handstr += "<a href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-edit' plain='true' onclick='changestat("+json+");'>[禁 用]</a>&nbsp;&nbsp;";
      }else{
    	   handstr += "<a href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-edit' plain='true' onclick='changestat("+json+");'>[启 用]</a>&nbsp;&nbsp;";
      }
     return  handstr;
}*/