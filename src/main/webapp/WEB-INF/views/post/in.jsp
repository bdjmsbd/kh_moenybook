<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="jumbotron">
	<p><em>${community.co_name}</em></p>
	<h2>${post.po_title}</h2>
	<div class="info">
		<p style="float: left;"><strong>${post.po_me_id}</strong> | <fmt:formatDate value="${post.po_date}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
		<p style="float: right;">조회수 : ${post.po_view}</p>
	</div>
</div>
<div style="min-height: 400px;">${post.po_content }</div>

	<a href="<c:url value="/post/list?co_num=${post.po_co_num}"/>" class="btn btn-outline-dar btn-lg mr-2" style="background: #3b4890; border-color: #29367c; text-shadow: 0px -1px #1d2761; color: #fff">목록</a>	
<div style="float: right;">
	<c:if test="${user.me_id == post.po_me_id}">
		<a href="<c:url value="/post/update?po_num=${post.po_num}"/>" class="btn btn-lg mr-2" style="background: #666; border-color: #444; text-shadow: 0px -1px #474747; color: #fff;">수정</a>
		<a href="<c:url value="/post/delete?po_num=${post.po_num}"/>" class="btn btn-lg btn-del" style="background: #666; border-color: #444; text-shadow: 0px -1px #474747; color: #fff;">삭제</a>
	</c:if>
</div>				

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />