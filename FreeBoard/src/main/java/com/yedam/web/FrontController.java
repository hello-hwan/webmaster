package com.yedam.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;

//프로젝트할때는 서블릿 하나만 만든다. 많으면 찾기 힘들어서
@WebServlet("*.do")// 뭔지는 몰라도 끝에 .do로 끝나면 실행 ex> abc.do, do.do
public class FrontController extends HttpServlet{
	Map<String, Control> map;
	
	//생성자
	public FrontController() {
		System.out.println("객체생성");
		map = new HashMap<>();
	}
	@Override
	public void init(ServletConfig config) throws ServletException {
		//되는지 확인용  System.out.println("init호출");
		//url과 실행문 매치
		map.put("/memberList.do", new MemberListControl());
		// 회원등록 1)등록화면 2)등록처리
		map.put("/memberAddForm.do", new MemberAddformControl());
		map.put("/memberAdd.do", new MemberAddControl());
		
		//게시판 관련
		map.put("/boardList.do",new BoardListControl());//목록
		map.put("/board.do", new BoardControl());//상세.
		//글등록 (등록화면 -> 등록처리)
		map.put("/addBoardForm.do", new AddBoardForm()); //화면열어주는 컨트롤
		map.put("/addBoard.do", new AddBoardControl()); // 등록 실행
		//글수정(수정화면 -> 변경처리)- get이면 화면, post면 등록
		map.put("/modifyBoard.do", new ModifyBoardControl());
		//글삭제
		map.put("/deleteBoard.do",new RemoveBoardControl());
	}
	
	@Override
	public void service(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		//되는지 확인용  System.out.println("service호출");
		//요청페이지?
		String uri = req.getRequestURI(); // 전체값은 url, uri : /FreeBoard/add.do
		String context = req.getContextPath(); //   /FreeBoard
		String page = uri.substring(context.length()); // /add.do
		
		Control control = map.get(page); //키를 넣으면 반환해줌
		control.exec(req, resp);
	}
	
	
}
