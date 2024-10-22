package com.yedam.control.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.BoardService;
import com.yedam.service.BoardServiceImpl;
import com.yedam.vo.BoardVO;

public class RemoveBoardControl implements Control {
	
	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		
		BoardService svc = new BoardServiceImpl();
		
		String bno = req.getParameter("bno");
		
		//GET : 삭제화면, POST 는 삭제처리.
		if(req.getMethod().equals("GET")) {
			BoardVO board = svc.searchBoard(Integer.parseInt(bno));
			
			req.setAttribute("boardvo", board);
			req.getRequestDispatcher("WEB-INF/jsp/removeForm.jsp").forward(req, resp);
		}else if(req.getMethod().equals("POST")) {
			BoardVO board = new BoardVO();
			board.setBoardNo(Integer.parseInt(bno));
			
			if(svc.removeBoard(Integer.parseInt(bno))) {
				resp.sendRedirect("boardList.do");
			}else {
				board = svc.searchBoard(Integer.parseInt(bno));
				
				req.setAttribute("boardvo", board);
				req.setAttribute("msg", "삭제할 게시글이 없습니다");
				req.getRequestDispatcher("WEB-INF/jsp/removeForm.jsp");
			}
		}
	}
	
}
