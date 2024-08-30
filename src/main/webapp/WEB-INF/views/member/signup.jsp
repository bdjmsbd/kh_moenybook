<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입</title>

<jsp:include page="/WEB-INF/views/common/head.jsp" />
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/additional-methods.min.js"></script>

<style type="text/css">
label.error {
	color: red;
}

button.btn-dup {
	background-color: rgb(50, 200, 80);
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container" style="min-height: calc(100vh - 246px)">
		<h1>회원 가입</h1>
		<form action="<c:url value="/signup"/>" method="post" id="form">

			<div class="form-group">
				<label for="id">아이디:</label>
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="id" name="id">
					<div class="input-group-append">
						<button type="button"
							class="input-group-text btn btn-outline-success btn-dup mb-3">아이디
							중복 검사</button>
					</div>
					<label class="error" for="id" generated="true"
						style="display: none;">에러에러</label>
				</div>
			</div>
			<div class="form-group">
				<label for="pwd">비밀번호:</label> <input type="password"
					class="form-control" id="pwd" name="pwd">
			</div>
			<div class="form-group">
				<label for="pwd2">비밀번호 확인:</label> <input type="password"
					class="form-control" id="pwd2" name="pwd2">
			</div>
			<div class="form-group">
				<label for="email">이메일:</label> <input type="text"
					class="form-control" id="email" name="email">
			</div>
			<button type="submit" class="btn btn-outline-success col-12">회원가입</button>
		</form>
	</div>



	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script type="text/javascript">
		var flag = false;

		$('#form')
				.validate(
						{
							rules : {
								id : {
									required : true,
									regex : /^\w{6,13}$/
								},
								pwd : {
									required : true,
									regex : /^(?=.*[A-Z])(?=.*[a-z])(?=.*[\d])(?=.*[^\w])([^\w]{1}|[\w]{1}){6,15}$/
								},
								pwd2 : {
									equalTo : pwd
								},
								email : {
									required : true,
									email : true
								}
							},
							messages : {
								id : {
									required : '필수 항목입니다.',
									regex : '아이디는 영어, 숫자만 가능하며, 6~13자이어야 합니다.'
								},
								pwd : {
									required : '필수 항목입니다.',
									regex : '영어 대소문자, 숫자, 특수문자가 꼭 들어가야 하며, 6~15자이어야 합니다.'
								},
								pwd2 : {
									required : '필수 항목입니다.',
									equalTo : '비번이 일치하지 않습니다.'
								},
								email : {
									required : '필수 항목입니다.',
									email : '올바른 이메일 형식이 아닙니다'
								}
							},
							submitHandler : function() {
								if (!flag) {
									alert('아이디 중복 검사를 하세요.');
									return false;
								}
								return checkId();
							}
						});

		$.validator.addMethod('regex', function(value, element, regex) {
			var re = new RegExp(regex);
			return this.optional(element) || re.test(value);
		}, "정규표현식을 확인하세요.");

		$('.btn-dup').click(function() {
			//아이디를 가져옴.
			var id = $('[name=id]').val();
			//아이디 유효성 검사 확인
			var regex = /^\w{6,13}$/;
			if (!regex.test(id)) {
				alert('아이디는 영어, 숫자만 가능하며, 6~13자이어야 합니다.');
				return;
			}
			if (checkId()) {
				alert('사용 가능한 아이디입니다.');
				flag = true;
			} else {
				alert('이미 사용 중인 아이디입니다.');
			}
		});

		function checkId() {

			var res = false;
			var id = $('[name=id]').val();

			$.ajax({
				async : false,
				url : '<c:url value="/check/id"/>',
				data : {
					me_id : id
				},
				success : function(data) {
					res = data.result;
				},
				error : function(xhr) {
					console.log(xhr);

				}
			});
			return res;
		}

		$('[name=id]').change(function() {
			flag = false;
		});
	</script>
</body>
</html>