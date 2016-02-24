/**
 * 初始化窗口
 */

	/**
	 * 打开DIALOG
	 * @param options
	 */
    $.createDialog = function(options){
    	//alert($.createDialog.handler)
//    	var $.createDialog.handler;
    	var ids = options.id;
//    	if ($.createDialog.handler == undefined){// 避免重复弹出
    	var width=options.width;
    	if(typeof(width)=="undefined" || width==""){
    		width="60%";
    	}
    	var height=options.height;
    	if(typeof(height)=="undefined" || height==""){
    		height=550;
    	}
	    	var  doption = {width : width,
	    			        height : height,
	    			        modal:true,
	    			        onClose : function() {
	    			        	delete dialogMap[ids];
	    			        	$(this).dialog('destroy');
	    					}};
	    	doption = $.extend(doption,options);
	    	var idval = "uframe_"+ids;
	    	if (doption.urls){
	    		doption.content = '<iframe id="'+idval+'"  src="'+doption.urls+'"  scrolling="auto" width="100%" height="99%" frameBorder="0" ></iframe>';
	    	}
	    	
	    	return dialogMap[ids]=  $('<div id="'+ids+'"/>').dialog(doption);
    };
		
var  searchDialog = function(){
	var count = 0;
	for(var obj in gridMap){
		
		alert(obj+"--"+$(gridMap[obj]).html());
		count++;
	}
	alert(count);
}