<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- header, footer 붙여넣기 -->
<jsp:include page="../includes/header.jsp"></jsp:include>

<h3>등록화면(boardForm.jsp)</h3>

<%
String msg = (String) request.getAttribute("msg");
%>

<p style = "color:red;"> <% if(msg != null){ %></p>

<p><%=msg %></p>

<%} %>

<form action="addBoard.do" method="post"> <!-- action은 form이 서브밋됐을때 호출할페이지 -->
	<table class="table">
		<tr>
			<th>제목</th>
			<td><input type = "text" name="title" class= "form-control"></td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td><textarea rows="3" cols="30" name = "content" class= "form-control"></textarea></td>
		</tr>
		
		<tr>
			<th>작성자</th>
			<td><input type = "text" name="writer" class= "form-control"></td>
		</tr>
		
		<tr>
		<td colspan="2" align = "center">
		<input type="submit" value = "저장" class= "btn btn-success"> <!-- 버튼은 밸류 없이 태그사이에 문자넣어야됨 -->
		<input type="reset" value = "취소" class= "btn btn-warning">
		</td>
		</tr>
		
		
	</table>
	
</form>


<!-- header, footer 붙여넣기 -->
<jsp:include page="../includes/footer.jsp"></jsp:include>