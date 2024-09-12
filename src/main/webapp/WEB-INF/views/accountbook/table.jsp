<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="<c:url value="/resources/css/table.css"/>">
<script type="text/javascript" src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<h1 class="text-center mb-5">표</h1>
<p style="font-size: 1.5em;"><strong>
	<c:choose>
		<c:when test="${curDate eq null || curDate eq ''}">
		${searchBegin} ~ ${searchEnd} 
		</c:when>
		<c:otherwise>
		${curDate}
		</c:otherwise> 
	</c:choose></strong>의 수입/지출 내역</p>

<div class="d-flex wrapper" style="gap: 3em;">
	<div class="table-box w-75">
		<table class="table table-striped text-center">
			<thead>
				<tr>
					<th>유형</th>
					<th>분류</th>
					<th>금액</th>
					<th>수단</th>
					<th>메모</th>
					<th>날짜</th>
					<th>정기결제</th>
					<th>제어</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ab_list }" var="ab">
					<%-- ${comments[n].name} --%>
					<tr>
						<td>${at_list[ab.ab_at_num-1].at_name}</td>
						<td>${pp_list[ab.ab_pp_num-1].pp_name}</td>
						<td><fmt:formatNumber value="${ab.ab_amount}" pattern="#,###"/></td>
						<td>${pt_list[ab.ab_pt_num-1].pt_name}</td>
						<td>${ab.ab_detail }</td>
						<td><fmt:formatDate value="${ab.ab_date}" pattern="yyyy-MM-dd" /></td>
						<td>
						<c:if test="${ab.ab_period eq 1}"> 매주 </c:if> 
						<c:if test="${ab.ab_period eq 2}"> 격주 </c:if> 
						<c:if test="${ab.ab_period eq 3}"> 매달 </c:if>
						</td>
						<td style=" display: flex; gap: 1px;">
						<a class="btn btn-outline-dark accountbook-update" href="javascript: void(0);" onclick="openUpdate(${ab.ab_num})" data-toggle="modal" data-target="#modal">수정</a>
						<a class="btn btn-outline-dark accountbook-delete" href="<c:url value="/accountbook/delete?ab_num=${ab.ab_num}"/>">삭제</a>
						</td>
					</tr>
				</c:forEach>
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
					<input type="date" class="form-control" id="begin" name="search_begin" <c:if test="${searchBegin ne null && searchBegin ne ''}">value="${searchBegin }" </c:if> > 
					<label for="end-date">종료일:</label> 
					<input type="date" class="form-control" id="end" name="search_end" <c:if test="${searchEnd ne null && searchEnd ne ''}">value="${searchEnd }" </c:if>>
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
		<div class="total-amount border mt-3 p-2">
			<div class="d-flex">
				<div class="w-50 mr-1">
					<strong class="btn border p-0 mb-2 d-block">수입</strong>
					<div class="text-right"><fmt:formatNumber value="${totalIncome}" pattern="#,###"/></div>
				</div>
				<div class="w-50 ml-1">
					<strong class="btn border p-0 mb-2 d-block">지출</strong>
					<div class="text-right"><fmt:formatNumber value="${totalExpense}" pattern="#,###"/></div>
				</div>
			</div>
			<div class="mt-2">
				<strong class="btn border p-0 mb-2 d-block">수입-지출</strong>
				<div class="text-right">
					<h4><fmt:formatNumber value="${totalIncome-totalExpense}" pattern="#,###"/></h4>
				</div>
			</div>
		</div>
	</div>
</div>

<script>

function openUpdate(num){
	$.ajax({
		url: '<c:url value="/accountbook/update"/>',
		type: 'get',
		data: {
			ab_num : num
		},
		success: function(data){
			$('.modal').addClass('show');
			$('.modal-content').html(data);
		},
		error : function(xhr){
			console.log(xhr);
		}
	})
}

function searchDate(changeMonth) {
	try {
		
		if(changeMonth == 0) { 
			// 0일 경우, 이번 달로 넘어오도록
			nowDate = new Date();
		}else {		
			// 검색한 날짜를 Date 포맷으로 변경
			nowDate = new Date("${curDate}");
		}
			searchDate = new Date(nowDate.setMonth(nowDate.getMonth() + changeMonth));
		
		// 검색할 날짜에 대한 새로운 Date 변수
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

$('.accountbook-delete').click(function(e){
	if ('${user.me_id}' == null || '${user.me_id}' == ab_me_id) {
		return false;
	}
	if (confirm('정말 삭제하시겠습니까?'))
		return true;
	else
		return false;
})

$(document).ready(function(){
    $('.table').DataTable({});
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />