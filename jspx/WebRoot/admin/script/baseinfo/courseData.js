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
 * 打开修改数据窗口参数
 */
var loadOpt = {id:"d6",title:"上传课程资料",width:"620px",height:"450px",buttons:dbuttons};
//添加函数
function  addF(){
	var courseId=$("#courseId","#qform").val();
	var index=$("#index","#qform").val();
	var urls = "../baseinfo/courseData/add.do?courseId="+courseId+"&index="+index;
	loadOpt.urls=urls;
	parent.parent.$.createDialog(loadOpt);
	parent.parent.$.createDialog.open_grid = dataGrid; 
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var courseId=$("#courseId","#qform").val();
	var index=$("#index","#qform").val();
	var urls = "../baseinfo/courseData/load.do?id="+row.id+"&courseId="+courseId+"&index="+index;
	loadOpt.urls=urls;
	parent.parent.$.createDialog(loadOpt);
	parent.parent.$.createDialog.open_grid = dataGrid; 
}
