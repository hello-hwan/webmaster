package com.yedam.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DataSource;
import com.yedam.dao.MemberMapper;
import com.yedam.vo.Member;

//IOC (제어의 역전) - 톰캣이 원하는 방식대로 실행됨
//객체생성 -> init() -> service() ->destroy :서블릿의 생명주기.
@WebServlet("/MemberListServlet")//url 요청이 들어오면 서블릿 실행
public class MemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public MemberListServlet() {
        super();
    }
    
    //코드실행 메소드 doGet
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		SqlSession sqlSession = DataSource.getInstance().openSession(true);
		MemberMapper dao = sqlSession.getMapper(MemberMapper.class);
		
		List<Member> result = dao.members();
		
		String str = "";
		
		str += "<h3>회원목록</h3>";
		str += "<table border = '1'>";
		str += "<thead><tr><th>회원아이디</th><th>회원명</th><th>연락처</th></tr></thead>";
		str += "<tbody>";
		for(Member member : result) {
			//물음표 뒤 값이 파라미터, member.getMemberId()를 ""안에 넣으면 그냥 문자로바뀜
			str +="<tr><td><a href = 'member.action?mid=" + member.getMemberId() + "'>"
			    + member.getMemberId() + "</a></td><td>"
			    + member.getMemberName() + "</td><td>"
			    + member.getPhone() + "</td></tr>";
		}
		str += "</tbody>";
		str += "</table>";
		str += "<a href = './'>첫페이지</a>";
		out.print(str);
		
	}
	
	//코드 전송 메소드 doPost
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		//doGet(request, response);
	}
	
}
