<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${webManagement.hTitle }</title>
<link type="image/vnd.microsoft.icon" rel="shortcut icon" href="<%=request.getContextPath()%>/${webManagement.iconUrl }">
<link type="text/css" href="<%=request.getContextPath() %>/admin/css/loginstyle.css"  rel="stylesheet"/>
<script src="<%=request.getContextPath()%>/admin/script/jquery.min.js" type="text/javascript"></script>
<script language="javascript">
/* $(function() {
		var userAgent = window.navigator.userAgent.toLowerCase();
 		alert(/msie 7\.0/i.test(userAgent))
 		alert(/msie 8\.0/i.test(userAgent))
 		alert(/msie 9\.0/i.test(userAgent))
	}); */

var $main = $cloud = mainwidth = null;
var offset1 = 450;
var offset2 = 0;

var offsetbg = 0;

$(document).ready(
    function () {
        $main = $("#mainBody");
		$body = $("body");
        $cloud1 = $("#cloud1");
		$cloud2 = $("#cloud2");
		
        mainwidth = $main.outerWidth();
     
    }
);

/// 飘动
setInterval(function flutter() {
    if (offset1 >= mainwidth) {
        offset1 =  -580;
    }

    if (offset2 >= mainwidth) {
		 offset2 =  -580;
    }
	
    offset1 += 1.1;
	offset2 += 1;
    $cloud1.css("background-position", offset1 + "px 100px")
	
	$cloud2.css("background-position", offset2 + "px 460px")
}, 70);


setInterval(function bg() {
    if (offsetbg >= mainwidth) {
        offsetbg =  -580;
    }

    offsetbg += 0.9;
    $body.css("background-position", -offsetbg + "px 0")
}, 90 );

	/* $(function(){
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
	$(window).resize(function(){  
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
    })  */ 
});  
</script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/admin/new-css/new_loginbox.css" type="text/css"></link>
</head>

<body /* background-image:url('/wxjk/css/images/light.png'); */ background-repeat:no-repeat; background-position:center top; overflow:hidden;">

    <div id="mainBody">
      <div class="nav"><img src="<%=request.getContextPath()%>/admin/css/images/logo_dr.png"/></div>
      <div id="cloud1" class="cloud"></div>
      <div id="cloud2" class="cloud"></div>
    </div>  
    <form id="loginform" name="loginform" method="post" action="../common/login.do">
    <div class="loginbody">
    <span class="systemlogo"></span>
    
    <div class="loginbox">
    	<div class="wk_lo"></div> 
    	<div class="wk_ul">
	 	    <ul>
			    <li><input name="text" type="text" class="loginuser" value="${vo.TEXT }" /></li>
			    <li><input name="password" type="password" class="loginpwd" value="${vo.PASSWORD}"  /></li>
			    <li class="fxuan"><input name="" class="fx_dw" type="checkbox" value="" /><span class="jz_mm">记住密码</span></li>
			    <li class="dengr">
			    	<input name="" type="submit" class="loginbtn" value="登 录"    />
			    	<!-- <label><input name="" type="checkbox" value="" checked="checked" />记住密码</label> -->
			    	<label style="color:red;">${msg }</label>
			    </li>
		    </ul>   	
    	</div>
    </div>
    </div>
    </form>
    <div class="loginbm"> Copyright ©2015-2016 厦门睿天科技有限公司版权所有</div>
</body>
</html>
