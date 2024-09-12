<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="modal-header">
	<h4 class="modal-title">이메일 변경</h4>
	<button type="button" class="close" data-dismiss="modal">×</button>
</div>

<div class="modal-body">
	<form action="<c:url value="/member/updateemail"/>" method="post"
		id="form">
		<div class="form-group">
		<label for="oldemail">기존 이메일:</label>
		<input type="text" class="form-control" id="oldemail" name="oldemail" readonly="readonly" value="${user.me_email }">
	</div>
	<div class="form-group">
		<label for="newemail">새 이메일:</label>
		<input type="text" class="form-control" id="newemail" name="newemail">
	</div>
	<button type="submit" class="col-12 btn-submit btn">수정</button>
	</form>
</div>