<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.yedam.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header, footer 붙여넣기 -->
<jsp:include page="../includes/header.jsp"></jsp:include>

<%
BoardVO board = (BoardVO) request.getAttribute("boardvo");
//date포맷(2024-10-09 12:22:33)
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>

<h3>상세페이지(board.jsp)</h3>

<form>

<table class ="table">
	<thead>
		<tr>
			<th>글번호</th>
			<td><%=board.getBoardNo() %></td>
			<th>조회수</th>
			<td><%=board.getViewCnt() %></td>
		</tr>
	</thead>
	<tr>
		<th>제목</th>
		<td colspan="3"><input type = "text" name = "title" placeholder="제목"></td>
	</tr>

	<tr>
		<th>내용</th>
		<textarea readonly cols="30" rows="4" class="form-control"><%=board.getContent() %></textarea>
		<td colspan="3"><input type = "text" name = "content" placeholder="내용"></td>
	</tr>

	<tr>
		<th>작성자</th>
		<td colspan="3"><input type = "text" name = "writer" placeholder="글쓴이"></td>
	</tr>

	<tr>
		<th>작성일시</th>
		<td colspan="3"><%=sdf.format(board.getWriteDate()) %></td>
	</tr>
</table >
<input type = "button" value ="수정" class = "btn btn-warning">
<input type = "button" value ="삭제" class = "btn btn-danger">
</form>

<!-- header, footer 붙여넣기 -->
<jsp:include page="../includes/footer.jsp"></jsp:include>

<script>
document.querySelector('input[value = "수정"]')
                  .addEventListener('click',function(e){
                	  location.href = 'modifyBoard.do?bno=<%=board.getBoardNo()%>';
                  });
                      


</script>