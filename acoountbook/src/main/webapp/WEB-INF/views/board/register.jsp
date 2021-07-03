<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> -->
	
 <!-- include libraries(bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>	
	
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		//취소버튼
		$(".cancle").on("click", function() {
			location.href = "/login";
		})

		$("#submit").on("click", function() {
			if ($("#userId").val() == "") {
				alert("아이디를 입력하세요");
				$("#userId").focus();
				return false;
			}
			if ($("#userPass").val() == "") {
				alert("비밀번호를 입력하세요");
				$("#userPass").focus();
				return false;
			}
			if ($("#userName").val() == "") {
				alert("이름을 입력하세요");
				$("#userName").focus();
				return false;
			}
			if ($("#email").val() == "") {
				alert("E-mail을 입력하세요");
				$("#email").focus();
				return false;
			}
			if($("#userPass").val() != $("#userPass2").val()){
				alert("입력하신 비밀번호가 동일하지 않습니다. 다시 입력하세요");
				$("#userPass").focus();
				return false;
			}
			
		
			self.close();
			
		
			
			
		})

	})
</script>


<body>


	<section id="container">
		<form action="/member/register" method="post">
			<div class="form-group has-feedback">
				<label class="control-label" for=userId>아이디</label> <input
					class="form-control" type="text" id="userId" name="userId" />
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="userPass">패스워드</label> <input
					class="form-control" type="password" id="userPass" name="userPass" />
			</div>
					<div class="form-group has-feedback">
				<label class="control-label" for="userPass2">패스워드 확인</label> <input
					class="form-control" type="password" id="userPass2" name="userPass2" />
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="userName">성명</label> <input
					class="form-control" type="text" id="userName" name="userName" />
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="email">E-Mail</label> <input
					class="form-control" type="text" id="email" name="email" />
			</div>
			<div class="form-group has-feedback">
				<button class="btn btn-success" type="submit" id="submit">회원가입</button>
				<button class="cencle btn btn-danger" type="button" id="cancle">취소</button>
			</div>

		</form>

	</section>






</body>
</html>