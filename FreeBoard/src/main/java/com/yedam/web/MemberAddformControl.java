package com.yedam.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;

public class MemberAddformControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) 
	throws ServletException, IOException{
		// jsp 페이지 open.
		//컨트롤에서는 WEB-INF밑에 있어도 접근 가능, url에서는 불가 
		req.getRequestDispatcher("WEB-INF/jsp/memberAddForm.jsp").forward(req,resp);
	}
	
}
