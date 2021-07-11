<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
 -->
<!-- 부가적인 테마 -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
 -->
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>	
 -->	
 
 <!-- include libraries(jQuery, bootstrap) -->
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

</head>
<script type="text/javascript">
	$(document).ready(function() {
		
		console.log(${msg});
		
		var result = '${result}';
		if (result == "deleteOK") {
			$('#deleteOK').show();
			$('#deleteOK').fadeOut(1000);
			a
		}

		if (result == "writeOK") {
			$('#writeOK').show();
			$('#writeOK').fadeOut(1000);
		}

		if (result == "updateOK") {
			$('#updateOK').show();
			$('#updateOK').fadeOut(1000);
		}

	})
</script>

<div id="deleteOK" role="delete alert" style="display: none">글이
	삭제되었습니다.</div>
<div id="writeOK" role="write alert" style="display: none">글이
	작성되었습니다.</div>
<div id="updateOK" role="update alert" style="display: none">글이
	수정되었습니다.</div>




<body>

<%@ include file="../common/header.jsp" %>
<%@ include file="../common/side.jsp" %>
<%@ include file="../common/layout.jsp" %>

<header>
<h1>자유게시판</h1>
</header>

	<div class="container">
		<section id="container">
			<form role="form" method="get">
				<table class="table table-hover">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일</th>
						<th>조회수</th>
					</tr>

					<c:forEach items="${list}" var="list">
						<tr>
							<td><c:out value="${list.bno}" /></td>
							<td><a href="/board/readView?bno=${list.bno}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}">
							<c:out value="${list.title}" /></a></td>
							<td><c:out value="${list.writer}" /></td>
							<td><fmt:formatDate value="${list.regdate}"
									pattern="yyyy-MM-dd" /></td>
							<td><c:out value="${list.hit }"/></td>
						</tr>
					</c:forEach>

				</table>
				<hr />
				<div class="search row">
				<div class="col-xs-2 col-sm-2">
					<select name="searchType" class="form-control">
						<option value="n"
							<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
						<option value="t"
							<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
						<option value="c"
							<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
						<option value="w"
							<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
						<option value="tc"
							<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
					</select> 
					</div>
					
					<div class="col-xs-10 col-sm-10">
					<div class="input-group">
					<input type="text" name="keyword" id="keywordInput"	value="${scri.keyword}" class="form-control" />
					<span class="input-group-btn">
					<button id="searchBtn" type="button" class="btn btn-default">검색</button>
					</span>
					</div>
					</div>
					
					<script>
						$(function() {
							$('#searchBtn').click(function() {
												self.location = "list"
														+ '${pageMaker.makeQuery(1)}'
														+ "&searchType="
														+ $(
																"select option:selected")
																.val()
														+ "&keyword="
														+ encodeURIComponent($(
																'#keywordInput')
																.val());
											});
						});
					</script>
				</div>
				
				<div>
				<a href="/board/writeView" style="float:right" >글 작성</a>
				</div>
				<br />
				<hr />
				
				<div class="paging col-md-offset-3" >
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li><a
								href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
						</c:if>

						<c:forEach begin="${pageMaker.startPage}"
							end="${pageMaker.endPage}" var="idx">
							<li <c:out value="${pageMaker.cri.page == idx ? 'class=info' : '' }"/> >
							<a href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
						</c:forEach>

						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li><a
								href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
						</c:if>
					</ul>
				</div>

			</form>



		</section>

	</div>
<%@ include file="../common/footer.jsp" %>



</body>
</html>