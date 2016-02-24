/**
 * 初始化表单
 */
$.initForm = function(options){
	var urls = options.urls;
	//提交的表单ID
	var formID = options.formID;
	//对话框ID
	var dialogID = options.dialogID;
	
	
	$("#dform").form({
		url:urls,
		ajax:true,
		//提交函数
		onSubmit:function(){
			parent.$.messager.progress({
				title : '提示',
				text : '数据提交中，请稍后....'
			});
			var isValid = $(this).form('validate');
			
			if (!isValid) {
				parent.$.messager.progress('close');
				alert("请检查录入信息是否正确");
			//	alert();
			}
			if(isValid && typeof(beforeSubmit)=='function'){
				isValid=beforeSubmit(formID);
				if(!isValid){
					parent.$.messager.progress('close');
				}
        	}
			return isValid;
		},
		//保存成功后
		success:function(data){
			parent.$.messager.progress('close');
			var json = $.parseJSON(data);
			if(json.message){
				
				parent.$.messager.alert("提示窗口",json.message);
				//关闭对话框
				/**
				*自定义刷新列表
				*/
				if(typeof(customRefresh)=="function"){
					customRefresh();
				}else{
					//刷新表格
					if(parent.dialogMap["d3"]!=undefined&&parent.dialogMap["d3"]!=null){
						parent.$.createDialog.open_grid.datagrid('reload');
						parent.dialogMap["d3"].dialog('close');
					}
				}
				if(typeof(succCall)=='function'){
					succCall(data);
				}
				
			}else if(json.unvail){
				alert(json.unvail);
				window.top.location.href="../../common/loginPage.do";
			}else{
				if(json.error){
					parent.$.messager.alert("提示窗口",json.error);
				}
				if(typeof(succCall)=='function'){
					succCall(data);
				}			
			}
		}
	});
};




/**
 * 设置表单信息
 */
$.setForm = function(json,formID){
	var  formOBJ = $("#"+formID);
	$(formOBJ).form("reset");
	$("input,select",formOBJ).each(function(i){
		var id = $(this).attr("id");
		var t = this.type;
		if(t == 'text' || t == 'hidden' || t == 'password'){
			if(id!=''&&id!=null&&id!='undefined'&&
			   json[id]!=null&&json[id]!='undefined'){
			   if($(this).hasClass("easyui-validatebox")){
			         $(this).val(json[id]);
			   }else if($(this).hasClass("easyui-numberbox")){
				     $(this).numberbox("setValue",json[id]);
			   }else if($(this).hasClass("easyui-datebox")){
				     $(this).datebox("setValue",json[id]);
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
		}else if(t=='checkbox'){
			
		}
	});
};




