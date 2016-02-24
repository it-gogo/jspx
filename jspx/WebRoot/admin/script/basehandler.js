/**
 * 基本增删改查操作
 * **/

  $.queryF = function(formID){
			 var  parameter = $.getQueryParameter(formID);
			 //$("#btmenu-mcode_liker").val(11);
			 dataGrid.datagrid('load',parameter);
  };
		 
 //查询全部
 $.queryAllF = function(formID){
	 $("#"+formID).form('reset');
	 var  parameter = $.getQueryParameter(formID);
	 $("#grid").datagrid('load',parameter);
	 
 };
 
