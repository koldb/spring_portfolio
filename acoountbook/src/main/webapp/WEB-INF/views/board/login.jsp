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

<!-- <a href="/board/list">게시판으로 바로 가기</a><br /> -->

<script type="text/javascript">
$(document).ready(function () {
	$("#logoutBtn").on("click", function () {
		location.href = "member/logout";
	})
	
	$("#cancel").on("click", function () {
		self.close();
	})
	
	$("#reg").on("click", function () {
		var popupX = (window.screen.width / 2)  - (450 / 2);
		//&nbsp;만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

		var popupY= (window.screen.height / 2) - (450 / 2);
		//&nbsp;만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음

		window.open("${contextPath}/member/register","register",'status=no, height=450, width=450, left='+ popupX + ', top='+ popupY)
		
		self.close();
		
	})
	
	$("#submit").on("click", function () {
		
		loginsubmit();
		
	});
	
	
	function loginsubmit()
		{
			var params = $("#loginForm").serializeArray();
			$.ajax(
			{
				url : "/member/login",
				data : params,
				type : "POST",
				success : function(xh)
						{				
							$("#loginForm").submit();
							window.opener.location.reload();
							window.close();
						}
			});
		}
	
	
	
	/* 
	//자식 창에서 부모창 새로고침
	window.opener.location.reload();
	//자식 창 닫기
	window.close();
	 */
	
})

</script>

<body>
	<form action="/member/login" name="loginForm" id="loginForm" method="post">
		<c:if test="${member == null }">
		<div>
		<label for="userId"></label>
		<input type="text" id="userId" name="userId" autofocus="autofocus">
		</div>
		
		<div>
		<label for="userPass"></label>
		<input type="password" id="userPass" name="userPass">
		</div>
		
		<div>
		<button type="button" id="submit">로그인</button>
		<button type="button" id="reg" >회원가입</button>
		<button type="button" id="cancel" >취소</button>
		</div>
		</c:if>


	<%-- 	<c:if test="${msg == false }">
			<p style="color: red;">아이디와 비밀번호를 확인하세요</p>
		</c:if>
		<c:if test="${msg == null }"></c:if> --%>
		
		
	</form>	



</body>
</html>