/**

 * IFRAME内存回收
 */
$.extend($.fn.panel.defaults, {
	onBeforeDestroy : function() {
		var frame = $('iframe', this);
		try {
			if (frame.length > 0) {
				for (var i = 0; i < frame.length; i++) {
					frame[i].src = '';
					frame[i].contentWindow.document.write('');
					frame[i].contentWindow.close();
				}
				frame.remove();
				if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
					try {
						CollectGarbage();
					} catch (e) {
					}
				}
			}
		} catch (e) {
		}
	}
});


/**
 * 对话框IFRAME内存回收
 */
$.extend($.fn.dialog.defaults, {
	onBeforeDestroy : function() {
		//alert();
		var frame = $('iframe', this);
		try {
			//alert(frame.length);
			if (frame.length > 0) {
				for (var i = 0; i < frame.length; i++) {
					frame[i].src = '';
					frame[i].contentWindow.document.write('');
					frame[i].contentWindow.close();
				}
				frame.remove();
				//alert(navigator.userAgent);
				if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
					try {
						//alert("hsnc");
						CollectGarbage();
					} catch (e) {
					}
				}
			}
		} catch (e) {
		}
	}
});



//设置默认validatebox
$.extend($.fn.validatebox.defaults, {
	tipOptions: {    // the options to create tooltip
        showEvent: 'mouseenter',
        hideEvent: 'mouseleave',
        showDelay: 100,
        hideDelay: 0,
        zIndex: '',
        onShow: function(){
            if (!$(this).hasClass('validatebox-invalid')){
                if ($(this).tooltip('options').prompt){
                    $(this).tooltip('update', $(this).tooltip('options').prompt);
                } else {
                    $(this).tooltip('tip').hide();
                }
            } else {
                $(this).tooltip('tip').css({
                    color: '#000',
                    borderColor: '#CC9933',
                    backgroundColor: '#FFFFCC'
                });
            }
        },
        onHide: function(){
            if (!$(this).tooltip('options').prompt){
                $(this).tooltip('destroy');
            }
        }
    }

});


//扩展验证
$.extend($.fn.numberbox.defaults.rules,{
	 mobile: {// 验证手机号码  
         validator: function (value) {  
             return /^(13|15|18)\d{9}$/i.test(value);  
         },  
         message: '手机号码格式不正确'  
     }
	
});

/**
 * 获得表格前多选框信息
 * @param gridID
 * @param colval
 * @returns {String}
 */
function  getCheckeds1(gridID,colval){
    var  r = $("#"+gridID).datagrid('getChecked');
    var  sns = "";
    for(var i=0;i<r.length;i++){
       sns += r[i][colval]+",";
    }
    if(sns.length!=0){
       sns = sns.substring(0,sns.length-1);
    }
    return sns;
}
function  getCheckeds(gridID){
    var  r = $("#"+gridID).find("input[type='checkbox']");
    alert(r.size())
    var  sns = "";
    for(var i=0;i<r.size();i++){
       sns += r.eq(i).attr("ID")+",";
    }
    if(sns.length!=0){
       sns = sns.substring(0,sns.length-1);
    }
    return sns;
}
function getChecked(treeID){
    var nodes = $('#'+treeID).tree('getChecked');
    var s = '';
    for(var i=0; i<nodes.length; i++){
        if (s != '') s += ',';
        s += nodes[i].id;
    }
    return s;
}
/**
 * 添加数据函数
 */
function  addF(){
	parent.$.createDialog.open_grid = dataGrid;
	parent.$.createDialog(options);
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
     var  handstr = "<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='loadF("+json+")';>[修 改]</a> "+
     							"<a href='javascript:void(0)'  iconCls='icon-edit'  onclick='deleteF("+json+")';>[删 除]</a> ";
     if(row.isActives==1){
    	   handstr += "<a href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-edit' plain='true' onclick='changestat("+json+");'>[禁 用]</a>&nbsp;&nbsp;";
      }else{
    	   handstr += "<a href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-edit' plain='true' onclick='changestat("+json+");'>[启 用]</a>&nbsp;&nbsp;";
      }
     return  handstr;
}
/**
 * 操作状态
 * @param value
 * @param row
 * @param index
 * @returns {String}
 */
function  handlerisactives(value,row,index){
     if(row.isActives==1){
    	   handstr = "启 用";
      }else{
    	   handstr = "禁 用";
      }
     return  handstr;
}
/**
 * 删除单条数据
 * @param row
 */
function deleteF(row){
	  var id = [];
	  id.push(row.id);
	  parent.$.messager.confirm('询问', '您是否要删除当前记录？', function(b) {
			if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('delete.do',{id:id.join(',')}, function(result) {
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
 * 批量删除数据
 */
function deleteAllF(){
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
/**
 * 更新数据状态（启用，禁用功能）
 * @param row
 */
function changestat(row){
	  $.post('changestat.do', {
			id : row.id,isActives : row.isActives
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