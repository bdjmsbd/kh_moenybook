<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f9f9f9;
	min-width: 10px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.dropdown-content .dropdown-item {
	float: none;
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	text-align: center;
}

.dropdown-content a:hover {
	background-color: #ddd;
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<ul class="navbar-nav">
			<li class="nav-item active"><a class="nav-link"
				href="<c:url value ="/"/>">Home</a></li>

			<li class="nav-item"><a class="nav-link pr-5"
				href="<c:url value="/moneybook"/>">가계부</a></li>

			<c:if test="${user == null}">
				<li class="nav-item w3-display-right" style="padding-right: 65px">
					<a class="nav-link pr-5" href="<c:url value="/signup"/>">회원가입</a>
				</li>
				<li class="nav-item w3-display-right"><a class="nav-link pr-5"
					href="<c:url value="/login"/>" > 로그인</a></li>
			</c:if>
			<c:if test="${user != null }">
				<li class="nav-item w3-display-right"><a class="nav-link pr-5"
					href="<c:url value="/logout"/>">로그아웃</a></li>
			</c:if>
			<li class="nav-item"><a class="nav-link disabled" href="#"></a>
			</li>
		</ul>
	</nav>
</body>
</html>