<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"
	type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"
	type="text/javascript"></script>



<title>내역 입력</title>
</head>
<style type="text/css">
li {
	list-style: none;
	float: left;
	padding: 6px;
}

th {
	text-align: center;
}

.paging {
	text-align: center;
	margin: 0 auto;
}

/* header{
 margin-left: 850px;    
}
 */
</style>



<body>
	<%@ include file="../common/header.jsp"%>
	<%@ include file="../common/side.jsp"%>
	<%@ include file="../common/layout.jsp"%>

	<header>
		<h1>내역 입력</h1>
	</header>

	<div>
		<section>
			<form action="/board/householdWrite" method="post" id="accInsert">
				<input type="hidden" id="userId" name="userId"
					value="${member.userId}" readonly="readonly" />

				<table>
					<tbody>

						<tr style="text-align: center;">
							<td>일자</td>
							<td>수입/지출</td>
							<td>항목</td>
							<td>적요</td>
							<td>금액</td>
						</tr>

						<tr>
							<td>
								<div>
									<label for="date"> <input type="date" id="accDate"
										name="accDate" />
									</label>
								</div>
							</td>

							<td>
								<div>
									<label for="accDiv"> <input type="text" id="accDiv"
										name="accDiv" />
									</label>
								</div>
							</td>

							<td>
								<div>
									<label for="accCategory"> <input type="text"
										id="accCategory" name="accCategory" />
									</label>
								</div>
							</td>

							<td>
								<div>
									<label for="accComment"> <input type="text"
										id="accComment" name="accComment" />
									</label>
								</div>
							</td>

							<td>
								<div>
									<label for="accAmount"> <input type="text"
										id="accAmount" name="accAmount" />
									</label>
								</div>
							</td>
						</tr>
				<tr>
					<td>
						<button type="button" id="accinsert">등록</button>
					</td>
				</tr>

<c:forEach items="${accList }" var="accList">
<tr style="text-align: center;">
<td><c:out value="${accList.accNum}" /></td>
<td><c:out value="${accList.accDate }"></c:out> </td>
<td><c:out value="${accList.accDiv }"></c:out> </td>
<td><c:out value="${accList.accCategory }"></c:out> </td>
<td><c:out value="${accList.accComment }"></c:out> </td>
<td><c:out value="${accList.accAmount }"></c:out> </td>

<td>
	 <a class="delbtn" href="/board/accDelete?accNum=${accList.accNum}">삭제</a>
</td>
</tr>
</c:forEach>
			
				</tbody>
				</table>
			</form>
		</section>
	</div>




	<%@ include file="../common/footer.jsp"%>
</body>
</html>