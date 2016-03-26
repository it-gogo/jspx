<%@ page language="java" import="java.util.*" pageEncoding="utf8"%>
<div class="footer">
    	<div class="yejiao">
        	<div class="yj_felt">
            	<ul>
                	<li>友情链接：
                	<select class="link">
                	<option value="">=========</option>
                	<c:if test="${!empty friend_links }">
                		<c:forEach items="${friend_links}" var="link">
                			<option value="${link.linkAddr }">${link.name }</option>
                		</c:forEach>
                	</c:if>
                	  <!-- <option>翔安职专翔安职专</option>
                	  <option>翔安一中</option>
                	  <option>翔安五中</option> -->
               	  </select></li>
                	<li>电话:0592-5590395 邮编:360300 邮箱：sd201yjt@126.com</li>
                	<li>地址:厦门市翔安区教师进修学校</li>
                	<li>翔安区进修学校 版权所有  <span>访问量：3649</span></li>
                	<li>备案号:ICP备14033316号</li>
                </ul>
            </div>
            <div class="yj_right">
            	<div class="two">
                	<ul>
                    	<li><img src="<%=path%>/client/portal/images/ew_03.png"><h3 class="gf">官方微信</h3></li>
                        <li><img src="<%=path%>/client/portal/images/ew_03.png"><h3 class="gf">微信公众号</h3></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</html>
