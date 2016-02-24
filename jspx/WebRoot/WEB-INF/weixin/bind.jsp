<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript">
    var formobj;
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"save.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $("#sbutton").bind('click',function(){
			 $("#dform").submit();
		 });
	});
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform">
            <input name="weixin_code"  type="hidden" value="${openid }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
			        <th>身份证号</th>
					<td><input name="id_card_no" type="text" class="easyui-validatebox textbox"  data-options="required:true,validType:'checkText'" placeholder="请输入身份证号"  value="">&nbsp;<span>*</span></td>
				</tr>
			</table>
			<div style="padding: 10px;text-align: center;">
			    	<a id="sbutton" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-save'" >保存</a>
			</div>
		</form>
     </div>
  </body>
</html>

