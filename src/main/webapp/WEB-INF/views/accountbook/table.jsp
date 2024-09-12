<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


<link rel="stylesheet" href="<c:url value="/resources/css/accountbook_table.css"/>">
<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css">
<script type="text/javascript" src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
.total-amount, .form-box {
	width: 300px;
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.summary {
	display: flex;
	justify-content: space-between;
	padding: 10px 0;
	border-bottom: 1px solid #ddd;
}

.summary:last-child {
	border-bottom: none;
}

.label {
	font-weight: bold;
}

.value {
	text-align: right;
}
</style>
<h1 class="text-center mb-5">표</h1>
<h3>검색 &lt;
<c:choose>
<c:when test="${curDate eq null || curDate eq ''}">
${searchBegin} ~ ${searchEnd} 
</c:when>
<c:otherwise>
${curDate}
</c:otherwise> 
</c:choose> 
&gt;</h3>
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
					<th>제어</th>
					
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
						<td>
						<c:if test="${ab.ab_period eq 1}"> 매주 </c:if> 
						<c:if test="${ab.ab_period eq 2}"> 격주 </c:if> 
						<c:if test="${ab.ab_period eq 3}"> 매달 </c:if>
						</td>
						<td style=" display: flex; gap: 1px;">
						<a class="btn btn-outline-dark accountbook-update" href="<c:url value="/accountbook/update?ab_num=${ab.ab_num}"/>">수정</a>
						<a class="btn btn-outline-dark accountbook-delete" href="<c:url value="/accountbook/delete?ab_num=${ab.ab_num}"/>">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="ml-5 right-content-container">
		<div class="form-box">
			<form action="<c:url value="/accountbook/search"/>">
				<label>유형 선택 :</label>
				<div class="form-group checkbox-group">
					<input type="radio" id="both" class="form-check-input" value="0" name="at_num" <c:if test="${searchType eq null || searchType eq '0'}">checked</c:if>> 
					<label for="both" class="form-check-label">둘다</label> 
					<input type="radio" id="income" class="form-check-input" value="1" name="at_num" <c:if test="${searchType eq '1'}">checked</c:if>>
					<label for="income" class="form-check-label">수입</label> 
					<input type="radio" id="expense" class="form-check-input" value="2" name="at_num" <c:if test="${searchType eq '2'}">checked</c:if>> 
					<label for="expense" class="form-check-label">지출</label>
				</div>
				<div class="form-group mt-2">
					<label for="begin-date">시작일:</label> 
					<input type="date" class="form-control" id="begin" name="search_begin" <c:if test="${searchBegin ne null && searchBegin ne ''}">value="${searchBegin }" </c:if> > 
					<label for="end-date">종료일:</label> 
					<input type="date" class="form-control" id="end" name="search_end" <c:if test="${searchEnd ne null && searchEnd ne ''}">value="${searchEnd }" </c:if>>
				</div>
				<button type="submit" class="btn btn-info mr-3 mb-2">조회</button>
			</form>
		</div>
		<div class="ml-3 mr-3 d-flex mt-5 justify-content-between">
			<a class="btn btn-primary mr-2" onclick=searchDate(-1) href="javascript:void(0);"> 이전 달</a> 
			<a class="btn btn-primary mr-2" onclick=searchDate(0) href="javascript:void(0);"> 이번 달</a> 
			<a class="btn btn-primary mr-2" onclick=searchDate(+1) href="javascript:void(0);"> 다음 달</a>
		</div>
		<div class="container total-amount mt-3">
		<c:if test="${searchType eq '0' || searchType eq '1' }">		
        <div class="summary">
            <div class="label">수입</div>
            <div class="value">${totalIncome}</div>
        </div>
		</c:if>
		<c:if test="${searchType eq '0' || searchType eq '2' }">	
        <div class="summary">
            <div class="label">지출</div>
            <div class="value">${totalExpense}</div>
        </div>
		</c:if>
		<c:if test="${searchType eq '0'}">	
        <div class="summary">
            <div class="label">수입-지출</div>
            <div class="value">${totalIncome-totalExpense}</div>
        </div>
		</c:if>
   		</div>
	
	</div>
</div>

<script>

function openUpdate(){
	$.ajax({
		url: '<c:url value="/accountbook/insert" />',
		type: 'get',
		data: {
			date: '${selected}'
		},
		success: function(data){
			$('.modal').addClass('show');
			$('.modal-content').html(data);
			console.log(data.date);
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
</script>

<script>

$('.accountbook-delete').click(function(e){
	if (${user.me_id == null || user.me_id == ab_me_id}) {
		return false;
	}
	if (confirm('정말 삭제하시겠습니까?'))
		return true;
	else
		return false;
})
$(document).ready(function(){
    $('.table').dataTable();
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />