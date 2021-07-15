<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<meta charset="UTF-8">
<!-- include libraries(bootstrap) -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

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
	$(document).ready(function() {
						var formObj = $("form[name = 'readForm']");
						//게시글 수정
						$(".update_btn").on("click", function() {
							formObj.attr("action", "/board/updateView");
							formObj.attr("method", "get");
							formObj.submit();
						})
						//게시글 삭제
						$(".delete_btn").on("click", function() {
							if (confirm("삭제하시겠습니까?")) {
							formObj.attr("action", "/board/delete");
							formObj.attr("method", "post");
								formObj.submit();
							}
						})

						//list로 돌아가기
						$(".list_btn").on("click", function() {
											location.href = encodeURI("/board/list?page=${scri.page}"
													+ "&perPageNum=${scri.perPageNum}"
													+ "&searchType=${scri.searchType}&keyword=${scri.keyword}");
										})


						//댓글 작성
						$(".replyWriteBtn").on("click", function() {
							var formObj = $("form[name='replyForm']");
							formObj.attr("action", "/board/replyWrite");
							formObj.submit();
						})

						//댓글 수정
						function replyupdatepopup() {
							var popupX = (window.screen.width / 2)  - (450 / 2);
							//&nbsp;만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
							var popupY= (window.screen.height / 2) - (450 / 2);
							//&nbsp;만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
							
							var urlupdate = encodeURI("/board/replyUpdateView?bno=${read.bno}"
									+ "&page=${scri.page}"
									+ "&perPageNum=${scri.perPageNum}"
									+ "&searchType=${scri.searchType}"
									+ "&keyword=${scri.keyword}"
									+ "&rno="
									+ $("#rplup").attr("data-rno"));
							
							
							window.open(urlupdate,"replyUpdateView",'status=no, height=450, width=450, left='+ popupX + ', top='+ popupY)
							
						} 
						//댓글 삭제
						  function replydeletepopup(){
							var popupX = (window.screen.width / 2)  - (450 / 2);
							//&nbsp;만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
							var popupY= (window.screen.height / 2) - (450 / 2);
							//&nbsp;만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
						    // 자식창을 열고 자식창의 window 객체를 windowObj 변수에 저장
						    var urldelete = encodeURI("/board/replyDeleteView?bno=${read.bno}"
										+ "&page=${scri.page}"
										+ "&perPageNum=${scri.perPageNum}"
										+ "&searchType=${scri.searchType}"
										+ "&keyword=${scri.keyword}"
										+ "&rno="
										+ $("#rpldlt").attr("data-rno"));
						    
						    windowObj = window.open(urldelete,"replyDeleteView",'status=no, height=450, width=450, left='+ popupX + ', top='+ popupY);
						};
						
						$(".replyUpdateBtn").on("click", function () {
							replyupdatepopup();
						});
					
						$(".replyDeleteBtn").on("click", function () {
							replydeletepopup();
						}) ;
							
						
						
						

					});
</script>





<body>
	<%@ include file="../common/header.jsp"%>
	<%@ include file="../common/side.jsp"%>
	<%@ include file="../common/layout.jsp"%>

	<header>
		<h1>게시글 읽기</h1>
	</header>


	<div class="container">
		<section id="container">
			<form name="readForm" role="form" method="post" id="readForm">
				<input type="hidden" id="bno" name="bno" value="${read.bno}" /> <input
					type="hidden" id="page" name="page" value="${scri.page }" /> <input
					type="hidden" id="perPageNum" name="perPageNum"
					value="${scri.perPageNum }" /> <input type="hidden"
					id="searchType" name="searchType" value="${scri.searchType }" /> <input
					type="hidden" id="keyword" name="keyword" value="${scri.keyword }" />

			</form>

			<div class="form-group">
				<label for="title" class="col-sm-2 control-label">제목</label>
				 <input	type="text" id="title" name="title" value="${read.title}"readonly="readonly" class="form-control" />
			</div>
			<div class="form-group ">
				 <label for="content" class="col-sm-2 control-label">내용</label>
				<%-- <textarea id="content" name="content" readonly="readonly"
					class="form-control">${read.content }</textarea> --%>
					 <pre><c:out value="${read.content}" escapeXml="false" ></c:out></pre>
			</div>
			<div class="form-group">
				<label for="writer" class="col-sm-2 control-label">작성자</label> <input
					type="text" id="writer" name="writer" value="${read.writer}"
					readonly="readonly" class="form-control" />
			</div>
			<div class="form-group">
				<label for="regdate" class="col-sm-2 control-label">작성날짜</label>
				<fmt:formatDate value="${read.regdate}" pattern="yyyy-MM-dd" />
			</div>
			<div>
				<button type="button" class="update_btn btn btn-warning">수정</button>
				<button type="button" class="delete_btn btn btn-danger">삭제</button>
				<button type="button" class="list_btn btn btn-primary">목록</button>

			</div>
			<br />

			<!-- 댓글 -->
			<div id="reply">
				<ol class="replyList">
				<li>
					<c:forEach items="${replyList}" var="replyList">
							<p>
								작성자 : ${replyList.writer}<br /> 
								작성 날짜 : <fmt:formatDate value="${replyList.regdate}" pattern="yyyy-MM-dd" /> <br />
								수정 날짜 : <fmt:formatDate value="${replyList.editdate}" pattern="yyyy-MM-dd" />
							</p>
							<p>댓글 내용 : ${replyList.content}</p>
					<c:if test="${member.userId != null && member.userId == replyList.writer}">
							<div>
								<button type="button" class="replyUpdateBtn btn btn-warning"
									data-rno="${replyList.rno}" id="rplup">수정</button>
								<button type="button" class="replyDeleteBtn btn btn-danger"
									data-rno="${replyList.rno}" id="rpldlt">삭제</button>
							</div>
					</c:if>	
					</c:forEach>
					</li>
				</ol>
			</div>



		<form>
		<div style="display: block;">
				<input type="hidden" id="bno" name="bno" value="${read.bno }" />
				<input type="hidden" id="page" name="page" value="${scri.page }" />
				<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum }" /> 
				<input type="hidden" id="searchType" name="searchType" value="${scri.searchType }" /> 
				<input type="hidden" id="keyword" name="keyword" value="${scri.keyword }" />
		</div>		
		</form>

	<form name="replyForm" method="post" class="form-horizontal">
				<c:if test="${member.userId != null }">
				<div class="form-group">	
					
						<label for="writer" class="col-sm-2 control-label"></label> 
						<div class="col-sm-10 col-sm-offset-1" style="display: block;">
						<p>댓글 작성자</p>
						<input type="text" id="writer" name="writer" value="${member.userId }" readonly="readonly" class="form-control"/>
						</div>
						<label for="content" class="col-sm-2 control-label"></label> 
						<div class="col-sm-10 col-md-offset-1" style="display: block;">	
						<p>댓글 내용</p>
						<input type="text" id="content"	name="content" class="form-control"/>
						</div>
						<div class="col-sm-offset-1 col-sm-10">
						<button type="button" class="replyWriteBtn btn btn-success">작성</button>
						</div>
				</div>	
				</c:if>

				<c:if test="${member.userId == null }">
					<p>로그인 후 댓글 작성 하실 수 있습니다.</p>
					<table>
						<tr>
							<td>
								<button class="cancel_btn " type="button">목록</button>
							</td>
						</tr>
					</table>
				</c:if>
				
			</form>
		</section>
		<hr />
	</div>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>