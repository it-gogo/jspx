<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/admin/common/head.jsp"%>
<link href="<%=request.getContextPath() %>/admin/css/index.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/common/css/pagination.css"/>
<script type="text/javascript">
$(function(){
	$("#tabNav li").click(function(){
		var index=$("#tabNav li").index(this);
		$(this).addClass("active").siblings().removeClass("active");
		$("#tabWrap >div").eq(index).show().siblings().hide();
	});
	
});
//查看文章
function lookArticle(id,title){
	var options = {id:"d3",urls:"../site/articleManagement/look.do?id="+id,title:"查看"+title};
	parent.$.createDialog(options);
}

//查看通知
function lookNotice(id,title){
	var options = {id:"d3",urls:"../train/noticeManagement/look.do?id="+id,title:"查看"+title};
	parent.$.createDialog(options);
}
//打开文章列表
function openArticle(){
	$.ajax({
		url:"../platform/power/loadByAjax.do",
		data:"id=01da7a544d6240f590683fd074f5c05d",
		async:false,
		success:function(data){
			var json = eval("("+data+")");
			var picUrl=json.picUrl;
			if(typeof(picUrl)=="undefined" || picUrl==""){
				picUrl="admin/css/icons/陈铭轩.png";
			}
			picUrl="<%=request.getContextPath()%>/"+picUrl;
			parent.bxunTabs.addTab(json.id,json.name,json.url,picUrl);
		}
	});
}
function openNav(sectionId,parentSectionId){
	var index=$("#tabNav li").index($("#tabNav li.active").get(0));
	var departId="";
	if(index==0){//查询站内栏目
	}else{//多发布部门条件
		departId=$("#tabNav li.active").attr("id");
	}
	$.ajax({
		url:"../platform/power/loadByAjax.do",
		data:"id=01da7a544d6240f590683fd074f5c05d",
		async:false,
		success:function(data){
			var json = eval("("+data+")");
			var picUrl=json.picUrl;
			if(typeof(picUrl)=="undefined" || picUrl==""){
				picUrl="admin/css/icons/陈铭轩.png";
			}
			picUrl="<%=request.getContextPath()%>/"+picUrl;
			parent.bxunTabs.addTab(json.id,json.name,json.url+"?sectionId="+sectionId+"&parentSectionId="+parentSectionId+"&departId="+departId,picUrl);
		}
	});
}
/**
   *点击
   */
   function  menuClick(id,text,urls,picUrl){
   		if(typeof(picUrl)=="undefined" || picUrl==""){
			picUrl="admin/css/icons/陈铭轩.png";
		}
		picUrl="<%=request.getContextPath()%>/"+picUrl;
	   parent.bxunTabs.addTab(id,text,urls,picUrl);
   }
   
   function enterClassIndex(classId,className){
	var url="admin/css/icons/陈铭轩.png";
	url="<%=request.getContextPath()%>/"+url;
	parent.bxunTabs.addTab("",className+"首页","../main/classIndex.do?classId="+classId,url);
}
</script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/admin/new-css/shouye.css" type="text/css"></link>
<style type="text/css">
	.title{
		font-size: 16px;
		font-weight: bold;
	}
	.mainUl li{
		line-height: 35px;
	}
</style>
</head>

<body style="margin: 0px;">
	

<div class="shouye_main">
	<div class="sy_an">
		<div class="an_t">
			<ul>
				<c:forEach items="${fastNavList }" var="fastNav">
					<li><a href="javascript:void(0);" onclick="menuClick('${fastNav.id}','${fastNav.name }','${fastNav.url }','${fastNav.picUrl }');">${fastNav.name }</a></li>			
				</c:forEach>
			</ul>			
		</div>
		<div class="an_jt"><img src="<%=request.getContextPath()%>/admin/css/images/anniu_jt_03.png"></div>	
	</div>
	<hr style="width: 99.8%;">
	<div style="clear: both;"></div>
	<div style="width: 100%;background-color: #ede8e6;">
			<div style="clear: both;"></div>
			<!--第一-->			
			<div class="sy_nrm">
					<div style="clear: both;"></div>			
				<div class="bw_kd" style="width: 50%;float:left;">
					<div class="sy_bt">
						<div class="sy_bt1">
							<ul>
								<li style="width: 100%;"><a href="#">待办事宜<span style="color: #fd1616;">(${sheetList.size()+noticeList.size() })</span></a></li>
							</ul>				
						</div>
		
					<div style="clear: both;"></div>
		
						<div class="sy_jtnr">										
						<div class="sy_lbx">
							<ul style="padding-bottom: 15px;">
								<c:forEach items="${noticeList }" var="notice">
									<li>
										<span class="title">
											<a href="javascript:void(0);" onclick="lookNotice('${notice.id}','${notice.title }')" >【通知消息】${notice.title }</a>
										</span>
										<span class="sy_rq">${fn:substring(notice.createdate, 5, 10)}</span>
									</li>
								</c:forEach>
							</ul>
						</div>						
						</div>									
					</div>				
				</div>


				<div class="bw_kd"style="width: 50%;float:left;">
					<div class="sy_bt">
						<div class="sy_bt1">
							<ul>
								<li style="background-color: #dcd96e;width:100%;"><a href="#">新闻中心<span style="color: #fd1616;">(${newest.size() })</span></a>
									<a href="javascript:void(0);" onclick="openArticle();" class="more" style="line-height: 50px;display: inline-block;width: 80px;">更多</a>
								</li>
							</ul>				
						</div>
		
					<div style="clear: both;"></div>
		
						<div class="sy_jtnr">										
						<div class="sy_lbx">
							<ul style="padding-bottom: 15px;">
								<c:forEach items="${newest }" var="article">
									<li>
										<span class="title">
											<a href="javascript:void(0);" onclick="lookArticle('${article.id}','${article.title }')" ><c:if test="${article.departName!=null }">【${article.departName }】</c:if>${article.title }</a>
										</span>
										<span class="sy_rq">${fn:substring(article.createdate, 5, 10)}</span>
									</li>
								</c:forEach>
							</ul>
						</div>						
						</div>									
					</div>				
				</div>

			</div>


			<div style="clear: both;"></div>
			<!-- zhangjf 2016-04-07 展示参与培训班及督导相关信息start -->
			<div class="sy_nrm" >
				<ul class="mainUl">
					<li>
					<span class="title">&nbsp;您参与的培训班级</span>
					<c:if test="${classList!=null }">
						<c:forEach items="${classList }" var="classInfo">
							&nbsp;&nbsp;<input type="button"  onclick="enterClassIndex('${classInfo.id}','${classInfo.name }')" value="${classInfo.name }"/>&nbsp;&nbsp;
						</c:forEach>
					</c:if>
					</li>
					<li  >
					<span class="title">您参与资源提交项目</span>
					<c:choose>
					<c:when test="${!empty todoProjects }">
						<c:forEach items="${todoProjects }" var="project">
							&nbsp;&nbsp;<input type="button"  onclick="" value="${project.superviseName }"/>&nbsp;&nbsp;
						</c:forEach>
					</c:when>
					<c:otherwise>&nbsp;&nbsp;<input type="button"  onclick="" value="暂无相关提交项目"/>&nbsp;&nbsp;</c:otherwise>
					</c:choose>
					</li>
					<li >
					<span class="title">您参与督导检查项目</span>
					<c:if test="${classList!=null }">
						<c:forEach items="${classList }" var="classInfo">
							&nbsp;&nbsp;<input type="button"  onclick="enterClassIndex('${classInfo.id}','${classInfo.name }')" value="${classInfo.name }"/>&nbsp;&nbsp;
						</c:forEach>
					</c:if>
					</li>
				</ul>
				<div style="clear: both;"></div>
			</div>
			<!-- zhangjf 2016-04-07 展示参与培训班及督导相关信息end -->
			<!--第一-->			
			<%-- <div class="sy_nrm">
					<div style="clear: both;"></div>			
				<div class="bw_kd" style="width: 100%;margin-bottom: 20px;">
					<div class="sy_bt" >
						<ul class="tab-nav" id="tabNav" style="background-color: #4EC6F8;">
							<li class="active" style="width:85px;"><a href="#">${section.name }</a></li>
							<c:forEach items="${section.departList }" var="depart">
								<li id="${depart.id }"><a href="#" >${depart.name }</a></li>
							</c:forEach>
							<a href="javascript:void(0);" onclick="openNav('${section.id}','${section.parentId}')" class="more" style="color: white;">更多</a>
						</ul>
						<div id="tabWrap">
		<div class="article_list" style="background-color: white;">
			<ul>
				<c:forEach items="${section.articlePB.list }" var="article">
					<li style="background-color: white;border-bottom: 1px dashed #F1EDEA;">
						<span class="title">
							<a href="javascript:void(0);" onclick="lookArticle('${article.id}','${article.title }')" >【${article.departName }】${article.title }</a>
						</span>
						<span class="time">${fn:substring(article.createdate, 0, 10)}</span>
					</li>
				</c:forEach>
				<li style="background-color: white;height: 10px;border-bottom: 0px;"></li>
			</ul>
			<div  class="paging" count="1" style="margin-top: 5px;">
                        	<div class="pagination">
	                        	<c:if test="${section.articlePB.hasPreviousPage }">
									<a href="javascript:void(0)" onclick="page(this,'${section.articlePB.page-1}','')" style="border:0px;"><span class="current prev">上一页</span>	</a>	
								</c:if>
	                        	<c:if test="${!section.articlePB.hasPreviousPage }">
									<a href="javascript:void(0);" style="border:0px;"><span class="current prev">上一页</span></a>	
								</c:if>
                        		<span class="current">${section.articlePB.page }</span>
                        		<c:if test="${section.articlePB.hasNextPage }">
									<a href="javascript:void(0)" onclick="page(this,'${section.articlePB.page+1}','')" style="border:0px;"><span class="current next">下一页</span></a>
								</c:if>
								<c:if test="${!section.articlePB.hasNextPage }">
										<a href="javascript:void(0);" style="border:0px;"><span class="current next">下一页</span></a>
								</c:if>
                        	</div>
                        </div>
		</div>
		<c:forEach items="${section.departList }" var="depart">
			<div class="article_list" style="display: none;background-color: white;">
				<ul>
					<c:forEach items="${depart.article_dPB.list }" var="article">
						<li style="background-color: white;border-bottom: 1px dashed #F1EDEA;">
							<span class="title">
								<a href="javascript:void(0);" onclick="lookArticle('${article.id}','${article.title }')" >【${article.departName }】${article.title }</a>
							</span>
							<span class="time">${fn:substring(article.createdate, 0, 10)}</span>
						</li>
					</c:forEach>
					<li style="background-color: white;height: 10px;border-bottom: 0px;"></li>
				</ul>
				<div  class="paging" count="1" style="margin-top: 5px;">
                        	<div class="pagination">
	                        	<c:if test="${depart.article_dPB.hasPreviousPage }">
									<a href="javascript:void(0)" onclick="page(this,'${depart.article_dPB.page-1}','${depart.id }')" style="border:0px;"><span class="current prev">上一页</span>	</a>	
								</c:if>
	                        	<c:if test="${!depart.article_dPB.hasPreviousPage }">
									<a href="javascript:void(0);" style="border:0px;"><span class="current prev">上一页</span></a>	
								</c:if>
                        		<span class="current">${depart.article_dPB.page }</span>
                        		<c:if test="${depart.article_dPB.hasNextPage }">
									<a href="javascript:void(0)" onclick="page(this,'${depart.article_dPB.page+1}','${depart.id }')" style="border:0px;"><span class="current next">下一页</span></a>
								</c:if>
								<c:if test="${!depart.article_dPB.hasNextPage }">
										<a href="javascript:void(0);" style="border:0px;"><span class="current next">下一页</span></a>
								</c:if>
                        	</div>
                        </div>
			</div>
		</c:forEach>
		</div>
					</div>				
				</div>
			</div> --%>	
		</div>	
	</div>
</div>

<script type="text/javascript">
function page(obj,page,departId){
	$.ajax({
		url:"findArticle.do?rows=20&page="+page+"&departId="+departId,
		success:function(data){
			var json=eval("("+data+")");
			var html="";
			for(var i=0,j=json.list.length;i<j;i++){
				var article=json.list[i];
				var departName=article.departName;
				if(departName==undefined){
					departName="";
				}else{
					departName="【"+departName+"】"
				}
				
				html+="<li style=\"background-color: white;border-bottom: 1px dashed #F1EDEA;\"><span class=\"title\"><a href=\"javascript:void(0);\" onclick=\"lookArticle('"+article.id+"','"+article.title+"')\" >"+departName+article.title+"</a></span><span class=\"time\">"+article.createdate.substring(0,10)+"</span></li>";
			}
			html+="<li style=\"background-color: white;height: 10px;border-bottom: 0px;\"></li>";
			$(obj).parent().parent().prev().html(html);
			setPage(obj, json, departId);
		}
	});
}
function setPage(obj,json,departId){
	var html="";
	if(json.hasPreviousPage){
		html+="<a href=\"javascript:void(0)\" onclick=\"page(this,'"+(json.page-1)+"','"+departId+"')\" style=\"border:0px;\"><span class=\"current prev\">上一页</span>	</a>	";
	}else{
		html+="<a href=\"javascript:void(0);\" style=\"border:0px;\"><span class=\"current prev\">上一页</span></a>";
	}
	html+="<span class=\"current\">"+json.page+"</span>";
	if(json.hasNextPage){
		html+="<a href=\"javascript:void(0)\" onclick=\"page(this,'"+(json.page+1)+"','"+departId+"')\" style=\"border:0px;\"><span class=\"current next\">下一页</span></a>";
	}else{
		html+="<a href=\"javascript:void(0);\" style=\"border:0px;\"><span class=\"current next\">下一页</span></a>";
	}
	$(obj).parent().html(html);
}
</script>



	
	
</body>
</html>
