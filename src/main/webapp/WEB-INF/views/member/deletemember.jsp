<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<link rel="stylesheet" href="<c:url value="/resources/css/insert.css"/>">

<div class="modal-header">
	<h4 class="modal-title">회원 탈퇴</h4>
	<button type="button" class="close" data-dismiss="modal">×</button>
</div>

<div class="modal-body">
	<form action="<c:url value="/member/deletemember"/>" method="post"
		id="form">
		<div class="form-group">
			<label for="pw">비밀번호:</label> <input type="password" class="form-control" id="pw" name="pw">
		</div>
		<button type="submit" class="col-12 btn-submit btn">탈퇴</button>
	</form>
</div>