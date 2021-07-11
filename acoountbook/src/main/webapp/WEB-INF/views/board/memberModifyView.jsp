<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

 <!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function () {
		pwdchk();
		
		
		$("#cancelBtn").on("click", function () {
			location.href="/board/list";
		});
		
		$("#deleteBtn").on("click", function () {
			location.href="memberDeleteView";
			
		});
		
		
		function pwdchk() {
			$("#alert-success").hide();
			$("#alert-danger").hide();
			$("#submit").hide();
			$("input").keyup(function () {
				var pwd1 = $("#userPass").val();
				var pwd2 = $("#userPass2").val();
				
				if(pwd2 !=""){
					if(pwd1 == pwd2){
						$("#alert-success").show();
						$("#alert-danger").hide();
						$("#submit").show();
						
					}else{
						$("#alert-success").hide();
						$("#alert-danger").show();
						$("#submit").hide();
					}
				}
				
				if(pwd2 == ""){
					$("#alert-success").hide();
					$("#alert-danger").hide();
					$("#submit").hide();
				}
					
			})
		};
		
		
		$("#submit").on("click", function () {
			if($("#userPass").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#userPass").focus();
				return false;
			}
			if($("#userName").val()==""){
				alert("성명을 입력해주세요.");
				$("#userName").focus();
				return false;
			}
			if($("#email").val()==""){
				alert("이메일을 입력해주세요.");
				$("#email").focus();
				return false;
			}
			
			$.ajax({
				url : "/member/memberModify",
				type : "POST",
				dateType : "json",
				data : $("#modifyMember").serializeArray(),
				success: function(data){
					if(confirm("회원정보 수정하시겠습니까?")){
						$("#modifyMember").submit();
						//history.go(-1);
						window.close();
					}
				}
			})
			
			
			
			
			
		});
		
		
		
		
		
		
		
	})
	
</script>

<meta charset="UTF-8">
<title>회원정보 수정</title>
</head>
<body>
<section id="container">
			<form action="/member/memberModify" method="post" id="modifyMember">
				<div class="form-group has-feedback">
					<label class="control-label" for="userId">아이디</label>
					<input class="form-control" type="text" id="userId" name="userId" value="${member.userId}" readonly="readonly"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userPass">패스워드</label>
					<input class="form-control" type="password" id="userPass" name="userPass" />
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userPass2">패스워드 확인</label>
					<input class="form-control" type="password" id="userPass2" name="userPass2" />
				</div>
				<div class="alert alert-success" id="alert-success" style="display:none">비밀번호 일치</div>
				<div class="alert alert-danger" id="alert-danger" style="display:none">비밀번호 불일치</div>
				
				
				<div class="form-group has-feedback">
					<label class="control-label" for="userName">성명</label>
					<input class="form-control" type="text" id="userName" name="userName" value="${member.userName}"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="email">이메일</label>
					<input class="form-control" type="text" id="email" name="email" value="${member.email}"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="regDate">가입일자</label>
					<fmt:formatDate value="${member.regDate}" pattern="yyyy-MM-dd HH:mm:ss" />
					<%-- <input class="form-control" type="datetime-local" id="regDate" name="regDate" value="${member.regDate}" /> --%>
				</div>
				
				
				<div class="form-group has-feedback">
					<button class="btn btn-success" type="button" id="submit">회원정보 수정</button>
					<button class="btn btn-success" type="button" id="deleteBtn">회원탈퇴</button>
					<button class="cencle btn btn-danger" type="button" id=cancelBtn>취소</button>
				</div>
			</form>
		</section>
		


</body>
</html>