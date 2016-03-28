<%@ page language="java" import="java.util.*" pageEncoding="utf8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <%@include file="/WEB-INF/client/common/title.jsp" %>
   <script type="text/javascript">
   	$(function(){
   		Effect.slider({
		"target": "slider",
		"showMarkers": true,
		"showControls": true
		});
		
	$("#validateCodeImg").click(function(){
					$(this).attr("src","validateCode.do?math="+Math.random()+"&HEIGHT=25&WIDTH=67");
			});
		
   	});
   	
   	function login(){
	$("#loginF").submit(function() {
		$.ajax({
			url:"login.do",
			data:$("#loginF").serialize(),
			type:"POST",
			success:function(data){
				var json =eval("("+data+")");
				if(json.message){
					location.href="../../common/loginSuccess.do" 
				}else{
					alert(json.error);
					$("#validateCodeImg").attr("src","validateCode.do?HEIGHT=25&WIDTH=67&math="+Math.random());
				}
				$("#loginF").unbind("submit");
			}
		});
		return false;
	}); 
	$("#loginF").submit();
}
   	
   </script>
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
    
    <!--主要内容 start-->
    <div class="content">
            <div class="content_bk">
                <!--轮播图-->
               <%@include file="/WEB-INF/client/common/carousel.jsp" %>
        	 <!--轮播图-->
        
                <!--通知公告、教育新闻、用户登入-->    	
                <div class="one">
                    <%@include file="/WEB-INF/client/common/notify.jsp" %>

                    
                    <!--教育新闻-->
                    <div class="xw">
                            <div class="xw_bt">
                                    <h3>${contentSections[0].name }</h3>
                                    <h3 class="hright"><a href="list.do?sectionId=${contentSections[0].id }">MORE>></a></h3>
                                    
                                    <div style="clear:both"></div>
                                    
                                    <div class="xw_zx">
                                    	<div class="xwyc">
                                            <div class="xw_img">
                                            	<c:choose>
                                            		<c:when test="${empty newArticle.picUrl }">
                                            			<img style="height:70px;" src="<%=path%>/client/portal/images/xw_img_05.png">
                                            		</c:when>
                                            		<c:otherwise>
                                            			<img style="height:70px;" src="<%=path%>/${newArticle.picUrl}">
                                            		</c:otherwise>
                                            	</c:choose>
                                            </div>
                                            <div class="img_text">
                                                <div class="img_kd">
                                                    <h2 class="hkd">${newArticle.title }</h2>
                                                    <p class="p_wb">${newArticle.introduction }</p>
                                                </div>
                                            </div>
                                        </div>
 
                                     <div style="clear:both"></div>
                                     <hr style="margin:0 20px;"/>
                                                                            
                                        <div class="xw_text">
                                            <ul>
                                            	<c:if test="${!empty contentSections[0].articles }">
                                            		<c:forEach items="${contentSections[0].articles }" var="article">
                                            			<li >
                                            				<a href="detail.do?id=${article.id }">${article.title }</a><span class="xw_rq">${fn:substring(article.createdate, 5, 10)}</span>
                                            			</li>
                                            		</c:forEach>
                                            	</c:if>
                                            </ul>
                                        </div>
                                    </div>
                            </div>
                    </div>
                    
                    <!--用户登入-->
                    <c:choose>
                    	<c:when test="${empty user }">
                    	<div class="dr">
                    	<div class="drbk">
                    	<form id="loginF">
                            <table class="user_dw">
                                <tr>
                                    <td><span class="ys">用户名:</span><input class="ynj" type="text" name="text"></td>	                 
                                </tr>
                                <tr>
                                    <td style="padding-top:8px;"><span class="ys">密<span style="color:#FFF">米</span>码:</span><input class="ynj" type="password" name="password" ></td>           
                                </tr>
                            </table> 
                            <div style="margin:8px 0 0 0">
                                <div class="dr_yzm">
                                    <span class="ys">验证码:</span><input name="code" style="width:80px; border:#308dce solid 1px; height:20px" type="text">
                                </div>    
                                <div class="dr_img"><img id="validateCodeImg" style="float: left;" class="yanzhengma-img" src="validateCode.do?HEIGHT=25&WIDTH=67" alt="验证码" title="点击更换"></div>
                            </div>
                            <div style="clear:both"></div>
                            </form>
                            <div class="fx">
                                <div style="text-align:center;">
                                    <input class="checkbox" name="" type="checkbox" value="">记住密码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input class="checkbox" name="" type="checkbox" value="">自动登入
                                </div>
                            </div>  
                            <div class="button">
                                <div style="margin:0 8px; margin-top:3px;">
                                    <input class="butt" onclick="login();"  name="登入" type="button" value="登入">
                                </div>
                            </div>    
                       
                        </div>
                    </div>
                    </c:when>
                    <c:otherwise>
                    <div class="dr">
                    	<div class="drl">
                    		<table width="100%">
                    			<tr></tr>
                    			<tr></tr>
                    			<tr></tr>
                    			<tr></tr>
                    			<tr></tr>
                    			<tr></tr>
                    			<tr>
                    				<th>用户名:</th>
                    				<td>${user.text }</td>
                    			</tr>
                    			<tr></tr>
                    			<tr></tr>
                    			<tr></tr>
                    			<tr></tr>
                    			<tr></tr>
                    			<tr></tr>
                    			<tr>
                    				<td colspan="2">
                    					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="dlra" href="../../common/loginSuccess.do">管理中心</a>&nbsp;&nbsp;&nbsp;
                    					<a class="dlra" href="logout.do">退出系统</a>
                    				</td>
                    			</tr>
                    		</table>
                    	</div>
                    </div>
                    </c:otherwise>
                    </c:choose>
                    
                </div>
                
                <div style="clear:both"></div>
                
                <!--中学教研、小学教研-->
				<div class="zx_jy">
                	<!--中学教研-->
            		<div class="zx">
                    	<div class="zx_bt">
                     		<div class="hbt">
                                <h3>${contentSections[1].name }</h3>
                            </div>
                            <div class="kemu">
                            	<div class="kemu_ul">
                                    <ul>
                                    	<c:if test="${!empty contentSections[1].childrens }">
                                    	<c:forEach items="${contentSections[1].childrens}" var="child">
						                     <li><a href="list.do?sectionId=${child.id }">&nbsp;${child.name }&nbsp;</a></li>               	
                                    	</c:forEach>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                      		<div class="zx_gd">
                            	<div class="zx_ggd"><a href="list.do?sectionId=${contentSections[1].id }">MORE>></a></div>
                            </div>

							<div style="clear:both"></div>
                            
                            <div class="zx_te">
                                <ul>
                                	<c:if test="${!empty contentSections[1].articles }">
                                		<c:forEach items="${contentSections[1].articles }" var="article">
                                		<li><a href="detail.do?id=${article.id }">${article.title }</a><span class="zx_rq">${fn:substring(article.createdate, 5, 10)}</span></li>
                                		</c:forEach>
                                	</c:if>
                                </ul>
                            </div>
                       </div>
                    </div>
               <!--小学教研-->
            		<div class="xx">
                    	<div class="xx_bt">
                     		<div class="xbt">
                                <h3>${contentSections[2].name }</h3>
                            </div>
                            <div class="kemu1">
                            	<div class="kemu1_ul">
                                    <ul>
                                       <c:if test="${!empty contentSections[2].childrens}">
                                    	<c:forEach items="${contentSections[2].childrens}" var="child">
						                     <li><a href="list.do?sectionId=${child.id }">&nbsp;${child.name }&nbsp;</a></li>               	
                                    	</c:forEach>
                                    	</c:if>
                                    </ul>
                                </div>
                            </div>
                      		<div class="xx_gd">
                            	<div class="xx_ggd"><a href="list.do?sectionId=${contentSections[2].id }">MORE>></a></div>
                            </div>

							<div style="clear:both"></div>
                            
                            <div class="xx_te">
                                <ul>
	                                    <c:if test="${!empty contentSections[2].articles }">
	                                		<c:forEach items="${contentSections[2].articles }" var="article">
	                                		<li><a href="detail.do?id=${article.id }">${article.title }</a><span class="xx_rq">${fn:substring(article.createdate, 5, 10)}</span></li>
	                                		</c:forEach>
	                                	</c:if>
                                </ul>
                            </div>
                       </div>
                    </div>
                </div>
				
				<div style="clear:both"></div>
                
                <!--小横条-->
                <div class="xht"><img src="<%=path%>/client/portal/images/xht.png"></div>

				<div style="clear:both"></div>

                <!--学前教育、教育科研、信息中心、教育培训、链接-->
                <div class="main_dhz">
                	<!--第一行-->
                	<div class="main_yh">
                        <!--学前教育-->
                        <div class="xq_jy">
                        	<h3>${contentSections[3].name }</h3>
                        	<h3 class="xq_gd"><a href="list.do?sectionId=${contentSections[3].id }">MORE>></a></h3>
                            
                            <div style="clear:both"></div>
                            
                            <div class="xq_text">
                            	<ul>
                            	
                                	 <c:if test="${!empty contentSections[3].articles }">
	                                		<c:forEach items="${contentSections[3].articles }" var="article">
	                                		<li><a href="detail.do?id=${article.id }">${article.title }</a><span class="xq_rq">${fn:substring(article.createdate, 5, 10)}</span></li>
	                                		</c:forEach>
	                                	</c:if>
                                </ul>
                            </div>
                        </div>
                       
                        <!--教育科研-->
                        <div class="jy_ky">
                            <div class="jy_bt">
                                    <h3>${contentSections[4].name }</h3>
                                    <h3 class="jy_gd"><a href="list.do?sectionId=${contentSections[4].id }">MORE>></a></h3>
                                    
                                    <div style="clear:both"></div>
                                    
                                    <div class="jy_zx">
                                    	<div class="jyky">
                                            <div class="jy_img">
                                            	<c:choose>
                                            		<c:when test="${empty newArticle.picUrl }">
                                            			<img style="height:70px;" src="<%=path%>/client/portal/images/xw_img_05.png">
                                            		</c:when>
                                            		<c:otherwise>
                                            			<img style="height:70px;" src="<%=path%>/${newArticle.picUrl}">
                                            		</c:otherwise>
                                            	</c:choose>
                                           
                                            </div>
                                            <div class="jimg_text">
                                                <div class="jimg_kd">
                                                    <h2 class="jhkd">${newArticle.title }</h2>
                                                    <p class="jp_wb">${newArticle.introduction }</p>
                                                </div>
                                            </div>
                                        </div>
 
                                     <div style="clear:both"></div>
                                     <hr style="margin:0 11px;"/>
                                                                            
                                        <div class="jy_text">
                                            <ul>
                                                 <c:if test="${!empty contentSections[4].articles }">
	                                		<c:forEach items="${contentSections[4].articles }" var="article">
	                                		<li><a href="detail.do?id=${article.id }">${article.title }</a><span class="jy_rq">${fn:substring(article.createdate, 5, 10)}</span></li>
	                                		</c:forEach>
	                                	</c:if>
                                            </ul>
                                        </div>
                                    </div>
                            </div>
                        </div>
                        
                        <!--链接-->
                        <div class="lj">
                        	<div class="lian">
                                <ul>
                                <c:if test="${!empty xzbg_list }">
                                	<c:forEach items="${xzbg_list }" var="xzbg" varStatus="count">
                                		<li class="lj_${1+count.index }"><a href="${xzbg.linkAddr }" target="${xzbg.openType }">${xzbg.name }</a></li>
                                	</c:forEach>
                                </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
 
 					<div style="clear:both"></div>
                    <div style="margin-top:5px"></div>
                    <!--第二行-->
                	<div class="main_yh">
                        <!--信息中心-->
                        <div class="xq_jy">
                        	<h3>${contentSections[5].name }</h3>
                        	<h3 class="xq_gd"><a href="list.do?sectionId=${contentSections[5].id }">MORE>></a></h3>
                            
                            <div style="clear:both"></div>
                            
                            <div class="xq_text">
                            	<ul>
                                	 <c:if test="${!empty contentSections[5].articles }">
	                                		<c:forEach items="${contentSections[5].articles }" var="article">
	                                		<li><a href="detail.do?id=${article.id }">${article.title }</a><span class="xq_rq">${fn:substring(article.createdate, 5, 10)}</span></li>
	                                		</c:forEach>
	                                	</c:if>
                                </ul>
                            </div>
                        </div>
                       
                        <!--教育培训-->
                        <div class="jy_ky">
                            <div class="jy_bt">
                                    <h3>${contentSections[6].name }</h3>
                                    <h3 class="jy_gd"><a href="list.do?sectionId=${contentSections[6].id }">MORE>></a></h3>
                                    
                                    <div style="clear:both"></div>
                                    
                                    <div class="jy_zx">
                                    	<div class="jyky">
                                            <div class="jy_img">
                                            	<c:choose>
                                            		<c:when test="${empty newArticle.picUrl }">
                                            			<img style="height:70px;" src="<%=path%>/client/portal/images/xw_img_05.png">
                                            		</c:when>
                                            		<c:otherwise>
                                            			<img style="height:70px;" src="<%=path%>/${newArticle.picUrl}">
                                            		</c:otherwise>
                                            	</c:choose>
                                            </div>
                                            <div class="jimg_text">
                                                <div class="jimg_kd">
                                                    <h2 class="jhkd">${newArticle.title }</h2>
                                                    <p class="jp_wb">${newArticle.introduction }</p>
                                                </div>
                                            </div>
                                        </div>
 
                                     <div style="clear:both"></div>
                                     <hr style="margin:0 11px;"/>
                                                                            
                                        <div class="jy_text">
                                            <ul>
                                                <c:if test="${!empty contentSections[6].articles }">
	                                			<c:forEach items="${contentSections[6].articles }" var="article">
	                                			<li><a href="detail.do?id=${article.id }">${article.title }</a><span class="jy_rq">${fn:substring(article.createdate, 5, 10)}</span></li>
	                                			</c:forEach>
	                                			</c:if>
                                            </ul>
                                        </div>
                                    </div>
                            </div>
                        </div>
                        
                        <!--链接-->
                        <div class="lj">
                        	<div class="lian">
                                <ul>
                                <c:if test="${!empty ztwz_list }">
                                	<c:forEach items="${ztwz_list }" var="ztwz" varStatus="count">
                                		<li class="lj_${count.index+5 }"><a href="${ztwz.linkAddr }" target="${ztwz.openType }">${ztwz.name }</a></li>
                                	</c:forEach>
                                </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
            </div>
    </div>
   
    <!--教师风采-->
    <div class="js_fc">
    	<div class="fc_zp">${contentSections[contentSections.size()-1].name }</div>
     	<div class="js_left">
        	<div class="jszb" id="jszb"><img src="<%=path%>/client/portal/images/jsfc_xz_03.png"></div>
        </div>
        <div class="jsfc">
        	<!--滚动图片 start-->
											<DIV class=rollphotos>
											<DIV class=blk_29 style="border: none;">
											<DIV class=Cont id=ISL_Cont_1 style="float:left;height:175px;">
											<!-- 图片列表 begin -->
											<ul>
											<c:forEach items="${contentSections[contentSections.size()-1].articles }" var="article">
												 <li><a href="detail.do?id=${article.id }"><img src="<%=path%>/${article.picUrl}" width="284" height="175"><h3>${article.title }</h3></a></li>
											</c:forEach>
							                   
							                   <%--  <li><a href="#"><img src="<%=path%>/client/portal/images/zp_03.png"><h3>翔安一中</h3></a></li>
							                    <li><a href="#"><img src="<%=path%>/client/portal/images/zp_03.png"><h3>翔安一中</h3></a></li> --%>
							                </ul>
											
											<!-- 图片列表 end -->
											</DIV>
											</DIV> 
											<SCRIPT language=javascript type=text/javascript>
													<!--//--><![CDATA[//><!--
													var scrollPic_02 = new ScrollPic();
													scrollPic_02.scrollContId   = "ISL_Cont_1"; //内容容器ID
													scrollPic_02.arrLeftId      = "jszb";//左箭头ID
													scrollPic_02.arrRightId     = "js_rrr"; //右箭头ID
													scrollPic_02.frameWidth     = 900;//显示框宽度
													scrollPic_02.pageWidth      = 284; //翻页宽度
													scrollPic_02.speed          = 10; //移动速度(单位毫秒，越小越快)
													scrollPic_02.space          = 10; //每次移动像素(单位px，越大越快)
													scrollPic_02.autoPlay       = true; //自动播放
													scrollPic_02.autoPlayTime   = 2; //自动播放间隔时间(秒)
													scrollPic_02.initialize(); //初始化					
													//--><!]]>
											</SCRIPT>
											</DIV>
											<!--滚动图片 end-->
        </div>
        <div class="js_right">
        	<div class="jsyb" id="js_rrr"><img src="<%=path%>/client/portal/images/jsfc_xy_03.png"></div>
        </div>
    </div>    
    <!--主要内容 finish-->
</div>

   <div style="clear:both"></div>

    <!--页脚 start-->
    	 <%@include file="/WEB-INF/client/common/footer.jsp" %>
    <!--页脚 finish-->

</body>
</html>
