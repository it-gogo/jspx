<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>异常信息提示页面</title>
<head>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/error/style/dandelion.css" />
<script type="text/javascript">
(function($) {
	$(document).ready(function() {			
		$('#astronaut')
			.sprite({fps: 30, no_of_frames: 1})
			.spRandom({top: 30, bottom: 200, left: 30, right: 200})
		$('#space').pan({fps: 40, speed: 3, dir: 'right', depth: 50});
	});
})(jQuery);	
</script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/error/style/new_css.css" />
</head>

<body>
    
	<div id="da-wrapper" class="fluid">
    
        <!-- Content -->
        <div id="da-content">
            
            <!-- Container -->
            <div class="da-container clearfix">
            
            	<div id="da-error-wrapper">
            		<div class="bj">
            			<div class="fanhui"><a href="#"><img src="<%=request.getContextPath()%>/error/images/fanhui_03.png" alt="" />返回</a></div>
            		</div>
                	
                </div>
            </div>
        </div>
        
        <!-- Footer -->
        <div id="da-footer">
        	<div class="da-container clearfix">
           	<p> Copyright ©2013-2015 All Rights Reserved 厦门睿天科技有限公司</div>
        </div>
    </div>
    
</body>
</html>