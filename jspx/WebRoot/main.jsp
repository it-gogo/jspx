<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
  <head>
  	<%@include file="/WEB-INF/admin/common/head.jsp" %>
  </head>
  
  <body class="easyui-layout">
      <div data-options="region:'north'" style="height:32px;border:0px;">
	       <div style="width:100%;height:100%;position:relative;background:url(../css/admin/images/maintop.jpg)" >
	       
	          <div id="sessionInfoDiv" style="margin-top:0px; float:left;right:150px;">
		        <img  src="../css/admin/images/mainlog.jpg">
	          </div>
	       
	          <div id="sessionInfoDiv" style="margin-top:10px; float:right;margin-right:25px;">
		         &nbsp;&nbsp;姓名:<strong>超级管理员</strong>，
		         欢迎登录！&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="loginOUT()">[退出系统]</a>
	          </div>
	       </div>
      </div>
       <div data-options="region:'west'" title="导航菜单" style="width:13%;">
           <ul id="tt" >  
           
           </ul>
       </div>
       <div data-options="region:'center'" >
          <div id="main" class="easyui-tabs" border="false" fit="true" ></div>
       </div>
       <div data-options="region:'south'" style="height:25px;">
             <div style="width:100%;margin-top:3px;" align="center" >
	           Copyright ©2013-2015 All Rights Reserved 隆茂信息云版权所有
	         </div>
       </div>
  </body>
</html>
<script type="text/javascript">
   //存储对话框MAP
   var  dialogMap = {};
   var  gridMap = {};
   var  treeOptions = {id:"tt",url:"../platform/bmenu/findTree.do",onClick:treeClick};
   $(document).ready(function(){
	   $.initTree(treeOptions);
   });
   function  treeClick(node){
	   var isleaf = $("#tt").tree('isLeaf', node.target);//判断是否最后节点
	   if(isleaf){
		   var text = node.text;
		   var urls = node.attr.url;
		   bxunTabs.addTab(text,urls);
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
</script>