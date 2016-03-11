<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/supervise/customize.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
	

function  handlerstatus(value,row,index){
	  var json = $.toJSON(row);
   var  handstr = "<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-edit' plain='true' onclick='loadF("+json+")';>修 改</a> "+
   							"<a  class=\"grid_button\" href='javascript:void(0)'  iconCls='icon-cancel' plain='true' onclick='deleteF("+json+")';>删 除</a> ";
   if(row.status=="启用"){
  	   handstr += "<a  class=\"grid_button\" href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-clear'  plain='true' onclick='changestatus("+json+");'>禁 用</a>&nbsp;&nbsp;";
    }else{
  	   handstr += "<a  class=\"grid_button\" href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-ok' plain='true' onclick='changestatus("+json+");'>启 用</a>&nbsp;&nbsp;";
    }
   return  handstr;
}

		</script>
		
	</head>
	<body >
		   <div class="easyui-panel" style="padding:5px;"  data-options="fit:true,border:false">
		   	<div class="easyui-layout" data-options="fit:true" >
		     <div data-options="region:'north'" style="height:35px;">
		       <div style="width:100%;height:100%">
		          <form id="qform">
		          <table>
		          <tr>
		            <td>名称:</td>
		            <td>
		            			            	<input type="text" class="easyui-validatebox" name="name" id="name" >&nbsp;&nbsp;
		            	开始时间:<input name="startDate" id="startDate" type="text" class="easyui-datebox textbox" data-options="editable:false"  >
		            	&nbsp;&nbsp;
		            	结束时间:<input name="endDate" id="endDate" type="text" class="easyui-datebox textbox" data-options="editable:false"  >
		            </td>
		            <td>
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查  询</a>
		              &nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全  部</a>
		              &nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新  增</a>
		            </td>
		          </tr>
		          </table>
		          </form>
		       </div>
		     </div>
		   <div data-options="region:'center'">
		    <table id="grid">
        <thead>
            <tr>
            	<!-- <th data-options="field:'id'" width="10" checkbox=true ></th> -->
                <th data-options="field:'name',align:'center'" width="25">督导项目名称</th>
                <th data-options="field:'superviseDate',align:'center'" width="30">时间</th>
                <th data-options="field:'type',align:'center'" width="30" >类型</th>
                <th data-options="field:'handler'" width="70" formatter="handlerstatus" align="center">操作</th>
            </tr>
        </thead>
    </table>
    </div>
    </div>
    </div>
	</body>
</html>
