package com.yedam.control.member;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.MemberService;
import com.yedam.service.MemberServiceImpl;
import com.yedam.vo.MemberVO;

public class MemberAddControl implements Control{
	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		System.out.println("MemberAddControl 출력");
		String id = req.getParameter("mid");
		String nm = req.getParameter("mname");
		String pw = req.getParameter("passwd");
		String pn = req.getParameter("phone");
		
		MemberVO mvo = new MemberVO();
		mvo.setMemberId(id);
		mvo.setMemberName(nm);
		mvo.setPassword(pw);
		mvo.setPhone(pn);
		
		MemberService svc = new MemberServiceImpl();
		
		try {
			svc.addMember(mvo);
			resp.sendRedirect("memberList.do");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("memberAddForm.do");
		}
		
		/*
		if(svc.addMember(mvo)) {
			// 목록페이지로 이동.
			resp.sendRedirect("memberList.do");
		}else {
			// 등록화면으로 이동.
			resp.sendRedirect("memberAddForm.do");
		}
		*/
	}
}
