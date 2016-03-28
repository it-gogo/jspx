<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
	<%@include file="/WEB-INF/admin/common/head.jsp" %>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/site/articleManagement.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/ajaxfileupload.js"></script>
    <script >
		window.UEDITOR_HOME_URL = "<%=request.getContextPath()%>/ueditor/";
	</script>
	<script language="javascript" src="<%=request.getContextPath() %>/ueditor/ueditor.config.js" ></script>
	<script language="javascript" src="<%=request.getContextPath() %>/ueditor/ueditor.all.min.js" ></script>
	<script >
		var ue;
		$(function(){
		     ue  = UE.getEditor('editor',{
		     });
		}); 
	</script>
    <script type="text/javascript">
	var formobj;
	var cbutton = parent.$("#cbutton");
	var sbutton = parent.$("#sbutton");
	$(document).ready(function(){
		var  formOptions = {id:"dform",urls:"save.do"};
		 $.initForm(formOptions);
		 //绑定保存事件
		 $(sbutton).bind('click',function(){
			 $("#dform").submit();
		 });
		 //绑定关闭事件
		 $(cbutton).bind('click',function(){
			parent.dialogMap["d3"].dialog('close');
		 });
		 
		 //设置图片的URL
		// var dataUrl = $("#picUrl").val();
		// $("#picFile").filebox('setValue',dataUrl);
		 //设置附件的URL
		 //dataUrl = $("#accessoryUrl").val();
		// $("#accessoryFile").filebox('setValue',dataUrl);
		 
		 var type=encodeURI("oa栏目");
		/*  $("#sectionId").combotree({url:"../sectionManagement/tree.do?type="+type+"&noBranchId=1"+"&ck="+Math.random()}); */
		
		 /* $("input[name^='titleHref']").blur(function(){
		 	$("#tr_body").css("display",'none');
		 }); */
		 $("input[name='useHref']").change(function(){
		 	var useHref=$(this).val();
		 	if(useHref=='1'){
		 		$("#tr_body").css("display",'none');
		 	}else{
		 		$("#tr_body").removeAttr("style");;
		 	}
		 });
		 
		 var use="${vo.titleHref}";
		 if(use!=null&&use!=''){
		 	$("#tr_body").css("display",'none');
		 }
		 
		 var treeoptions = {id:"treeID",url:"../sectionManagement/tree.do?type="+type+"&authLoginId=${user.id}",checkbox:true,cascadeCheck:false,onClick:treeClick,onLoadSuccess:setTree};
 		 $.initTree(treeoptions);
 		 
	});
/**
*点击树方法
*/
function  treeClick(node){
	if(node.checked){
		$("#treeID").tree("uncheck", node.target);
	}else{
		$("#treeID").tree("check", node.target);
	}
}
//提交前操作
function beforeSubmit(dform){
	/**
		zhangjf 处理之前先将原先处理产生的隐藏域去掉防止重复start
	*/
		$("input[name='sectionId']").remove();
	/**
		zhangjf 处理之前先将原先处理产生的隐藏域去掉防止重复end
	*/
	var node=$("#treeID").tree("getChecked");
	if(node==null || node==""){
		parent.$.messager.alert("提示窗口","至少选择一个栏目。");
		return false;
	}
	var html="";
	for(var i=0;i<node.length;i++){
		var n=node[i];
		html+="<input name=\"sectionId\"  type=\"hidden\"      value=\""+n.id+"\">";
	}
	$("#dform").prepend(html);
	$("#content").val(ue.getContent());
	return true;
}
//设置选中栏目
function setTree(/* sectionIds */){
	var sectionIds="${vo.sectionIds}";
	if(sectionIds==""){
		return;
	}
	var arr=sectionIds.split(",");
	for(var i=0;i<arr.length;i++){
		 var node=$("#treeID").tree("find",arr[i]);
		 $("#treeID").tree("check", node.target);
	}
}

function ajaxFileUpload(fileId){
	$.ajaxFileUpload({  
        /* url:"excelToTable.do", */  
        url:"../../common/xlsAnddocToStr.do",
        secureuri:false,  
        fileElementId:fileId,
        dataType: "text",
        success: function (data) {
        	ue.setContent(data);
        	/* var json=eval("("+data+")");
	        if(json.message){
	        	ue.setContent(json.message);
	        }else{
	        	parent.$.messager.alert("提示窗口",json.error);
	        } */
        },
         error: function (data) {  
            alert(data);  
        }  
    }); 
}

/**
*导入信息
*/
function importInfo(){
	$("#fileId1").click();
}


	</script>
  </head>
  <body <%-- onload="setTree('${vo.sectionIds}')" --%>>
  	<div class="easyui-layout" data-options="fit:'true',border:false" >
		<div data-options="region:'east',split:true,title:'栏目树',collapsible:true" style="width:280px;">
			<%@include file="/WEB-INF/admin/common/tree.jsp"%>
		</div>
         <div data-options="region:'center'">
         <form id="dform" method="post"  enctype="multipart/form-data"  >
         	<input name="content" type="hidden" id="content"   value="">
            <input name="id"  type="hidden"  id="id"    value="${vo.id }">
			<table width="100%" class="table table-hover table-condensed">
				<tr>
					<th>标题</th>
					<td><input name="title" type="text" class="easyui-validatebox textbox" required="required"  style="width:80%;"  value="${vo.title }"></td>
				</tr>
				<tr>
					<th>是否启用标题转向</th>
					<td>
							<input type="radio" name="useHref" checked="checked" value="-1"/>否
						<input type="radio" name="useHref" <c:if test="${!empty vo.titleHref }">checked="checked"</c:if> value="1"/>是
					</td>
				</tr>
				<tr>
					<th>标题转向地址</th>
					<td><input name="titleHref" type="text" class="easyui-validatebox textbox"   style="width:80%;"  value="${vo.titleHref }"></td>
				</tr>
				<tbody id="tr_body">
				<tr>
			        <th width="120px;">标题颜色</th>
					<td>
						<input class="easyui-combobox" id="titleColor"  name="titleColor"    style="width:80%;"  value="${vo.titleColor }"  data-options="url:'../../oa/articleTitleColor/all.do',
		                    method:'get',
		                    valueField:'color',
		                    textField:'name',
		                    editable:false
		            		">
					</td>
				</tr>
				<tr>
					<th>副标题</th>
					<td><input name="subtitle" type="text" class="easyui-validatebox textbox"   style="width:80%;"  value="${vo.subtitle }"></td>
				</tr>
				<tr>
				<tr>
					<th>标题图片</th>
					<td>
						<c:if test="${!empty vo.picUrl }">
							<span style="color:green;">原地址</span>：<span style="width: 300px;color:red;">${vo.picUrl }</span>
						</c:if>
						<input class="easyui-filebox" name="picFile" id="picFile"   data-options="prompt:'选择图片',buttonText:'选择文件'" style="width:58%;" >
						<input id="picUrl" name="picUrl" type="hidden" value="${vo.picUrl }" />
					</td>
				</tr>
				<tr>
					<th>文章附件</th>
					<td>
						<c:if test="${!empty vo.accessoryUrl }">
							<span style="color:green;">原地址</span>：<span style="width: 300px;color:red;">${vo.accessoryUrl }</span>
						</c:if>
						<input class="easyui-filebox" name="accessoryFile" id="accessoryFile" data-options="prompt:'选择附件',buttonText:'选择文件'" style="width:58%;" >
						<input id="accessoryUrl" name="accessoryUrl" type="hidden" value="${vo.accessoryUrl }" />
					</td>
				</tr>
				<%-- <tr>
			        <th width="100px;">发布部门</th>
					<td>
						<input class="easyui-combotree" id="departId"  name="departId"   style="width:80%;"  value="${vo.departId }"  data-options="url:'../../baseinfo/depart/departTree.do',
		                    method:'get',
		                    valueField:'id',
		                    textField:'name',
		                    editable:false
		            		">
					</td>
				</tr> --%>
				<tr>
					<th>关键字</th>
					<td><input name="keyword" type="text" class="easyui-validatebox textbox"   style="width:80%;"  value="${vo.keyword }"></td>
				</tr>
				<tr>
					<th>文章来源</th>
					<td>
						<c:choose>
							<c:when test="${vo==null || vo.source==null}">
								<input name="source" type="text" class="easyui-validatebox textbox"   style="width:80%;"  value="本站原创">
							</c:when>
							<c:otherwise>
								<input name="source" type="text" class="easyui-validatebox textbox"   style="width:80%;"  value="${vo.source }">
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>发布范围</th>
					<td>
						<input name="scope" checked="checked" type="radio" value="外网"  id="外网" /><label for="外网">外网</label>
						<input name="scope" <c:if test="${vo.scope=='内网' }">checked="checked"</c:if> type="radio" value="内网"  id="内网" /><label for="内网">内网</label>
					</td>
				</tr>
				<tr>
					<th>是否发布</th>
					<td>
						<input name="isPubish" checked="checked" type="radio" value="是"  id="isPubish_shi" /><label for="isPubish_shi">是</label>
						<input name="isPubish" <c:if test="${vo.isPubish=='否' }">checked="checked"</c:if> type="radio" value="否"  id="isPubish_fou" /><label for="isPubish_fou">否</label>
					</td>
				</tr>
				<tr>
					<th>是否置顶</th>
					<td>
						<input name="isTop" checked="checked" type="radio" value="是"  id="isTop_shi" /><label for="isTop_shi">是</label>
						<input name="isTop" <c:if test="${vo.isTop=='否' }">checked="checked"</c:if> type="radio" value="否"  id="isTop_fou" /><label for="isTop_fou">否</label>
					</td>
				</tr>
				<tr>
					<th>发布时间</th>
					<td>
						<input name="pubishDate" type="text" class="easyui-datetimebox textbox" data-options="editable:false"  style="width:80%;"  value="${vo.pubishDate }">
					</td>
				</tr>
				<tr>
					<th >文章简介</th>
					<td>
						<input name="introduction" type="text" data-options="multiline:true"   class="easyui-textbox textbox" style="width:80%;height:100px;"  value="${vo.introduction }">
					</td>
				</tr>
				<tr>
					<th >文章内容</th>
					<td>
					 <span  id="upload_google" >
		              		<input type="file" id="fileId1" style="display:none;" name="excel" onchange="ajaxFileUpload('fileId1');" />
			              <a  href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'"  onclick="importInfo()">
			              导入文档或表格
			              </a>
		              </span>
		              <span   id="upload_ie" style="display: none;">
			              <a style="position:relative;" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" >
			              导入文档或表格
			              <input style="position:absolute;left:0;top:0;width:100%;height:100%;z-index:999;filter:Alpha(opacity=0);" onchange="ajaxFileUpload('fileId2')" type="file" id="fileId2"  name="excel"/>
			              </a>
		              </span>
						<%-- <input name="introduction" type="text" data-options="multiline:true"   class="easyui-textbox textbox" style="width:350px;height:100px;"  value="${vo.introduction }"> --%>
						<textarea id="editor"   name="editor"  style="width:80%;"   >${vo.content }</textarea>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
     </div>
     </div>
  </body>
</html>

