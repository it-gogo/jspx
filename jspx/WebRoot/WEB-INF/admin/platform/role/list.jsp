<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>




<!DOCTYPE html>
<html lang="zh-Cn">
	<head>
		<%@include file="/WEB-INF/admin/common/head.jsp" %>
		<script type="text/javascript" src="<%=request.getContextPath() %>/admin/script/platform/role.js"></script>
		<script type="text/javascript">
			var dataGrid;
		 	$(document).ready(function(){
			  	var gridoption = {url:"list.do",id:"grid",pagination:true};
			  	dataGrid = $.initBasicGrid(gridoption); 
		 	});
		 

/**
 * 操作信息
 * @param value
 * @param row
 * @param index
 * @returns {String}
 */
function  handlerstr(value,row,index){
	  var json = $.toJSON(row);
	  var creator=row.creator;
	  var userId="${user.id}";
	  var  handstr="";
	  if(creator==userId){
	      handstr += "<a  class=\"grid_button\"  href='javascript:void(0)'  iconCls='icon-lock'  plain='true' onclick='bindMenu("+json+")';>绑定模块</a> ";
	     handstr +="<a  class=\"grid_button\"  href='javascript:void(0)'  iconCls='icon-man'  plain='true' onclick='bindUser("+json+")';>绑定用户</a> ";
	     handstr +="<a  class=\"grid_button\"  href='javascript:void(0)'  iconCls='icon-edit'  plain='true' onclick='loadF("+json+")';>修 改</a> ";
	     if(row.status=="启用"){
	  	   handstr += "<a  class=\"grid_button\"  href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-clear' plain='true' onclick='changeStatus("+json+");'>禁 用</a>&nbsp;&nbsp;";
	    }else{
	  	   handstr += "<a  class=\"grid_button\"  href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-ok' plain='true' onclick='changeStatus("+json+");'>启 用</a>&nbsp;&nbsp;";
	    }
	  }else{
	  	handstr +="<a  class=\"grid_button\"  href='javascript:void(0)'  iconCls='icon-man'  plain='true' onclick='bindUser("+json+")';>绑定用户</a> ";
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
		          <form class="bjaa" id="qform">
		          <table>
		          <tr>
		            <td>名称:</td>
		            <td>
		            	<input type="text" class="easyui-validatebox" id="name" name="name" value="">
		            </td>
		            <td>
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryF('qform');">查  询</a>&nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="$.queryAllF('qform');">全  部</a>&nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addF();">新  增</a> &nbsp;&nbsp;
		              <a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="deleteAllF();">删 除</a>
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
            	<th data-options="field:'id'" width="10" checkbox=true ></th>
                <th data-options="field:'name'" width="80">名称</th>
                <th data-options="field:'status'" width="50">状态</th>
                <th data-options="field:'handler'" width="70" formatter="handlerstr" align="center">操作</th>
            </tr>
        </thead>
    </table>
    </div>
    </div>
    </div>
	</body>
</html>
