package com.yedam.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DataSource;
import com.yedam.dao.MemberMapper;
import com.yedam.vo.Member;

/**
 * Servlet implementation class MemberAddServlet
 */
// 서블릿 실행하기 위한 url.(요청정보 전송)
// 응답정보를 전송.
// 우클릭 빌드패스 - 컨피겨 - 컨피겨 빌드패스 - 라이브러리 아래쪽에 애드 라이브러리 - server runtime - tomcat 9.0
// 실행후 아래 tomcat 클릭후 실행
// httpservlet 상속받은걸 전부 servlet 이라고함 -규칙에 따라서 만들어주기만하면된다

// http 프로토콜을 데이터 전송 수신.
// httpServlet 상속 기능 구현.
@WebServlet("/MemberAddServlet")//url을 넣어주면
public class MemberAddServlet extends HttpServlet {//class 실행시켜줌
	private static final long serialVersionUID = 1L;
	
    /**
     * Default constructor. 
     */
    public MemberAddServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    //코드를 실행하는 메소드 doGet
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		//자바 => 데이터의 입출력 : 스트림
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print("<h3>여기는 웹브라우저<h3>");
		out.print("<h3>응답정보를 처리하는 객체 response<h3>");
		out.print("<a href = 'index.html'>첫페이지로 이동</a>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//doGet(request, response);
		//한글로 인코딩해서 넘겨줌
		request.setCharacterEncoding("utf-8");
		//4개 파라미터.
		String id = request.getParameter("mid");//mid에 담긴 파라미터 값
		String name = request.getParameter("mname");//mname에 담긴 파라미터 값
		String passwd = request.getParameter("pass");//pass에 담긴 파라미터 값
		String phone = request.getParameter("phone");//phone에 담긴 파라미터 값
		
		Member member = new Member();
		member.setMemberId(id);
		member.setMemberName(name);
		member.setPassword(passwd);
		member.setPhone(phone);
		
		SqlSession sqlSession = DataSource.getInstance().openSession(true);
		//openSession에 트루하면 자동커밋
		MemberMapper dao = sqlSession.getMapper(MemberMapper.class);
		
		try {
			if(dao.insertMember(member)==1) {
				response.getWriter().print("OK");
			}
		} catch (Exception e) {
			response.getWriter().print("NG");
		}
		
	}

}
