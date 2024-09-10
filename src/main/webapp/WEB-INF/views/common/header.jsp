<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<header>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

	<c:set var="now" value="<%=new java.util.Date()%>" />
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate" />
	
	<a class="open-menu" onclick="openMenu();"> 
	<i class="fa-solid fa-bars"></i>
	</a>
	<nav id="gnb">
		<ul>
			<li><a href="<c:url value="/" />">하루소비</a></li>
			<li><a href="<c:url value="/table?searchDate=${nowDate}" />">가계부(표)</a></li>
			<li><a href="<c:url value="/accountbook" />">가계부(달력)</a></li>
			<li><a href="<c:url value="/graph" />">가계부(그래프)</a></li>
			<li><a href="<c:url value="/board" />">게시판</a></li>
		</ul>
	</nav>

	<script>
		function openMenu() {
			$('header').toggleClass('show');
		}
	</script>
</header>

<nav id="login-menu">
	<ul>
		<c:choose>
			<c:when test="${user == null }">
				<li><a href="<c:url value="/login" />">로그인</a></li>
				<li><a href="<c:url value="/signup" />">회원가입</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="<c:url value="/mypage" />">마이페이지</a></li>
				<li><a href="<c:url value="/logout" />">로그아웃</a></li>
			</c:otherwise>
		</c:choose>
	</ul>
</nav>
<section id="body" class="container">