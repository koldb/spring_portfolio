<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- include libraries(jQuery, bootstrap) -->



<!-- include libraries(jQuery, bootstrap) -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>



<head>
<script type="text/javascript">
	$(document)
			.ready(
					function() {

						/* 	$('textarea[name="content"]').html($('.summernote').code());  */

						/* 	$('#content').val("${board_data.BOARD_CONTENT}"); */
						
						
						$('#content')
								.summernote(
										{
											height : 400,
											fontNames : [ '맑은고딕', 'Arial',
													'Arial Black',
													'Comic Sans MS',
													'Courier New', ],
											fontNamesIgnoreCheck : [ '맑은고딕' ],
											focus : true,
											lang : 'ko-KR',
											//콜백 함수
											callbacks : {
												onImageUpload : function(files,
														editor, welEditable) {
													// 파일 업로드(다중업로드를 위해 반복문 사용)
													for (var i = files.length - 1; i >= 0; i--) {
														uploadSummernoteImageFile(
																files[i], this);
													}
												}
											}
										});

						function uploadSummernoteImageFile(file, editor) {
							data = new FormData();
							data.append("file", file);
							$.ajax({
								data : data,
								type : "POST",
								url : "/board/uploadSummernoteImageFile",
								contentType : false,
								enctype : 'multipart/form-data',
								processData : false,
								success : function(data) {
									$(editor).summernote('insertImage',
											data.url);
								}
							});
						};
						
						
						
						
						
					});
</script>


<meta charset="UTF-8">

<title>게시판</title>
</head>



<body>
	<%@ include file="../common/header.jsp"%>
	<%@ include file="../common/side.jsp"%>
	<%@ include file="../common/layout.jsp"%>

	<header>
		<h1>게시글 작성</h1>
	</header>

	<section id="container">
		<form role="form" name="writeForm" method="post" action="/board/write"
			enctype="multipart/form-data" id="postForm">
			<table>
				<tbody>
				<c:if test="${member.userId != null }">
				
					<tr>
						<td><label for="title">제목</label><input type="text"
							id="title" name="title" /></td>
					</tr>
					<tr>
						<td><label for="content">내용</label> <textarea id="content"
								name="content" class="summernote" title="내용을 입력하세요" style="display:none"></textarea></td>
					</tr>
					<tr>
						<td><label for="writer">작성자</label><input type="text"
							id="writer" name="writer"  /></td>
					<tr>
						<td>
							<button class="write_btn" type="submit">작성</button>
							<button class="cancel_btn" type="button">목록</button>
						</td>
					</tr>
					</c:if>
					
					<c:if test="${member.userId == null }">
						<p>로그인 후 작성 하실 수 있습니다.</p>
						<table>
						<tr>
						<td>
						<button class="cancel_btn" type="button">목록</button>
						</td>
						</tr>
						</table>
					</c:if>
					
				</tbody>

			</table>
		</form>
	</section>
	<hr />

	<%@ include file="../common/footer.jsp"%>


</body>
<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form[name='writeForm']");
		$(".write_btn").on("click", function() {

			if($("input[name='title']").val() =="" || $("input[name='title']").val() == null){
				alert('제목을 입력하세요');
				$("input[name='title']").focus();
				return false;}
			
			if($("input[name='writer']").val() =="" || $("input[name='writer']").val() == null){
				alert('작성자를 입력하세요');
				$("input[name='writer']").focus();
				return false;}
		
		/* 	var contents = $('.summernote').summernote('code');
			//alert(contents.length);
			if(contents.length < 8 || contents.length > 10){ // 소스보기로 보면 <p><br></p> 가 기본으로 있음
			window.alert('내용을 입력하세요');
			$('.summernote').summernote('focus');
			return false;
			}  */
			
			var scontent = content.Value;
			
			
			formObj.attr("action", "/board/write");
			formObj.attr("method", "post");
			formObj.submit();
		});

		$(".cancel_btn").on("click", function() {
			event.preventDefault();
			location.href = "/board/list";
		})

	})
	

	
</script>

</html>