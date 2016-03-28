<%@ page language="java" import="java.util.*" pageEncoding="utf8"%>
 <div class="tz">
                    	<!--通知公告-->
                    	<div class="tz_bt">
                        	<h3>通知公告</h3>
                        	<h3 class="hright"><a href="notify_list.do">MORE>></a></h3>
                            
                            <div style="clear:both"></div>
                            
                            <div class="tz_text">
                            	<ul>
                            	<c:forEach items="${notifys}" var="notify">
                            		<li><a href="notify_detail.do?id=${notify.id }">${notify.title }</a><span class="tz_rq">${fn:substring(notify.createdate, 5, 10)}</span></li>
                            	</c:forEach>
                                </ul>
                            </div>
                        </div>
 </div>
