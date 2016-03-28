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
                    		<a href="notify_list.do">通知公告>></a>
                    			${notice.title }
                    		</li>
                    </ul>
                </div>
                <div class="list_lie">
                	<div class="main_lie">
                        <div class="main_bt">${notice.title }</div>
                    	<div class="main_zz">
                        	<span>作者：${notice.creatorName }</span>
                        	<span>发布时间：${notice.createdate }</span>
                        </div>
                        <div class="main_te">
                        	${notice.content }
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

