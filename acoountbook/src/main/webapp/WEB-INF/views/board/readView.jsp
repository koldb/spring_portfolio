<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>게시판</title>
</head>

<script type="text/javascript">
$(document).ready(function () {
	
	showReplyList();
	
	
	var formObj = $("form[name = 'readForm']");
	
	//수정
	$(".update_btn").on("click", function () {
		formObj.attr("action", "/board/updateView");
		formObj.attr("method", "get");
		formObj.submit();
	})
	//삭제
	$(".delete_btn").on("click",function(){
		if(confirm("삭제하시겠습니까?")){
			formObj.attr("action", "/board/delete");
			formObj.attr("method", "post");
			formObj.submit();
		}
	})
		
	
	//취소
	$(".list_btn").on("click", function () {
		location.href = encodeURI("/board/list?page=${scri.page}"
				+"&perPageNum=${scri.perPageNum}"
				+"&searchType=${scri.searchType}&keyword=${scri.keyword}");
	})
	
/* 	//댓글 작성
	$(".replyWrite_btn").on("click", function () {
		var formObj = $("form[name='replyForm']");
		formObj.attr("action", "/board/replyWrite");
		formObj.submit();
	}); */
	
});

	function showReplyList() {
		var url = "${pageContext.request.contextPath}/restBoard/readReply";
		var paramData = {"bno" : "${read.bno}"};
		$.ajax({
            type: 'POST',
            url: url,
            data: paramData,
            dataType: 'json',
            success: function(result) {
               	var htmls = "";
			if(result.length < 1){
				htmls.push("등록된 댓글이 없습니다.");
				console.log("htmls ? ")
			} else {
	                    $(result).each(function(){
	                        htmls += '<div class="media text-muted pt-3" id="rno' + this.rno + '">';
		                     htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';
		                     htmls += '<title>Placeholder</title>';
		                     htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';
		                     htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';
		                     htmls += '</svg>';
		                     htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
		                     htmls += '<span class="d-block">';
		                     htmls += '<strong class="text-gray-dark">' + this.writer + '</strong>';
		                     htmls += '<span style="padding-left: 7px; font-size: 9pt">';
		                     htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + this.rno + ', \'' + this.writer + '\', \'' + this.content + '\' )" style="padding-right:5px">수정</a>';
		                     htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.rno + ')" >삭제</a>';
		                     htmls += '</span>';
		                     htmls += '</span>';
		                     htmls += this.content;
		                     htmls += '</p>';
		                     htmls += '</div>';
		                });	//each end
			}
			$("#replyList").html(htmls);
            }	   // Ajax success end
		});	// Ajax end
		
	};


	
	
	function fn_editReply(rno, writer, content){
		var htmls = "";
		htmls += '<div class="media text-muted pt-3" id="rno' + rno + '">';
		htmls += '<svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder:32x32">';
		htmls += '<title>Placeholder</title>';
		htmls += '<rect width="100%" height="100%" fill="#007bff"></rect>';
		htmls += '<text x="50%" fill="#007bff" dy=".3em">32x32</text>';
		htmls += '</svg>';
		htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
		htmls += '<span class="d-block">';
		htmls += '<strong class="text-gray-dark">' + writer + '</strong>';
		htmls += '<span style="padding-left: 7px; font-size: 9pt">';
		htmls += '<a href="javascript:void(0)" onclick="fn_updateReply(' + rno + ', \'' + writer + '\')" style="padding-right:5px">저장</a>';
		htmls += '<a href="javascript:void(0)" onClick="showReplyList()">취소<a>';
		htmls += '</span>';
		htmls += '</span>';		
		htmls += '<textarea name="editContent" id="editContent" class="form-control" rows="3">';
		htmls += content;
		htmls += '</textarea>';
		htmls += '</p>';
		htmls += '</div>';
		$('#rno' + rno).replaceWith(htmls);
		$('#rno' + rno + ' #editContent').focus();
	}
	
	//댓글 수정
	function fn_updateReply(rno, writer){
		var replyEditContent = $('#editContent').val(); 
		var paramData = JSON.stringify({"content": replyEditContent
				, "rno": rno
		});
		var headers = {"Content-Type" : "application/json"
				, "X-HTTP-Method-Override" : "POST"};
		$.ajax({
			url: "${pageContext.request.contextPath}/restBoard/updateReply"
			, headers : headers
			, data : paramData
			, type : 'POST'
			, dataType : 'text'
			, success: function(result){
                                console.log(result);
				showReplyList();
			}
			, error: function(error){
				console.log("에러 : " + error);
			}
		});
	}
	
	//댓글 삭제
	function fn_deleteReply(rno){
		var paramData = {"rno": rno};
		$.ajax({
			url: "${pageContext.request.contextPath}/restBoard/deleteReply"
			, data : paramData
			, type : 'POST'
			, dataType : 'text'
			, success: function(result){
				showReplyList();
			}
			, error: function(error){
				console.log("에러 : " + error);
			}
		});
		location.reload();
	}
	
</script>

<script type="text/javascript">

//댓글 저장
$(document).on("click","#replyWrite_btn" ,function(){
	var replyContent = $('#rpcontent').val(); 
	var replyWriter = $('#rpwriter').val(); 
	var paramData = JSON.stringify({"content": replyContent
		, "writer": replyWriter
		, "bno":'${read.bno}'
});
	var headers = {"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"};

	$.ajax({
		url: "${pageContext.request.contextPath}/restBoard/writeReply"
		, headers : headers
		, data : paramData
		, type : 'POST'
		, dataType : 'text'
		, success: function(result){
			console.log(replyContent);
			console.log(replyWriter);
			
			showReplyList();
			$('#rpcontent').val(); 
			$('#rpwriter').val(); 
		}
		, error: function(error){
			console.log("에러 : " + error);
		}
	});
})
</script>



<body>
<header>
<h1>게시글 읽기</h1>
</header>


<div id="root">
			<section id="container">
				<form name="readForm" role="form" method="post">
					<input type="hidden" id="bno" name="bno" value="${read.bno}" />
					<input type="hidden" id="page" name="page" value="${scri.page }" />
					<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum }" />
					<input type="hidden" id="searchType" name="searchType" value="${scri.searchType }" />
					<input type="hidden" id="keyword" name="keyword" value="${scri.keyword }" />
					
				</form>
				<table>
					<tbody>
						<tr>
							<td>
								<label for="title">제목</label><input type="text" id="title" name="title" value="${read.title}" readonly="readonly" />
							</td>
						</tr>	
						<tr>
							<td>
								<label for="content">내용</label><textarea id="content" name="content" readonly="readonly"><c:out value="${read.content}" /></textarea>
							</td>
						</tr>
						<tr>
							<td>
								<label for="writer">작성자</label><input type="text" id="writer" name="writer" value="${read.writer}"  readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<label for="regdate">작성날짜</label>
								<fmt:formatDate value="${read.regdate}" pattern="yyyy-MM-dd" />					
							</td>
						</tr>		
					</tbody>			
				</table>
			<div>
				<button type="button" class="update_btn">수정</button>
				<button type="button" class="delete_btn">삭제</button>
				<button type="button" class="list_btn">목록</button>
				
				</div>
				<br />
		<%-- 	<!-- 댓글 부분 -->
				<div id="reply">
					<ol class="replyList">
					<c:forEach items="${replyList }" var="replyList">
					<li>
					<p>
					작성자 : ${replyList.writer } <br />
					작성날짜 : <fmt:formatDate value="${replyList.regdate }" pattern = "yyyy-MM-dd"/>
					</p>
					
					<p>comments : ${replyList.content}</p>
					</li>
					</c:forEach>
					
					</ol>
				</div>  --%>
				
				<form name="replyForm" method="post">
				<input type="hidden" id="bno" name="bno" value="${read.bno }"/>
				<input type="hidden" id="page" name="page" value="${scri.page }" />
				<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum }" />
				<input type="hidden" id="searchType" name="searchType" value="${scri.searchType }" />
				<input type="hidden" id="keyword" name="keyword" value="${scri.keyword }" />
				
			<!-- 	<div>
				<label for="writer">댓글 작성자</label><input type="text" id="writer" name="writer" />
				<br />
				<label for="content">댓글 내용</label><input type="text" id="content" name="content" />
				</div> -->
				
					<!-- Reply Form {s} -->


				<form:form name="form" id="form" role="form" modelAttribute="replyList" method="post">

				<%-- <form:hidden path="bno" id="bno" value="${read.bno }"/> --%>


					<div>
						 <textarea name="rpcontent" id="rpcontent" class="rpcont" rows="3" placeholder="댓글을 입력해 주세요"></textarea>
					</div>

					<div>
						<input name="rpwriter" class="rpwform" id="rpwriter" placeholder="댓글 작성자"/>

						<button type="button" class="rpbtn" id="replyWrite_btn" > 댓글 등록 </button>
					</div>


				</form:form>


			<!-- Reply Form {e} -->

			

			<!-- Reply List {s}-->
				<h6 class="border-bottom pb-2 mb-0">Reply list</h6>
				<div id="replyList"></div>
			<!-- Reply List {e}-->



				
				<!-- <div>
				<button type="button" class="replyWrite_btn">작성</button>
				</div> -->

				
				</form>
				
				
			</section>
			<hr />
		</div>


	
</body>
</html>