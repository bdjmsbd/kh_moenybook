<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ������</title>

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
		<h1>ȸ�� ����</h1>
		<form action="<c:url value="/signup"/>" method="post" id="form">

			<div class="form-group">
				<label for="id">���̵�:</label>
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="id" name="id">
					<div class="input-group-append">
						<button type="button"
							class="input-group-text btn btn-outline-success btn-dup mb-3">���̵�
							�ߺ� �˻�</button>
					</div>
					<label class="error" for="id" generated="true"
						style="display: none;">��������</label>
				</div>
			</div>
			<div class="form-group">
				<label for="pwd">��й�ȣ:</label> <input type="password"
					class="form-control" id="pwd" name="pwd">
			</div>
			<div class="form-group">
				<label for="pwd2">��й�ȣ Ȯ��:</label> <input type="password"
					class="form-control" id="pwd2" name="pwd2">
			</div>
			<div class="form-group">
				<label for="email">�̸���:</label> <input type="text"
					class="form-control" id="email" name="email">
			</div>
			<button type="submit" class="btn btn-outline-success col-12">ȸ������</button>
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
									required : '�ʼ� �׸��Դϴ�.',
									regex : '���̵�� ����, ���ڸ� �����ϸ�, 6~13���̾�� �մϴ�.'
								},
								pwd : {
									required : '�ʼ� �׸��Դϴ�.',
									regex : '���� ��ҹ���, ����, Ư�����ڰ� �� ���� �ϸ�, 6~15���̾�� �մϴ�.'
								},
								pwd2 : {
									required : '�ʼ� �׸��Դϴ�.',
									equalTo : '����� ��ġ���� �ʽ��ϴ�.'
								},
								email : {
									required : '�ʼ� �׸��Դϴ�.',
									email : '�ùٸ� �̸��� ������ �ƴմϴ�'
								}
							},
							submitHandler : function() {
								if (!flag) {
									alert('���̵� �ߺ� �˻縦 �ϼ���.');
									return false;
								}
								return checkId();
							}
						});

		$.validator.addMethod('regex', function(value, element, regex) {
			var re = new RegExp(regex);
			return this.optional(element) || re.test(value);
		}, "����ǥ������ Ȯ���ϼ���.");

		$('.btn-dup').click(function() {
			//���̵� ������.
			var id = $('[name=id]').val();
			//���̵� ��ȿ�� �˻� Ȯ��
			var regex = /^\w{6,13}$/;
			if (!regex.test(id)) {
				alert('���̵�� ����, ���ڸ� �����ϸ�, 6~13���̾�� �մϴ�.');
				return;
			}
			if (checkId()) {
				alert('��� ������ ���̵��Դϴ�.');
				flag = true;
			} else {
				alert('�̹� ��� ���� ���̵��Դϴ�.');
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