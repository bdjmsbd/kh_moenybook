<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container" style="min-height: calc(100vh - 240px)">
	<h1 class="text-center mb-5">마이페이지(미완)</h1>
	<c:if test="${user == null}">
		<div class="form-group">
			<label>비밀번호 확인 : </label>
			<input type="password" class="form-control" id="pw" name="me_pw">
		</div>
		<button type="submit" class="btn btn-outline-success col-12">확인</button>
	</c:if>
	<c:if test="${user != null }">
		<div class="form-group">
			<label>아이디 : </label>
			<div class="form-control">${user.me_id}</div>
		</div>
		<div class="form-group">
			<label>닉네임 : </label>
			<div class="form-control">${user1.mp_nickname}</div>
		</div>
		<div class="form-group">
			<label>이메일 : </label>
			<div class="form-control">${user.me_email}</div>
		</div>
	</c:if>
	<c:if test="${user.me_id == post.po_me_id}">
		<a href="<c:url value="/post/update?po_num=${post.po_num}"/>" class="btn btn-outline-dark">수정</a>
		<a href="<c:url value="/post/delete?po_num=${post.po_num}"/>" class="btn btn-outline-danger">삭제</a>
		<a href="<c:url value="/post/list?co_num=${post.po_co_num}"/>" class="btn btn-outline-danger">목록</a>
	</c:if>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />