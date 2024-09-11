<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>

<h1 class="text-center mb-5">카테고리별 소비내역 그래프</h1>

<div class="w-75 h-75 m-auto">
	<canvas width="600" height="600" id="chart" style="display: block; box-sizing: border-box;"></canvas>
</div>


<c:forEach items="${ab_list}" var="ab">
	<p>${ab}</p>
</c:forEach>

<script>
let stat = document.getElementById('chart');

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
	    responsive: false,
	}
};

let config = new Chart(stat, {
    type: 'doughnut',
    data: data
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />