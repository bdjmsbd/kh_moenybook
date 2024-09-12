<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<h1 class="text-center mb-5">MyPage</h1>
<form action="<c:url value="/mypage"/>" method="post" id="form">
	<div class="form-group">
		<label for="id">아이디:</label> <input type="text" class="form-control"
			id="id" name="me_id" readonly="readonly" value="${user.me_id }">
	</div>
	<div class="btn btn-dark" data-toggle="modal" data-target="#modal" onclick="openUpdatePW();">비밀번호 변경</div>
	<div class="form-group mt-3">
		<label for="id">이메일:</label> <input type="text" class="form-control"
			id="id" name="me_id" readonly="readonly" value="${user.me_email }">
	</div>
	<div class="btn btn-dark" data-toggle="modal" data-target="#modal" onclick="openUpdateEmail();">이메일 변경</div>
	<div class="btn btn-dark mt-3" data-toggle="modal" data-target="#modal" onclick="openDropCheck();">회원 탈퇴</div>
</form>
<div id="modal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content"></div>
	</div>
</div>
<script>
function openUpdatePW(){
	$.ajax({
		url: '<c:url value="/member/updatepw" />',
		type: 'get',
		success: function(data){
			$('.modal').addClass('show');
			$('.modal-content').html(data);
			console.log(data);
		},
		error : function(xhr){
			console.log(xhr);
		}
	})
}
function openUpdateEmail(){
	$.ajax({
		url: '<c:url value="/member/updateemail" />',
		type: 'get',
		success: function(data){
			$('.modal').addClass('show');
			$('.modal-content').html(data);
			console.log(data);
		},
		error : function(xhr){
			console.log(xhr);
		}
	})
}
function openDropCheck(){
	$.ajax({
		url: '<c:url value="/member/deletemember" />',
		type: 'get',
		success: function(data){
			$('.modal').addClass('show');
			$('.modal-content').html(data);
			console.log(data);
		},
		error : function(xhr){
			console.log(xhr);
		}
	})
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />