<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
  <head>
    <title>微网绑定</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <link href="<%=request.getContextPath() %>/weixin/css/bootstrap.min.css" rel="stylesheet" media="screen">
     <link href="<%=request.getContextPath() %>/weixin/css/base.css" rel="stylesheet" media="screen">
    <link href="<%=request.getContextPath() %>/weixin/css/info.css" rel="stylesheet" media="screen">
    
    <script src="<%=request.getContextPath() %>/admin/script/jquery.min.js"></script>
    <link href="<%=request.getContextPath() %>/weixin/css/mobiscroll.custom-2.6.2.min.css" rel="stylesheet" type="text/css" />
	<script src="<%=request.getContextPath() %>/weixin/js/mobiscroll.custom-2.6.2.min.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	var step=0;
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
       $("#btn_").click(function(){
       	 var idcard=$("#idcard").val();
       	 if(idcard==null||idcard==''){
       	 	alert('请输入绑定的身份证号');
       	 	return;
       	 }
       		step=step+1;
       		if(step==1){
       		 	$("#dform").submit();
       		 }
       	});
       
  			//表单提交
       $('#dform').submit(function() {
			jQuery.ajax({
			url:'addBindInfo.do',
			data:$('#dform').serialize(),
			type:"POST",
			async: false,
			success:function(rs)
			{
				var json =eval("("+rs+")");
				if(json.message){
					alert(json.message);
					step=0;
				}else{
					alert(json.error);
					$('#myform')[0].reset();
					step=0;
				}
			}
			});
			
		});     
       
        });
    </script>
  </head>
<body>
	<header>
		<div class="left-box">
			<a href="javascript:history.back()">
				<img src="<%=request.getContextPath() %>/client/weixin/css/arrow-left.png" />
			</a>
		</div>
		<h1>微信绑定</h1>
	</header>
	<div class="info tc">
		<div class="box_ui_sy1 tc">

			<form id="dform" method="post" accept-charset="utf-8">
			<input type="hidden" name="openid" value="${openid}"/>
				<div class="detail">
					<h1>以下信息将作为绑定查询，请认真填写！</h1>
				<div class="detail_info">
					<ul class="mb5">
						<li>
							<strong class="bt">身份证号</strong>
							<div class="nr"><input id="idcard" type="text" name="idcard" style="width: 100%;" /></div>
						</li>
					</ul>
				</div>
				</div>
				<p>
					<input id="btn_" type="button" value="提交" class="btn btn-success" />
				</p>
			</form>
		</div>

	</div>
	
	<%@include file="/WEB-INF/weixin/common/footer.jsp" %>
</body>
</html>