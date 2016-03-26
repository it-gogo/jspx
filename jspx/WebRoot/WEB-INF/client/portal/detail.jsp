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
                	<div class="main_lie">
                        <div class="main_bt">${article.title }</div>
                    	<div class="main_zz">
                        	<span>作者：${article.userName }</span>
                        	<span>发布时间：${article.createdate }</span>
                        	<span>点击次数：${article.readCount }</span>
                        </div>
                        <div class="main_te">
                        	${article.content }
                        </div>
                        <div class="fanye">
                        	<div class="fy_hd">
                                <p>上一篇：
                        <c:choose>
                        	<c:when test="${!empty preArticle }">
                        	<a href="detail.do?id=${preArticle.id }">${preArticle.title }</a>
                        	</c:when>
                        	<c:otherwise>
                        		没有了
                        	</c:otherwise>
                        </c:choose></p>
                                <p>下一篇：<c:choose>
                        	<c:when test="${!empty nextArticle }">
                        	<a href="detail.do?id=${nextArticle.id }">${nextArticle.title }</a>
                        	</c:when>
                        	<c:otherwise>
                        		没有了
                        	</c:otherwise>
                        </c:choose></p>
                            </div>
                        </div>
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

