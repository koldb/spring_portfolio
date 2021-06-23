<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">

<title>게시판</title>
</head>
<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='writeForm']");
			$(".write_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				formObj.attr("action", "/board/write");
				formObj.attr("method", "post");
				formObj.submit();
			});
			
			$(".cancel_btn").on("click", function () {
				event.preventDefault();
				location.href = "/board/list";		
			})
			
		})
		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
	</script>


<body>
<header>
<h1>게시글 작성</h1>
</header>

	<section id="container">
		<form role="form" name="writeForm" method="post" action="/board/write">
			<table>
				<tbody>
					<tr>
						<td><label for="title">제목</label><input type="text"
							id="title" name="title" class="chk" title="제목을 입력하세요" /></td>
					</tr>
					<tr>
						<td><label for="content">내용</label>
						<textarea id="content" name="content" class="chk" title="내용을 입력하세요" ></textarea></td>
					</tr>
					<tr>
						<td><label for="writer">작성자</label><input type="text"
							id="writer" name="writer" class="chk" title="작성자를 입력하세요"  /></td>
					<tr>
						<td>
							<button class="write_btn" type="submit">작성</button>
							<button class="cancel_btn" type="button" >목록</button>
						</td>
					</tr>

				</tbody>

			</table>
		</form>
	</section>
<hr />

</body>
</html>