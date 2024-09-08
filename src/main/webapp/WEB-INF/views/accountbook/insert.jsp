<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
[type="radio"] {
	appearance: none;
}

.form_radio_btn {
	width: 47%;
	height: 45px;
	border: 1px solid #EAE7E7;
	border-radius: 10px;
}

.form_radio_btn input[type=radio] {
	display: none;
}

.form_radio_btn label, .btn-submit {
	display: block;
	border-radius: 10px;
	margin: 0 auto;
	text-align: center;
	height: -webkit-fill-available;
	line-height: 45px;
}

/* Checked */
.form_radio_btn input[type=radio]:checked+label, .btn-submit {
	background: #184DA0;
	color: #fff;
}

/* Disabled */
.form_radio_btn input[type=radio]+label {
	background: #F9FAFC;
	color: #666;
}
</style>
<h1 class="text-center mb-5">가계부 등록</h1>
<form action="<c:url value="/accountbook/insert"/>" method="post"
	id="form">
	<div class="form-group">
		<div class="form_toggle row-vh d-flex flex-row justify-content-between" >
			<div class="form_radio_btn radio_male">
				<input id="radio-1" type="radio" name='ab_at_num' id='at_num' value='1' checked>
				<label for="radio-1">수입</label>
			</div>
			<div class="form_radio_btn">
				<input id="radio-2" type="radio" name='ab_at_num' id='at_num' value='3'>
				<label for="radio-2">지출</label>
			</div>
		</div>
	</div>

	<div class="form-group">
		<c:set var="now" value="<%=new java.util.Date()%>" />
		<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate" />
		<label for="date">날짜</label> 
		<input type="date" class="form-control" name="ab_date" id="date" value="${nowDate }">
	</div>
	<div class="form-group">
		<label for="amount">금액</label>
		<input type="number" class="form-control" name="ab_amount" id="amount">
	</div>
	<div class="form-group">
	  <label for="">분류</label>
	  <select class="form-control" name="ab_pp_num" id="pp_num" >
	  	<c:forEach items="${pp_list}" var="pp">
	  		<option value="${pp.pp_num }">${pp.pp_name}</option>
	  	</c:forEach>
	    
	  </select>
	</div>
	<div class="form-group">
	  <label for="">지불 방식</label>
	  <select class="form-control" name="ab_pt_num" id="pt_num" >
   	  	<c:forEach items="${pt_list}" var="pt">
	  		<option value="${pt.pt_num }">${pt.pt_name}</option>
	  	</c:forEach>
	  </select>
	</div>
	<div class="form-group">
	  <label for="">정기성</label>
	  <select class="form-control" name="regularity">
	    <option value="1">일회성</option>
	    <option value="0">정기성</option>
	  </select>
	</div>
	<div class="form-group">
		<textarea class="form-control mt-3" name="ab_detail" id="detail" placeholder='메모'></textarea>
	</div>
		
	<button type="submit" class="col-12 btn-submit">가계부 등록</button>
</form>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />