<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>내역 조회</title>
</head>
<style type="text/css">
li {
	list-style: none;
	float: left;
	padding: 6px;
}

th{
text-align: center;
}

.paging{
text-align: center;
margin:0 auto;
}

/* header{
 margin-left: 850px;    
}
 */

</style>


<body>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/side.jsp" %>
<%@ include file="../common/layout.jsp" %>

<header>
<h1>내역 조회</h1>
</header>


<div>
<section>

<form action="#">
<tr>
<td>
시작일 : <input type="date" />
</td>   

<td>
종료일 : <input type="date" />
</td>

<td>
항목 : <input type="text" id="cate" />
</td>
</tr>

</form>






<form action="#">
<input type="hidden" id="userId" name="userId"
					value="${member.userId}" readonly="readonly" />
<table>
<thead>


<tr>
<th>번호</th>
<th>일자</th>
<th>수입/지출</th>
<th>항목</th>
<th>적요</th>
<th>금액</th>
</tr>
</thead>

<tbody>

<c:forEach items="${accList }" var="accList">
<tr style="text-align: center;">
<td><c:out value="${accList.accNum}" /></td>
<td><c:out value="${accList.accDate }"></c:out> </td>
<td><c:out value="${accList.accDiv }"></c:out> </td>
<td><c:out value="${accList.accCategory }"></c:out> </td>
<td><c:out value="${accList.accComment }"></c:out> </td>
<td><c:out value="${accList.accAmount }"></c:out> </td>

<td><!--  <a class="updbtn" href="#">수정</a> -->
	 <a class="delbtn" href="/board/accDelete?accNum=${accList.accNum}">삭제</a>
</td>
</tr>
</c:forEach>
</tbody>
</table>
</form>

<div style="text-align: center;">
<a href="${contextPath}/board/householdWrite?userId=${member.userId}">가계부 작성</a>
</div>


</section>
</div>





<%@ include file="../common/footer.jsp" %>
</body>
</html>