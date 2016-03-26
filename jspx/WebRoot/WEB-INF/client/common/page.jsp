<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<div id="pageBarWarpper">
	<form name="pageBarForm" id="pageBarForm" action="list.do?sectionId=${section.id}" method="post">
		<div id="pageBarLine">
			<div class="left">
				第<span>${pageBean.page }</span>页 / 共<span>${pageBean.totalPage }</span>页&nbsp;每页
				<span><input type="text" name="rows" value="${pageBean.rows }" class="inbox" /></span>条&nbsp;共计<span>${pageBean.totalRows }</span>条
			</div>
			<div class="right">
				<img src="<%=request.getContextPath()%>/client/portal/images/first.GIF"page="1" width="15" height="14" border="0" class="navigator"title="第一页" /> 
				<c:if test="${pageBean.hasPreviousPage }">
					<img src="<%=request.getContextPath()%>/client/portal/images/prev.GIF" page="${pageBean.page-1 }" width="13" height="14" border="0" class="navigator" title="上一页" /> 
				</c:if>
				<c:forEach begin="1" end="${pageBean.totalPage }" varStatus="i">
					<a name="page1" flag="navNum" title="第${i.index }页" href="javascript:void(0);" page="${i.index }" <c:if test="${pageBean.page==i.index }">class="curr"</c:if>>${i.index }</a> 
				</c:forEach>
				<c:if test="${pageBean.hasNextPage }">
					<img src="<%=request.getContextPath()%>/client/portal/images/next.GIF" page="${pageBean.page+1 }" width="13" height="14" border="0" class="navigator" title="下一页" />
				</c:if> 
				<img src="<%=request.getContextPath()%>/client/portal/images/last.GIF" page="${pageBean.totalPage }" width="15" height="14" border="0" class="navigator" title="最后一页" /> 
				第<input name="page" id="page" value="1" type="text" maxlength="5" class="box">页
				<input  class="go" type="image" src="<%=request.getContextPath()%>/client/portal/images/go.gif" width="33" height="18" border="0" onclick="javascript:$('#pageBarForm').submit();" />
			</div>
		</div>
	</form>
</div>
<script language="javascript" type="text/javascript">
$("#pageBarLine img.navigator").each(function(){
	$(this).click(function(){
		$("#page").val($(this).attr("page"));
		$("#pageBarForm").submit();
	})
});
$("#pageBarLine a[flag='navNum']").each(function(){
	$(this).click(function(){
		$("#page").val($(this).attr("page"));
		$("#pageBarForm").submit();
	})
});
</script>