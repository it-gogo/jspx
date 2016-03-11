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
var options = {id:"d3",title:"查看操作",width:"1500px",height:"800px;"};
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../supervise/superviseLook/load.do?id="+row.id+"&unitId="+row.unitId+"&step="+row.step;
	options.urls = urls;
	parent.$.createDialog(options);
	parent.$.createDialog.open_grid = dataGrid;
}
