<%@page import="com.yedam.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header, footer 붙여넣기 -->
<jsp:include page="../includes/header.jsp"></jsp:include>

<h3>삭제화면(removeForm.jsp)</h3>

<%
String msg = (String) request.getAttribute("msg");
BoardVO board = (BoardVO) request.getAttribute("boardvo");
%>

<p style="color: red;">
	<%
	if (msg != null) {
	%>
</p>

<p><%=msg%></p>

<% } %>

	<!-- action은 form이 서브밋됐을때 호출할페이지 -->
<form action="deleteBoard.do" method="post">

<input type="hidden" name = "bno" value="<%=board.getBoardNo() %>">

	<table class="table">
		<tr>
			<th>글번호</th>
			<td><%=board.getBoardNo()%></td>
			<th>조회</th>
			<td><%=board.getViewCnt()%></td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3"><input type="text" name="title" class="form-control" value="<%=board.getTitle() %>>"></td>
		</tr>

		<tr>
			<th>내용</th>
			<td colspan="3"><textarea rows="3" cols="30" name="content"
					class="form-control"><%=board.getContent() %></textarea></td>
		</tr>

		<tr>
			<th>작성자</th>
			<td colspan="3"><%=board.getWriter()%></td>
		</tr>

		<tr>
			<td colspan="4" align="center"><input type="submit" value="삭제"
				class="btn btn-success"> <!-- 버튼은 밸류 없이 태그사이에 문자넣어야됨 --> <input
				type="reset" value="취소" class="btn btn-warning"></td>
		</tr>
		
	</table>

</form>


<!-- header, footer 붙여넣기 -->
<jsp:include page="../includes/footer.jsp"></jsp:include>