<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>

<div class="d-flex account-book-container">
	<div class="calendar-wrapper">
		<div class="mt-3 mb-3 p-3 d-flex justify-content-between">
			<span><a class="btn btn-outline-dark btn-sm"
				href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month-1}"/>">이전달</a>
			</span> <span class="fw-bold fs-3">${cal.year}년 ${cal.month+1}월</span> <span>
				<a class="btn btn-outline-dark btn-sm"
				href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month+1}"/>">다음달</a>
			</span>
		</div>

		<table class="table text-center table-bordered calendar">
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
						<td><c:if test="${selected ne null }">
								<c:choose>
									<c:when
										test="${selected.dayOfMonth == (j - cal.startBlankCnt)}">
										<c:set var="cls" value="selected" />
									</c:when>
									<c:otherwise>
										<c:set var="cls" value="" />
									</c:otherwise>
								</c:choose>
							</c:if> <a
							href="<c:url value="/accountbook?year=${cal.year}&month=${cal.month}&day=${j - cal.startBlankCnt}"/>">
								<c:if
									test="${(j > cal.startBlankCnt) && (j <= cal.startBlankCnt + cal.lastDate)}">
									<c:choose>
										<c:when test="${j % 7 == 0 }">
											<span class="text-primary ${cls}">${j - cal.startBlankCnt }</span>
										</c:when>
										<c:when test="${j % 7 == 1 }">
											<span class="text-danger ${cls}">${j - cal.startBlankCnt }</span>
										</c:when>
										<c:otherwise>
											<span class="${cls}">${j - cal.startBlankCnt }</span>
										</c:otherwise>
									</c:choose>
								</c:if>
						</a></td>
					</c:forEach>
				</tr>
			</c:forEach>
		</table>
	</div>

	<div class="list-wrapper">
		<h3>${selected }</h3>
		<div class="overflow-auto mt-3 mb-5" style="max-height: 70vh;">
			<table class="table table-hover">
				<thead>
					<tr>
						<th></th>
						<th class="text-center" colspan="2">상세</th>
						<th class="text-center">금액</th>
						<th class="text-center">수단</th>
						<th class="text-center">용도</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ab_list}" var="ab">
						<tr>
							<td class="text-center">${at_list[ab.ab_at_num-1].at_name}</td>
							<td colspan=2>${ab.ab_detail }</td>
							<td class="text-right"><fmt:formatNumber value="${ab.ab_amount }" pattern="#,###"/></td>
							<td class="text-center">${pt_list[ab.ab_pt_num-1].pt_name}</td>
							<td class="text-center">${pp_list[ab.ab_pp_num-1].pp_name}</td>
						</tr>
					</c:forEach>
					
					<c:if test="${ab_list.size() eq 0 || ab_list eq null }">
						<tr>
							<td class="text-center" colspan="6">내역이 없습니다</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<c:choose>
			<c:when test="${user ne null }">
				<div class="btn btn-dark d-block" data-toggle="modal"
					data-target="#modal" onclick="openInsert();">내역 등록</div>
			</c:when>
			<c:otherwise>
				<a href="<c:url value="/login"/>" class="btn btn-dark">로그인</a>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<div id="modal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content"></div>
	</div>
</div>

<script>
	function openInsert() {
		$.ajax({
			url : '<c:url value="/accountbook/insert" />',
			type : 'get',
			data : {
				date : '${selected}'
			},
			success : function(data) {
				$('.modal').addClass('show');
				$('.modal-content').html(data);
				console.log(data.date);
			},
			error : function(xhr) {
				console.log(xhr);
			}
		})
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />