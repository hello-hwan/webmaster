package com.yedam.web;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DataSource;
import com.yedam.dao.MemberMapper;
import com.yedam.vo.Member;

//객체생성 -> init -> service -> destroy
@WebServlet("/member.action")
public class MemberControlServlet extends HttpServlet {
	// 1. extends HttpServlet
	// 2. @WebServlet("/member.action") url 요청

	// 3. 타자 그대로 침 , 최초 요청일때만 객체 생성
	public MemberControlServlet() {
		System.out.println("MemberControl 객체 생성");
	}

	// 4. init ctrl +스페이스바 두번째 꺼 최초 요청일때만 실행
	@Override // HttpServlet 가 가진 메소드 재정의
	public void init(ServletConfig config) throws ServletException {
		System.out.println("최초 요청이면 init 실행");
	}

	// 5. service ctrl +스페이스바 첫번째꺼 요청이 올때마다 실행
	// 기능 만들때는 여기다가 넣어야함
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		//8. public interface MemberMapper { 이동
		//10번 두줄 복붙
		SqlSession sqlSession = DataSource.getInstance().openSession(true);
		MemberMapper dao = sqlSession.getMapper(MemberMapper.class);
		
		
		//12 content type
		resp.setContentType("text/html;charset=utf-8");
		System.out.println("서블릿을 요청 실행");
		
		//7. 상세조회 -멤버 아이디 값을가지고 db에서 조회
		//parameter를 가져오는 메소드, ?값이 파라미터, 위치는 member.action
		String id = req.getParameter("mid");//http://localhost/mybatis3/member.action?mid=user01
		
		//19타자 get:조회하면, post:삭제처리
		if(req.getMethod().equals("GET")){
			
			//11번 타자로 쳤음
			Member member = dao.selectMember(id); //해당되는 아이디가 없으면 null
			if(member == null) {
				resp.getWriter().print("조회된 정보가 없습니다.");
				return;
			}
			String str = "<h3>회원정보</h3>";
			
			//15타자
			str += "<form action='member.action' method='post'>";
			
			//17타자
			str += "<input type = 'hidden' name = 'mid' value='" + member.getMemberId() + "'>";
			
			str += "<table border = '1'>";
			str += "<tr><th>회원아이디</th><td>" + member.getMemberId() + "</td></tr>";
			str += "<tr><th>회원이름</th><td>" + member.getMemberName() + "</td></tr>";
			str += "<tr><th>연락처</th><td>" + member.getPhone() + "</td></tr>";
			
			//18타자
			str += "<tr><td colspan = '2'><input type = 'submit'></td></tr>";
			
			str += "</table>";
			
			//16타자
			str += "</form>";
			
			//14.링크
			str += "<a href = 'MemberListServlet'>목록으로</a>";
			
			resp.getWriter().print(str);
		} else if(req.getMethod().equals("POST")) {//삭제처리
			if(dao.deleteMember(id)==1) {
				resp.getWriter().print("<p>삭제완료</p>");
			}else {
				resp.getWriter().print("<p>삭제할 회원없음.</p>");
			}
			resp.getWriter().print("<a href = 'MemberListServlet'>목록으로</a>");
		}
		//13 bound 어쩌고 오류 뜨면 인터페이스랑 xml 이름에 오타나서 연결안됨
		
		//20 실행하고 뒤에 ?mid=guest 이렇게 넣어줘야 제대로 실행됨
		
	}// end of service

	// 6. destroy ctrl +스페이스바 첫번째꺼
	@Override
	public void destroy() {
		System.out.println("서버가 종료될때 한번 실행");
	}

}
