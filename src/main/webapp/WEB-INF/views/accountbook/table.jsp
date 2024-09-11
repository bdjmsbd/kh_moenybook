<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


<link rel="stylesheet" href="<c:url value="/resources/css/accountbook_table.css"/>">
<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<h1 class="text-center mb-5">표</h1>
<h2>검색 &lt; ${curDate}${searchPeriod} &gt;</h2>
<div class="d-flex container">
	<div class="table-box d-flex justify-content-between mr-3">

		<table class="table table-striped">
			<thead>
				<tr>
					<th>유형</th>
					<th>분류</th>
					<th>금액</th>
					<th>결제 방식</th>
					<th>메모</th>
					<th>날짜</th>
					<th>정기결제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ab_list }" var="ab">
					<%-- ${comments[n].name} --%>
					<tr>
						<td>${at_list[ab.ab_at_num-1].at_name}</td>
						<td>${pp_list[ab.ab_pp_num-1].pp_name}</td>
						<td>${ab.ab_amount}</td>
						<td>${pt_list[ab.ab_pt_num-1].pt_name}</td>
						<td>${ab.ab_detail }</td>
						<td><fmt:formatDate value="${ab.ab_date}"
								pattern="yyyy-MM-dd" /></td>
						<td><c:if test="${ab.ab_period eq 1}"> 매주 </c:if> <c:if
								test="${ab.ab_period eq 2}"> 격주 </c:if> <c:if
								test="${ab.ab_period eq 3}"> 매달 </c:if></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="right-content-container">
	<div class="form-box" style="border: 1px solid;">
		<form action="<c:url value="/accountbook/search"/>">
		    <label>유형 선택 :</label>
		    <div class="checkbox-group">
		        <input type="radio" id="both" class="form-check-input" value="0" name="at_num" checked>
		        <label for="both" class="form-check-label">둘다</label>
		        <input type="radio" id="income" class="form-check-input" value="1" name="at_num">
		        <label for="income" class="form-check-label">수입</label>
		        <input type="radio" id="expense" class="form-check-input" value="2" name="at_num">
		        <label for="expense" class="form-check-label">지출</label>
		    </div>
			<div class="form-group mt-2">
				<label for="begin-date">시작일:</label> <input type="date"
					class="form-control" id="begin" name="search_begin"> <label
					for="end-date">종료일:</label> <input type="date" class="form-control"
					id="end" name="search_end">
			</div>
			<button type="submit" class="btn btn-info mr-3 mb-2">조회</button>
		</form>
	</div>
		<div class="d-flex justify-content-between mt-2">
			<a class="btn btn-primary mr-2" onclick=searchDate(-1)
				href="javascript:void(0);"> 이전 달</a> <a class="btn btn-primary mr-2"
				onclick=searchDate(0) href="javascript:void(0);"> 이번 달</a> <a
				class="btn btn-primary mr-2" onclick=searchDate(+1)
				href="javascript:void(0);"> 다음 달</a>
		</div>
		<div class="total-amount mt-3">
			<label>수입</label>
			<div class="abc">${totalIncome}</div>

			<label>지출</label>
			<div class="abc">${totalExpense}</div>

			<label>수입-지출</label>
			<div class="abc">${totalIncome-totalExpense}</div>
		</div>
	</div>
</div>




<script>

function searchDate(changeMonth) {
	
	if(changeMonth == 0) { 
		// 0일 경우, 이번 달로 넘어오도록
		nowDate = new Date();
	}else {		
		// 검색한 날짜를 Date 포맷으로 변경
		nowDate = new Date("${curDate}");
	}
	
	// 검색할 날짜에 대한 새로운 Date 변수
	searchDate = new Date(nowDate.setMonth(nowDate.getMonth() + changeMonth));
	
	// 연도, 월, 일 추출
	const year = searchDate.getFullYear();
	const month = String(searchDate.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
	const day = String(searchDate.getDate()).padStart(2, '0');

	// 포맷된 날짜 문자열 생성
	const searchDateStr = year+'-'+month;/*  +'-'+day; */
	location.href = "<c:url value="/table?searchDate="/>" + searchDateStr;
	
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />