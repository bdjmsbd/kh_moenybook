<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header>
	<a class="open-menu" onclick="openMenu();">
		<i class="fa-solid fa-bars"></i>
	</a>
	<nav id="gnb">
		<ul>
			<li>
				<a href="<c:url value="/" />">메인</a>
			</li>
			<li>
				<a href="<c:url value="/moneybook" />">가계부</a>
			</li>
			<li>
				<a href="<c:url value="/board" />">게시판</a>
			</li>
		</ul>
	</nav>
	
	<nav id="login-menu">
		<ul>
			<li>
				<a href="<c:url value="/mypage" />">마이페이지</a>
			</li>
			<li>
				<a href="<c:url value="/login" />">로그인</a>
			</li>
			<li>
				<a href="<c:url value="/signup" />">회원가입</a>
			</li>
		</ul>
	</nav>
	
	<script>
		function openMenu(){
			$('header').toggleClass('show');
		}
	</script>
</header>
<section id="body" class="container">