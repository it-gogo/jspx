<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
  <head>
  	<%@include file="/WEB-INF/admin/common/head.jsp" %>
  	<link href="<%=request.getContextPath()%>/admin/menu_tree/css/default.css" rel="stylesheet" type="text/css" />
  	
  	<link href="<%=request.getContextPath()%>/admin/menu_tree/css/tree.css" rel="stylesheet" type="text/css" />
  	
  	 <!--[if IE 7]>
  	 <style type="text/css">
  	 .icon{display:inline-block;}
  	 </style>
  	 <![endif]-->
  	<script src="<%=request.getContextPath()%>/admin/menu_tree/js/jquery.tree.js" type="text/javascript"></script>
  	<style type="text/css">
  		
  		.logout{
  			<%-- background:url('<%=request.getContextPath()%>/admin/css/images/logout.png') no-repeat center center; --%>
  			display: block;
  			height: 60px;
  			width: 80px;
  			margin-right: 10px;
  			text-align: center;
  		}
  		.modifypw{
  			<%-- background:url('<%=request.getContextPath()%>/admin/css/images/modifypw.png') no-repeat center center; --%>
  			display: block;
  			height: 60px;
  			width: 80px;
  			margin-right: 10px;
  			text-align: center;
  		}
  		.notices{
  			<%-- background:url('<%=request.getContextPath()%>/admin/css/images/notice.png') no-repeat center center; --%>
  			display: block;
  			height: 60px;
  			width: 80px;
  			margin-right: 10px;
  			
  		}
  		.client{
  			<%-- background:url('<%=request.getContextPath()%>/admin/css/images/client.png') no-repeat center center; --%>
  			display: block;
  			height: 60px;
  			width: 80px;
  			margin-right: 10px;
  			text-align: center;
  			
  		}
  		.icon-logout{
  			<%-- background:url('<%=request.getContextPath()%>/admin/css/images/logout.png') no-repeat center center; --%>
  		}
  		.icon-modifypw{
  			<%-- background:url('<%=request.getContextPath()%>/admin/css/images/modifypw.png') no-repeat center center; --%>
  		}
  		.link_{
  			line-height: 60px;
  			font-size: 16px;
  			font-weight: bold;
  			color:#5ab8fd;
  		}
  		a:link{
			text-decoration:none;
			}
		a:visited{
		text-decoration:none;
		}
		a:hover{
		text-decoration:none;
		color: #084c8e;
		}
		a:active{
		text-decoration:none;
		}

  	</style>
  	<script type="text/javascript">
  	//js 获取当前时间
		function fnDate(){
		var showDate=document.getElementById("showDate");
		var date=new Date();
		var year=date.getFullYear();//当前年份
		var month=date.getMonth();//当前月份
		var data=date.getDate();//天
		var hours=date.getHours();//小时
		var minute=date.getMinutes();//分
		var second=date.getSeconds();//秒
		var time=year+"年"+fnW((month+1))+"月"+fnW(data)+"日 ";/* +fnW(hours)+"时"+fnW(minute)+"分"+fnW(second)+"秒" */
		showDate.innerHTML=""+time+"";
		}
		//补位 当某个字段不是两位数时补0
		function fnW(str){
		var num;
		str>=10?num=str:num="0"+str;
		return num;
		} 
		$(function(){
			setInterval(function(){ fnDate(); },0,1000);
			
			$("#welcome").tooltip({
				position : "bottom",
				content : "<a href=\"../\" class=\"client link_\"    >返回主页</a>"
					+"<a href=\"javascript:void(0);\" title=\"点击修改密码\" class=\"modifypw link_\"  onclick=\"modifypw()\"  >密码修改</a>"
					+"<a href=\"javascript:void(0);\" title=\"点击退出\" class=\"logout link_\"  onclick=\"loginOUT()\"  >退出系统</a>",
				onShow : function() {
					var t = $(this);
                    t.tooltip("tip").unbind().bind("mouseenter", function(){
                        t.tooltip("show");
                    }).bind("mouseleave", function(){
                        t.tooltip("hide");
                    });
                    $(this).tooltip("tip").css({            
                    	backgroundColor: "#ffffff",            
                    });
				}
			});
		});
  	</script>
  	
	<link rel="stylesheet" href="<%=request.getContextPath()%>/admin/new-css/shouye.css" type="text/css"></link>
</head>
  
  <body class="easyui-layout" >
      <div data-options="region:'north'" style="height:105px;border:0px;">
      	<c:choose>
	    	<c:when test="${webManagement!=null && webManagement.bLogo!=null }">
	       		<div style="width:100%;height:100%;position:relative;background:url(<%=request.getContextPath()%>/${webManagement.bLogo })  " >
	       	</c:when>
          		<c:otherwise>
          			<div class="top_1" style="width:100%;height:100%;position:relative;<%-- background:url(<%=request.getContextPath()%>/admin/css/images/maintop_1.jpg) --%> " >
          		</c:otherwise>
          	</c:choose>
	       
	          <div class="sy_bdl" id="sessionInfoDiv">
	          	<c:choose>
	          		<c:when test="${webManagement!=null && webManagement.hLogo!=null }">
	          			<img  src="<%=request.getContextPath()%>/${webManagement.hLogo}">
	          		</c:when>
	          		<c:otherwise>
				        <img  src="<%=request.getContextPath()%>/admin/css/images/mainlog_1.jpg">
	          		</c:otherwise>
	          	</c:choose>
	          </div>
	       	  <div class="top_nr">
<%-- 	       	  		<div class="top_tis"><img alt="" src="<%=request.getContextPath()%>../css/images/rentou_06.png">上午好！ 黄某某  2016-12-12  星期六  14：50 </div> --%>
	       	  		<div class="top_tis">
							<ul>
								<li>上午好！ ${user.userName }  <span id="showDate" style="font-size: 18px;"></span> 星期六  14：50</li>
							</ul>	       	  		
	       	  		</div>
	       	  		<div class="top_xinx">
<%-- 	       	  			<div class="top_xxk">
	       	  				<img alt="" src="<%=request.getContextPath()%>/admin/css/images/xinxi_08.png">
	       	  			</div> --%>
	       	  			<div class="top_hydr">
<%-- 						       	  欢迎您，张三老师<span class="top_img"><img alt="" src="<%=request.getContextPath()%>/admin/css/images/dr_xsj_03.png"></span> --%>
	       	  				<ul>
	       	  					<li><a href="#"   id="welcome" style="display: inline-block;height: 35px;line-height: 35px;" >欢迎您，${user.userName }！<span class="top_img"><img alt="" src="<%=request.getContextPath()%>/admin/css/images/dr_xsj_03.png"></a></li>
<%-- 	       	  					<li><a href="#"><img alt="" src="<%=request.getContextPath()%>/admin/css/images/dr_xsj_03.png"></a></li> --%>
	       	  				</ul>
	       	  			</div>	       	  			
	       	  		</div>
	       	  </div>
	          <%-- <div id="sessionInfoDiv" style="margin-top:10px; float:right;margin-right:25px;">
		         <a href="javascript:void(0);" title="点击退出" class="logout link_"  onclick="loginOUT()" style="float: right;">退出系统</a>
		         <a href="javascript:void(0);" class="firstLogin"  onclick="firstLogin()" style="display:none;" ></a>
		         <a href="javascript:void(0);" title="点击修改密码" class="modifypw link_"  onclick="modifypw()"  style="float: right;margin-right: 20px;">密码修改</a>
		         <!-- <a href="javascript:void(0);" class="notices link_"   style="float: right;margin-right: 20px;">消息提示</a> -->
		         <a href="../" class="client link_"   style="float: right;margin-right: 20px;">返回主页</a>
		        <h1 style="float: right;/* margin-right: 20px; */line-height: 40px;margin-right: 20px; font-size: 16px;font-weight: bold;" class="welcome"><span style="color:red;">${user.userName }</span>,欢迎您。
		        <!-- 当前时间：<span id="showTime" style=""></span> -->
		        </h1>
	          </div> --%>
	       </div>
      </div>
       <div data-options="region:'west'" split="true" title="系统操作菜单" style="width:13%;">
          <!--  <ul id="tt" >  
           </ul> -->
           <div class="easyui-accordion1" fit="true" border="false" >
		</div>
       </div>
       <div data-options="region:'center'" >
          <div id="main" class="easyui-tabs" border="false" fit="true" ></div>
       </div>
       <!-- <div data-options="region:'south'" style="height:25px;">
             <div style="width:100%;margin-top:3px;" align="center" >
	           Copyright ©2013-2015 All Rights Reserved 厦门睿天科技有限公司版权所有
	         </div>
       </div> -->
  </body>
</html>
<script type="text/javascript">
   //存储对话框MAP
   var  dialogMap = {};
   var  gridMap = {};
   //var  treeOptions = {id:"tt",url:"../common/tree.do",onClick:treeClick,lines:true};
   $(document).ready(function(){
   		$.ajax({
   			url:"../common/tree.do?"+Math.random(),
   			success:function(data){
   				var json=eval("("+data+")");
   				if(json.error){
   					parent.$.messager.alert("提示窗口",json.error);
   					return;
   				}
   				InitLeftMenu(json);
   			}
   		});
   		var html="";
   		html+=sheetHtml();
   		html+=noticeHtml();
   		
   		if(html!=""){
   			$.messager.show({
				title:"消息提示",
				msg:html,
				width:"auto",
				height:"auto",
				showType:"show",
				timeout:0,
				style:{
					left:'',
					right:0,
					top:document.body.scrollTop+document.documentElement.scrollTop+80,
					bottom:''
				}
			});
			
   			//html+="<a href=\"javascript:void(0);\" onclick=\"hideTooltip();\">关闭</a>";
  		}
  		/* $(".notices").tooltip({
			position : "bottom",
			hideDelay:10000,
			content : html,
			onShow : function() {
			}
		});
		if(html!=""){
			$(".notices").tooltip("show");
  		} */
  		
  		/**zhangjf 2015-11-09 首次登陆弹出密码修改框start**/
   		var firstLogin="${firstLogin}";
   		if(firstLogin!=null&&firstLogin!=''&&firstLogin!=undefined){
   			$(".firstLogin").click();
   		}
   		/**zhangjf 2015-11-09 首次登陆弹出密码修改框end**/
   		
   		bxunTabs.addTabNoClose("首页","../main/index.do?sectionId=6fd7fbf58fc7466dbf725497dfe2ed47");//显示首页
   });
 //隐藏tooltip
function hideTooltip(){
   $(".notices").tooltip({hideDelay:0});
   	$(".notices").tooltip("hide");
   	$(".notices").tooltip({hideDelay:10000});
}
//通知信息html
function noticeHtml(){
	var html="";
	$.ajax({//获取为阅读通知列表
		url:"../common/noticeList.do?"+Math.random(),
		async:false,
		success:function(data){
			var json=eval("("+data+")");
			 for(var i=0;i<json.length;i++){
			 	var vo=json[i];
			 	html+= "<div  style=\"max-width:300px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;margin-bottom:5px;\"><a  href=\"javascript:void(0);\" onclick=\"lookNotice('"+vo.id+"',this,'"+vo.isInStation+"')\" title=\""+vo.title+"\" ><span style=\"color: rgb(214, 80, 80);\">"+vo.isInStation+"：</span>"+vo.title+"</a></div>";
			 }
		}
	});
  	return html;
}
//在线填表信息html
function sheetHtml(){
	var html="";
	$.ajax({//获取为填表列表
		url:"../common/sheetList.do?"+Math.random(),
		async:false,
		success:function(data){
			var json=eval("("+data+")");
			 for(var i=0;i<json.length;i++){
			 	var vo=json[i];
			 	html+= "<div  style=\"max-width:300px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;margin-bottom:5px;\"><a  href=\"javascript:void(0);\" onclick=\"sheet('"+vo.id+"',this)\" title=\""+vo.title+"\" ><span style=\"color: rgb(214, 80, 80);\">在线填表：</span>"+vo.title+"</a></div>";
			 }
		}
	});
  	return html;
}
//在线填表
function sheet(id,obj){
	var dbuttons = [{ 
		text:'保 存',
		iconCls:'icon-ok',
		id:'sbutton'
	},{
		text:'关 闭',
		iconCls:'icon-cancel',
		id:'cbutton'
	}];
	$(obj).parent().remove();
	var options = {id:"d3",urls:"../oa/sheetTeacher/sheet.do?sheetId="+id,title:"在线填表",buttons:dbuttons};
	parent.$.createDialog(options);
	hideTooltip();
}
//查看通知
function lookNotice(id,obj,isInStation){
	$(obj).parent().remove();
	var options = {id:"d3",urls:"../site/noticeManagement/look.do?id="+id,title:"查看"+isInStation};
	parent.$.createDialog(options);
	hideTooltip();
}
//初始化左侧
function InitLeftMenu(json) {
    $(".easyui-accordion1").empty();
    var menulist = "";
   for(var i=0;i<json.length;i++){
   		var n=json[i];
   		menulist += "<div title=\""+n.name+"\"  style=\"overflow:auto;\" >";
		menulist += "<ul>";
		var children=n.children;
		var arr=new Array();
		var index=0;
		if(typeof(children)=="undefined"){
			continue;
		}
		for(var j=0;j<children.length;j++){
			var o=children[j];
			if(o.children==null){
				var picUrl=o.picUrl;
				if(picUrl==null){
					picUrl="admin/css/icons/陈铭轩.png";
				}
				picUrl="<%=request.getContextPath()%>/"+picUrl;
				menulist += "<li><div><a  href=\"javascript:void(0);\" onclick=\"menuClick('"+o.id+"','"+o.name+"','"+o.url+"','"+picUrl+"');\"   ><span class=\"icon\" style=\"background:url("+picUrl+") no-repeat;\" ></span>" + o.name + "</a></div></li> ";// onclick="menuClick(\''+o.name+'\',\''+o.url+'\')" 
			}else{
				arr[index++]=o;
			}
		}
		if(arr.length>0){
			var treeData=$.toJSON(arr);
			menulist += "<ul class=\"menuTree\"  data-options='data:"+treeData+",onClick:treeClick' style=\"padding:0px;\"></ul> ";
		}
        menulist += "</ul></div>";
   }
   var  treeOptions = {id:"tt",lines:true};
	$(".easyui-accordion1").append(menulist);
	
	$(".easyui-accordion1 li a").click(function(){
		$(".easyui-accordion1 li div").removeClass("selected");
		$(this).parent().addClass("selected");
	}).hover(function(){
		$(this).parent().addClass("hover");
	},function(){
		$(this).parent().removeClass("hover");
	});
	$(".easyui-accordion1").accordion({selected:false});
	$(".menuTree").tree({});
}

   /**
   *点击
   */
   function  menuClick(id,text,urls,picUrl){
	   bxunTabs.addTab(id,text,urls,picUrl);
   }
/**
*点击树方法
*/
function  treeClick(node){
	if($(".menuTree").tree("isLeaf",node.target)){
		var url=node.picUrl;
		if(url==null){
			url="admin/css/icons/陈铭轩.png";
		}
		url="<%=request.getContextPath()%>/"+url;
	 	bxunTabs.addTab(node.id,node.text,node.url,url);
	}else{
		if(node.state=="closed"){
			var tree=$(".menuTree");
			for(var i=0;i<tree.length;i++){
				try {
					tree.eq(i).tree("expandAll",node.target);
					//alert(tree.eq(i).tree("expandAll",node.target))
				} catch (e) {
				}
			}
		}else{
			var tree=$(".menuTree");
			for(var i=0;i<tree.length;i++){
				try {
					tree.eq(i).tree("collapseAll",node.target);
				} catch (e) {
				}
			}
		}
	}
}
   /**
   *退出系统
   **/
   function  loginOUT(){
	   parent.$.messager.confirm('确认','您确认要退出吗？',function(r){  
		   if(r){
			   location.href = "../common/loginOUT.do";
		   }
	   });
   }
   
   function modifypw(){
   		var dbuttons = [{ 
			text:'保 存',
			iconCls:'icon-ok',
			id:'sbutton'
		},{
			text:'关 闭',
			iconCls:'icon-cancel',
			id:'cbutton'
		}];
   		var options = {id:"d3",urls:"../platform/userInfo/toModifyPW.do",title:"修改密码",width:"600px;",height:"620px;",buttons:dbuttons};
		parent.$.createDialog(options);
   }
   
   function firstLogin(){
   		var dbuttons = [{ 
			text:'保 存',
			iconCls:'icon-ok',
			id:'sbutton'
		},{
			text:'关 闭',
			iconCls:'icon-cancel',
			id:'cbutton'
		}];
   		var options = {id:"d3",urls:"../platform/userInfo/toModifyPW.do",title:"首次登陆修改密码",width:"600px;",height:"620px;",buttons:dbuttons};
		parent.$.createDialog(options);
   }
   
   
</script>