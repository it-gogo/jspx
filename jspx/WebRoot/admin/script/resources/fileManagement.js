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
var options = {id:"d3",title:"文件管理编辑",width:"650px;",height:"500px;",buttons:dbuttons};
//添加函数
function  addF(){
	var topFileId=$("#topFileId").val();
	var parentId=$("#parentId").val();
	var urls = "../resources/fileManagement/add.do?topFileId="+topFileId+"&parentId="+parentId;
	options.urls = urls;
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
}

//共享
function share(){
	var dbuttons = [{ 
		text:'保 存',
		iconCls:'icon-ok',
		id:'sbutton'
	},'-',{
		text:'关 闭',
		iconCls:'icon-cancel',
		id:'cbutton'
	}];
	var topFileId=$("#topFileId").val();
	var parentId=$("#parentId").val();
	var parentName=$("#parentName").val();
	var options = {id:"d3",title:parentName+"文件共享",width:"100%",height:"100%",toolbar:dbuttons};
	var urls = "../resources/fileManagement/share.do?parentId="+parentId+"&topFileId="+topFileId;
	options.urls = urls;
	parent.$.createDialog(options);
	parent.$.createDialog.open_grid = dataGrid;
}
/**
 * 导出数据
 * @param row
 */
function  loadF(row){
	var urls = "../resources/fileManagement/load.do?id="+row.id;
	options.urls = urls;
	parent.$.createDialog(options);
	parent.$.createDialog.open_grid = dataGrid;
}

/**
 * 跳转到文件上传页面
 * @param row
 */
function uploadF(row){
	var options = {id:"d3",title:"文件上传",width:"800px;",height:"600px;"};
	var topFileId=$("#topFileId").val();
	var parentId=$("#parentId").val();
	var urls = "../resources/fileManagement/toUpload.do?topFileId="+topFileId+"&parentId="+parentId;
	options.urls = urls;
	parent.$.createDialog(options);
	parent.$.createDialog.open_grid = dataGrid;
}

/**
 * 服务器导入页面
 * @param row
 */
function importF(row){
	var options = {id:"d3",title:"服务器导入",width:"800px;",height:"450px;"};
	var topFileId=$("#topFileId").val();
	var parentId=$("#parentId").val();
	var urls = "../resources/fileManagement/toImport.do?topFileId="+topFileId+"&parentId="+parentId;
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
     if(row.type=="文件夹"){
    	 handstr += "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit'  plain='true'  onclick='loadF("+json+")';>修改</a> &nbsp;&nbsp;";
     }
    // handstr += "<a class=\"grid_button\" href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-ok' plain='true' onclick='remark("+json+");'>备注</a>&nbsp;&nbsp;";
     /* if(row.status=="启用"){
    	   handstr += "<a class=\"grid_button\"  href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-clear' plain='true' onclick='changeStatus("+json+");'>禁用</a>&nbsp;&nbsp;";
      }else{
    	   handstr += "<a class=\"grid_button\" href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-ok' plain='true' onclick='changeStatus("+json+");'>启用</a>&nbsp;&nbsp;";
      }*/
     return  handstr;
}
/**
 * 重命名
 * @param row
 */
function rename(row){
	
}
/**
 * 备注
 * @param row
 */
function remark(row){
	
}
/**
 * 操作名称
 * @param value
 * @param row
 * @param index
 * @returns {String}
 */
function  showName(value,row,index){
	 var json = $.toJSON(row);
	 if(json=="{}"){
		 return "";
	 }
	 var handstr = "";
	 if(row.type=="文件夹"){
		 handstr = "<a  href='javascript:void(0)'  onclick='go("+json+");'><span class=\"tree-icon tree-folder  tree-folder-open\"></span> "+value+"</a>";
	 }else if(row.suffix.toLowerCase()==".txt"){
		 handstr = "<span class=\"tree-folder icon-txt\"> </span> "+value+"<a  href='javascript:void(0)'  onclick='downLoad_("+json+");'>下载</a>";
	 }else if(row.suffix.toLowerCase()==".doc"){
		 handstr = "<span class=\"tree-folder icon-doc\"> </span> <a  href='javascript:void(0)'  onclick='lookWord("+json+");'>"+value+"</a><a  href='javascript:void(0)'  onclick='downLoad_("+json+");'>下载</a>";
	 }else if(row.suffix.toLowerCase()==".jpg" || row.suffix.toLowerCase()==".png" || row.suffix.toLowerCase()==".jpeg" || row.suffix.toLowerCase()==".gif" || row.suffix.toLowerCase()==".bmp"){
		 handstr = "<span class=\"tree-folder icon-jpg\"> </span> <a  href='javascript:void(0)'  onclick='lookImg("+json+");'>"+value+"</a> <a  href='javascript:void(0)'  onclick='downLoad_("+json+");'>下载</a>";
	 }else if(row.suffix.toLowerCase()==".xls"){
		 handstr = "<span class=\"tree-folder icon-jpg\"> </span> <a  href='javascript:void(0)'  onclick='lookExcel("+json+");'>"+value+"</a> <a  href='javascript:void(0)'  onclick='downLoad_("+json+");'>下载</a>";
	 }else{
		// handstr=value;
		 handstr = value+"<a  href='javascript:void(0)'  onclick='downLoad_("+json+");'>下载</a>";
	 }
     return  handstr;
}
/**
 * 查看图片
 */
function lookImg(row){
	var options = {id:"d3",title:"查看图片",width:"80%",height:"70%"};
	var urls ="../common/lookImg.do?id="+row.id
	//options.urls = urls;
	options.content="<img style=\"display:block; margin:0px auto;\"  src=\"../resources/fileManagement/lookImg.do?id="+row.id+"\"/>";
	parent.$.createDialog(options);
}
/**
 * 查看Excel文件
 */
function lookExcel(row){
	var options = {id:"d3",title:"查看Excel文件",width:"80%",height:"70%"};
	var urls ="../resources/fileManagement/lookExcel.do?id="+row.id
	options.urls = urls;
	//options.content="<img style=\"display:block; margin:0px auto;\"  src=\"../common/lookImg.do?id="+row.id+"\"/>";
	parent.$.createDialog(options);
}
/**
 * 查看Word文件
 */
function lookWord(row){
	$.ajax({
		url:"lookWord.do",
		data:"id="+row.id,
		success:function(data){
			var json=eval("("+data+")");
			if(json.message){
				var options = {id:"d3",title:"查看Word文件",width:"80%",height:"70%"};
				var urls ="../"+json.message
				options.urls = urls;
				parent.$.createDialog(options);
			}
		}
	});
}

function  showLocation(value,row,index){
	 var json = $.toJSON(row);
	 var handstr = "";
	 if(row.location==null||row.location==''){
		 handstr = "部门文件夹";
	 }else{
		 handstr=row.location;
	 }
    return  handstr;
}
/**
 * 回收站删除
 * */
function remove_(){
	  var id=[];
	  id.push(getCheckeds1("grid","id"));
	  if(id==""){
		  parent.$.messager.alert('提示', "至少选择一条数据删除！", 'info');
		  return;
	  }
	  parent.$.messager.confirm('询问', '您是否要删除当前记录？', function(b) {
			if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('delete.do', {
						id : id.join(',')
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

/**回收站数据还原**/
function reduction(){
	  var id=[];
	  id.push(getCheckeds1("grid","id"));
	  if(id==""){
		  parent.$.messager.alert('提示', "至少选择一条数据还原！", 'info');
		  return;
	  }
	  parent.$.messager.confirm('询问', '您是否要还原当前记录？', function(b) {
			if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('reduction.do', {
						id : id.join(',')
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
/**
 * 回收站内容清空
 */
function removeAll(){
	 parent.$.messager.confirm('询问', '您确定要清空当前回收站吗？', function(b) {
			if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('removeAll.do',  function(result) {
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
//定位
function position(parentId,parentName,folderId,obj){
	$(obj).nextAll().remove();
	$(obj).remove();
	$(".dqwz").html(parentName);
	
	$("#parentId").val(parentId);
	$("#parentName").val(parentName);
	$("#folderId").val(folderId);
	
	var  parameter = {};
	parameter["parentId"]=parentId;
	$("#grid").datagrid('load',parameter);
	
	//选择树
	var node=$("#treeID").tree("find",parentId);
	if(node!=null){
		$("#treeID").tree("collapseAll");//关闭节点
		$("#treeID").tree("expandTo",node.target);//打开节点
		
		$("#treeID").tree("expand",node.target);
		$("#treeID").tree("select",node.target);
	}
}

function go(row){
	var parentId_old=$("#parentId").val();
	var parentName_old=$("#parentName").val();
	var folderId_old=$("#folderId").val();
	var html="<a  href=\"javascript:void(0);\" onclick=\"position('"+parentId_old+"','"+parentName_old+"','"+folderId_old+"',this)\" >"+parentName_old+"  >  </a>";
	$(".dqwz_a").append(html);
	$(".dqwz").html(row.name);
	
	
	$("#parentId").val(row.id);
	$("#parentName").val(row.name);
	$("#folderId").val(row.parentId);
	
	var  parameter = {};
	parameter["parentId"]=row.id;
	$("#grid").datagrid('load',parameter);
	
	//选择树
	var node=$("#treeID").tree("find",row.id);
	if(node!=null){
		$("#treeID").tree("collapseAll");//关闭节点
		$("#treeID").tree("expandTo",node.target);//打开节点
		
		$("#treeID").tree("expand",node.target);
		$("#treeID").tree("select",node.target);
	}
}

/**文件下载功能**/
function downLoad_(row){
	window.open("download.do?id="+row.id);
}

/**照片查看**/
function look_(row){
	alert('图片查看功能开发中....');
}
/**文档预览功能**/
function show(row){
	alert("预览功能开发中。。。");
}


