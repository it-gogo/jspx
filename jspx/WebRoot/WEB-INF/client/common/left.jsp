<%@ page language="java" import="java.util.*" pageEncoding="utf8"%>

 <div class="list_felt">
                <div class="list_bt">教育新闻</div>
                <div class="list_kd">
                    <div class="list_xb">
                    	<ul>
                    		<c:choose>
                    		<c:when test="${!empty childrenList }">
                    		 <c:forEach items="${childrenList }" var="children">
                    		 	<li><a href="list.do?sectionId=${children.id }">${children.name }</a></li>
                    		 </c:forEach>
                    		</c:when>
                    		<c:otherwise>
                    			<li><a href="javascript:void(0);">暂无相关数据</a></li>
                    		</c:otherwise>
                    		</c:choose>
                        	<!-- <li><a href="#">教师培训</a></li>
                        	<li><a href="#">教师培训</a></li>
                        	<li><a href="#">教师培训</a></li>
                        	<li><a href="#">教师培训</a></li>
                        	<li><a href="#">教师培训</a></li>
                        	<li><a href="#">教师培训</a></li>
                        	<li><a href="#">教师培训</a></li> -->
                        </ul>
                    </div>
                </div>
</div>
