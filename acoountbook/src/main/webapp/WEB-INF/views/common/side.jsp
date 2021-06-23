<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%
  request.setCharacterEncoding("UTF-8");
%> 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html> --%>

<html>
<head>
 <style>
   .no-underline{
      text-decoration:none;
   }
 </style>
  <meta charset="UTF-8">
  <title>side menu</title>
</head>
<body>
	<h1>메뉴</h1>
	<hr />
	
<%-- 	<h1>
		<a href="${contextPath}/member/listMembers.do"  class="no-underline">회원관리</a><br>
		<a href="${contextPath}/board/listArticles.do"  class="no-underline">게시판관리</a><br>
		<a href="#"  class="no-underline">상품관리</a><br>
	</h1> --%>
	
	<h1>
	<a href="${contextPath}/board/list" class="no-underline">자유게시판</a><br />
	<a href="#" class="no-underline">뉴스게시판</a><br />
	<a href="#" class="no-underline">일정 관리</a><br />
	<hr />
	<a href="#" class="no-underline">내역 입력</a><br />
	<a href="#" class="no-underline">내역 조회</a><br />
	<a href="#" class="no-underline">수익/비용 결산</a><br />
	<a href="#" class="no-underline">저축/지출 분석</a><br />
	<a href="#" class="no-underline">신용카드 결산</a><br />
	<hr />
	</h1>
	
	
</body>
</html>