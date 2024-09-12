<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<link rel="stylesheet" href="<c:url value="/resources/css/insert.css"/>">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.js"></script>

<div class="modal-header">
	<h4 class="modal-title">내역 수정</h4>
	<button type="button" class="close" data-dismiss="modal">×</button>
</div>

<div class="modal-body">
	<form action="<c:url value="/accountbook/update"/>" method="post" id="form">
		<div class="form-group">
			<div class="form_toggle row-vh d-flex flex-row justify-content-between">
				<div class="form_radio_btn radio_male btn-income">
				<input id="radio-1" type="radio" name='ab_at_num' id='at_num' value='1' 
				<c:choose> <c:when test="${ab.ab_at_num eq '1'}"> checked </c:when> 
				<c:otherwise> disabled </c:otherwise> </c:choose> > 
				<label for="radio-1">수입</label>
				</div>
				<div class="form_radio_btn btn-expense"> 
				<input id="radio-2" type="radio" name='ab_at_num' id='at_num' value='2'
				<c:choose> <c:when test="${ab.ab_at_num eq '2'}"> checked </c:when> 
				<c:otherwise> disabled </c:otherwise> </c:choose> >
				<label for="radio-2">지출</label>
				</div>
			</div>
		</div>

		<div class="form-group">
			<fmt:formatDate value="${ab.ab_date}" pattern="yyyy-MM-dd" var="nowDate" />
			<label for="date">날짜</label> 
			<input type="date" class="form-control" name="ab_date" id="date" value="${nowDate }">
		</div>
		<div class="form-group">
			<label for="amount">금액</label> 
			<input type="number" class="form-control" step="500" name="ab_amount" id="amount" value="${ab.ab_amount }">
		</div>
		<div class="form-group">
			<label for="">분류</label> 
			<select class="form-control" name="ab_pp_num" id="pp_num">
				<c:forEach items="${pp_list}" var="pp">
					<c:if test="${ab.ab_pp_num eq pp.pp_num}">
						<option value="${pp.pp_num }"  selected>${pp.pp_name}</option>
					</c:if>
				</c:forEach>
			</select> 
		</div>
		<div class="form-group">
			<label for="">지불 방식</label> 
			<select class="form-control" name="ab_pt_num" id="pt_num">
				<c:forEach items="${pt_list}" var="pt">
					<c:if test="${ab.ab_pt_num eq pt.pt_num}"> 
						<option value="${pt.pt_num }" selected>${pt.pt_name}</option>
					</c:if>
				</c:forEach>
			</select> 
		</div>
		<div class="form-group">
			<label for="">주기 여부</label> <select class="form-control"
				name="ab_regularity" id="regularity"
				onchange="addPeriod(this.value)">
				<c:choose>
					<c:when test="${ab.ab_regularity eq 1}">
						<option value="1" selected>일회성</option>
					</c:when>
					<c:otherwise>
						<option value="0">일회성</option>
						<option value="1">정기성</option>
					</c:otherwise>
				</c:choose>
			</select>
		</div>
		<div class="form-group period-box" style="display: none">
			<label for="period" class="mr-3">주기</label>
			<div class="form-check-inline">
				<label class="form-check-label mr-3"> <input type="radio"
					class="form-check-input" name="ab_period" id="period" value="1">매주
				</label><label class="form-check-label mr-3"> <input type="radio"
					class="form-check-input" name="ab_period" id="period" value="2">격주
				</label><label class="form-check-label mr-3"> <input type="radio"
					class="form-check-input" name="ab_period" id="period" value="3">매달
				</label>
			</div>
		</div>
		<div class="form-group">
			<textarea class="form-control mt-3" name="ab_detail" id="detail">${ab.ab_detail }</textarea>
		</div>
		<input type="hidden" class="form-control" name="ab_num" id="num" value="${ab.ab_num }">
		<button type="submit" class="col-12 btn btn-submit">가계부 수정</button>
	</form>
</div>
<script>
	function addPeriod(value) {
		console.log(value);
		$('.period-box').hide();
		if (value == 1) {
			$('.period-box').show();
		}
	}
</script>