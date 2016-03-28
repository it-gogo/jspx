<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
  	<%@include file="/WEB-INF/admin/common/head.jsp" %>
  	<link href="<%=request.getContextPath()%>/admin/menu_tree/css/default.css" rel="stylesheet" type="text/css" />
   	<link href="<%=request.getContextPath()%>/admin/new-css/shouye.css" rel="stylesheet" type="text/css" /> 	
  </head>
  
  <body class="easyui-layout">
      <!-- 模板一 -->
      <div data-options="region:'north'" style="height:89px;border:0px;">
	       <div class="top_1" style="width:100%;height:100%;position:relative;<%-- background:url(<%=request.getContextPath()%>/cssTemplate1/images/top_b.jpg) --%>" >
	          <div id="sessionInfoDiv" style="margin-top:0px; float:left;right:150px;width: 40%;">
		        <img  src="<%=request.getContextPath()%>/cssTemplate1/images/logo.png">
	          </div>	          
	          
<%-- 	          <div id="sessionInfoDiv" style=" float:right;margin-right:25px;font-size: 20px;margin-top: 60px;">
		         &nbsp;&nbsp;名称:<strong>${user.name }</strong>，
		         欢迎登录！
		         &nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="modifyInfo()">[修改信息]</a>
		         &nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="loginOUT()">[退出系统]</a>
	          </div> --%>
	       	  <div class="top_nr">
	       	  		<div class="top_tis">
							<ul>
								<li>上午好！ ${user.userName }  <span id="showDate" style="font-size: 18px;"></span> 星期六  14：50</li>
							</ul>	       	  		
	       	  		</div>
	       	  		<div class="top_xinx">
	       	  			<div class="top_hydr">
	       	  				<ul>
	       	  					<li><a href="#"   id="welcome" style="display: inline-block;height: 35px;line-height: 35px;" >欢迎您，${user.userName }！<span class="top_img"><img alt="" src="<%=request.getContextPath()%>../css/images/dr_xsj_03.png"></a></li>
	       	  				</ul>
	       	  			</div>	       	  			
	       	  		</div>
	       	  </div>	          
	          
	       </div>
      </div>
       <!-- 模板一 -->
       
       <div data-options="region:'west'" title="导航菜单" style="width:217px;" class="menu1"   >
           <!-- <ul id="menuTree" >  
           </ul> -->
            <div class="easyui-accordion1" fit="true" border="false" >
			</div>
       </div>
       <div data-options="region:'center'" >
          <div id="main" class="easyui-tabs" border="false" fit="true" >
			
          </div>
       </div>
       <div data-options="region:'south'" style="height:25px;">
             <div style="width:100%;margin-top:3px;" align="center" >
	           Copyright ©2013-2015 All Rights Reserved 厦门睿天科技有限公司版权所有
	         </div>
       </div>
  </body>
</html>
<script type="text/javascript">
   //存储对话框MAP
   var  dialogMap = {};
   var  gridMap = {};
   //var  treeOptions = {id:"menuTree",url:"../common/tree.do",onClick:treeClick};
   $(document).ready(function(){
	   /* $.initTree(treeOptions); */
	   $.ajax({
   			url:"../common/tree.do?"+Math.random(),
   			success:function(data){
   				var json=eval("("+data+")");
   				InitLeftMenu(json);
   			}
   		});
	    bxunTabs.addTabNoClose("首页","../main/index.do");//显示首页
   });
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
				menulist += "<li><div><a  href=\"javascript:void(0);\" onclick=\"menuClick('"+o.id+"','"+o.name+"','"+o.urls+"','"+picUrl+"');\"   ><span class=\"icon\" style=\"background:url("+picUrl+") no-repeat;\" ></span>" + o.name + "</a></div></li> ";// onclick="menuClick(\''+o.name+'\',\''+o.url+'\')" 
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
	 	bxunTabs.addTab(node.id,node.text,node.urls,url);
	}else{
		if(node.state=="closed"){
			var tree=$(".menuTree");
			for(var i=0;i<tree.length;i++){
				try {
					tree.eq(i).tree("expandAll",node.target);
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
 function lookNotice(){
 	bxunTabs.addTab("查看公告","../train/noticeInfo/lookNoticeList.do");
 }
 
 function modifyInfo(){
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
</script>