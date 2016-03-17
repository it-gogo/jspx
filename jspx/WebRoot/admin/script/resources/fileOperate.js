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
var options = {id:"d3",title:"文件上传",width:"600px;",height:"500px;",buttons:dbuttons};
//添加函数
function  addF(){
	var urls = "../resources/fileSubmit/add.do";
	options.urls = urls;
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 导出数据
 * @param row
 */
function  look(id){
	var urls = "../resources/fileOperate/load.do?submitId="+id;
	options.urls = urls;
	parent.$.createDialog(options);
	parent.$.createDialog.open_grid = dataGrid;
}
//下载文件
function download1(row){
	window.open("../../common/downloadData.do?fileName="+row.title+"&fileUrl="+row.accessoryUrl);
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
     var  handstr = "<a class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-search'  plain='true'   onclick='look(\""+row.id+"\")';>查看</a>"
     +"<a class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-filter'  plain='true'   onclick='download1("+json+")';>下载</a> ";
     return  handstr;
}