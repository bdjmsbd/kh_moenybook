<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<link rel="stylesheet" href="<c:url value="/resources/css/insert.css"/>">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.js"></script>

<div class="modal-header">
	<h4 class="modal-title">내역 등록</h4>
	<button type="button" class="close" data-dismiss="modal">×</button>
</div>

<div class="modal-body">
	<form action="<c:url value="/accountbook/insert"/>" method="post" id="form">
		<div class="form-group">
			<div
				class="form_toggle row-vh d-flex flex-row justify-content-between">
				<div class="form_radio_btn radio_male btn-income">
					<input id="radio-1" type="radio" name='ab_at_num' id='at_num'
						value='1' checked> <label for="radio-1">수입</label>
				</div>
				<div class="form_radio_btn btn-expense">
					<input id="radio-2" type="radio" name='ab_at_num' id='at_num'
						value='2'> <label for="radio-2">지출</label>
				</div>
			</div>
		</div>

		<div class="form-group">
			<c:set var="now" value="<%=new java.util.Date()%>" />
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate" />
			<label for="date">날짜</label> <input type="date" class="form-control"
				name="ab_date" id="date" value="<c:choose><c:when test="${date ne null}">${date }</c:when><c:otherwise>${nowDate }</c:otherwise></c:choose>">
		</div>
		<div class="form-group">
			<label for="amount">금액</label> 
			<input type="number" class="form-control" step="100" name="ab_amount" id="amount">
		</div>
		<div class="form-group">
			<label for="">분류</label> 
			<select class="form-control pt-income-box" name="ab_pp_num" id="pp_num">
				<c:set var="isFirst" value="true" />
				<c:forEach items="${pp_list}" var="pp">
					<c:if test="${pp.pp_at_num eq 1 }">
						<option value="${pp.pp_num }" <c:if test="${isFirst}"> selected </c:if> >${pp.pp_name}</option>
						<c:set var="isFirst" value="false" />
					</c:if>
				</c:forEach>
			</select> 
			<select class="form-control pt-expense-box" name="pp_num" id="pp_num">
				<c:set var="isFirst" value="true" />
				<c:forEach items="${pp_list}" var="pp">
					<c:if test="${pp.pp_at_num ne 1 }">
						<option value="${pp.pp_num }" <c:if test="${isFirst}"> selected </c:if>>${pp.pp_name}</option>
						<c:set var="isFirst" value="false" />
					</c:if>
				</c:forEach>
			</select>
		</div>
		<div class="form-group">
			<label for="">지불 방식</label> 
			<select class="form-control pp-income-box" name="ab_pt_num" id="pt_num">
				<c:set var="isFirst" value="true" />
				<c:forEach items="${pt_list}" var="pt">
					<c:if test="${pt.pt_at_num eq 1 }">
						<option value="${pt.pt_num }" <c:if test="${isFirst}"> selected </c:if>>${pt.pt_name}</option>
						<c:set var="isFirst" value="false" />
					</c:if>
				</c:forEach>
			</select> 
			<select class="form-control pp-expense-box" name="pt_num" id="pt_num">
				<c:set var="isFirst" value="true" />
				<c:forEach items="${pt_list}" var="pt">
					<c:if test="${pt.pt_at_num ne 1 }">
						<option value="${pt.pt_num }" <c:if test="${isFirst}"> selected </c:if>>${pt.pt_name}</option>
						<c:set var="isFirst" value="false" />
					</c:if>
				</c:forEach>
			</select>
		</div>
		<div class="form-group">
			<label for="">주기 여부</label> <select class="form-control"
				name="ab_regularity" id="regularity"
				onchange="addPeriod(this.value)">
				<option value="0">일회성</option>
				<option value="1">정기성</option>
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
			<textarea class="form-control mt-3" name="ab_detail" id="detail"
				placeholder='메모'></textarea>
		</div>

		<button type="submit" class="col-12 btn btn-submit btn-primary">가계부 등록</button>
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

	$(document).ready(function() {

		$('.pt-income-box').show(); 
		$('.pt-expense-box').hide();
		$('.pp-income-box').show();  
		$('.pp-expense-box').hide();

		$("input[name='ab_at_num']").change(function() {
			// 수입
			if ($("input[name='ab_at_num']:checked").val() == '1') {
				
				$('.pt-income-box').attr('name','ab_pt_num');
				$('.pt-income-box').show();
				$('.pt-expense-box').attr('name','pt_num');
				$('.pt-expense-box').hide();
				$('.pp-income-box').attr('name', 'ab_pp_num');
				$('.pp-income-box').show();
				$('.pp-expense-box').attr('name','pp_num');
				$('.pp-expense-box').hide();
			}
			// 지출
			else if ($("input[name='ab_at_num']:checked").val() == '2') {
				
				$('.pt-income-box').attr('name','pt_num');
				$('.pt-income-box').hide();
				$('.pt-expense-box').attr('name','ab_pt_num');
				$('.pt-expense-box').show();
				$('.pp-income-box').attr('name', 'pp_num');
				$('.pp-income-box').hide();
				$('.pp-expense-box').attr('name','ab_pp_num');
				$('.pp-expense-box').show();
			
			}
		});

	});
</script>