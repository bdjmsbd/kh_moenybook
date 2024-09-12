<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>

<h1 class="text-center mb-5">카테고리별 소비내역 그래프</h1>

<div class="w-75 h-75 m-auto">
	<c:choose>
		<c:when test="${user ne null }"><canvas width="600" height="600" id="chart" style="display: block; box-sizing: border-box;"></canvas></c:when>
		<c:otherwise>
			<p class="text-center">내역을 보려면 로그인해주세요</p>
			<a href="<c:url value="/login"/>" class="btn btn-dark m-auto w-25">로그인</a>
		</c:otherwise>
	</c:choose>
</div>

<script>
let chart = document.getElementById('chart');

const data = {
	labels: [
	 <c:forEach items="${pp_list}" var="pp">
	 	<c:if test="${pp.pp_at_num eq 2}">'${pp.pp_name}',</c:if>
	 </c:forEach>
	],
	datasets: [{
	  data: [
	  	<c:forEach items="${ex_list}" var="ab">
	  		${ab.ex_sum},
		</c:forEach>
	  ],
	  backgroundColor: [
	  	'rgb(255, 99, 132)',
	      'rgb(75, 192, 192)',
	      'rgb(255, 205, 86)',
	      'rgb(179, 117, 255)',
	      'rgb(54, 162, 235)',
	      'rgb(201, 203, 207)'
	  ]
	}],
	options: {
	    responsive: true,
	}
};

let config = new Chart(chart, {
    type: 'doughnut',
    data: data
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />