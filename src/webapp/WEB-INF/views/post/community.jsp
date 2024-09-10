<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container" style="min-height: calc(100vh - 0px);">
<h1 class="mt-3 mb-3">커뮤니티 목록</h1>
<ul class="list-group">
	<c:forEach items="${list}" var="co">
		<li class="list-group-item" style="text-align: center; ">
			<a href="<c:url value="/post/list?co_num=${co.co_num}"/>">${co.co_name}</a>
		</li>
	</c:forEach>
</ul>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />