<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/insert.css"/>">

<div class="d-flex account-book-container">
	<div class="calendar-wrapper">
		<div class="mt-3 mb-3 p-3 d-flex justify-content-between">
			<span>
				<a class="btn btn-outline-dark btn-sm" href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month-1}"/>">이전달</a>
			</span> 
			<span class="fw-bold fs-3">${cal.year}년 ${cal.month+1}월</span> 
			<span>
				<a class="btn btn-outline-dark btn-sm" href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month+1}"/>">다음달</a>
			</span>
		</div>
		
		<table class="table text-left table-bordered calendar">
			<tr class="table-light text-center fs-5 tr-h">
				<th class="text-danger">일</th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th class="text-primary">토</th>
			</tr>
			<c:forEach begin="1" end="${cal.tdCnt}" step="7" var="i">
				<tr>
					<c:forEach begin="${i }" end="${i + 6}" step="1" var="j">
					<td class="text-center"> <!-- ${cal.nowDay == j} -->
						<c:choose>
							<c:when test="${cal.nowDay == j}">
								<c:set var="cls" value="selected" />
							</c:when>
							<c:otherwise>
								<c:set var="cls" value="" />
							</c:otherwise>
						</c:choose>
						
						<a href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month}&day=${j}"/>">
							<c:if test="${(j > cal.startBlankCnt) && (j <= cal.startBlankCnt + cal.lastDate)}">
								<c:choose>
									<c:when test="${j % 7 == 0 }">
										<span class="text-primary ${cls}">${j - cal.startBlankCnt}</span>
									</c:when>
									<c:when test="${j % 7 == 1 }">
										<span class="text-danger ${cls}">${j - cal.startBlankCnt}</span>
									</c:when>
									<c:otherwise>
										<span class="${cls}"> ${j - cal.startBlankCnt}</span>
									</c:otherwise>
								</c:choose>
							</c:if>
						</a>
					</td>
				</c:forEach>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div style=" width: 50px">
	</div>
	<div class="list-wrapper">
		<h3>${cal.year} /
		<c:choose>
			<c:when test="${cal.month+1 < 10}">${'0' + cal.month+1}</c:when>
			<c:otherwise>${cal.month+1}</c:otherwise>
		</c:choose>/
		<c:choose>
			<c:when test="${cal.nowDay < 10}">${'0' + cal.day}</c:when>
			<c:otherwise>${cal.nowDay}</c:otherwise>
		</c:choose>
		</h3>
		<table class="table table-hover">
			<tr>
				<td colspan=2>더미 1</td>
				<td>85,000</td>
				<td></td>
				<td>신용카드</td>
			</tr>
		</table>
		
		<div class="btn btn-dark" data-toggle="modal" data-target="#modal" onclick="openInsert();">내역 등록</div>
	</div>
</div>

<div id="modal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content"></div>
	</div>
</div>

<script>
function openInsert(){
	$.ajax({
		url: '<c:url value="/accountbook/insert" />',
		type: 'get',
		success: function(data){
			$('.modal').addClass('show');
			$('.modal-content').html(data);
			console.log(data);
		},
		error : function(xhr){
			console.log(xhr);
		}
	})
}

function closeForm() {
	console.log('hi');
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />