<%@page import="com.yedam.service.MemberService"%>
<%@page import="com.yedam.service.MemberServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl 라이브러리 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- MVC 디자인: View (JSP페이지) , Model(DB처리), 컨트롤 -->

	<!-- Expression Language : EL (jsp에서만 사용가능한  jsp 컨테이너), 서블릿 컨테이너 = > tomcat이 둘다 가지고 있음-->
복잡한 코드말고 문자타입, 숫자타입, 불린 타입 간단한 연산식 가능, 3항 연산식 가능
		<%
		String name = "Hong";
		%>

		<!-- jsp action tag -태그안에 있는 기능들  <jsp 치고 컨트롤 엔터   -->
		<!-- JSP standard Tag Library : JSTL      jstl apache 검색 -->
		${logId}
		<c:set var="name" value="Hong"></c:set>
		<!-- prefix="c" 로 변수지정 -->
		<c:out value="${name }"></c:out>
		<!-- prefix="c" 로 ${}안의 변수 출력 -->

		<c:set var="age" value="30"></c:set>
		<c:if test="${age>=60 }">
			<p>노인입니다</p>
		</c:if>

		<c:choose>
			<c:when test="${age>=20 }">
				<p>청인</p>
			</c:when>
			<c:otherwise>
				<p>미성년</p>
			</c:otherwise>
		</c:choose>

		<c:forEach var="i" begin="1" end="5" step="1">
			<p>i의 값은</p>
		</c:forEach>

<c:set var="page" value = "boardList.do"></c:set>
<jsp:forward page="${page }"></jsp:forward>

</body>
</html>