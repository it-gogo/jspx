<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/datagrid-detailview.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/resources/fileSubmit.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	//var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	var gridoption = {url:"list.do",id:"grid",pagination:true, view: detailview,detailFormatter:function(index,row){return detailHtml(index,row);},onExpandRow: function(index,row){return openDetail(index,row);}};
			  	dataGrid = $.initBasicGrid(gridoption); 
			  	
		 	});

 function detailHtml(index,row){
	var titles="上传人员列表";
	var res =  
      " <div id=\"cc_"+index+"  style=\"padding:1px;\">"+
         " <div id=\"subTabs_"+index+"\" style=\"width:10px;height:400px;padding:1px;\" >";
            res += "<div title=\""+titles+"\"  style=\"padding:1px;\">"+
                      "<iframe id=\"iframe_"+index+"\" scrollng=\"yes\" frameborder=\"0\"  src=\"\"  style=\"width:100%;height:100%;\"></iframe>"+
                   "</div>";
        res+=  "</div>" +
        		 "</div>";
        return  res;
}
function openDetail(index,row){
	$("#subTabs_"+index).tabs({
      		fit:true,
      		id:"s_"+index,
      		onSelect:function(title,tindex){
      			$("#iframe_"+index).attr("src","../submitTeacher/redirect.do?submitId="+row.id+"&index="+index);
      			setTimeout(function(){
      				 $('#grid').datagrid('fixDetailRowHeight',index);
                  },0);
      		}
      	});
} 
		</script>
			
	</head>
	<body >
			   <div class="easyui-panel" style="padding:5px;"  data-options="fit:true,border:false">
			   	<div class="easyui-layout" data-options="fit:true" >
			    <div class="jb_bj" data-options="region:'north'" style="height:80px;/* background-color: #d2e0f2; */">
			     <fieldset style="margin-top: 10px;/* border: 1px solid #9c9c9c; */">
		                    <legend>数据查询</legend>
			       <div style="width:100%;height:100%">
			          <form id="qform">
			          <table>
			          <tr>
			            <td>名称:</td>
			            <td>
			            	<input type="text" class="easyui-validatebox" id="title" name="title" value="">
			            </td>
			            <td>
			              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查  询</a>&nbsp;&nbsp;
			              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全  部</a>&nbsp;&nbsp;
			              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新  增</a>&nbsp;&nbsp;
			              <!-- <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="deleteAllF();">删 除</a> -->
			            </td>
			          </tr>
			          </table>
			          </form>
			       </div>
			       </fieldset>
			     </div>
						<div data-options="region:'center'">
							<table id="grid">
								<thead>
									<tr>
										<th data-options="field:'id'" width="10" checkbox=true></th>
										<th data-options="field:'title'" width="80">标题</th>
										<th data-options="field:'totalNumber'" width="10">总填表数</th>
										<th data-options="field:'submitNumber'" width="10">已填表数</th>
										<th data-options="field:'endDate'" width="20">结束时间</th>
										<th data-options="field:'creatorName'" width="20">创建账号</th>
										<th data-options="field:'createdate'" width="20">创建时间</th>
										<th data-options="field:'handler'" width="50" formatter="handlerstatus" align="center">操作</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
		   		</div>
	</body>
</html>

