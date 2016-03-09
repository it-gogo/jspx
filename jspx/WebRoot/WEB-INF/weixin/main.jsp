<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <title>微网操作入口</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <link href="<%=request.getContextPath() %>/weixin/css/bootstrap.min.css" rel="stylesheet" media="screen">
     <link href="<%=request.getContextPath() %>/weixin/css/base.css" rel="stylesheet" media="screen">
    <link href="<%=request.getContextPath() %>/weixin/css/info.css" rel="stylesheet" media="screen">
    
    <script src="<%=request.getContextPath() %>/admin/script/jquery.min.js"></script>
    <link href="<%=request.getContextPath() %>/weixin/css/mobiscroll.custom-2.6.2.min.css" rel="stylesheet" type="text/css" />
	<script src="<%=request.getContextPath() %>/weixin/js/mobiscroll.custom-2.6.2.min.js" type="text/javascript"></script>
	
	<script type="text/javascript">
        $(function () {
            var curr = new Date().getFullYear();
            var opt = {
            }
            opt.date = {preset : 'date'};
			opt.datetime = { preset : 'datetime', minDate: new Date(2012,3,10,9,22), maxDate: new Date(2014,7,30,15,44), stepMinute: 5  };
			opt.time = {preset : 'time'};
			opt.tree_list = {preset : 'list', labels: ['Region', 'Country', 'City']};
			opt.image_text = {preset : 'list', labels: ['Cars']};
			opt.select = {preset : 'select'};
      		$('.Hdate').val('').scroller('destroy').scroller($.extend(opt['datetime'], {dateFormat : 'yy-mm-dd',timeFormat : 'HH:ii', theme: 'default', mode: 'scroller', display: 'modal', lang: 'zh' }));
        });
    </script>
  </head>
<body>
	<header>
		<div class="left-box">
			<a href="javascript:history.back()">
				<img src="<%=request.getContextPath() %>/weixin/css/home.png" />
			</a>
		</div>
		<h1>选择入口进行相应的操作</h1>
	</header>
	<div class="box_ui_sy1">
	<ul>
				<li>
		            <a href="bindPage.do?openid=${openid}">微信号绑定</a>
		        </li>
   		</ul>
   	</div>
	
	<%@include file="/WEB-INF/weixin/common/footer.jsp" %>
</body>
</html>