<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달력</title>

<jsp:include page="/WEB-INF/views/common/head.jsp" />

<style>
html, body {
	height: 100%;
	margin: 0px;
}

td {
	width: 100px;
	height: 100px;
}

th {
	height: 30px;
	font-weight: normal;
}
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div style="display: flex;">
		<div class="container"
			style="min-height: calc(100vh - 237px); float: left;">
			<div class="container mt-3">
				<div class="mt-3 mb-3 p-3 d-flex justify-content-between">
					<span> <a class="btn btn-outline-dark btn-sm"
						href="<c:url value="/moneybook?year=${cal.year}&month=${cal.month-1}"/>">
							[이전달] </a>
					</span> 
					<span class="fw-bold fs-3">${cal.year}년 ${cal.month+1}월</span> 
					<span>
						<a class="btn btn-outline-dark btn-sm"
						href="<c:url value="/moneybook?year=${cal.year}&month=${cal.month+1}"/>">
							[다음달] </a>
					</span>
				</div>
				<div>
					<table class="table text-left table-bordered">
						<tr class="table-light text-center fs-5 tr-h">
							<th class="text-danger">일</th>
							<th>월</th>
							<th>화</th>
							<th>수</th>
							<th>목</th>
							<th>금</th>
							<th class="text-primary">토</th>
						</tr>
						<tr>
							<c:forEach begin="1" end="${cal.tdCnt}" step="1" var="i">
							<td>
							<c:choose>
								<c:when test="${(i > cal.startBlankCnt) && (i <= cal.startBlankCnt + cal.lastDate)}">
									<c:choose>
									<c:when test="${i % 7 == 0 }">
										<span class="text-primary">${i - cal.startBlankCnt }</span>
									</c:when>
									<c:when test="${i % 7 == 1 }">
										<span class="text-danger">${i - cal.startBlankCnt }</span>
									</c:when>
									<c:otherwise>
										<span> ${i - cal.startBlankCnt }</span>
									</c:otherwise>
									</c:choose>
								</c:when> 
								<c:otherwise>
									&nbsp;
								</c:otherwise>
							</c:choose>
							</td>
							<c:if test="${(i != cal.tdCnt) && (i % 7 == 0) }">
							</tr>
							<tr>							
							</c:if>
        					</c:forEach>
						</tr>
					</table>
				</div>
				<!--  
				1. bootstrap 적용
				2. 첫번줄 일 월 화 수 목 금 토 
				3. 토요일 파란색 / 일요일 빨간색
			-->

			</div>
		</div>
		<div class="container mt-4"
			style="min-height: calc(100vh - 245px); display: inline-block;">
			<table class="table table-hover">
				<thead>

				</thead>
				<tbody>
					<tr>
						<td>24/08/23 12:30</td>
						<td></td>
						<td colspan=2>더미 1</td>
						<td>85,000</td>
						<td></td>
						<td>신용카드</td>
					</tr>
					<tr>
						<td>24/08/23 12:30</td>
						<td></td>
						<td colspan=2>더미 2</td>
						<td>45,000</td>
						<td></td>
						<td>신용카드</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>