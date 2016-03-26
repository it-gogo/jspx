<%@ page language="java" import="java.util.*" pageEncoding="utf8"%>
 <div class="nav">
    	<div class="nav_kd">
            <ul class="nav_yj">
                <li style="background:none;"><a href="index.do">首页</a></li>
                <c:forEach items="${sections }" var="section">
                <c:if test="${section.isNavShow=='是' }">
                	<c:choose>
                		<c:when test="${empty section.absoluteUrl }">
                			 <li><a href="list.do?sectionId=${section.id }">${section.name }</a>
                		</c:when>
                		<c:otherwise>
                			 <li><a href="${section.absoluteUrl  }">${section.name }</a>
                		</c:otherwise>
                	</c:choose>
                </c:if>
                <c:if test="${!empty section.childrens }">
                	<ul class="nav-list">
                		<c:forEach items="${section.childrens}" var="child" >
                			<c:choose>
	                		<c:when test="${empty child.absoluteUrl }">
								<li ><a href="list.do?sectionId=${child.id }">${child.name }</a></li>
							</c:when>
						 	<c:otherwise>
						 		<li><a href="${child.absoluteUrl }">${child.name }</a></li>
						 	</c:otherwise>
						 	</c:choose>
                		</c:forEach>
                	</ul>
                </c:if>
                </li>
                </c:forEach>
                <!-- <li><a href="#">学校概括</a></li>
                <li><a href="#">教育新闻</a>
 					<ul class="nav-list">
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    </ul>               
                </li> -->
               <!--  <li><a href="#">中学教研</a>
 					<ul class="nav-list">
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    </ul>               
                </li>
                <li><a href="#">小学教研</a>
 					<ul class="nav-list">
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    </ul>               
                </li>
                <li><a href="#">学前教育</a>
 					<ul class="nav-list">
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    </ul>               
                </li>
                <li><a href="#">教育科研</a>
 					<ul class="nav-list">
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    </ul>               
                </li>
                <li><a href="#">教育培训</a>
 					<ul class="nav-list">
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    </ul>               
                </li>
                <li><a href="#">信息中心</a>
 					<ul class="nav-list">
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    </ul>               
                </li>
                <li><a href="#">教师风采</a>
 					<ul class="nav-list">
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    	<li><a href="#">教育新闻</a></li>
                    </ul>               
                </li> -->
            </ul>
        </div>
    </div> 
</html>
