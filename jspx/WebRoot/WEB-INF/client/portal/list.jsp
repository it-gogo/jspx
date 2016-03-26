<%@ page language="java" import="java.util.*" pageEncoding="utf8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <%@include file="/WEB-INF/client/common/title.jsp" %>
</head>

<body>
<div class="container">
    <!--头部 start-->
	<%@include file="/WEB-INF/client/common/logo.jsp" %>
	<!--头部 finish-->
    
    <div style="clear:both"></div>
    
    <!--nav start--> 
    <%@include file="/WEB-INF/client/common/nav.jsp" %>  
    <!--nav finish-->
   
   <div style="clear:both"></div>
	   
    <!--列表 start--> 
    <div class="content" style="background:none;">
            <!--左边-->
           <%@include file="/WEB-INF/client/common/left.jsp" %>
           
           <!--右边-->
            <div class="list_right">
            	<div class="list_nrbt">
                	<ul>
                    	<li>当前位置：<a href="#">首页>></a>
                    		<c:if test="${!empty parentsection }">
                    		<a href="list.do?sectionId=${parentsection.id }">${parentsection.name }>></a>
                    		</c:if>
                    		<a href="list.do?sectionId=${section.id }">${section.name }</a>
                    		</li>
                    </ul>
                </div>
                <div class="list_lie">
                	<div class="lie_bt"><p class="lie_bg">${section.name }</p></div>
                    <div style="background:#5daffb; height:3px"></div>
                	
                    <div class="lie_rn">
                    	<ul>
                    		<c:choose>
                         	<c:when test="${!empty pageBean.list }">
                         		 <c:forEach items="${pageBean.list }" var="article">
                         		 <c:choose>
                         		 	<c:when test="${empty article.titleHref }">
                         		 		<li><a href="detail.do?id=${article.id }">${article.title }</a><span class="lie_rq">${fn:substring(article.createdate, 0, 10)}</span></li>
                         		 	</c:when>
                         		 	<c:otherwise>
		                       		 <li><a href="${article.titleHref }">${article.title }</a><span class="lie_rq">${fn:substring(article.createdate, 0, 10)}</span></li>
                         		 	</c:otherwise>
                         		 </c:choose>
								</c:forEach>
                         	</c:when>
                         	<c:otherwise>
                         		<li>暂无内容...</li>
                         	</c:otherwise>
                         </c:choose>
                        	<!-- <li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li>
                        	<li><a href="#">通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估通过北师大基础教育对外合作办学部导引性评估</a><span class="lie_rq">2016-03-23</span></li> -->
                        </ul>
                    </div>
                    <div
								style="position: relative;float:left;padding-top:11px; margin-bottom:10px; width:660px; padding-left:40px;">
							<%@include file="/WEB-INF/client/common/page.jsp" %>
							</div>
                </div>
            </div>
    </div>
    <!--列表 finish-->
   <div style="clear:both"></div>

    <!--页脚 start-->
    	<%@include  file="/WEB-INF/client/common/footer.jsp" %>
    <!--页脚 finish-->    
</div>
</body>
</html>

