/**
 * 打开添加数据窗口参数
 */
var options = {id:"d3",urls:"../baseinfo/accepte/accepte.do",title:"申请受理"};
/**
 * 打开修改数据窗口参数
 */
var loadOpt = {id:"d3",title:"查看学生"};
//申请学生
function  accepte(row){
	var urls = "../baseinfo/accepte/accepte.do?schoolId="+row.schoolId+"&classId="+row.classId;
	options.urls = urls;
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}
/**
 * 查看学生
 * @param row
 */
function  lookStudent(row){
	var urls = "../baseinfo/accepte/lookStudent.do?classId="+row.classId+"&schoolId="+row.schoolId;
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
function  accepteStr(value,row,index){
	  var json = $.toJSON(row);
     var  handstr = "<a href='javascript:void(0)'  iconCls='icon-ok'  onclick='accepted("+json+")';>通过</a> "+
     							"<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='unAcepted("+json+")';>不通过</a> ";
     return  handstr;
}

/**
 * 不通过
 */
function unAcepted(row){
	 var id = [];
	 id.push(row.id);
	 parent.$.messager.prompt('确定是否审核当前记录','确定请输入不通过的原因',function(msg){	
		 if(msg==undefined){
		 		return;
		 	}
		 	parent.$.messager.progress({
				title : '提示',
				text : '数据处理中，请稍后....'
			});
			$.post('accepted.do',{id:id.join(','),status:'3',reason:msg}, function(result) {
				if (result.message) {
					parent.$.messager.alert('提示', result.message, 'info');
					dataGrid.datagrid('reload');
				}else if(result.other){
					//做其他回调函数
				}
				parent.$.messager.progress('close');
				
			}, 'JSON');	
	 });
}


function unAceptedList(){
	var id=[];
	  id.push(getCheckeds1("grid","id"));
	  if(id==""){
		  parent.$.messager.alert('提示', "至少选择一条数据进行审核！", 'info');
		  return;
	  }
	 parent.$.messager.prompt('确定是否审核当前记录','确定请输入不通过的原因',function(msg){	
		 if(msg==undefined){
		 		return;
		 	}
		 	parent.$.messager.progress({
				title : '提示',
				text : '数据处理中，请稍后....'
			});
			$.post('accepted.do',{id:id.join(','),status:'3',reason:msg}, function(result) {
				if (result.message) {
					parent.$.messager.alert('提示', result.message, 'info');
					dataGrid.datagrid('reload');
				}else if(result.other){
					//做其他回调函数
				}
				parent.$.messager.progress('close');
				
			}, 'JSON');	
	 });
}


/**
 * 通过单条数据
 * @param row
 */
function accepted(row){
	  var id = [];
	  id.push(row.id);
	  parent.$.messager.confirm('询问', '您是否要审核当前记录？', function(b) {
			if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('accepted.do',{id:id.join(','),status:'2'}, function(result) {
						if (result.message) {
							parent.$.messager.alert('提示', result.message, 'info');
							dataGrid.datagrid('reload');
						}else if(result.other){
							//做其他回调函数
						}
						parent.$.messager.progress('close');
					}, 'JSON');
				}
			
		});
}


/**zhangjf 2015-08-31 处理通过受理**/
function acceptedList(){
	 var id=[];
	  id.push(getCheckeds1("grid","id"));
	  if(id==""){
		  parent.$.messager.alert('提示', "至少选择一条数据进行审核！", 'info');
		  return;
	  }
	  parent.$.messager.confirm('询问', '您是否要审核当前记录？', function(b) {
			if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('accepted.do', {
						id : id.join(','),
						status:'2'
					}, function(result) {
						if (result.message) {
							parent.$.messager.alert('提示', result.message, 'info');
							dataGrid.datagrid('reload');
						}else if(result.other){
							//做其他回调函数
						}
						parent.$.messager.progress('close');
					}, 'JSON');
				}
			
		});
}



