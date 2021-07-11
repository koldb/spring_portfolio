<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<script type="text/javascript">
			
		

	function joinmember() {
		var popupX = (window.screen.width / 2)  - (450 / 2);
		//&nbsp;만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

		var popupY= (window.screen.height / 2) - (450 / 2);
		//&nbsp;만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음

		window.open("${contextPath}/member/register","register",'status=no, height=450, width=450, left='+ popupX + ', top='+ popupY)
	}
	
	function loginpopup() {
		var popupX = (window.screen.width / 2)  - (450 / 2);
		//&nbsp;만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

		var popupY= (window.screen.height / 2) - (450 / 2);
		//&nbsp;만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음

		window.open("${contextPath}/member/login","login",'status=no, height=450, width=450, left='+ popupX + ', top='+ popupY)
	}
	
	function memberModifyViewpopup() {
		var popupX = (window.screen.width / 2)  - (450 / 2);
		//&nbsp;만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

		var popupY= (window.screen.height / 2) - (450 / 2);
		//&nbsp;만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음

		window.open("${contextPath}/member/memberModifyView","memberModifyView",'status=no, height=450, width=450, left='+ popupX + ', top='+ popupY)
	}
	


</script>



<html>
<head>
  <meta charset="UTF-8">
      <style>
        #header {
        padding: 5px;
        margin-bottom: 5px;
        border: 0px solid #bcbcbc;
         background-color: lightgreen;
      }
      
    </style>
<title >header</title>
</head>
<body>

<table border=0  width="100%" id="header">
  <tr>
 <%--     <td>
       <h1><font size=30>enjoy your account!!</font></h1>
       <a href="#" style="float:right">로그인</a> <br />
         <a href="${contextPath}/member/register" style="float:right" >회원 가입</a>  
         <a href="javascript:joinmember()" style="float:right" id="reg">회원 가입</a>  
         
     </td> --%>
     
     <td>
       <h1 style="text-align: center"><font size=30 >Enjoy Your Account!!</font></h1>
     <ul>
	<li style="list-style: none;">
		<c:if test="${member != null}">
			<a href="javascript:memberModifyViewpopup()">${member.userId}님.</a>
		</c:if>
	</li>  
	
	<li style="list-style: none;">
		<c:if test="${member != null}"><a href="/member/logout">로그아웃</a></c:if>
		<c:if test="${member == null}"><a href="javascript:loginpopup()" >로그인</a></c:if> &nbsp;
		<c:if test="${member == null}"> <a href="javascript:joinmember()" style="float:right" id="reg">회원 가입</a>  </c:if>
	</li>
	
	
	<li >
		<c:if test="${msg == false }">
			<!-- <p style="color: red;">아이디와 비밀번호를 확인하세요</p> -->
			<script type="text/javascript">
			alert("아이디와 비밀번호를 확인하세요");
			
			</script>
			
		</c:if>
		<%-- <c:if test="${msg == null }"></c:if> --%>
		
	</li>
	
  
</ul>
     </td>
     
  </tr>
  </table>
  

  



</body>
</html>