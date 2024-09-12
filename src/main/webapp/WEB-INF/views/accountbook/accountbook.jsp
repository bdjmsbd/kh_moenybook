<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
.btn-amount {
	display: inline-flex;
	justify-content: center; 
    width: 100%;
    height: 20px;
    font-size: 10px;
    border: 1px solid #ccc;  /* 버튼 경계 색상 */
    align-items: center;
}
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
<div class="d-flex account-book-container">
	<div class="calendar-wrapper">
		<div class="mt-3 mb-3 p-3 d-flex justify-content-between">
			<span><a class="btn btn-outline-dark btn-sm"
				href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month-1}&btncheck=true"/>">이전달</a>
			</span> 
			<span class="fw-bold fs-3">${cal.year}년 ${cal.month+1}월</span> 
			<span>
				<a class="btn btn-outline-dark btn-sm"
				href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month+1}&btncheck=true"/>">다음달</a>
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
					<td class="text-center">
						<c:if test="${selected ne null }">
							<c:choose>
								<c:when test="${selected.dayOfMonth == (j - cal.startBlankCnt)}">
									<c:set var="cls" value="selected" />
								</c:when>
								<c:otherwise>
									<c:set var="cls" value="" />
								</c:otherwise>
							</c:choose>
						</c:if>
						
						
							<c:if test="${(j > cal.startBlankCnt) && (j <= cal.startBlankCnt + cal.lastDate)}">
								<c:choose>
									<c:when test="${j % 7 == 0 }">
										<a href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month}&day=${j - cal.startBlankCnt}&searchType=0"/>">
										<span class="text-primary ${cls}">${j - cal.startBlankCnt }</span><br></a>
										<c:forEach  items="${amount_list }" var="amount" >
										<c:if test="${(j - cal.startBlankCnt) eq amount.day}">
											<span><c:if test="${amount.totalIncome ne 0}"> 
												<a class="btn btn-primary btn-amount" href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month}&day=${j - cal.startBlankCnt}&searchType=1"/>">
												<fmt:formatNumber value="${amount.totalIncome}" type="number" groupingUsed="true"/>
												</a> 
											</c:if></span><br>
											<span><c:if test="${amount.totalExpense ne 0}">  
												<a class="btn btn-danger btn-amount" href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month}&day=${j - cal.startBlankCnt}&searchType=2"/>">
												<fmt:formatNumber value="${amount.totalExpense}" type="number" groupingUsed="true"/>
												</a>
											</c:if></span>
										</c:if>
										</c:forEach>
										
									</c:when>
									<c:when test="${j % 7 == 1 }">
										<a href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month}&day=${j - cal.startBlankCnt}&searchType=0"/>">
										<span class="text-danger ${cls}">${j - cal.startBlankCnt } </span><br></a>
										<c:forEach  items="${amount_list }" var="amount" >
										<c:if test="${(j - cal.startBlankCnt) eq amount.day}">
											<span><c:if test="${amount.totalIncome ne 0}"> 
												<a class="btn btn-primary btn-amount" href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month}&day=${j - cal.startBlankCnt}&searchType=1"/>">
												<fmt:formatNumber value="${amount.totalIncome}" type="number" groupingUsed="true"/>
												</a> 
											</c:if></span><br>
											<span><c:if test="${amount.totalExpense ne 0}"> 
												<a class="btn btn-danger btn-amount" href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month}&day=${j - cal.startBlankCnt}&searchType=2"/>">
												<fmt:formatNumber value="${amount.totalExpense}" type="number" groupingUsed="true"/>
												</a>
											</c:if></span>
										</c:if>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<a href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month}&day=${j - cal.startBlankCnt}&searchType=0"/>">
										<span class="${cls}"> ${j - cal.startBlankCnt } </span><br></a>
										<c:forEach  items="${amount_list }" var="amount" >
										<c:if test="${(j - cal.startBlankCnt) eq amount.day}">
											<span><c:if test="${amount.totalIncome ne 0}"> 
												<a class="btn btn-primary btn-amount" href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month}&day=${j - cal.startBlankCnt}&searchType=1"/>">
												<fmt:formatNumber value="${amount.totalIncome}" type="number" groupingUsed="true"/>
												</a> 
											</c:if></span><br>
											<span><c:if test="${amount.totalExpense ne 0}"> 
												 <a class="btn btn-danger btn-amount" href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month}&day=${j - cal.startBlankCnt}&searchType=2"/>">
												 <fmt:formatNumber value="${amount.totalExpense}" type="number" groupingUsed="true"/>
												 </a>
											</c:if></span>
										</c:if>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:if>
						
					</td>
				</c:forEach>
				</tr>
			</c:forEach>
			
		</table>
	</div>
	<div class="list-wrapper ml-3">
		<h3>${search } 내역</h3>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>유형</th>
					<th>분류</th>
					<th>금액</th>
					<th>결제 방식</th>
					<th>메모</th>
					<th>정기결제</th>
					<th>제어</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ab_list }" var="ab">
					<%-- ${comments[n].name} --%>
					<tr>
						<c:if test="${searchType eq '0' || ab.ab_at_num eq searchType}">
						<td>${at_list[ab.ab_at_num-1].at_name}</td>
						<td>${pp_list[ab.ab_pp_num-1].pp_name}</td>
						<td>${ab.ab_amount}</td>
						<td>${pt_list[ab.ab_pt_num-1].pt_name}</td>
						<td>${ab.ab_detail }</td>
						<td>
						<c:if test="${ab.ab_period eq 1}"> 매주 </c:if> 
						<c:if test="${ab.ab_period eq 2}"> 격주 </c:if> 
						<c:if test="${ab.ab_period eq 3}"> 매달 </c:if>
						</td>
						<td style=" display: flex; gap: 1px;">
						<a class="btn btn-outline-dark accountbook-update" href="<c:url value="/accountbook/update?ab_num=${ab.ab_num}"/>">수정</a>
						<a class="btn btn-outline-dark accountbook-delete" href="<c:url value="/accountbook/delete?ab_num=${ab.ab_num}"/>">삭제</a>
						</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<c:choose>
			<c:when test="${user ne null }"><div class="btn btn-dark" data-toggle="modal" data-target="#modal" onclick="openInsert();">내역 등록</div></c:when>
			<c:otherwise><a href="<c:url value="/login"/>" class="btn btn-dark">로그인</a></c:otherwise>
		</c:choose>
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

$('.accountbook-delete').click(function(e){
	if (${user.me_id == null || user.me_id == ab_me_id}) {
		return false;
	}
	if (confirm('정말 삭제하시겠습니까?'))
		return true;
	else
		return false;
})
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />