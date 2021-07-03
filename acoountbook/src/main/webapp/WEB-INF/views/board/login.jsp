<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<meta charset="UTF-8">
<title>로그인</title>
</head>

<a href="/board/list">게시판으로 바로 가기</a><br />
<script type="text/javascript">
$(document).ready(function () {
	$("#logoutBtn").on("click", function () {
		location.href = "member/logout";
	})
	
	$("#reg").on("click", function () {
		var popupX = (window.screen.width / 2)  - (450 / 2);
		//&nbsp;만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

		var popupY= (window.screen.height / 2) - (450 / 2);
		//&nbsp;만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음

		window.open("${contextPath}/member/register","register",'status=no, height=450, width=450, left='+ popupX + ', top='+ popupY)
		
	})
	
})

</script>

<body>
	<form action="/member/login" name="loginForm" method="post">
		<c:if test="${member == null }">
		<div>
		<label for="userId"></label>
		<input type="text" id="userId" name="userId">
		</div>
		
		<div>
		<label for="userPass"></label>
		<input type="password" id="userPass" name="userPass">
		</div>
		
		<div>
		<button type="submit">로그인</button>
		<button type="button" id="reg" >회원가입</button>
		</div>
		</c:if>
		
		<c:if test="${member != null }">
		<div>
		<p>${member.userId } 님 환영 합니다.</p>
		<button id="logoutBtn" type="button">로그 아웃</button>
		</div>
		</c:if>
		
		<c:if test="${msg == false }">
			<p style="color: red;">아이디와 비밀번호를 확인하세요</p>
		</c:if>
		
		
	</form>	



</body>
</html>