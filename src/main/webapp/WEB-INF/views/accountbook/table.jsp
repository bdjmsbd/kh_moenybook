<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<jsp:include page="/WEB-INF/views/common/header.sub.jsp" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<h1 class="text-center mb-5"> 표</h1>
<div class="container">

<%-- ${date.setMonth }
<c:set var="preMonth" value="<%=new java.util.Date() %>" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate" /> --%>
<!--  
var oneMonthAgo = new Date(now.setMonth(now.getMonth() - 1));
new Date(now.setDate(now.getDate() - 1))
-->

<a class="btn" href="<c:url value="/table?searchDate=${nowDate}"/>">이전 달</a>
<a class="btn" href="<c:url value="/table?searchDate=${nowDate}"/>">다음 달</a>


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
        <td><fmt:formatDate value="${ab.ab_date}" pattern="yyyy-MM-dd" /></td>   
        <td>
        <c:if test="${ab.ab_period eq 1}"> 매주 </c:if>
        <c:if test="${ab.ab_period eq 2}"> 격주 </c:if>
        <c:if test="${ab.ab_period eq 3}"> 매달 </c:if>
		</td>
      </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
<script>

console.log("현재 : ${date}");

var preMonth = new Date(${date.setYear(date.getYear()+1)});	// 한달 전
console.log(preMonth);
/*
var now = new Date();	// 현재 날짜 및 시간
console.log("현재 : ", now);
var oneMonthLater = new Date(now.setMonth(now.getMonth() + 1));	// 한달 후
console.log("한달 후 : ", oneMonthLater);
 */
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<jsp:include page="/WEB-INF/views/common/footer.sub.jsp" />