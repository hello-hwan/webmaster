<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.yedam.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.reply span{
display: inline-block;
}
.reply ul{
list-style: none;
}
</style>

<!-- header, footer 붙여넣기 -->
<jsp:include page="../includes/header.jsp"></jsp:include>

<%
BoardVO board = (BoardVO) request.getAttribute("boardvo");
//date포맷(2024-10-09 12:22:33)
String pg = (String) request.getAttribute("page");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>

<h3>상세페이지(board.jsp)</h3>

<form>

	<table class="table">
		<thead>
			<tr>
				<th>글번호</th>
				<td><%=board.getBoardNo()%></td>
				<th>조회수</th>
				<td><%=board.getViewCnt()%></td>
			</tr>
		</thead>
		<tr>
			<th>제목</th>
			<td><input type="text" name="title" placeholder="제목"></td>
			<th>작성자</th>
			<td><input type="text" name="writer" placeholder="글쓴이"></td>
		</tr>

		<tr>
			<th>내용</th>
			<textarea readonly cols="30" rows="4" class="form-control"><%=board.getContent()%></textarea>
			<td colspan="3"><input type="text" name="content"
				placeholder="내용"></td>
		</tr>

		<%
		if (board.getImg() != null) {
		%>
		<tr>
			<th>이미지</th>
			<td colspan="3"><img src="images/<%=board.getImg()%>"
				width="150px"></td>
		</tr>
		<%
		}
		%>
		<tr>
			<th>작성일시</th>
			<td colspan="3"><%=sdf.format(board.getWriteDate())%></td>
		</tr>
	</table>
	<input type="button" value="수정" class="btn btn-warning"> <input
		type="button" value="삭제" class="btn btn-danger">
</form>


<!-- 댓글관련. -->
<div class="container reply">
	<!-- 댓글 등록 -->
	<div class="header">
	댓글내용:<input class="col-sm-8" id="reply">
	<button class="col-sm-3" id="addReply">댓글등록</button>
	
	</div>
	<!-- 댓글 목록 -->
	<div class="content">
		<ul>
			<li>
			<span class="col-sm-2">글번호</span> 
			<span class="col-sm-5">내용</span>
			<span class="col-sm-2">작성자</span>
			<span class="col-sm-2">삭제</span>
			</li>
			
			<!-- <li>
			<span class="col-sm-2">3</span> 
			<span class="col-sm-5">댓글입니다</span>
			<span class="col-sm-2">user01</span>
			<span class="col-sm-2"><button>삭제</button></span>
			</li> -->
		</ul>
	</div>
	<!-- 댓글 페이징 -->
<nav aria-label="Page navigation example">
  <ul class="pagination">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
	<!-- 댓글 페이징 -->
</div>



<!-- header, footer 붙여넣기 -->
<jsp:include page="../includes/footer.jsp"></jsp:include>

<script>
const bno = "${boardvo.boardNo }"; console.log(bno);
const logId = "${logId}";console.log(logId);


document.querySelector('input[value = "수정"]')
                  .addEventListener('click',function(e){
                	  location.href = 'modifyBoard.do?page=<%=pg%>&bno=<%=board.getBoardNo()%>';
// searchCondition=${searchCondition}&keyword=${keyword}&page=${page}&bno=${bno}
                  });

document.querySelector('input[value = "삭제"]')
.addEventListener('click',function(e){
	  location.href = 'deleteBoard.do?page=<%=pg%>&bno=<%=board.getBoardNo()%>';});
</script>

<script src="js/replyService.js"></script>
<script src="js/reply.js"></script>