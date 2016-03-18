<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/fileManagement.js"></script>
		<script type="text/javascript">
//打开文件管理	
function openFileManagement(departId,departName){
	var tab = parent.$("#main").tabs("getSelected");  // 获取选择的面板
	var tabTitle=tab.panel('options').title;
	var parentTitle=encodeURI(tabTitle);
	if (parent.$("#main").tabs("exists", departName)){
		parent.$("#main").tabs("select", departName);
		tab = parent.$("#main").tabs("getTab", departName);
	}
	
	var url="../resources/fileManagement/management.do?parentId="+departId+"&parentTitle="+parentTitle+"&topFileId="+departId;
	parent.$("#main").tabs("update", {
		tab: tab,
		options: {
			title: departName,
			//href: "management.do?topFileId="+departId  // 新内容的URL
			content:"<iframe  scrolling=\"auto\" frameborder=\"0\"   src=\""+url+"\" style=\"width:100%;height:100%;\" ></iframe>"
		}
	});
}

		
		</script>
		
	</head>
<body>
	<div class="easyui-panel" style="padding:5px;"
		data-options="fit:true,border:false">
		<div class="easyui-layout" data-options="fit:true">
			<div class="jb_bj" data-options="region:'north'" style="height:100%;/* background-color: #d2e0f2; */">
				<%-- <fieldset style="margin-top: 10px;/* border: 1px solid #9c9c9c; */">
		            <legend>科室文档</legend>
			        <div style="width:100%;height:100%">
			          <form id="qform">
				          <table>
					          <tr>
					            <td>
					            	<c:forEach items="${departList }" var="depart">
						              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-l-folder',size:'large'" plain="true" onclick="openFileManagement('${depart.id}','${depart.name }');">${depart.name }</a>&nbsp;&nbsp;
					            	</c:forEach>
					            </td>
					          </tr>
				          </table>
			          </form>
			       </div>
		       </fieldset> --%>
		       
		       <c:if test="${schoolList.size()>0 }">
		       	<fieldset style="margin-top: 10px;border: 1px solid #9c9c9c;">
		            <legend>资源文件夹</legend>
			        <div style="width:100%;height:100%">
			          <form id="qform">
				          <table>
					          <tr>
					            <td>
					            	<c:forEach items="${schoolList }" var="folder">
						              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-l-folder',size:'large'" plain="true" onclick="openFileManagement('${folder.id}','${folder.name }');">${folder.name }</a>&nbsp;&nbsp;
					            	</c:forEach>
					            </td>
					          </tr>
				          </table>
			          </form>
			       </div>
		       	</fieldset>
		       </c:if>
		       
		       <c:if test="${assessList.size()>0 }">
		       	<fieldset style="margin-top: 10px;border: 1px solid #9c9c9c;">
		            <legend>评估文件夹</legend>
			        <div style="width:100%;height:100%">
			          <form id="qform">
				          <table>
					          <tr>
					            <td>
					            	<c:forEach items="${assessList }" var="folder">
						              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-l-folder',size:'large'" plain="true" onclick="openFileManagement('${folder.id}','${folder.name }');">${folder.name }</a>&nbsp;&nbsp;
					            	</c:forEach>
					            </td>
					          </tr>
				          </table>
			          </form>
			       </div>
		       	</fieldset>
		       </c:if>
			</div>
		</div>
	</div>
</body>
</html>
