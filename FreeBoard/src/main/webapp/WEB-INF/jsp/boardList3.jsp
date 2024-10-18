<%@page import="com.yedam.common.PageDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.yedam.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- header, footer 붙여넣기 -->
<jsp:include page="../includes/header.jsp"></jsp:include>

<h3>글목록(boardList.jsp)</h3>

<%
List<BoardVO> list = (List<BoardVO>) request.getAttribute("boardList");
//date포맷(2024-10-09 12:22:33)
//String pg = (String) request.getAttribute("page");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

PageDTO paging = (PageDTO) request.getAttribute("page");
String sc = (String) request.getAttribute("searchCondition");
String kw = (String) request.getAttribute("keyword");
kw = kw == null ? "" : kw;  //널 값을 처리하기.
%>

<!-- 검색조건 넣기 -->
<form action = "boardList.do" class="row g-3">
  
  <div class="col-md-3">
    <select name = "searchCondition" class="form-select">
      <option selected value = "">선택하세요</option>
      <option value ="T" <%= ( sc != null && sc.equals("T") ? "selected" : "" ) %>>제목</option>
      <option value ="W">작성자</option>
      <option value ="TW">제목 & 작성자</option>
    </select>
  </div>
  
  <div class="col-md-4">
    <input type="text" class="form-control" name = "keyword" value = '<%=kw%>'>
  </div>

  <div class="col-md-5">
    <button type="submit" class="btn btn-primary">조 회</button>
  </div>
  
</form>


<!--  <p><%=list%></p> -->
<table class="table">
	<thead>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일자</th>
		</tr>
	</thead>
	<tbody>
	
		<c:forEach var="board" items="${boardList }">
		<tr>
			<td><c:out value="${board.boardNo}" /></td>
			<td><a href='board.do?searchCondition=${searchCondition }&keyword=${keyword}&page=${page.page }&bno=${board.boardNo}'>${board.title}</a></td>
			<td><c:out value="${board.writer}" /></td>
			<td><fmt:formatDate value="${board.writer}" pattern="yyyy.MM.dd HH:mm:ss" /></td>
			<td><c:out value="${board.viewCnt}" /></td>
		</tr>
		</c:forEach>

	</tbody>
</table>

<!-- <%=paging%>   -->

<!-- paging : 페이지 넘김 -부트스트랩 pagination -->
<nav aria-label="Page navigation example">
	<ul class="pagination justify-content-center">
	<!-- 이전페이지 출력 -->
		<% if (paging.isPrev()) { %>
		
		<li class="page-item" aria-current="page"><a class="page-link"
			href="boardList.do?page=<%=paging.getStartPage() - 1%>">Previous</a>
		</li>
		
		<% } else { %>
		
		<li class="page-item disabled"><a class="page-link" href="#">Previous</a>
		</li>
		
		<% } %>
		<!-- 페이지 출력 -->
		<%
		for (int p = paging.getStartPage(); p <= paging.getEndPage(); p++) {
		%>
		<%if(paging.getPage() ==p) {%>
		<li class="page-item active" aria-current="page">
		<span class="page-link"><%=p%></span></li>
		
		<% } else{%>
		<li class="page-item"><a class="page-link"
			href="boardList.do?searchCondition=<%=sc %>&keyword=<%=kw %>&page=<%=p%>"><%=p%></a></li>
		<% } %>
		<% } %>
		
		<!-- 다음페이지 출력 -->
		<% if (paging.isNext()) {%>
		
		<li class="page-item" aria-current="page"><a class="page-link"
			href="boardList.do?page=<%=paging.getEndPage() + 1%>">Next</a></li>
		
		<% } else { %>
		
		<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
		<%} %>
		
	</ul>
</nav>


<!-- header, footer 붙여넣기 -->
<jsp:include page="../includes/footer.jsp"></jsp:include>