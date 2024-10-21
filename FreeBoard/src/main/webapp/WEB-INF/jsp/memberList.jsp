<%@page import="com.yedam.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<h3>회원목록</h3>
<%
//(List<MemberVO>) : 오브젝트타입을 List 타입으로 변환
List<MemberVO> list = (List<MemberVO>) request.getAttribute("memberList");
System.out.println(list);
%>
<table class = 'table'>
	<tbody>
		<%
		for (MemberVO mvo : list) {
		%>
		<tr>
			<td><%=mvo.getMemberId()%></td>
			<td><%=mvo.getMemberName()%></td>
			<td><%=mvo.getPhone()%></td>
		</tr>
		<% } %>
	</tbody>
</table>
