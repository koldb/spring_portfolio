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
	$("#cancelBtn").on("click", function(){
		
		history.go(-1)
				    
	})

	$("#submit").on("click", function(){
		if($("#userPass").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#userPass").focus();
			return false;
		}
		$.ajax({
			url : "/member/passChk",
			type : "POST",
			dataType : "json",
			data : $("#delForm").serializeArray(),
			success: function(data){
				
				if(data== 1){
					if(confirm("회원탈퇴하시겠습니까?")){
						$("#delForm").submit();
					}
				}else{
					alert("패스워드가 틀렸습니다. 다시 입력하세요.");
					return;
					
				}
			}
		})
		
	});
	
})



</script>

<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>

<section id="container">
			<form action="/member/memberDelete" method="post" id="delForm">
				<div class="form-group has-feedback">
					<label class="control-label" for="userId">아이디</label>
					<input class="form-control" type="text" id="userId" name="userId" value="${member.userId}" readonly="readonly"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userPass">패스워드</label>
					<input class="form-control" type="password" id="userPass" name="userPass" />
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userName">성명</label>
					<input class="form-control" type="text" id="userName" name="userName" value="${member.userName}" readonly="readonly"/>
				</div>
			</form>
			<div class="form-group has-feedback">
				<button class="btn btn-success" type="button" id="submit">회원탈퇴</button>
				<button class="cencle btn btn-danger" type="button" id="cancelBtn">취소</button>
			</div>
			<div>
				<c:if test="${msg == false}">
					비밀번호가 맞지 않습니다.
				</c:if>
			</div>
		</section>




</body>
</html>