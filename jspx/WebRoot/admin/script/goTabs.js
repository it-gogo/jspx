var tabsIndex=0;
var bxunTabs = {
   addTab:function(id,title,url,picUrl){
	   var iconImg="<img id='"+id+"' src='"+picUrl+"' style='position: relative;top:20%;right:5px;border:0px;' width='18px;' height='18px;'>";
	   title=iconImg+title;
		if ($('#main').tabs('exists', title)){
			$('#main').tabs('select', title);
			 var currTab = $('#main').tabs('getTab', title),  
             iframe = $(currTab.panel('options').content),  
             content = '<iframe scrolling="auto" frameborder="0"  src="' + iframe.attr('src') + '" style="width:100%;height:100%;"></iframe>';  
			 $('#main').tabs('updateIframeTab', {tab: currTab, options: {content: content, closable: true},which:title}); 
		} else {
			$("#main").tabs('addIframeTab',{
				tab:{
					id:"tabs_"+tabsIndex,
					title:title,
					content:'<iframe  scrolling="auto" frameborder="0"   src="'+url+'" style="width:100%;height:100%;" ></iframe>',
					closable: true,
					border:false,
					fit:true
                },
				iframe:{src:url}
			});
		}
		tabsIndex++;
	},
	
	addTabNoClose:function(title,url){
		$("#main").tabs('addIframeTab',{
			tab:{
				id:"tabs_"+tabsIndex,
				title:title,
				content:'<iframe  scrolling="auto" frameborder="0"   src="'+url+'" style="width:100%;height:100%;" ></iframe>',
				closable: false,
				border:false,
				fit:true
            },
			iframe:{src:url}
		});
	}
	
};

