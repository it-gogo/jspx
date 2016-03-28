<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <div class="lunbo">
                	<div class="pic_car">
                   		<div id="slider" class="case_box" style="height:388px;width:1000px;">
                   			<ul>
                   			<c:forEach items="${carousels }" var="carousel">
								<li><img src="<%=request.getContextPath() %>/${carousel.picUrl}" title="${carousel.name }" width="1000px" height="388px"></li>
							</c:forEach>
                   			<%--  <li>
								<img src="<%=request.getContextPath() %>/client/oa_ly/image/carousel.jpg"  width="797px" height="372px">
							</li>
							<li>
								<img src="<%=request.getContextPath() %>/client/oa_ly/image/carousel.jpg"  width="797px" height="372px">
							</li> --%>
							</ul>
                   			<%-- <ul>
                   				<li> <img src="<%=path%>/client/portal/images/lunbo_tp_03.png" width="1000px" height="388px"></li>
                   				<li> <img src="<%=path%>/client/portal/images/lunbo_tp_03.png" width="1000px" height="388px"></li>
                   				<li> <img src="<%=path%>/client/portal/images/lunbo_tp_03.png" width="1000px" height="388px"></li>
                   				<li> <img src="<%=path%>/client/portal/images/lunbo_tp_03.png" width="1000px" height="388px"></li>
                   				<li> <img src="<%=path%>/client/portal/images/lunbo_tp_03.png" width="1000px" height="388px"></li>
							</ul>  --%>
                   		</div>
                   	</div>
 </div>
