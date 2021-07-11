<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	 <!-- include libraries(bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>게시판</title>
<style type="text/css">
li {
	list-style: none;
	float: left;
	padding: 6px;
}
</style>
</head>
<script type="text/javascript">
$(document).ready(function () {
	$(".cancel_btn").on("click", function () {
		event.preventDefault();
		location.href = "/board/readView?bno=${update.bno}"
				+"&page=${scri.page}"
				+"&perPageNum=${scri.perPageNum}"
				+"&searchType=${scri.searchType}"
				+"&keyword=${scri.keyword}";
	})
	$(".update_btn").on("click", function(){
		if(fn_valiChk()){
			return false;
		}
		formObj.attr("action", "/board/update");
		formObj.attr("method", "post");
		formObj.submit();
	})
})
	
function fn_valiChk(){
	var updateForm = $("form[name='updateForm'] .chk").length;
	for(var i = 0; i<updateForm; i++){
		if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
			alert($(".chk").eq(i).attr("title"));
			return true;
		}
	}
}

</script>


<body>

<%@ include file="../common/header.jsp" %>
<%@ include file="../common/side.jsp" %>
<%@ include file="../common/layout.jsp" %>

<header>
<h1>게시글 수정</h1>
</header>

	<div>
		<section id="container">
			<form name="updateForm" role="form" method="post" action="/board/update" id="fform">
				<input type="hidden" name="bno" value="${update.bno}" readonly="readonly" />
							<div>
							<div>
							<label for="title">제목</label>
							<input type="text" id="title" name="title" value="${update.title}" class="chk" title="제목을 입력하세요"/>
							</div>
							</div>
							
							<div>
							<div>
							<label for="content">내용</label>
							<textarea id="content" name="content" class="chk" title="내용을 입력하세요">
							<c:out value="${update.content}" />
							</textarea>
							</div>
							</div>
							
							<div> 
							<div>
							<label for="writer">작성자</label>
							<input type="text" id="writer" name="writer" value="${update.writer}" readonly="readonly"/>
							</div>
							</div>
							
							<div>
							<div>
							<label for="regdate">수정 날짜</label> 
							<fmt:formatDate	value="${update.regdate}" pattern="yyyy-MM-dd" />
							</div>
							</div>
							
				<div>
				<div>
					<button type="submit" class="update_btn btn btn-success">저장</button>
					<button type="button" class="cancel_btn btn btn-danger">취소</button>
				</div>
				</div>
			</form>
		</section>
		<hr />
	</div>

<%@ include file="../common/footer.jsp" %>

</body>
</html>