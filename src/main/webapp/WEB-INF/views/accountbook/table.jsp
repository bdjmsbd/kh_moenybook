<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
.table-box {height: 70vh;}

.checkbox-group {
	display: flex;
	gap: 10px; /* 체크박스와 레이블 사이의 간격 */
	align-items: center;
}

.checkbox-group input[type="radio"] {
	position: absolute;
	opacity: 0; /* 기본 체크박스 숨기기 */
}

.checkbox-group label {
	display: flex;
	align-items: center;
	padding: 5px 5px;
	background-color: #F9FAFC;
	cursor: pointer;
	transition: background-color 0.3s, border-color 0.3s;
	font-size: 16px;
	font-family: Arial, sans-serif;
	position: relative;
	width: 30%;
	justify-content: center;
}

.checkbox-group input[type="radio"]:checked+label {
	background-color: #007bff;
	color: var(--white) !important;
}

.checkbox-group input[type="radio"]:checked+label::before {
	background: #F9FAFC;
	color: #666;
}

@media all and (max-width: 1024px) {
	.wrapper.d-flex {flex-direction: column;}
	.table-box {width: 100% !important; max-height: 50vh;}
	.right-content-container {width: 100% !important;}
}
</style>

<h1 class="text-center mb-5">표</h1>
<h2>검색 &lt; ${curDate}${searchPeriod} &gt;</h2>
<div class="d-flex wrapper" style="gap: 3em;">
	<div class="table-box overflow-auto w-75">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>유형</th>
					<th>분류</th>
					<th>금액</th>
					<th>수단</th>
					<th>메모</th>
					<th>날짜</th>
					<th>정기결제</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${user ne null }">
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
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="7" class="text-center">
								내역을 보려면 로그인해주세요
								<a href="<c:url value="/login"/>" class="w-25 m-auto btn btn-primary" style="margin-top: 1em !important;">로그인</a>
							</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	<div class="right-content-container w-25">
		<div class="form-box p-3 border" style="border: 1px solid;">
			<form action="<c:url value="/accountbook/search"/>">
				<label>유형 선택 :</label>
				<div class="checkbox-group">
					<input type="radio" id="both" class="form-check-input" value="0" name="at_num" checked>
					<label for="both" class="form-check-label btn text-dark">둘다</label>
					<input type="radio" id="income" class="form-check-input" value="1" name="at_num">
					<label for="income" class="form-check-label btn text-dark">수입</label>
					<input type="radio" id="expense" class="form-check-input" value="2" name="at_num">
					<label for="expense" class="form-check-label btn text-dark">지출</label>
				</div>
				<div class="form-group mt-2">
					<label for="begin-date">시작일:</label>
					<input type="date" class="form-control" id="begin" name="search_begin">
					<label for="end-date">종료일:</label>
					<input type="date" class="form-control" id="end" name="search_end">
				</div>
				<button type="submit" class="btn w-100 btn-primary">조회</button>
			</form>
		</div>
		<div class="mt-3 w-100 btn-group">
			<a class="btn btn-outline-light text-dark" onclick=searchDate(-1) href="javascript:void(0);">이전 달</a>
			<a class="btn btn-outline-light text-dark" onclick=searchDate(0) href="javascript:void(0);">이번 달</a>
			<a class="btn btn-outline-light text-dark" onclick=searchDate(+1) href="javascript:void(0);">다음 달</a>
		</div>
		<hr>
		<div class="total-amount mt-3">
			<div class="d-flex">
				<div class="border btn p-2 w-50 mr-1">
					<strong class="btn border p-0 mb-2">수입</strong>
					<div><fmt:formatNumber value="${totalIncome}" pattern="#,###"/></div>
				</div>
				<div class="border btn p-2 w-50 ml-1">
					<strong class="btn border p-0 mb-2">지출</strong>
					<div><fmt:formatNumber value="${totalExpense}" pattern="#,###"/></div>
				</div>
			</div>
			<div class="border btn p-2 mt-2">
				<strong class="btn border p-0 mb-2">수입-지출</strong>
				<div><fmt:formatNumber value="${totalIncome-totalExpense}" pattern="#,###"/></div>
			</div>
		</div>
	</div>
</div>

<script>

function searchDate(changeMonth) {
	
	try {
		
		if(changeMonth == 0) { 
			// 0일 경우, 이번 달로 넘어오도록
			nowDate = new Date();
		}else {		
			// 검색한 날짜를 Date 포맷으로 변경
			nowDate = new Date(curDate);
		}
		
		// 검색할 날짜에 대한 새로운 Date 변수
		searchDate = new Date(nowDate.setMonth(nowDate.getMonth() + changeMonth));
    } catch (error) {
        // 오류가 발생했을 때 실행할 코드
       searchDate = new Date();
        alert('올바른 날짜를 입력해주세요. \n이번 달로 넘어갑니다.')
    }
	
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