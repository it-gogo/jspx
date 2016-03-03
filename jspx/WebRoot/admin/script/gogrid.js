/**
 * 表格信息
 */
var pageList = [2,5,7,20,100,120,150,200];

 
//初始化普通表格
$.initBasicGrid=function(options){
	 var gridoption={fit:true,
			         border:false,
			         fitColumns:true,
			         singleSelect: true,
			         selectOnCheck:false,
			         multiSort:false,
			         checkOnSelect:false,
			         remoteSort:true,
			         autoRowHeight:false,
			         rownumbers:true,
			         showHeader:true,
			         
			         loadFilter:function(data){
			             if(data.unvail){
			            	     alert(data.unvail);
				        		 window.top.location.href="../../common/loginPage.do";
				        		 return {total:0,rows:[]};
			             }else{
			               return  data;
			             }
			         },
			         onLoadSuccess:function(data){  
	 					if(typeof(loadSuccess)=="function"){
	 						loadSuccess(data);
	 					}
			             $('.grid_button').linkbutton();  
			         } 
			        	 
			        	
			        
			         
	 };
	 var ispage = options.pagination;
	 if(ispage){
		 gridoption.pageSize=20;
		 gridoption.pageList=pageList;
	 }
	 gridoption = $.extend(gridoption,options);
	 var gid = gridoption.id;
	 return  $("#"+gid).datagrid(gridoption);
};



//初始化表格树
$.initTreeGrid=function(options){
	 var gridoption={fit:true,border:false,line:true};
	 gridoption = $.extend(gridoption,options);
	 var gid = gridoption.id;
	 $("#"+gid).treegrid(gridoption);
};

/**
 * 获取查询的条件
 */
$.getQueryParameter = function(formID){
	var  formOBJ = $("#"+formID);
	var  parameter = {};
	$("input,select",formOBJ).each(function(i){
		var id = $(this).attr("id");
		var t = this.type;
		if(t == 'text' || t == 'hidden' || t == 'password'){
			if(id!=''&&id!=null&&id!='undefined'){
			   if($(this).hasClass("easyui-validatebox")){
				  var val = $(this).val();
				  if(val!=null&&val!=''){
			         parameter[id] = $(this).val();
				  }
			   }else if($(this).hasClass("easyui-datebox")){
				   var val = $(this).datebox("getValue");
				   
					  if(val!=null&&val!=''){
				         parameter[id] = $(this).datebox("getValue");
					  }
			   }
			}
		}else if(t=='select-one'){
			if(id!=''&&id!=null&&id!='undefined'){
				if($(this).hasClass("easyui-combobox")){
				  var val = $(this).combobox("getValue");
				  if(val!=''&&val!=null&&val!='0'){
				    parameter[id] = val;
				  }
				}
			}
		}
	});
	return  parameter;
};

//$.extend($.fn.datagrid.defaults.editors,{    
//    text: {    
//        init: function(container, options){    
//            var input = $('<input type="text" class="datagrid-editable-input">').appendTo(container);    
//            return input;    
//        },    
//        getValue: function(target){    
//            return $(target).val();    
//        },    
//        setValue: function(target, value){    
//            $(target).val(value);    
//        },    
//        resize: function(target, width){    
//            var input = $(target);    
//            if ($.boxModel == true){    
//                input.width(width - (input.outerWidth() - input.width()));    
//            } else {    
//                input.width(width);    
//            }    
//        }    
//    }    
//});  

$.extend($.fn.datagrid.methods, {
    editCell: function(jq,param){
        return jq.each(function(){
        	var dg = $(this);
            var opts = dg.datagrid('options');
            var fields = dg.datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
            for(var i=0; i<fields.length; i++){
                var col = dg.datagrid('getColumnOption', fields[i]);
                col.editor1 = col.editor;
                
                //alert(param.field+","+fields[i]+(fields[i] == param.field));
                if (fields[i] != param.field){
                    col.editor = null;
                }
            }
            //alert("进入编辑："+param.index);
            //alert(dg);
            dg.datagrid('beginEdit',param.index);
            var ed = dg.datagrid('getEditor', param);
            //alert("param,"+$.toJSON(param));
            if (ed){
                if ($(ed.target).hasClass('textbox-f')){
                    $(ed.target).textbox('textbox').focus();
                } else {
                    $(ed.target).focus();
                }
               
            }
            for(var i=0; i<fields.length; i++){
                var col = $(this).datagrid('getColumnOption', fields[i]);
                col.editor = col.editor1;
            }
           
        });
        
    },
    enableCellEditing: function(jq){
        return jq.each(function(){
            var dg = $(this);
            var opts = dg.datagrid('options');
            opts.oldOnClickCell = opts.onClickCell;
            opts.onClickCell = function(index, field){
            	//alert("点击:"+opts.editIndex);
            	var row = dg.datagrid("getRows")[index];
            	if(row.FREE_ID=="T"){
            		return;
            	}
                if (opts.editIndex != undefined){
                    if (dg.datagrid('validateRow', opts.editIndex)){
                    	//alert(opts.editIndex);
                        dg.datagrid('endEdit', opts.editIndex);
                        opts.editIndex = undefined;
                        opts.field = undefined;
                    } else {
                    	//opts.editIndex = undefined;
                       // opts.field = undefined;
                        return;
                    }
                }
                opts.editIndex = index;
                opts.field = field;
                dg.datagrid('selectRow', index).datagrid('editCell', {
                    index: index,
                    field: field
                });
                //alert("点击1："+index+","+field);
                opts.oldOnClickCell.call(this, index, field);
            }
        });
    }
});

$.extend($.fn.datagrid.methods, {
    addEditor : function(jq, param) {
        if (param instanceof Array) {
            $.each(param, function(index, item) {
                var e = $(jq).datagrid('getColumnOption', item.field);
                e.editor = item.editor;
            });
        } else {
            var e = $(jq).datagrid('getColumnOption', param.field);
            e.editor = param.editor;
        }
    },
    removeEditor : function(jq, param) {
        if (param instanceof Array) {
            $.each(param, function(index, item) {
                var e = $(jq).datagrid('getColumnOption', item);
                e.editor = {};
            });
        } else {
            var e = $(jq).datagrid('getColumnOption', param);
            e.editor = {};
        }
    }
});
