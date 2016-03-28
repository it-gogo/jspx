<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript">
	var formobj;
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"save.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $('#save').bind('click',function(){
			 $("#dform").submit();
		 });
		 
		  //设置图片的URL
		 var dataUrl = $("#hLogo").val();
		 $("#hLogoFile").filebox('setValue',dataUrl);
		 
		  //设置图片的URL
		 var dataUrl = $("#bLogo").val();
		 $("#bLogoFile").filebox('setValue',dataUrl);
		 
		  //设置前台Logo的URL
		 var dataUrl = $("#qLogo").val();
		 $("#qLogoFile").filebox('setValue',dataUrl);
		 
		  var dataUrl = $("#iconUrl").val();
		 $("#iconFile").filebox('setValue',dataUrl);
		 
		 var dataUrl = $("#adPic").val();
		 $("#adFile").filebox('setValue',dataUrl);
		 
	});
	</script>
  </head>
  <body layout="easyui-layout">
         <div data-options="region:'center'">
         <form id="dform" method="post"  enctype="multipart/form-data"  >
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
			        <th>后台Title</th>
					<td><input name="hTitle" style="width: 350px;" type="text" class="easyui-validatebox textbox" value="${vo.hTitle }" data-options="required:true"></td>
				</tr>
				<tr>
			        <th>微网Title</th>
					<td><input name="wTitle" style="width: 350px;" type="text" class="easyui-validatebox textbox" value="${vo.wTitle }" data-options="required:true"></td>
				</tr>
				<tr>
			        <th>前台Title</th>
					<td><input name="qTitle" style="width: 350px;" type="text" class="easyui-validatebox textbox" value="${vo.qTitle }" data-options="required:true"></td>
				</tr>
				<tr>
					<th>后台Logo</th>
					<td>
						<input class="easyui-filebox" name="hLogoFile" id="hLogoFile" data-options="prompt:'选择图片',buttonText:'选择文件'" style="width:350px;" >
						<input id="hLogo" name="hLogo" type="hidden" value="${vo.hLogo }" />
					</td>
				</tr>
				<tr>
					<th>后台logo背景</th>
					<td>
						<input class="easyui-filebox" name="bLogoFile" id="bLogoFile" data-options="prompt:'选择图片',buttonText:'选择文件'" style="width:350px;" >
						<input id="bLogo" name="bLogo" type="hidden" value="${vo.bLogo }" />
					</td>
				</tr>
				<tr>
					<th>前台Logo</th>
					<td>
						<input class="easyui-filebox" name="qLogoFile" id="hLogoFile" data-options="prompt:'选择图片',buttonText:'选择文件'" style="width:350px;" >
						<input id="qLogo" name="qLogo" type="hidden" value="${vo.qLogo }" />
					</td>
				</tr>
				<tr>
					<th>显示前台登陆框</th>
					<!-- <td><input name="isMoreGarden" class="easyui-switchbutton" data-options="onText:'单园',offText:'多园',onValue:'单园'"></td> -->
					<td>
						<input type="radio" value="1" checked="checked" name="showLoginTab" id="显示"><label for="显示">显示</label>
						<input type="radio" value="-1" <c:if test="${vo.showLoginTab=='-1' }">checked="checked"</c:if> name="showLoginTab" id="不显示"><label for="不显示">不显示</label>
					</td>
				</tr>
				<tr>
					<th>网站图标</th>
					<td>
						<input class="easyui-filebox" name="iconFile" id="iconFile" data-options="prompt:'选择图片',buttonText:'选择文件'" style="width:350px;" >
						<input id="iconUrl" name="iconUrl" type="hidden" value="${vo.iconUrl }" />
					</td>
				</tr>
				<tr>
					<th>oa版本</th>
					<td>
						<select name="oaVersion" style="width: 350px;" class="easyui-combobox" data-options="editable:false">
							<option value="" selected="selected">基础版本</option>
							<option value="xqb" <c:if test="${vo.oaVersion=='xqb' }">selected="selected"</c:if>>校庆本</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>是否启用广告</th>
					<td>
						<input type="radio" value="启用" checked="checked" name="isShow" id="启用"><label for="启用">启用</label>
						<input type="radio" value="禁用" <c:if test="${vo.isShow=='禁用' }">checked="checked"</c:if> name="isShow" id="禁用"><label for="禁用">禁用</label>
					</td>
				</tr>
				<tr>
			        <th>广告链接地址</th>
					<td><input name="adUrl" style="width: 350px;" type="text" placeholder="http://www.baidu.com" class="easyui-validatebox textbox" value="${vo.adUrl }"></td>
				</tr>
				
				<tr>
					<th>广告图片</th>
					<td>
						<input class="easyui-filebox" name="adFile" id="adFile" data-options="prompt:'选择图片',buttonText:'选择文件'" style="width:350px;" >
						<input id="adPic" name="adPic" type="hidden" value="${vo.adPic }" />
					</td>
				</tr>
				
				<tr>
					<th>&nbsp;</th>
					<td>
						<a href="javascript:void(0);" id="save" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存修改</a>&nbsp;
					</td>
				</tr>
			</table>
		</form>
     </div>
  </body>
</html>

